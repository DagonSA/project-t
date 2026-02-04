extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func highlight_tiles(tiles: Array[Vector2i]):
	clear()
	for tile in tiles:
		set_cell(tile, 0, Vector2i(0,0), 0)
		
func clear_highlight():
	clear()
