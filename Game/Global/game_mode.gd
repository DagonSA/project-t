extends Node2D
class_name GameMode

signal action_phase_started
signal show_end_movement_button #info to show button
signal game_state_changed(payload: Dictionary) 
signal sig_selected_character(character: Character)

const Enums = preload("res://Game/Global/enums.gd")
const Team = Enums.Team
const TurnPhase = Enums.TurnPhase

@export var attacking: Attacking
@export var movement: Movement
@export var line_of_sight: LineOfSight
@export var board_manager: BoardManager
@export var tile_spawner: TileSpawner
@export var character_spawner: CharacterSpawner
@export var event_token_manager: EventTokenManager


var current_phase: int
var current_turn: int
var current_team: Enums.Team
var alignment : String #potentially enum
var selected_char: Node = null
var character_tween_movement: bool
var character_locked_to_move: Character = null
var targeted_character: Character = null



func _ready() -> void:
	current_phase = TurnPhase.MOVEMENT_PHASE
	current_turn = 1
	current_team = Team.BLUE
	tile_spawner.spawn_board()
	
func board_spawned():
	var tile_set = board_manager.tile_data_map
	event_token_manager.initial_token_spawn(tile_set)
	
func initial_tokens_spawned():
	tile_spawner.spawn_ships()

	
func ships_spawned(blue: Vector2i, orange: Vector2i):
	character_spawner.spawn_start_player_characters(blue, orange)
	
		
func select_character(clicked_char: Node = null) -> void:
	if selected_char == clicked_char: #If you click the same character which is selected
		return
	selected_char = clicked_char
	emit_signal("sig_selected_character", selected_char)
	
func is_movement_phase() -> bool:
	return current_phase == TurnPhase.MOVEMENT_PHASE
	
func on_tile_clicked(clicked_tile: Vector2i):
	if selected_char == null:
		return
	if selected_char.state == Enums.CharacterState.PREATTACKING:
		selected_char.state = Enums.CharacterState.IDLE
		targeted_character = null
		movement.movement_initiation(selected_char)
		return
	if character_locked_to_move == null or character_locked_to_move == selected_char:
		if (current_phase == TurnPhase.MOVEMENT_PHASE and
		selected_char != null and 
		selected_char.state == Enums.CharacterState.PREMOVE and 
		selected_char.team == current_team):
			print("second")
			movement.on_movement_tile_clicked(clicked_tile)

func after_character_movement_check(destination_tile: Vector2i, moved_char: Character):
	_is_token_to_trigger(destination_tile)
	_scout_after_movement(destination_tile)
	moved_char.move_actions -= 1
	if moved_char.move_actions <= 0:
		_check_end_of_movement_phase_or_switch_team()
		character_locked_to_move = null
	else:
		character_locked_to_move = moved_char
		movement.movement_initiation(character_locked_to_move)
	board_manager.set_formation_on_tile_entry(destination_tile, moved_char)
	

func players_spawned(blue: Vector2i, orange: Vector2i):
	line_of_sight.reveal_tokens(blue)
	line_of_sight.reveal_tokens(orange)
	
func _check_end_of_movement_phase_or_switch_team():
	current_team = Enums.Team.BLUE if current_team == Enums.Team.ORANGE else Enums.Team.ORANGE
	#for char in board_manager.playable_character_roster:
		#if char.move_actions > 0:
		#	game_state_changed.emit(build_game_info_ui_payload())
		#	return
	#emit_signal("show_end_movement_button")
	
	
func _is_token_to_trigger(coords: Vector2i):
	var token = board_manager.get_token(coords)
	if token != null:
		token.trigger_event_token(coords)
		selected_char.move_actions = 0
		
func _scout_after_movement(destination_tile: Vector2i):
	line_of_sight.reveal_tokens(destination_tile)
	
func build_game_info_ui_payload() -> Dictionary:
	var game_info_payload = {}
	game_info_payload["current_team"] = current_team
	return game_info_payload
	
func spawn_monster(coords: Vector2i):
	character_spawner.spawn_monster(coords)
		
func can_character_be_attacked(defender: Character):
	if selected_char.move_actions <= 0:
		return
	if is_enemy(defender):
		var origin_tile = selected_char.standing_tile
		var destination_tile = defender.standing_tile
		var range = HexMathHelper.check_range_between_tiles(origin_tile, destination_tile)
		print(range)
		if range <= 1:
			attacking.attack_initiation(selected_char, defender, range)
			
		
	
func is_enemy(char: Character) -> bool:
	return char.team != current_team
			
func deselect_reset():
	selected_char.state = Enums.CharacterState.IDLE
	movement.tile_to_move = Vector2i(-1, -1)
	select_character(null)
