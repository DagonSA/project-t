extends Node2D

@onready var tilemap: TileMapLayer #Getting access to TileMap
@onready var camera: Camera2D #Getting access to Camera2d
#@onready var background: Sprite2D
var map_centerpx: Vector2 #Setting center of the map

func _ready() -> void:
	camera = $Camera2D
	tilemap = $L0_tilemap_data
	#background = $Backgroundimg
	
	#Setting camera and background to the middle of the screen based on center tile
	var local_pos:= tilemap.map_to_local(Vector2i(0,0)) 
	map_centerpx = tilemap.to_global(local_pos)
	camera.global_position = map_centerpx
	#background.global_position = map_centerpx

	
