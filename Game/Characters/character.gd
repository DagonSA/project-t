extends Node2D

@export var char_data: CharacterData
@export var texture: Texture2D
@onready var ring_tint:= $Ring

var game_mode

var health: int
var damage: int
var attack: int
var defense: int
var speed: int
var intellect: int
var team: String
var actions: int
var portrait: Texture2D


func _ready():
	game_mode = $/root/Main/Game/GameMode
	_apply_data()
	$Texture.texture = char_data.portrait
	_set_color(team)

	
		
func _apply_data(): 
	if char_data == null:
		return
	_apply_stats()
	print(team)
	
func _apply_stats():
	name = char_data.display_name
	health = char_data.starting_health
	damage = char_data.starting_damage
	attack = char_data.starting_attack
	defense = char_data.starting_defense
	speed = char_data.starting_speed
	intellect = char_data.starting_intellect
	team = char_data.starting_team
	actions = char_data.starting_actions
	
func _set_color(team: String):
	match team:
		"Blue":
			ring_tint.modulate = Color(0.2, 0.4, 1.0)
		"Orange":
			ring_tint.modulate = Color(1.0, 0.5, 0.0)


func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx) -> void:
	if event is InputEventMouseButton and event.is_released():
		game_mode.select_character(self)
		
func set_selected_vis(on: bool):
	$SelectionRing.visible = on
	
	
