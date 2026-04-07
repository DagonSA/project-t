extends Node2D

const CLICKABLE_CHARACTERS_MASK := 1 << 0
@onready var game_mode = $"../GameMode"
@export var board_manager: Node2D
@onready var tile_map_layer_0 = $"../L0_tilemap_data"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	check_for_mouse_hover()
	
## MIGHT NEED MORE CONDITIONS EVENTUALLY!	
func check_for_mouse_hover():
		var tile_coords = get_tile_coords()
		game_mode.on_mouse_hover(tile_coords)
		
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var mouse_click_world = get_global_mouse_position()
		var space = get_world_2d().direct_space_state
		var query = PhysicsPointQueryParameters2D.new()
		
		query.position = mouse_click_world
		query.collide_with_areas = true
		query.collision_mask = CLICKABLE_CHARACTERS_MASK
		
		var hits = space.intersect_point(query)
		if hits.size() > 0:
			var area: Area2D = hits[0].collider
			var character = area.get_parent()
			game_mode.select_character(character)
		else:
			var clicked_tile = get_tile_coords()
			if board_manager.tile_data_map.has(clicked_tile):
				print("checking click works")
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
		game_mode.select_character(null)

func get_tile_coords() -> Vector2i:
	var mouse_world_pos := get_global_mouse_position()
	var local_pos : Vector2 = tile_map_layer_0.to_local(mouse_world_pos)
	var tile_coord: Vector2i = tile_map_layer_0.local_to_map(local_pos)
	return(tile_coord)
