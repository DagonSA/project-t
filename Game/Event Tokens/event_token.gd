extends Node2D
class_name EventToken

var token_id: int
var token_type: Enums.EventTokensTypes
var token_data: EventTokenData
var token_heads: Texture2D

# Called when the node enters the scene tree for the first time.
func _apply_data(): 
	if token_data == null:
		return
	_apply_stats()
	
func _apply_stats():
	token_id = token_data.event_token_id
	token_type = token_data.token_type
	token_heads = token_data.token_heads
