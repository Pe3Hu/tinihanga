class_name DeckResource
extends Node


var battlefield: BattlefieldResource
var draw: PileResource = PileResource.new(Catalog.pile_to_card_limit[State.Pile.DECK], State.Pile.DECK)

@export var power: int = 4

var elements: Array[State.Element] = [
	State.Element.CHAOS, 
	State.Element.AQUA,
	State.Element.WIND,
	State.Element.FIRE,
	State.Element.EARTH
]

func _init(battlefield_: BattlefieldResource) -> void:
	battlefield = battlefield_
	init_cards()
	
func init_cards() -> void:
	for _i in range(1, power + 1):
		add_cards_with_power(_i)
	
	draw.cards.shuffle()
	
func add_cards_with_power(power_: int) -> void:
	for element in elements:
		add_card(element, power_)
	
func add_card(element_: State.Element, power_: int) -> void:
	var card = CardResource.new(self, element_, power_)
	draw.add_card(card)
	
func raise_power() -> void:
	power += 1
	add_cards_with_power(power)
	
func draw_card() -> CardResource:
	var card = draw.cards.back()
	return card
