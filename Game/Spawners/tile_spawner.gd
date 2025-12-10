extends Node
#Spawner script for tiles


@onready var tilemap = $".." #Access to TileMap (parent)
@onready var hextile := preload("res://WorldMap/tile_data.tscn")
var tile_bag: Array = [] #Creating an Array for Tiles to be spawned
const central_tile := Vector2i(0,0) #Location of a central tile
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
	tilemap = get_parent() #accessing Tile Map
	spawn_tile(central_tile, Vector2i(0,0)) #Calling function 
	tiles_to_bag()
	spawn_rings(3)
	_test_hextile(Vector2i(0,0))
	
func spawn_tile(coords: Vector2i, atlas: Vector2i, layer:= 0, source_id:= 0):
	tilemap.set_cell(layer, coords, source_id, atlas)
		
func tiles_to_bag(): #create a bag with set amount and type of tiles
	add_tiles_to_bag(Vector2i(2,3), 3)
	add_tiles_to_bag(Vector2i(5,1), 3)
	add_tiles_to_bag(Vector2i(3,8), 3)
	add_tiles_to_bag(Vector2i(0,12), 6)
	add_tiles_to_bag(Vector2i(7,0), 1)
	add_tiles_to_bag(Vector2i(8,8), 1)
	add_tiles_to_bag(Vector2i(10,7), 1)
	
func add_tiles_to_bag(tile: Vector2i, count: int):
	for i in range(count):
		tile_bag.append(tile)	
	

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

#TESTING FOR SPAWNING A TILE WITH DIFFERENT WALL PATTERNS
func _test_hextile(loc: Vector2i):
	var hextile = hextile.instantiate()
	add_child(hextile)
	hextile.position = loc
	
	

func hex_rings(steps: int):
	var center_axial = offset_to_axial_odd_r(central_tile.x, central_tile.y)
	var start_tile = center_axial + (axial_dirs[4] * steps)
	var current = start_tile
	for side in range(axial_dirs.size()):
		for step in range(steps):
			var tile_to_spawn = random_hex_in_bag()
			var current_offset = axial_to_offset_odd_r(current.x, current.y)
			spawn_tile(current_offset, tile_to_spawn)
			current += axial_dirs[side]
			
func random_hex_in_bag(): #draw one random tile from this bag
	var index = randi() % tile_bag.size()
	return tile_bag.pop_at(index)		
			
	
