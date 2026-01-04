extends Node


@onready var tilemap = $".." #Access to TileMap (parent)
@export var tile_bag_template: Array[HexTileData] = [] #Creating an Array for Tiles to be spawned
const TILE_INSTANCE := preload("res://WorldMap/Tiles/Tile_instance.tscn")
const central_tile := Vector2i(0,0) #Location of a central tile
@export var terminus_tile: HexTileData
var tile_bag: Array[HexTileData] = []
const axial_dirs := [
	Vector2i(1, 0),
	Vector2i(1, -1),
	Vector2i(0, -1),
	Vector2i(-1, 0),
	Vector2i(-1, 1),
	Vector2i(0, 1)
]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tilemap = get_parent() 
	tile_bag = tile_bag_template.duplicate()
	spawn_tile(central_tile, Vector2i(0,0))
	spawn_rings(3)
	
func spawn_tile(coords: Vector2i, atlas: Vector2i):
	tilemap.set_cell(0, coords, 0, atlas, 0)
	
# OFFSET (TileMap coords) → AXIAL (logic coords)
func offset_to_axial_odd_r(x:int, y:int) -> Vector2i:
	var q := x - int((y - (y & 1)) / 2)
	var r := y
	return Vector2i(q, r)

# AXIAL → OFFSET
func axial_to_offset_odd_r(q:int, r:int) -> Vector2i:
	var x := q + int((r - (r & 1)) / 2)
	var y := r
	return Vector2i(x, y)

func spawn_rings(steps: int):
	for r in range(steps):
		hex_rings(r)
	
func hex_rings(steps: int):
	var center_axial = offset_to_axial_odd_r(central_tile.x, central_tile.y)
	var start_tile = center_axial + (axial_dirs[4] * steps)
	var current = start_tile
	for side in range(axial_dirs.size()):
		for step in range(steps):
			if tile_bag.size() > 0:
				var data = draw_from_bag()
				var current_offset = axial_to_offset_odd_r(current.x, current.y)
				spawn_tile(current_offset, data.atlas_coords)
				current += axial_dirs[side]
			else:
				print("not enough tiles")
				return
			
func draw_from_bag() -> HexTileData: #draw one random tile from this bag
	var index = randi() % tile_bag.size()
	return tile_bag.pop_at(index)		
			
	
