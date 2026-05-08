extends Character
class_name CharacterPlayer

var intellect: int

func _apply_stats():
	super()
	intellect = char_data.starting_intellect
