extends Node2D
class_name Character

const Enums = preload("res://Game/Global/enums.gd")
@export var char_data: CharacterData
@export var texture: Texture2D
@onready var ring_tint:= $Ring

var game_mode

var health: int
var damage: int
var attack: int
var defense: int
var speed: int
var team: Enums.Team
var actions: int
var portrait: Texture2D
var standing_tile: Vector2i
var movement_range := 1
var state = Enums.CharacterState.IDLE


func _ready():
	game_mode = $/root/Main/Game/GameMode
	_apply_data()
	_set_color(team)
	game_mode.sig_selected_character.connect(_on_selection_change)

	
		
func _apply_data(): 
	if char_data == null:
		return
	_apply_stats()
	$Texture.texture = char_data.portrait
	
func _apply_stats():
	name = char_data.display_name
	health = char_data.starting_health
	damage = char_data.starting_damage
	attack = char_data.starting_attack
	defense = char_data.starting_defense
	speed = char_data.starting_speed
	team = char_data.starting_team
	actions = char_data.starting_actions
	
func _set_color(team: Enums.Team):
	match team:
		Enums.Team.BLUE:
			ring_tint.modulate = Color(0.2, 0.4, 1.0)
		Enums.Team.ORANGE:
			ring_tint.modulate = Color(1.0, 0.5, 0.0)
		Enums.Team.MONSTER:
			ring_tint.modulate = Color(0.88, 0.0, 0.165, 1.0)

func _on_selection_change(char: Node): 
	if char == self:
		set_selected_vis(true)
	else:
		set_selected_vis(false)
		
		
func set_selected_vis(on: bool):
	$SelectionRing.visible = on
	
func can_character_initiate_move() -> bool:
	return actions > 0
	
func register_tile_position(tile: Vector2i):
	standing_tile = tile
