extends RefCounted
class_name HexMathHelper

#ordering of neighbours for current tile: NE, E, SE, SW, W, NW
const AXIAL_DIRS = [
	Vector2i(0, -1),
	Vector2i(1, 0),
	Vector2i(0, 1),
	Vector2i(-1, 1),
	Vector2i(-1, 0),
	Vector2i(-1, -1)
	]

#calculation of indeces for a given neighbour (wall)
const DELTA_TO_DIR = {
	Vector2i(0, -1): 0,
	Vector2i(1, 0): 1,
	Vector2i(0, 1): 2,
	Vector2i(-1, 1): 3, 
	Vector2i(-1, 0): 4,
	Vector2i(-1, -1): 5
}

static func get_all_neighbours(tile: Vector2i) -> Array[Vector2i]:
	var all_neighbours_ordered: Array[Vector2i] = []
	for neighbour in AXIAL_DIRS:
		all_neighbours_ordered.append(tile + neighbour)
	return all_neighbours_ordered
		 
