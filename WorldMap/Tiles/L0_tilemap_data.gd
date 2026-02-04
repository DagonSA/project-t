extends TileMapLayer

const TEAM_SOLO_POS:= [
	Vector2(0,-30),
	Vector2(-30, 10),
	Vector2(30, 10)
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_standing_pos(tile_coords: Vector2i, slot_index: int) -> Vector2:
	var local_origin := map_to_local(tile_coords)
	var local_center := local_origin
	return to_global(local_center) + TEAM_SOLO_POS[slot_index]
