class_name PileResource
extends Node


var card_limit: int = 6
var cards: Array[CardResource]
var current_power: int = 0



func add_card(card_: CardResource) -> void:
	cards.append(card_)
	current_power += card_.power
	
func remove_card(card_: CardResource) -> void:
	cards.erase(card_)
	current_power -= card_.power
