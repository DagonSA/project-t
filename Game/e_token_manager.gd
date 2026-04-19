extends Node2D
class_name EventTokenManager

@export var event_token_blueprint: PackedScene
@export var tilemap: TileMapLayer
@export var game_mode: GameMode
	
func initial_token_spawn(tile_set: Dictionary):
	for tile in tile_set:
		var tile_to_spawn_token = (
			tile_set[tile].tile_def_reference.tile_id != Enums.TileID.SHIP_BLUE and
			tile_set[tile].tile_def_reference.tile_id != Enums.TileID.SHIP_ORANGE and
			tile_set[tile].tile_def_reference.tile_id != Enums.TileID.TERMINUS)
		if tile_to_spawn_token:
			spawn_event_token(tile)
	game_mode.initial_tokens_spawned()
			
func spawn_event_token(coords: Vector2i):
	var new_event_token = event_token_blueprint.instantiate()
	var position_global = tilemap.get_global_pos(coords)
	new_event_token.global_position = position_global
	add_child(new_event_token)
	print(new_event_token)
