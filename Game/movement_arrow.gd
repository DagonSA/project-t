extends Node2D
class_name MovementArrow

func draw_movement_arrow(origin: Vector2i, target: Vector2i):
	self.points = PackedVector2Array([Vector2(origin), Vector2(target)])
	print(target)
