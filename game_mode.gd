extends Node2D

const Enums = preload("res://Game/Global/enums.gd")

const Team = Enums.Team

var current_turn: int
var current_team: int
var alignment : String #potentially enum
var selected_char: Node = null

signal turn_updated(new_turn: int, current_team: int) #info for UI
signal selected_character(character)


func _ready() -> void:
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
	emit_signal("turn_updated", current_turn, team_label)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
		deselect_character()
	
	
func select_character(clicked_char: Node) -> void:
	if selected_char == clicked_char: #If you click the same character which is selected
		return
	
		#show UI panels for the characters
	$"../../UI Root/CharacterPanel/Stats".visible = true
	
	#unselect previous - if any	
	if selected_char != null:
		selected_char.set_selected_vis(false)
		
	#select clicked	- show selection ring and send signal
	clicked_char.set_selected_vis(true)
	selected_char = clicked_char
	emit_signal("selected_character", selected_char)
	
func deselect_character():
	selected_char.set_selected_vis(false)
	selected_char = null
	$"../../UI Root/CharacterPanel/Stats".visible = false
		
	
	
	
	
