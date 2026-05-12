extends Node2D
class_name Attacking

@export var game_mode: GameMode
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"
@onready var board_manager = $"../BoardManager"
@onready var tile_data_map = board_manager.tile_data_map
@export var indicator_arrow: IndicatorArrow

var final_tile_set: Array[Vector2i] = []
var selected_char: Node2D
var tile_to_move: Vector2i

##FLOW:
## movement_initiation --> get_valid_cells --> is_there_passage --> opposite_direction_passage_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
## called from GameMode signal around (de)selecting a character.
func attack_initiation(attacker: Character, defender: Character):
	indicator_arrow.hide()
	tilemap_highlight_L1.clear_highlight()
	attacker.state = Enums.CharacterState.PREATTACKING
	update_attack_arrow(attacker, defender)
	game_mode.targeted_character = defender


func update_attack_arrow(attacker: Character, defender: Character):
	var origin_global = attacker.global_position
	var target_global = defender.global_position
	indicator_arrow.draw_indicator_arrow(origin_global, target_global, Color.RED)
	indicator_arrow.show()
		
	
	
