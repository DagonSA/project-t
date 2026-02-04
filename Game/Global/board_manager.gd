extends Node

var tile_data_map := {}
signal board_changed
@onready var game_mode = $"../GameMode"
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"

const DELTA_TO_DIR = {
	Vector2i(1, 0): 0,
	Vector2i(1, -1): 1,
	Vector2i(0, -1): 2,
	Vector2i(-1, 0): 3, 
	Vector2i(-1, 1): 4,
	Vector2i(0, 1): 5
}

func _ready() -> void:
	game_mode.selected_character.connect(movement_initiation)

func register_tile(coords: Vector2i, tile_data: TileDataContainer):
	tile_data_map[coords] = tile_data
	board_changed.emit()
	
func movement_initiation(selected_char: Node):
	if selected_char == null:
		tilemap_highlight_L1.clear_highlight()
		return
	if not game_mode.is_movement_phase():
		return
	if not selected_char.can_character_initiate_move():
		return
	var current_tile = selected_char.current_tile_grid
	
	#now we need to 1) check if tile exist and to check if it's traversable
	
	var valid_cells = get_valid_cells(current_tile)
	tilemap_highlight_L1.highlight_tiles(valid_cells)

	
		
func get_valid_cells(current_tile: Vector2i) -> Array[Vector2i]:
	var neighbours = tilemap_base_L0.get_surrounding_cells(current_tile)
	var existing_neighbours: Array[Vector2i]
	for tile in neighbours:
		if tile_data_map.has(tile):
			existing_neighbours.append(tile)
	var tiles_with_passage = is_there_passage(current_tile, existing_neighbours)
	return tiles_with_passage


	
func is_there_passage(current_tile: Vector2i, existing_neighbours: Array[Vector2i]) -> Array[Vector2i]:
	var current_tile_data = tile_data_map[current_tile]
	var tiles_with_passage = []
	for tile in existing_neighbours:
		var delta = tile - current_tile
		
		#debugging:
		if not DELTA_TO_DIR.has(delta):
			push_error("DELTA NOT FOUND: %s | dict keys: %s" % [delta, DELTA_TO_DIR.keys()])
			print("y")
			return []
		#debug over
		
		var direction_index = DELTA_TO_DIR[delta]
		if current_tile_data.final_wall_setup[direction_index]:
			continue
		if opposite_direction_passage_check(direction_index):
			continue
		else:
			tiles_with_passage.append(tile)
	return tiles_with_passage
	
func opposite_direction_passage_check(direction_index: int) -> bool:
	return (direction_index + 3) % 6
