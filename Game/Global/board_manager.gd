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
	
func register_token(coords: Vector2i, token: EventToken):
	event_token_data_map[coords] = {"token": token}
	
func set_character_formation_on_tile(target_tile: Vector2i, char: Character):
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
			char.global_position = get_node("../L0_tilemap_data").get_global_pos(tile) + formations.ONE_TEAM_FORMATION[char_count-1][i]
	elif team_count.size() == 2:
		var has_blue: bool
		var has_orange: bool
		var orange_left_side = []
		var blue_right_side = []
		var monster_temporary = []
		for char in map[tile]:
			if char["team"] == Enums.Team.BLUE:
				has_blue = true
				blue_right_side.append(char)
			if char["team"] == Enums.Team.ORANGE:
				has_orange = true
				orange_left_side.append(char)
			if char["team"] == Enums.Team.MONSTER:
				monster_temporary.append(char)
		if has_blue:
			orange_left_side.append_array(monster_temporary)
		if has_orange:
			blue_right_side.append_array(monster_temporary)	
		for i in blue_right_side.size():
			var blue_char = blue_right_side[i]["char"]
			var global_position = tilemap_base_L0.get_global_pos(tile)
			blue_char.global_position = global_position + Vector2(29, 0)
			#blue_char.global_position = global_position + formations.TWO_TEAM_FORMATION[blue_right_side.size() -1][i] + formations.SIDE_BLUE_RIGHT_X
		for i in orange_left_side.size():
			var orange_char = orange_left_side[i]["char"]
			var global_position = tilemap_base_L0.get_global_pos(tile)
			orange_char.global_position = global_position + Vector2(-29, 0)
			#orange_char.global_position = global_position + formations.TWO_TEAM_FORMATION[orange_left_side.size() -1][i] + formations.SIDE_ORANGE_LEFT_X
		

		
func register_playable_character(character: Character):
	playable_character_roster.append(character)

func scout_tokens(scouted_tiles: Array[Vector2i]):
	for coords in scouted_tiles:
		if event_token_data_map.has(coords):
			event_token_data_map[coords]["token"].reveal_token()
			
func get_token(coords: Vector2i) -> EventToken:
	var token = event_token_data_map.get(coords, {}).get("token", null)
	return token
	

	
