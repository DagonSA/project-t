extends Node2D
class_name EventTokenManager

@export var event_token_blueprint: PackedScene
@export var tilemap: TileMapLayer
@export var game_mode: GameMode
@export var board_manager: BoardManager
@export var initial_tokens_to_spawn: Array[EventTokenData]

var token_database := {}
	
func initial_token_spawn(tile_set: Dictionary):
	for tile in tile_set:
		var tile_to_spawn_token = (
			tile_set[tile].tile_def_reference.tile_id != Enums.TileID.SHIP_BLUE and
			tile_set[tile].tile_def_reference.tile_id != Enums.TileID.SHIP_ORANGE and
			tile_set[tile].tile_def_reference.tile_id != Enums.TileID.TERMINUS)
		if tile_to_spawn_token:
			var token = _draw_from_initial_bag()
			spawn_event_token(tile, token)
	game_mode.initial_tokens_spawned()
			
func spawn_event_token(coords: Vector2i, data: EventTokenData):
	var new_event_token = event_token_blueprint.instantiate()
	var position_global = tilemap.get_global_pos(coords)
	new_event_token.global_position = position_global
	new_event_token.token_data = data
	new_event_token._apply_data()
	board_manager.register_token(coords, new_event_token)
	add_child(new_event_token)
	

func _draw_from_initial_bag():
	var index = randi() % initial_tokens_to_spawn.size()
	return initial_tokens_to_spawn.pop_at(index)		
	
