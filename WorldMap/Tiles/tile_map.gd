extends TileMap

const TEAM_SOLO_POS:= [
	Vector2(0,-30),
	Vector2(-30, 10),
	Vector2(30, 10)
]
#const TILE_SIZE := Vector2(256,296) - or actual tile sizes
var tile_size2i := tile_set.tile_size
var tile_size := Vector2(tile_size2i)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_standing_pos(tile_coords: Vector2i, slot_index: int) -> Vector2:
	var local_origin := map_to_local(tile_coords)
	var local_center := local_origin
	return to_global(local_center) + TEAM_SOLO_POS[slot_index]
