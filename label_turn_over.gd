extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_change_text(1, "Blue")
	var game_mode = get_node("/root/Main/Game/GameMode")
	game_mode.turn_updated.connect(_change_text)
	
func _change_text(turn: int, team: String):
	text = "Turn: " + str(turn) + "\n" + "Current team: " + team
