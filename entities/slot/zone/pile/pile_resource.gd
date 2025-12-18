class_name PileResource
extends Node


var card_limit: int
var cards: Array[CardResource]
var current_power: int = 0
var type: State.Pile
var faction: State.Faction


func _init(card_limit_: int = 6, type_: State.Pile = State.Pile.HAND, faction_: State.Faction = State.Faction.NONE) -> void:
	card_limit = card_limit_
	type = type_
	faction = faction_
	
func add_card(card_: CardResource) -> void:
	if card_.current_pile != null:
		card_.current_pile.remove_card(card_)
	
	if card_.faction == State.Faction.NONE:
		card_.faction = faction
	
	card_.current_pile = self
	cards.append(card_)
	if type == State.Pile.FIELD:
		current_power += card_.power
	
func remove_card(card_: CardResource) -> void:
	cards.erase(card_)
	if type == State.Pile.FIELD:
		current_power -= card_.power
