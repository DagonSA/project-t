extends Node

enum Team {
	BLUE,
	ORANGE,
	MONSTER
	}
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
	FORTRESS_C,
	SHIP_BLUE,
	SHIP_ORANGE
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
	SHIP,
	NONE
}

enum TurnPhase {
	MOVEMENT_PHASE,
	ACTION_PHASE
}

enum CharacterState {
	IDLE,
	PREMOVE,
	MOVING,
	MOVED,
	PREATTACKING
}

enum EventTokensTypes {
	LURKER,
	HUNTER,
	LOOTEQ,
	LOOTCARDS,
	PASSAGE,
	PORTAL,
	MOUNTAIN,
	DESERT,
	JUNGLE
}

enum AttackRangeType {
	MELEE,
	RANGED
}

enum AttackDiceAdvantage {
	NONE,
	ONE,
	TWO,
	THREE_OR_MORE
}

enum DiceSides {
	MISS,
	WEAK_HIT,
	HIT,
	STRONG_HIT,
	CRIT
}
