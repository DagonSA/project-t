extends Node

var tile_data_map := {}
signal board_changed
@onready var game_mode = $"../GameMode"
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"

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
	var valid_cells = get_valid_cells(current_tile)
	tilemap_highlight_L1.highlight_tiles(valid_cells)


	
		
func get_valid_cells(current_tile: Vector2i) -> Array[Vector2i]:
	var all_neighbours = HexMathHelper.get_all_neighbours(current_tile)
	var existing_neighbours: Array[Vector2i]
	for tile in all_neighbours:
		if tile_data_map.has(tile):
			existing_neighbours.append(tile)
	var tiles_with_passage = is_there_passage(current_tile, existing_neighbours)
	return tiles_with_passage


	
func is_there_passage(current_tile: Vector2i, existing_neighbours: Array[Vector2i]) -> Array[Vector2i]:
	var current_tile_data = tile_data_map[current_tile]
	var tiles_with_passage: Array[Vector2i] = []
	for tile in existing_neighbours:
		var delta = tile - current_tile
		var direction_index = HexMathHelper.DELTA_TO_DIR[delta]
		var neighbour_data = tile_data_map[tile]
		if current_tile_data.final_wall_setup[direction_index]:
			continue
		if opposite_direction_passage_check(direction_index, neighbour_data):
			continue
		else:
			tiles_with_passage.append(tile)
			print(tiles_with_passage)
	return tiles_with_passage
	

	
func opposite_direction_passage_check(direction_index: int, data: TileDataContainer) -> bool:
	var neighbour_index = (direction_index + 3) % 6
	if data.final_wall_setup[neighbour_index]:
		return true
	else:
		return false
