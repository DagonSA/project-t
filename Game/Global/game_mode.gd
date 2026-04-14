extends Node2D
class_name GameMode

signal action_phase_started
signal show_end_movement_button #info to show button
signal current_player_updated(team) 
signal sig_selected_character(character)

const Enums = preload("res://Game/Global/enums.gd")
const Team = Enums.Team
const TurnPhase = Enums.TurnPhase

@export var movement: Movement
@export var board_manager: BoardManager

var current_phase: int
var current_turn: int
var current_team: Enums.Team
var alignment : String #potentially enum
var selected_char: Node = null
var character_tween_movement: bool



func _ready() -> void:
	current_phase = TurnPhase.MOVEMENT_PHASE
	current_turn = 1
	current_team = Team.BLUE
		
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

func after_character_movement_check():
	current_team = Enums.Team.BLUE if current_team == Enums.Team.ORANGE else Enums.Team.ORANGE
	for char in board_manager.playable_character_roster:
		if char.actions > 0:
			return
	emit_signal("show_end_movement_button")
	
func movement_phase_finished(): 
	current_phase = TurnPhase.ACTION_PHASE
	emit_signal("action_phase_started", current_turn, current_team, current_phase)
	
	
	
		
			
