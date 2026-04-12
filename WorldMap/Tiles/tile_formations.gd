extends Node
class_name TileFormations

static var Formations := {
	Enums.StandingFormations.SOLO: {"center": [Vector2(0,0)]},
	Enums.StandingFormations.DOUBLE: {"center": [Vector2(-30, 0), Vector2(30, 0)]},
	Enums.StandingFormations.TRIPLE: {"center": [Vector2(0, -30), Vector2(-30, 10), Vector2(30,10)]},
}


const TEAM_SOLO_POS:= [
	Vector2(0,-30),
	Vector2(-30, 10),
	Vector2(30, 10)
]
