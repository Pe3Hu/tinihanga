class_name Pile
extends Zone


@onready var card_drop_area_right: Area2D = %CardDropAreaRight
@onready var card_drop_area_left: Area2D = %CardDropAreaLeft
@onready var cards_holder: HBoxContainer = %CardsHolder
@onready var lock_button: CheckButton = %LockCheckButton
@onready var power_token: Token = %PowerToken
@onready var current_slot: Slot

@export var type: State.Pile


func _ready() -> void:
	#%Label.text = name
	_on_lock_check_box_pressed()
	recreate_collision_shapes()
	resize_collision_shapes()
	
	for child in cards_holder.get_children():
		var card := child as Card
		card.current_pile = self
	
func recreate_collision_shapes() -> void:
	var collision_shape = card_drop_area_right.get_child(0)
	collision_shape.shape = RectangleShape2D.new()
	collision_shape = card_drop_area_left.get_child(0)
	collision_shape.shape = RectangleShape2D.new()
	
	collision_shape = drop_point_detector.get_child(0)
	collision_shape.shape = RectangleShape2D.new()
	collision_shape = zones_detector.get_child(0)
	collision_shape.shape = RectangleShape2D.new()
	
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
	if Catalog.pile_to_card_limit[type] == cards_holder.get_child_count():
		card_.current_pile.return_card_starting_position(card_)
		return
	
	card_reposition(card_)
	card_.current_pile.update_power_token(card_, false)
	card_.current_pile.update_card_index()
	card_.current_pile = self
	update_power_token(card_, true)
	
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
		#card.update_value_label()
	
func _on_lock_check_box_pressed() -> void:
	is_locked = !lock_button.button_pressed
	
	if type == State.Pile.ACTIVE:
		if !is_locked:
			hide_while_drag()
		else:
			show_after_release()
	
func update_power_token(card_: Card, is_added_: bool) -> void:
	if is_added_:
		if cards_holder.get_child_count() == 1:
			power_token.element = card_.resource.element
			power_token.value_int = card_.resource.power
		else:
			power_token.value_int += card_.resource.power
			power_token.element = get_pile_element()
	else:
		if cards_holder.get_child_count() == 0:
			reset_power_token()
		else:
			power_token.value_int -= card_.resource.power
			power_token.element = get_pile_element()
	
	if cards_holder.get_child_count() < 3:
		print([is_added_, power_token.element])
	
func reset_power_token() -> void:
	power_token.element = State.Element.CHAOS
	power_token.value_int = 0
	
func get_pile_element() -> State.Element:
	var elements = []
	
	for card in cards_holder.get_children():
		if !elements.has(card.resource.element):
			if card.resource.element != State.Element.CHAOS:
				elements.append(card.resource.element)
		if elements.size() > 1:
			return State.Element.CHAOS
	
	if elements.is_empty():
		return State.Element.CHAOS
	
	return elements.front()
	
func hide_while_drag() -> void:
	cards_holder.visible = false
	lock_button.visible = false
	
	zone_container.size = Catalog.CARD_MAX_SIZE
	resize_collision_shapes()
	size = custom_minimum_size
	
func show_after_release() -> void:
	#if true: return
	cards_holder.visible = true
	lock_button.visible = true
	zone_container.size = Catalog.pile_to_size[type]
	resize_collision_shapes()
