extends Node


@onready var tilemap = $".." #Access to TileMap (parent)
@onready var board_manager = $"../../BoardManager"
@export var tile_bag_template: Array[TileDefinition] = [] #Creating an Array for Tiles to be spawned
@export var terminus_data: TileDefinition
const central_tile := Vector2i(0,0) #Location of a central tile in world grid
const terminus_atlas := Vector2i(11,5) #atlas location of central tile
const axial_dirs := [
	Vector2i(1, 0),
	Vector2i(1, -1),
	Vector2i(0, -1),
	Vector2i(-1, 0),
	Vector2i(-1, 1),
	Vector2i(0, 1)
	]
var tile_bag: Array[TileDefinition] = []
var data_container = TileDataContainer
var wall_patterns := {
	Enums.WallPatterns.OPEN: [false, false, false, false, false, false],
	Enums.WallPatterns.COCOCO: [true, false, true, false, true, false],
	Enums.WallPatterns.CCOOOO: [true, true, false, false, false, false],
	Enums.WallPatterns.COCOOO: [true, false, true, false, false, false],
	Enums.WallPatterns.COOCOO: [true, false, false, true, false, false]
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tilemap = get_parent() 
	tile_bag = tile_bag_template.duplicate()
	board_manager.board_changed.connect(_on_board_changed)
	spawn_tile(central_tile, terminus_data)
	spawn_rings(3)
	
#### Functions	
func spawn_tile(coords: Vector2i, tile_definition: TileDefinition) -> void:
	data_container = TileDataContainer.new()
	data_container.tile_def_reference = tile_definition

	## Decide on final wall pattern
	var wall_pattern_index = tile_definition.base_wall_pattern
	var base_wall_pattern = wall_patterns[wall_pattern_index]
	var rotation = randi_range(0,5)
	var final_wall_pattern = calculate_walls(base_wall_pattern, rotation)
	data_container.final_wall_setup = final_wall_pattern
	board_manager.register_tile(coords, data_container) #saving to board manager
	#Saving to board manager will signal render_cell function
	
func _on_board_changed():
	render_cells()	
	
func calculate_walls(base_wall_pattern: Array, rotation: int) -> Array:
	var final_wall_pattern: Array = []
	final_wall_pattern.resize(6)
	for i in range(base_wall_pattern.size()):
		var new_index = (i + rotation) % 6
		final_wall_pattern[new_index] = base_wall_pattern[i]
	return final_wall_pattern
	
func render_cells():
	var tile_map = board_manager.tile_data_map
	for tile in tile_map:
		var atlas = tile_map[tile].tile_def_reference.atlas_coords
		tilemap.set_cell(0, tile, 0, atlas, 0)
		
	
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
				spawn_tile(current_offset, data)
				current += axial_dirs[side]
			else:
				print("not enough tiles")
				return
			
func draw_from_bag() -> TileDefinition: #draw one random tile from this bag
	var index = randi() % tile_bag.size()
	return tile_bag.pop_at(index)		
			
	
