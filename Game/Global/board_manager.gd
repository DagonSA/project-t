extends Node

var tile_data_map := {}
signal board_changed

func register_tile(coords: Vector2i, tile_data: TileDataContainer):
	tile_data_map[coords] = tile_data
	board_changed.emit()
