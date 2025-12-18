class_name Table
extends Control


@export var card_scene: PackedScene

@onready var field_pile: Pile = %FieldPile
@onready var hand_pile: Pile = %HandPile
@onready var field_slot: Slot = %FieldSlot
@onready var hand_slot: Slot = %HandSlot

var resource: TableResource


func _ready() -> void:
	field_pile.resource = resource.field_pile
	hand_pile.resource = resource.hand_pile
	field_slot.faction = field_pile.resource.faction
	hand_slot.faction = hand_pile.resource.faction
	
	#field_slot.recolor(State.Recolor.FACTION)
	#hand_slot.recolor(State.Recolor.FACTION)
	
func fill_hand() -> void:
	resource.fill_hand_pile()
	
	for card_resource in resource.hand_pile.cards:
		add_card(card_resource)
	
func add_card(card_resource_: CardResource) -> void:
	var card = card_scene.instantiate()
	hand_pile.cards_holder.add_child(card)
	card.resource = card_resource_
	card.current_pile = hand_pile
	#hand_pile.set_new_card(card)
	
func _on_undo_button_pressed() -> void:
	History.undo_redo.undo()
	
func _on_redo_button_pressed() -> void:
	History.undo_redo.redo()
	
func pack_field_pile_from_adviser() -> void:
	#resource.player.adviser.promote_pile_card_to_table()
	
	while !resource.player.adviser.pile.cards.is_empty():
		var card_resource = resource.player.adviser.pile.cards.back()
		resource.field_pile.add_card(card_resource)
		var card = hand_pile.get_card_based_on_resource(card_resource)
		field_pile.set_new_card(card)
	
	field_pile.pack_cards()
