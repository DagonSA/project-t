extends Line2D
class_name IndicatorArrow

func draw_indicator_arrow(origin: Vector2i, target: Vector2i, color: Color):
	points = PackedVector2Array([Vector2(origin), Vector2(target)])
	default_color = color
