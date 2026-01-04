extends Node2D

var tile_data: HexTileData
var board_coords: Vector2i
var final_wall_pattern: Array[bool]

func _ready() -> void:
	$GroundTexture.texture = tile_data.texture
