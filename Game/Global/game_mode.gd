extends Node2D
class_name GameMode

signal action_phase_started
signal show_end_movement_button #info to show button
signal game_state_changed(payload: Dictionary) 
signal sig_selected_character(character: Character)

const Enums = preload("res://Game/Global/enums.gd")
const Team = Enums.Team
const TurnPhase = Enums.TurnPhase

@export var movement: Movement
@export var line_of_sight: LineOfSight
@export var board_manager: BoardManager
@export var tile_spawner: TileSpawner
@export var player_spawner: PlayerSpawner
@export var event_token_manager: EventTokenManager


var current_phase: int
var current_turn: int
var current_team: Enums.Team
var alignment : String #potentially enum
var selected_char: Node = null
var character_tween_movement: bool



func _ready() -> void:
	
	#Will probably need to add SETUP phase and others 
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
	player_spawner.spawn_start_characters(blue, orange)
	
		
func select_character(clicked_char: Node = null) -> void:
	if selected_char == clicked_char: #If you click the same character which is selected
		return
	selected_char = clicked_char
	emit_signal("sig_selected_character", selected_char)
	
func is_movement_phase() -> bool:
	return current_phase == TurnPhase.MOVEMENT_PHASE
	
func on_tile_clicked(clicked_tile: Vector2i):
	if (current_phase == TurnPhase.MOVEMENT_PHASE and 
	selected_char != null and 
	selected_char.state == Enums.CharacterState.PREMOVE and 
	selected_char.team == current_team):
		movement.on_movement_tile_clicked(clicked_tile)

func after_character_movement_check(destination_tile: Vector2i):
	_is_token_to_trigger(destination_tile)
	_scout_after_movement(destination_tile)
	_check_end_of_movement_phase_or_switch_team()


func players_spawned(blue: Vector2i, orange: Vector2i):
	line_of_sight.reveal_tokens(blue)
	line_of_sight.reveal_tokens(orange)
	
func _check_end_of_movement_phase_or_switch_team():
	current_team = Enums.Team.BLUE if current_team == Enums.Team.ORANGE else Enums.Team.ORANGE
	for char in board_manager.playable_character_roster:
		if char.actions > 0:
			game_state_changed.emit(build_game_info_ui_payload())
			return
	emit_signal("show_end_movement_button")
	
	
func _is_token_to_trigger(tile: Vector2i):
	var token = board_manager.get_token(tile)
	if token != null:
		token.trigger_event_token()
		
func _scout_after_movement(destination_tile: Vector2i):
	line_of_sight.reveal_tokens(destination_tile)
	
func build_game_info_ui_payload() -> Dictionary:
	var game_info_payload = {}
	game_info_payload["current_team"] = current_team
	return game_info_payload
		
			
