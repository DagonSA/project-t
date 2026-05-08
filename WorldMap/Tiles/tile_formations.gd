extends Node
class_name TileFormations

const ONE_TEAM_FORMATION := [
	[Vector2(0,0)],
	[Vector2(-30, 0), Vector2(30, 0)],
	[Vector2(0, -30), Vector2(-30, 10), Vector2(30,10)]
	]
	
const TWO_TEAM_FORMATION := [
	[Vector2(-28, 0)],
	[Vector2(-30, -30), Vector2(-30, 20)],
	[Vector2(-10, -30), Vector2(-10, 20), Vector2(-40, 0)]
	]
	
const SIDE_BLUE_RIGHT_X = Vector2(58, 0)
const SIDE_ORANGE_LEFT_X = Vector2(0, 0)
