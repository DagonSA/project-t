extends Node2D
class_name EventTokenManager

@export var event_token_blueprint: PackedScene
@export var tilemap: TileMapLayer

func spawn_event_token(coords: Vector2i):
	var new_event_token = event_token_blueprint.instantiate()
	var position_global = tilemap.get_global_pos(coords)
	new_event_token.global_position = position_global
	add_child(new_event_token)
	print(new_event_token)
	
	
