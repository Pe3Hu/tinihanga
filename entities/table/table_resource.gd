class_name TableResource
extends Node


var player: PlayerResource
var deck: DeckResource
var order_to_pile: Dictionary
var hand_pile: PileResource = PileResource.new()
var field_pile: PileResource = PileResource.new(3, State.Pile.FIELD)


func _init(player_: PlayerResource) -> void:
	player = player_
	
func update_faction() -> void:
	hand_pile.faction = player.faction
	field_pile.faction = player.faction

func fill_hand_pile() -> void:
	for _i in hand_pile.card_limit:
		var card = deck.draw_card()
		hand_pile.add_card(card)
