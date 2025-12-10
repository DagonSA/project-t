extends Node2D

var grid_coords: Vector2i
var terrain_type: String #maybe int if enum? 
var special_type: String #same as abovr
var base_wall_pattern := [false, false, false, false, false, false]
var final_wall_pattern := []
var standing_pattern := []


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:

	#What we need to take from Tilemap:
	#apply_data(grid_coords, terrain_type, special, standing_slots, walls_pattern, rotation) 
	#instead ^ jhust reach directly for the tile. properties! 
	# set base walls visibility to false 

	
