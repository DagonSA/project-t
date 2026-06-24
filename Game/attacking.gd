extends Node2D
class_name Attacking

@export var game_mode: GameMode
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"
@onready var board_manager = $"../BoardManager"
@onready var tile_data_map = board_manager.tile_data_map
@onready var attack_result_img = $Attack_result_img
@export var indicator_arrow: IndicatorArrow
@export var dice_helper = preload("res://Game/Dice/dice_helper.gd").new()
@export var dice_roll_sounds: Array[AudioStream]
@export var audio_player: AudioStreamPlayer
@export var laser_shot_blueprint: PackedScene

var final_tile_set: Array[Vector2i] = []
var selected_char: Character
var tile_to_move: Vector2i
var attack_type: int

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
	if range == 0:
		attack_type = range ## 0 = melee
	else:
		attack_type = 1 ## 1 = ranged


func update_attack_arrow(attacker: Character, defender: Character):
	var origin_global = attacker.global_position
	var target_global = defender.global_position
	indicator_arrow.draw_indicator_arrow(origin_global, target_global, Color.RED)
	indicator_arrow.show()
	
func attack_character(defender: Character):
	var attacker = game_mode.selected_char
	var advantage = attacker.attack - defender.defense
	var effect = _roll_for_attack(attack_type, advantage)
	attack_result_animation(attacker, defender, effect)
	apply_damage(attacker, defender)
	clear_after_attack(attacker)
	
	
## For now we'll only use melee. We'll decide how to diff. later.	
func _roll_for_attack(type: int, advantage: int) -> Dictionary:
	var roll = randi() % 12 + 1
	var cumulative = 0
	var dice = dice_helper.DICE_SET[type][advantage]
	print("roll: ", roll)
	for effect in dice["weights"]:
		cumulative += dice["weights"][effect]
		if roll <= cumulative:
			return {"result": Enums.DiceSides.keys()[effect], "image": dice["images"][effect], "sound": dice["sounds"][effect]}
			break
	return {}
		
func attack_result_animation(attacker: Character, defender: Character, effect_dict: Dictionary):
	print(effect_dict["result"])
	attack_result_img.show()
	attack_result_img.texture = effect_dict["image"]
	audio_player.stream = dice_roll_sounds[randi() % dice_roll_sounds.size()]
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()
	var tween = get_tree().create_tween()
	tween.tween_property(attack_result_img, "scale", Vector2(0.5, 0.5), 1)
	tween.parallel().tween_property(attack_result_img, "rotation", deg_to_rad(360), 1)
	await tween.finished
	audio_player.stream = effect_dict["sound"]
	audio_player.play()
	await get_tree().create_timer(2.0).timeout
	attack_result_img.hide()
	print(effect_dict["result"])
	if effect_dict["result"] != "MISS":
		play_laser_shot(attacker, defender)
		
func play_laser_shot(attacker: Character, defender: Character):
		var laser_shot = laser_shot_blueprint.instantiate()
		add_child(laser_shot)
		var start = attacker.global_position
		var end = defender.global_position
		var duration = start.distance_to(end) / 500
		laser_shot.global_position = attacker.global_position
		laser_shot.rotation = (end - start).angle()
		var tween = get_tree().create_tween()
		tween.tween_property(laser_shot, "global_position", defender.global_position, duration)
		await tween.finished
		laser_shot.queue_free()
	
	
	
func clear_after_attack(attacker: Character): 
	indicator_arrow.hide()
	attacker.move_actions = 0
	## TEMPORARY SOLUTION BEFORE WE CHANGE GAME TURNS ANYWAYS: 
	game_mode.after_character_movement_check(attacker.standing_tile, attacker)
	
	
func apply_damage(attacker: Character, defender: Character): 
	defender.health -= attacker.damage
	if defender.health <= 0:
		defender.queue_free()
		print("KILL")
	
	
	
	
		
	
	
