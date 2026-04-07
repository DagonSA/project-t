extends RefCounted
class_name TileDataContainer

var tile_coords: Vector2i
var tile_def_reference: TileDefinition
var final_wall_setup: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	final_wall_setup = []
