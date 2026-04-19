extends Node
class_name PlayerSpawner

#For the future -> set for many instances of characters (1-6)
#Also, write a spawner for monsters (but that would be easy - that depends on the event tokens)
#The most difficult things for now - spawning CHOSEN characters. Not suitable for MVP for now

@onready var tilemap = $"../L0_tilemap_data"
@export var board_manager: BoardManager
@export var character_blueprint: PackedScene
@onready var tileset = tilemap.tile_set
@export var roster: Array[CharacterData]

var blue_slot_index = 0
var orange_slot_index = 0
	
func spawn_start_characters(blue_ship: Vector2i, orange_ship: Vector2i):
	print("roster", roster.size())
	for char_data in roster:
		var new_char = character_blueprint.instantiate()
		var position_global: Vector2
		new_char.char_data = char_data
		add_child(new_char)
		if new_char.team == Enums.Team.BLUE:
			position_global = tilemap.get_standing_pos(blue_ship, 3, blue_slot_index)
			new_char.register_tile_position(blue_ship)
			blue_slot_index += 1
		else:
			position_global = tilemap.get_standing_pos(orange_ship, 3, orange_slot_index)
			new_char.register_tile_position(orange_ship)
			orange_slot_index += 1
		new_char.global_position = position_global
		board_manager.register_playable_character(new_char)
	
		
		
