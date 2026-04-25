extends Node2D
class_name LineOfSight

@export var board_manager: BoardManager

var visible_tile_set: Array[Vector2i] = []

func reveal_tokens(origin_tile: Vector2i):
	var scouted_tiles = _check_line_of_sight(origin_tile)
	var tokens_to_reveal = board_manager.scout_tokens(scouted_tiles)




func _check_line_of_sight(tile: Vector2i) -> Array[Vector2i]:
	visible_tile_set = get_valid_cells(tile)
	return visible_tile_set
	
## RETURNUJE PUSTY ARRAY NA RAZIE 	
func get_valid_cells(current_tile: Vector2i) -> Array[Vector2i]:
	var all_neighbours = HexMathHelper.get_all_neighbours(current_tile)
	var existing_neighbours: Array[Vector2i]
	for tile in all_neighbours:
		if board_manager.tile_data_map.has(tile):
			existing_neighbours.append(tile)
	var tiles_with_passage = is_there_passage(current_tile, existing_neighbours)
	return tiles_with_passage
	
func is_there_passage(current_tile: Vector2i, existing_neighbours: Array[Vector2i]) -> Array[Vector2i]:
	var current_tile_data = board_manager.tile_data_map[current_tile]
	var current_tile_axial = HexMathHelper.offset_to_axial_odd_r(current_tile.x, current_tile.y)
	var tiles_with_passage: Array[Vector2i] = []
	for tile in existing_neighbours:
		var neighbour_tile_axial = HexMathHelper.offset_to_axial_odd_r(tile.x, tile.y)
		var neighbour_data = board_manager.tile_data_map[tile]
		var delta_axial = neighbour_tile_axial - current_tile_axial
		var direction_index = HexMathHelper.AXIAL_DIRS.find(delta_axial)
		if current_tile_data.final_wall_setup[direction_index]:
			continue
		if opposite_direction_passage_check(direction_index, neighbour_data):
			continue
		else:
			tiles_with_passage.append(tile)	
	return tiles_with_passage
	
func opposite_direction_passage_check(direction_index: int, data: TileDataContainer) -> bool:
	var neighbour_index = (direction_index + 3) % 6
	if data.final_wall_setup[neighbour_index]:
		return true
	else:
		return false
