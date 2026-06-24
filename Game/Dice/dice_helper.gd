extends Node
class_name DiceHelperDuplicate

const MISS = Enums.DiceSides.MISS
const WEAK_HIT = Enums.DiceSides.WEAK_HIT
const HIT = Enums.DiceSides.HIT
const STRONG_HIT = Enums.DiceSides.STRONG_HIT
const CRIT = Enums.DiceSides.CRIT

var sound_miss = preload("res://Sounds/Attack_results/attack_miss.ogg")
var sound_weak_hit = preload("res://Sounds/Attack_results/attack_weak_hit.ogg")
var sound_hit = preload("res://Sounds/Attack_results/attack_hit.ogg")
var sound_strong_hit = preload("res://Sounds/Attack_results/attack_strong_hit.ogg")
var sound_crit = preload("res://Sounds/Attack_results/attack_crit.ogg")

var DICE_SET = {
	Enums.AttackRangeType.MELEE: {
		Enums.AttackDiceAdvantage.NONE: {
			"weights": 
				{MISS: 5, HIT: 7},
			"images": 
				{MISS: preload("res://Game/Dice/Dice images/NO Miss.png"), HIT: preload("res://Game/Dice/Dice images/NO Hit.png")},
			"sounds": 
				{MISS: sound_miss, HIT: sound_hit}
			},
		Enums.AttackDiceAdvantage.ONE: {
			"weights": 
				{MISS: 2, WEAK_HIT: 2, HIT: 6, STRONG_HIT: 2},
			"images": 
				{MISS: preload("res://Game/Dice/Dice images/M1 Miss.png"), WEAK_HIT: preload("res://Game/Dice/Dice images/M1 Weak Hit.png"), HIT: preload("res://Game/Dice/Dice images/M1 Hit.png"), STRONG_HIT: preload("res://Game/Dice/Dice images/M1 Strong Hit.png")},
			"sounds":
				{MISS: sound_miss, WEAK_HIT: sound_weak_hit}
			},
		Enums.AttackDiceAdvantage.TWO: {
			"weights":
				{MISS: 1, WEAK_HIT: 2, HIT: 6, STRONG_HIT: 3},
			"images":
				{MISS: preload("res://Game/Dice/Dice images/M2 Miss.png"), WEAK_HIT: preload("res://Game/Dice/Dice images/M2 Weak Hit.png"), HIT: preload("res://Game/Dice/Dice images/M2 Hit.png"),	STRONG_HIT: preload("res://Game/Dice/Dice images/M2 Strong Hit.png")},
			"sounds":
				{MISS: sound_miss, WEAK_HIT: sound_weak_hit, HIT: sound_hit, STRONG_HIT: sound_strong_hit}
			},
		Enums.AttackDiceAdvantage.THREE_OR_MORE: {
			"weights":
				{WEAK_HIT: 2, HIT: 5, STRONG_HIT: 4, CRIT: 1},
			"images":
				 {WEAK_HIT: preload("res://Game/Dice/Dice images/M3 Weak Hit.png"), HIT: preload("res://Game/Dice/Dice images/M3 Hit.png"), STRONG_HIT: preload("res://Game/Dice/Dice images/M3 Strong Hit.png"), CRIT: preload("res://Game/Dice/Dice images/M3 Crit.png")},
			"sounds":
				 {WEAK_HIT: sound_weak_hit, HIT: sound_hit, STRONG_HIT: sound_strong_hit, CRIT: sound_crit}
			}
		},
	Enums.AttackRangeType.RANGED: {
		Enums.AttackDiceAdvantage.NONE: {
			"weights":
				{MISS: 5, HIT: 7},
			"images":
				{MISS: preload("res://Game/Dice/Dice images/NO Miss.png"), HIT: preload("res://Game/Dice/Dice images/NO Hit.png")},
			"sounds":
				{MISS: sound_miss, HIT: sound_hit, CRIT: sound_crit}
				},
		Enums.AttackDiceAdvantage.ONE: {
			"weights":
				{MISS: 2, HIT: 9, CRIT: 1},
			"images": 
				{MISS: preload("res://Game/Dice/Dice images/R1 Miss.png"), HIT: preload("res://Game/Dice/Dice images/R1 Hit.png"), CRIT: preload("res://Game/Dice/Dice images/R1 Crit.png")},
			"sounds":
				{MISS: sound_miss, HIT: sound_hit, CRIT: sound_crit}
				},
		Enums.AttackDiceAdvantage.TWO: {
			"weights":
				{MISS: 1, HIT: 10, CRIT: 1},
			"images": 
				{MISS: preload("res://Game/Dice/Dice images/R2 Miss.png"), HIT: preload("res://Game/Dice/Dice images/R2 Hit.png"), CRIT: preload("res://Game/Dice/Dice images/R2 Crit.png")},
			"sounds":
				{MISS: sound_miss, HIT: sound_hit, CRIT: sound_crit}
				},
		Enums.AttackDiceAdvantage.THREE_OR_MORE: {
			"weights":
				{HIT: 10, CRIT: 2},
			"images": 
				{HIT: preload("res://Game/Dice/Dice images/R3 Hit.png"), CRIT: preload("res://Game/Dice/Dice images/R3 Crit.png")},
			"sounds":
				{MISS: sound_miss, HIT: sound_hit, CRIT: sound_crit}
				}
			}
		}
	
			
	
