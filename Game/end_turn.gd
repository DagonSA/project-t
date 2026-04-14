extends Button

@export var game_mode: GameMode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_mode.show_end_movement_button.connect(show)
	pressed.connect(_on_pressed)

func _on_pressed():
	game_mode.movement_phase_finished
# Called every frame. 'delta' is the elapsed time since the previous frame.
