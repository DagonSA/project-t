## Responsible for:
## Registering spawned tiles in a tile manager
## Initiating movement

extends Node
class_name BoardManager

var tile_data_map := {}
var tile_occupation_map : Dictionary[Vector2i, Array] = {}
var event_token_data_map := {}
var playable_character_roster := []
signal board_changed
@onready var game_mode = $"../GameMode"
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"
@export var formations: TileFormations

func _ready() -> void:
	pass

## called from tilespawner when a tile spawns
func register_tile(coords: Vector2i, tile_data: TileDataContainer):
	tile_data_map[coords] = tile_data
	board_changed.emit()
	
func register_token(coords: Vector2i ,token: EventToken):
	event_token_data_map[coords] = {"token": token}
	
func formation_after_move(target_tile: Vector2i, char: Character):
	if tile_occupation_map.has(target_tile):
		tile_occupation_map[target_tile].append({"char": char, "team": char.team})
	else:
		tile_occupation_map[target_tile] = [{"char": char, "team": char.team}]
	update_tile_formation(tile_occupation_map, target_tile)
	
func update_tile_formation(map: Dictionary[Vector2i, Array], tile: Vector2i):
	var char_count = map[tile].size()
	var team_count = {}
	for i in map[tile]:
		team_count[i["team"]] = true
	if team_count.size() == 1: 
		for i in char_count:
			var char = map[tile][i]["char"]
			char.global_position = tilemap_base_L0.get_standing_pos(tile, char_count, i)
	elif team_count.size() == 2:
		print("2 team formation, pass char/teamqty")
	else:
		print("3 team formation, pass char/teamqty")
		
func register_playable_character(character: Character):
	playable_character_roster.append(character)

func scout_tokens(scouted_tiles: Array[Vector2i]):
	for coords in scouted_tiles:
		if event_token_data_map.has(coords):
			event_token_data_map[coords]["token"].reveal_token()
			
func get_token(tile: Vector2i) -> EventToken:
	var token = event_token_data_map[tile]["token"]
	return token
	

	
