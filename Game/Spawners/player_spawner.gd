extends Node

#For the future -> set for many instances of characters (1-6)
#Also, write a spawner for monsters (but that would be easy - that depends on the event tokens)
#The most difficult things for now - spawning CHOSEN characters. Not suitable for MVP for now

@onready var tilemap = $"../L0_tilemap_data"
@onready var character = load("res://Game/Characters/character.tscn")
@onready var tileset = tilemap.tile_set
@export var roster: Array[CharacterData]
@export var blue_spawn_tile: Vector2i
@export var orange_spawn_tile: Vector2i
var blue_slot_index = 0
var orange_slot_index = 0

func _ready() -> void: #maybe later we can expose the parameters in a "ship" vector	
	spawn_start_characters(Vector2i(0,0),roster)
	
	
func spawn_start_characters(pos: Vector2i, roster: Array[CharacterData]):
	for char_data in roster:
		var new_char = character.instantiate()
		var tile_coords: Vector2i
		var position_global: Vector2
		new_char.char_data = char_data
		add_child(new_char)
		if new_char.team == "Blue":
			tile_coords = blue_spawn_tile
			position_global = tilemap.get_standing_pos(tile_coords, blue_slot_index)
			blue_slot_index += 1
		else:
			tile_coords = orange_spawn_tile
			position_global = tilemap.get_standing_pos(tile_coords, orange_slot_index)
			orange_slot_index += 1
		new_char.global_position = position_global
		new_char.current_tile_grid = tile_coords
		
