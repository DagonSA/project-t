#Camera_2d_movement
#Script for mouse screen edge scroll + zoom in


#!!!!!!! Check (https://www.reddit.com/r/godot/comments/pmd21r/edge_scrolling_in_2d_game/)
#Check if accounting for window size will work here (getting size every frame helped)



extends Camera2D

var screen_size = get_viewport_rect().size
var edge_treshold = 20
var scroll_speed = 100
var move_dir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	print(screen_size)
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	move_dir = Vector2.ZERO
	if mouse_pos.x < edge_treshold:
		move_dir.x = -1
	if mouse_pos.x > screen_size.x - edge_treshold:
		move_dir.x = 1
	if mouse_pos.y < edge_treshold:
		move_dir.y = -1
	if mouse_pos.y > screen_size.y - edge_treshold:
		move_dir.y = 1
	position += move_dir * scroll_speed * delta
	print(screen_size)
