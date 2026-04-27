extends Label

@export var game_mode: GameMode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_mode.game_state_changed.connect(_change_text)
	_initial_text()


func _change_text(payload: Dictionary):
	var text_enum = payload.get("current_team", "unknown")
	var team_text_string = _enum_to_text(text_enum)

	text = "Turn: 1" + "\n" + "Current team: " + team_text_string + "\n" + "Phase: Movement"
	
func _initial_text():
	text = "Turn: 1" + "\n" + "Current team: " + "Blue" + "\n" + "Phase: Movement"

func _enum_to_text(text_enum) -> String:
		match text_enum:
			Enums.Team.BLUE:
				return "Blue"
			Enums.Team.ORANGE:
				return "Orange"
			_:
				return "Unknown"
