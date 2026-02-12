extends RefCounted
class_name HexMathHelper

#ordering of neighbours for current tile: NE, E, SE, SW, W, NW
const AXIAL_DIRS := [
	Vector2i(1, -1), #NE
	Vector2i(1, 0), #E
	Vector2i(0, 1), #SE
	Vector2i(-1, 1), #SW
	Vector2i(-1, 0), #W
	Vector2i(0, -1) #NW
	]

# OFFSET (TileMap coords) → AXIAL (logic coords)
static func offset_to_axial_odd_r(x:int, y:int) -> Vector2i:
	var q := x - int((y - (y & 1)) / 2)
	var r := y
	return Vector2i(q, r)

# AXIAL → OFFSET
static func axial_to_offset_odd_r(q:int, r:int) -> Vector2i:
	var x := q + int((r - (r & 1)) / 2)
	var y := r
	return Vector2i(x, y)


static func get_all_neighbours(tile: Vector2i) -> Array[Vector2i]:
	var all_neighbours_ordered: Array[Vector2i] = []
	var tile_axial = offset_to_axial_odd_r(tile.x, tile.y)
	for neighbour in AXIAL_DIRS:
		var returned_tile_axial = tile_axial + neighbour
		var returned_tile_offset = axial_to_offset_odd_r(returned_tile_axial.x, returned_tile_axial.y)
		all_neighbours_ordered.append(returned_tile_offset)
	return all_neighbours_ordered
		 
