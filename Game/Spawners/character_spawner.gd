extends Node
class_name CharacterSpawner

#For the future -> set for many instances of characters (1-6)
#Also, write a spawner for monsters (but that would be easy - that depends on the event tokens)
#The most difficult things for now - spawning CHOSEN characters. Not suitable for MVP for now

@onready var tilemap = $"../L0_tilemap_data"
@export var board_manager: BoardManager
@export var player_blueprint: PackedScene
@export var monster_blueprint: PackedScene
@onready var tileset = tilemap.tile_set
@export var player_roster: Array[CharacterPlayerData]
@export var monster: CharacterMonsterData
@export var game_mode: GameMode

var blue_slot_index = 0
var orange_slot_index = 0
	
func spawn_start_player_characters(blue_ship: Vector2i, orange_ship: Vector2i):
	for char_data in player_roster:
		var new_char = player_blueprint.instantiate()
		var position_global: Vector2
		new_char.char_data = char_data
		add_child(new_char)
		if new_char.team == Enums.Team.BLUE:
			new_char.register_tile_position(blue_ship)
		else:
			new_char.register_tile_position(orange_ship)
		new_char.global_position = tilemap.get_global_pos(new_char.standing_tile)
		board_manager.register_playable_character(new_char)
		board_manager.set_character_formation_on_tile(new_char.standing_tile, new_char)
	game_mode.players_spawned(blue_ship, orange_ship)
	
func spawn_monster(coords: Vector2i):
	## in the future we will be drawing from a pool - roster - of monsters. currently just one
		var new_monster = monster_blueprint.instantiate()
		var position_global: Vector2
		new_monster.char_data = monster
		add_child(new_monster)
		position_global = tilemap.get_global_pos(coords)
		board_manager.set_character_formation_on_tile(coords, new_monster)
	
	
	
	
	

		
		
