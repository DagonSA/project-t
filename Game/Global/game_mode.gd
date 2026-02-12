extends Node2D

const Enums = preload("res://Game/Global/enums.gd")

const Team = Enums.Team
const TurnPhase = Enums.TurnPhase

var current_phase: int
var current_turn: int
var current_team: int
var alignment : String #potentially enum
var selected_char: Node = null

signal turn_updated(new_turn: int, current_team: int) #info for UI
signal phase_updated(new_phase: int) 
signal selected_character(character)


func _ready() -> void:
	current_phase = TurnPhase.MOVEMENT_PHASE
	current_turn = 1
	current_team = Team.BLUE
	
	
func _on_end_turn_pressed() -> void:
	end_player_turn()
	
func end_player_turn():
	current_turn += 1
	if current_team == Team.BLUE:
		current_team = Team.ORANGE
	else:
		current_team = Team.BLUE
	var team_label = Team.keys()[current_team].capitalize()
	#probably signal for phase change as well
	emit_signal("turn_updated", current_turn, team_label)
	
func select_character(clicked_char: Node = null) -> void:
	if selected_char == clicked_char: #If you click the same character which is selected
		return
	selected_char = clicked_char
	emit_signal("selected_character", selected_char)
	
func is_movement_phase() -> bool:
	return current_phase == TurnPhase.MOVEMENT_PHASE
	
	
	
	
