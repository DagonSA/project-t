extends Label

@export var game_mode: GameMode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_initial_text(
		1, #turn
		"Blue", #current team
		"Movement" #current phase
		)
	game_mode.action_phase_started.connect(_change_text_phase)
	game_mode.current_player_updated.connect(_change_text_player)


func _set_initial_text(turn: int, team: String, phase: String):
	text = "Turn: " + str(turn) + "\n" + "Current team: " + team + "\n" + "Phase: Movement"

func _change_text_phase(turn: int, team: Enums.Team, phase: String):
	text = "Turn: " + str(turn) + "\n" + "Current team: " + str(team) + "\n" + "Phase: " + phase

func _change_text_player(turn: int, team: String, phase: String):
	text = "Turn: " + str(turn) + "\n" + "Current team: " + team + "\n" + "Phase: Movement"
