extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#get info from GM on selected char and pass its stats to all stat labels
	var game_mode = get_node("/root/Main/Game/GameMode")
	game_mode.selected_character.connect(_show_stats)
	
func _show_stats(char: Node2D):
	$SelCharName.text = char.name
	$Attack/AttValue.text = str(char.attack)
	$Defense/DefValue.text = str(char.defense)	
	$Speed/SpdValue.text = str(char.speed)
	$Intellect/IntValue.text = str(char.intellect)
	$Actions/ActValue.text = str(char.actions)
