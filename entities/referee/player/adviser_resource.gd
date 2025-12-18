class_name AdviserResource
extends Node



var player: PlayerResource
var pile: PileResource = PileResource.new(3, State.Pile.PREFERENCE)


func _init(player_: PlayerResource) -> void:
	player = player_
	pile.faction = player.faction
	
func fill_pile_as_rnd_claw() -> void:
	for _i in 3:
		var card = player.table.hand_pile.cards.pick_random()
		pile.add_card(card)
	
#func promote_pile_card_to_table() -> void:
	#while !pile.cards.is_empty():
		#var card = pile.cards.back()
		#player.table.field_pile.add_card(card)
