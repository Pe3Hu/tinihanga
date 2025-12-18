class_name CardResource
extends Node


var deck: DeckResource
var element: State.Element
var power: int = 0
var current_pile: PileResource
var faction: State.Faction


func _init(deck_: DeckResource, element_: State.Element, power_: int) -> void:
	deck = deck_
	element = element_
	power = power_
