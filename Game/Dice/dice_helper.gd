extends Node
class_name DiceHelper

const DICE_SET = {
	Enums.AttackRangeType.MELEE: {
		Enums.AttackDiceAdvantage.NONE: {
			"weights": {Enums.DiceSides.MISS: 5, Enums.DiceSides.HIT: 7},
			"images": {Enums.DiceSides.MISS: preload("res://Game/Dice/Dice images/NO Miss.png"), Enums.DiceSides.HIT: preload("res://Game/Dice/Dice images/NO Hit.png")},
			},
		Enums.AttackDiceAdvantage.ONE: {
			"weights": {Enums.DiceSides.MISS: 2, Enums.DiceSides.WEAK_HIT: 2, Enums.DiceSides.HIT: 6, Enums.DiceSides.STRONG_HIT: 2},
			"images": {Enums.DiceSides.MISS: preload("res://Game/Dice/Dice images/M1 Miss.png"), Enums.DiceSides.WEAK_HIT: preload("res://Game/Dice/Dice images/M1 Weak Hit.png"), Enums.DiceSides.HIT: preload("res://Game/Dice/Dice images/M1 Hit.png"), Enums.DiceSides.STRONG_HIT: preload("res://Game/Dice/Dice images/M1 Strong Hit.png")},
			},
		Enums.AttackDiceAdvantage.TWO: {
			"weights":  {Enums.DiceSides.MISS: 1, Enums.DiceSides.WEAK_HIT: 2,	Enums.DiceSides.HIT: 6,	Enums.DiceSides.STRONG_HIT: 3},
			"images": {Enums.DiceSides.MISS: preload("res://Game/Dice/Dice images/M2 Miss.png"), Enums.DiceSides.WEAK_HIT: preload("res://Game/Dice/Dice images/M2 Weak Hit.png"),	Enums.DiceSides.HIT: preload("res://Game/Dice/Dice images/M2 Hit.png"),	Enums.DiceSides.STRONG_HIT: preload("res://Game/Dice/Dice images/M2 Strong Hit.png")},
			},
		Enums.AttackDiceAdvantage.THREE_OR_MORE: {
			"weights": {Enums.DiceSides.WEAK_HIT: 2, Enums.DiceSides.HIT: 5, Enums.DiceSides.STRONG_HIT: 4,	Enums.DiceSides.CRIT: 1},
			"images": {Enums.DiceSides.WEAK_HIT: preload("res://Game/Dice/Dice images/M3 Weak Hit.png"), Enums.DiceSides.HIT: preload("res://Game/Dice/Dice images/M3 Hit.png"), Enums.DiceSides.STRONG_HIT: preload("res://Game/Dice/Dice images/M3 Strong Hit.png"),	Enums.DiceSides.CRIT: preload("res://Game/Dice/Dice images/M3 Crit.png")}
			},
		}
	}
	
		
const something = {
	Enums.AttackRangeType.RANGED: {
		Enums.AttackDiceAdvantage.NONE:
			{Enums.DiceSides.MISS: 5,
			Enums.DiceSides.HIT: 7},
		Enums.AttackDiceAdvantage.ONE: 
			{Enums.DiceSides.MISS: 2,
			Enums.DiceSides.HIT: 9,
			Enums.DiceSides.CRIT: 1},
		Enums.AttackDiceAdvantage.TWO:
			{Enums.DiceSides.MISS: 1,
			Enums.DiceSides.HIT: 10,
			Enums.DiceSides.CRIT: 1},
		Enums.AttackDiceAdvantage.THREE_OR_MORE:
			{Enums.DiceSides.HIT: 10,
			Enums.DiceSides.CRIT: 2},
		}
	}
	
			
	
