## Responsible for:
## Registering spawned tiles in a tile manager
## Initiating movement

extends Node

var tile_data_map := {}
var tile_occupation_map : Dictionary[Vector2i, Array] = {}
signal board_changed
@onready var game_mode = $"../GameMode"
@onready var tilemap_base_L0 = $"../L0_tilemap_data"
@onready var tilemap_highlight_L1 = $"../L1_tilemap_highlight"

func _ready() -> void:
	pass

## called from tilespawner when a tile spawns
func register_tile(coords: Vector2i, tile_data: TileDataContainer):
	tile_data_map[coords] = tile_data
	tile_occupation_map[coords] = []
	board_changed.emit()

	
