class_name Table
extends Control


@onready var active_pile: Pile = %ActivePile
@onready var hand_pile: Pile = %HandPile
@onready var active_slot: Slot = %ActiveSlot
@onready var hand_slot: Slot = %HandSlot

@export var card_scene: PackedScene


var deck: DeckResource = DeckResource.new()
var hand_card_resources: Array[CardResource]



func _ready() -> void:
	draw_cards()
	
func draw_cards() -> void:
	for _i in Catalog.pile_to_card_limit[State.Pile.HAND]:
		var card_resource = deck.draw_card()
		add_card(card_resource)
	
func add_card(card_resource_: CardResource) -> void:
	hand_card_resources.append(card_resource_)
	var card = card_scene.instantiate()
	hand_pile.cards_holder.add_child(card)
	card.resource = card_resource_
	card.current_pile = hand_pile
	#hand_pile.set_new_card(card)


func _on_undo_button_pressed() -> void:
	if active_pile.current_slot != active_slot:
		active_slot.set_new_pile(active_pile)
		active_pile.show_after_release()
		active_pile.is_locked = false
		active_pile.lock_button.button_pressed = false
