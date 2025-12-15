class_name Pile
extends Zone


@onready var card_drop_area_right: Area2D = %CardDropAreaRight
@onready var card_drop_area_left: Area2D = %CardDropAreaLeft
@onready var cards_holder: HBoxContainer = %CardsHolder
@onready var lock_button: CheckButton = %LockCheckButton
@onready var current_slot: Slot


func _ready() -> void:
	#%Label.text = name
	_on_lock_check_box_pressed()
	resize_collision_shapes()
	
	for child in cards_holder.get_children():
		var card := child as Card
		card.current_pile = self
	
func resize_collision_shapes() -> void:
	var origin_size = zone_container.size
	custom_minimum_size = origin_size
	var collision_shape = drop_point_detector.get_child(0)
	collision_shape.shape.size = origin_size
	collision_shape.position = origin_size / 2
	collision_shape = zones_detector.get_child(0)
	collision_shape.shape.size = origin_size
	collision_shape.position = origin_size / 2
	
	collision_shape = card_drop_area_left.get_child(0)
	collision_shape.shape.size = Vector2(origin_size.x / 2, origin_size.y)
	collision_shape.position = Vector2(origin_size.x / 4, origin_size.y / 2)
	card_drop_area_right.position.x = origin_size.x / 2
	collision_shape = card_drop_area_right.get_child(0)
	collision_shape.shape.size = Vector2(origin_size.x / 2, origin_size.y)
	collision_shape.position = Vector2(origin_size.x / 4, origin_size.y / 2)
	
func return_card_starting_position(card_: Card) -> void:
	cards_holder.remove_child(card_)
	cards_holder.add_child(card_)
	#card_.reparent(cards_holder)
	cards_holder.move_child(card_, card_.index)
	
func set_new_card(card_: Card) -> void:
	card_reposition(card_)
	card_.current_pile.update_card_index()
	card_.current_pile = self
	
func card_reposition(card_: Card) -> void:
	var pile_areas = card_.drop_point_detector.get_overlapping_areas()
	var card_areas = card_.zones_detector.get_overlapping_areas()
	var _index: int = 0
	
	if card_areas.is_empty():
		#print(pile_areas.has(card_drop_area_left))
		if pile_areas.has(card_drop_area_right):
			_index = cards_holder.get_children().size()
	elif card_areas.size() == 1:
		if pile_areas.has(card_drop_area_left):
			_index = card_areas[0].get_parent().get_index()
		else:
			_index = card_areas[0].get_parent().get_index() + 1
	else:
		_index = card_areas[0].get_parent().get_index()
		if _index > card_areas[1].get_parent().get_index():
			_index = card_areas[1].get_parent().get_index()
		
		_index += 1

	card_.reparent(cards_holder)
	cards_holder.remove_child(card_)
	cards_holder.add_child(card_)
	cards_holder.move_child(card_, _index)
	update_card_index()
	
func update_card_index() -> void:
	for card in cards_holder.get_children():
		card.index = card.get_index()
		card.update_name_label()
		
func _on_lock_check_box_pressed() -> void:
	is_locked = !lock_button.button_pressed
