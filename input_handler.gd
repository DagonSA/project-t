extends Node2D

const CLICKABLE_CHARACTERS_MASK := 1 << 0
@onready var game_mode = $"../GameMode"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
		if game_mode.selected_char != null:
			game_mode.select_character(null)
