extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game_mode = get_node("/root/Main/Game/GameMode")
	game_mode.selected_character.connect(_show_attack)
	
func _show_attack(char: Node2D):
	text = str(char.attack)
