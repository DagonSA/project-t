extends Node2D
class_name Attacking

@export var game_mode: GameMode
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"
@onready var board_manager = $"../BoardManager"
@onready var tile_data_map = board_manager.tile_data_map
@onready var attack_result_img = $Attack_result_img
@export var indicator_arrow: IndicatorArrow
@export var dice_helper: DiceHelper

var final_tile_set: Array[Vector2i] = []
var selected_char: Character
var tile_to_move: Vector2i

##FLOW:
## movement_initiation --> get_valid_cells --> is_there_passage --> opposite_direction_passage_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
## called from GameMode signal around (de)selecting a character.
func attack_initiation(attacker: Character, defender: Character, range: int):
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
	
func attack_character(defender: Character):
	var attacker = game_mode.selected_char
	var advantage = attacker.attack - defender.defense
	var type = 0 #For Enums melee
	var effect = _roll_for_attack(type, advantage)
	attack_result_animation(effect)
	clear_after_attack()
	
	
## For now we'll only use melee. We'll decide how to diff. later.	
func _roll_for_attack(type: int, advantage: int) -> Dictionary:
	var roll = randi() % 12 + 1
	var cumulative = 0
	var dice = dice_helper.DICE_SET[type][advantage]
	print("roll: ", roll)
	for effect in dice["weights"]:
		cumulative += dice["weights"][effect]
		if roll <= cumulative:
			return {"result": Enums.DiceSides.keys()[effect], "image": dice["images"][effect]}
			break
	return {}
		
func attack_result_animation(dict: Dictionary):
	print(dict["result"])
	attack_result_img.show()
	attack_result_img.texture = dict["image"]
	var tween = get_tree().create_tween()
	tween.tween_property(attack_result_img, "scale", Vector2(0.5, 0.5), 1)
	tween.parallel().tween_property(attack_result_img, "rotation", deg_to_rad(360), 1)
	
	await get_tree().create_timer(2.0).timeout
	attack_result_img.hide()
	
func clear_after_attack():
	indicator_arrow.hide()
	
	
	
	
		
	
	
