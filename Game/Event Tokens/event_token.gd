extends Node2D
class_name EventToken

var token_id: int
var token_type: Enums.EventTokensTypes
var token_data: EventTokenData
var token_heads: Texture2D
var is_token_scouted: bool = false
@onready var main_sprite = $Base_Token_Sprite
@onready var hover_sprite = $Hover_Sprite

# Called when the node enters the scene tree for the first time.
func _apply_data(): 
	if token_data == null:
		return
	_apply_stats()
	
func _apply_stats():
	token_id = token_data.event_token_id
	token_type = token_data.token_type
	token_heads = token_data.token_heads

func on_event_token_hover_enter():
	hover_sprite.texture = main_sprite.texture
	hover_sprite.global_position = global_position + Vector2(50, -50)
	hover_sprite.scale = Vector2(1.3, 1.3)
	hover_sprite.show()
	
func reveal_token():
	is_token_scouted = true
	$Base_Token_Sprite.texture = token_heads
	
func on_event_token_hover_exit():
	hover_sprite.hide()
	
func trigger_event_token():
	print("triggered")
	queue_free()
