extends Node2D

const BLACK_WALL_THICKNESS := 4.0
const WHITE_WALL_THICKNESS := 6.0
@export var tile_map: TileMapLayer
var tile_data: TileDataContainer 
@onready var board_manager = $"../../../BoardManager"

#cell coords - Array[bool], size 6
var coords: Vector2i
var walls_by_cell: Dictionary = {}

#Precomputed corner offsets for pointy top tiles (120, 140)
const OFFSETS := [
	Vector2(  0, -70),  # v0
	Vector2( 60, -35),  # v1
	Vector2( 60,  35),  # v2
	Vector2(  0,  70),  # v3
	Vector2(-60,  35),  # v4
	Vector2(-60, -35),  # v5
]

func _ready() -> void:
	board_manager.board_changed.connect(_on_board_changed)

func _on_board_changed():
	for coords in board_manager.tile_data_map:
		var wall_pattern = board_manager.tile_data_map[coords].final_wall_setup
		set_walls(coords, wall_pattern)

func set_walls(coords: Vector2i, pattern: Array) ->void: 
	assert(pattern.size() == 6)
	walls_by_cell[coords] = pattern
	queue_redraw()
	
func clear_walls(coords) -> void:
	walls_by_cell.erase(coords)
	queue_redraw()
	
func _draw() -> void:
	if tile_map == null:
		return
		
	for coords in walls_by_cell.keys():
		var pattern: Array = walls_by_cell[coords]
		if pattern == null or pattern.size() != 6:
			continue
				
		var center: Vector2 = tile_map.map_to_local(coords)
		
		#computing corners
		var v: Array[Vector2] = []
		v.resize(6)
		for i in 6:
			v[i] = center + OFFSETS[i]
			
		# pattern[0] = NE edge => v0->v1, then clockwise
		for i in 6:
			if pattern[i]:
				var a := v[i]
				var b := v[(i + 1) % 6]
				draw_line(a, b, Color.WHITE, WHITE_WALL_THICKNESS, true)
				draw_line(a, b, Color.BLACK, BLACK_WALL_THICKNESS, true)
