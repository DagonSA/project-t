extends Node2D
class_name Movement

@export var game_mode: GameMode
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"
@onready var board_manager = $"../BoardManager"
@onready var tile_data_map = board_manager.tile_data_map
@export var movement_arrow: MovementArrow

var final_tile_set: Array[Vector2i] = []
var selected_char: Node2D

##FLOW:
## movement_initiation --> get_valid_cells --> is_there_passage --> opposite_direction_passage_check

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_mode.sig_selected_character.connect(movement_initiation)


## called from GameMode signal around (de)selecting a character.
func movement_initiation(char: Node):
	selected_char = char
	if selected_char == null:
		tilemap_highlight_L1.clear_highlight()
		return
	if not game_mode.is_movement_phase():
		return
	if not selected_char.can_character_initiate_move():
		return
	var current_tile = selected_char.current_tile_coords
	final_tile_set = get_valid_cells(current_tile)
	tilemap_highlight_L1.highlight_tiles(final_tile_set)
	selected_char.state = Enums.CharacterState.PREMOVE
		
func get_valid_cells(current_tile: Vector2i) -> Array[Vector2i]:
	#get ALL neighbours and then only existing neighbours. IN OFFSET
	var all_neighbours = HexMathHelper.get_all_neighbours(current_tile)
	var existing_neighbours: Array[Vector2i]
	for tile in all_neighbours:
		if tile_data_map.has(tile):
			existing_neighbours.append(tile)
	var tiles_with_passage = is_there_passage(current_tile, existing_neighbours)
	final_tile_set = get_tiles_color_movement(current_tile, tiles_with_passage)
	return final_tile_set

func is_there_passage(current_tile: Vector2i, existing_neighbours: Array[Vector2i]) -> Array[Vector2i]:
	var current_tile_data = tile_data_map[current_tile]
	var current_tile_axial = HexMathHelper.offset_to_axial_odd_r(current_tile.x, current_tile.y)
	var tiles_with_passage: Array[Vector2i] = []
	for tile in existing_neighbours:
		var neighbour_tile_axial = HexMathHelper.offset_to_axial_odd_r(tile.x, tile.y)
		var neighbour_data = tile_data_map[tile]
		var delta_axial = neighbour_tile_axial - current_tile_axial
		var direction_index = HexMathHelper.AXIAL_DIRS.find(delta_axial)
		if current_tile_data.final_wall_setup[direction_index]:
			continue
		if opposite_direction_passage_check(direction_index, neighbour_data):
			continue
		else:
			tiles_with_passage.append(tile)
			print(tiles_with_passage)
	return tiles_with_passage
	
func opposite_direction_passage_check(direction_index: int, data: TileDataContainer) -> bool:
	var neighbour_index = (direction_index + 3) % 6
	if data.final_wall_setup[neighbour_index]:
		return true
	else:
		return false

## Input array is in OFFSET
func get_tiles_color_movement(current_tile: Vector2i, final_tile_set: Array[Vector2i]) -> Array[Vector2i]:
	var current_tile_axial = HexMathHelper.offset_to_axial_odd_r(current_tile.x, current_tile.y)
	var current_tile_type = tile_data_map[current_tile].tile_def_reference.terrain_type
	for key in tile_data_map: 
		var tile_axial = HexMathHelper.offset_to_axial_odd_r(key.x, key.y)
		if current_tile_axial == tile_axial:
			continue
		var tile_type = tile_data_map[key].tile_def_reference.terrain_type
		if tile_type != current_tile_type:
			continue
		if is_same_line_axial(current_tile_axial, tile_axial):
			final_tile_set.append(key)
	return final_tile_set

func is_same_line_axial(current_tile: Vector2i, comparing_tile: Vector2i) -> bool:
	var same_line = (
		current_tile.x == comparing_tile.x
		or current_tile.y == comparing_tile.y
		or (current_tile.x + current_tile.y) == (comparing_tile.x + comparing_tile.y)
		)
	if same_line:
		return true
	else:
		return false

func update_movement_arrow(target_point: Vector2i):
	movement_arrow.hide()
	if final_tile_set.has(target_point):
		var origin_coords = selected_char.current_tile_coords
		var origin_global = tilemap_base_L0.to_global(tilemap_base_L0.map_to_local(origin_coords))
		var target_global = tilemap_base_L0.to_global(tilemap_base_L0.map_to_local(target_point))
		movement_arrow.draw_movement_arrow(origin_global, target_global)
		movement_arrow.show()
