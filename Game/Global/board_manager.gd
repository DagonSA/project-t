extends Node

var tile_data_map := {}
signal board_changed
@onready var game_mode = $"../GameMode"

func _ready() -> void:
	game_mode.selected_character.connect(movement_initiation)

func register_tile(coords: Vector2i, tile_data: TileDataContainer):
	tile_data_map[coords] = tile_data
	board_changed.emit()
	
func movement_initiation(selected_char: Node):
	if not game_mode.is_movement_phase():
		return
	if not selected_char.can_character_initiate_move():
		return
		
		
		
	#print("yay")
