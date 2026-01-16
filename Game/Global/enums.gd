extends Node

enum Team {BLUE, ORANGE}

#WallPatterns for tiles - COCOCO for ritual tiles, normal colors have 1 of each remaining
enum WallPatterns {
	OPEN, 
	COCOCO,
	CCOOOO,
	COCOOO,
	COOCOO
}

enum TileID {
	TERMINUS,
	LIBRARY,
	TEMPLE,
	HEART,
	MOUNTAIN_A,
	MOUNTAIN_B,
	MOUNTAIN_C,
	JUNGLE_A,
	JUNGLE_B,
	JUNGLE_C,
	DESERT_A,
	DESERT_B,
	DESERT_C,
	FORTRESS_A,
	FORTRESS_B,
	FORTRESS_C
}

enum TerrainType {
	ALL,
	MOUNTAIN,
	JUNGLE,
	DESERT,
	FORTRESS
}

enum SpecialType {
	TERMINUS,
	LIBRARY,
	TEMPLE,
	HEART,
	NONE
}
