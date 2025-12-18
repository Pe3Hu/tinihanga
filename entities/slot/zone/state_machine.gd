class_name StateMachine
extends Node


signal transitioned


@export var zone: Zone
@export var current_state: State.Machine = State.Machine.IDLE:
	set(value_):
		current_state = value_
		
		if current_state == State.Machine.DRAG:
			pass
		
		if zone as Card:
			zone.state_label.text = Catalog.machine_to_string[current_state]


func _ready() -> void:
	transitioned.connect(on_child_transition)
	
	if current_state:
		call_deferred("_enter")
	
func _enter() -> void:
	if zone as Pile:
		if zone.status != State.Status.PACKED: return
	if zone as Card:
		if zone.status != State.Status.WAITING: return
	match current_state:
		State.Machine.IDLE:
			zone.pivot_offset = Vector2.ZERO
		State.Machine.DRAG:
			zone.index = zone.get_index()
			
			var canvas_layer := get_tree().get_first_node_in_group("piles")
			if canvas_layer:
				zone.reparent(canvas_layer)
		State.Machine.RELEASE:
			drop_update()
			transitioned.emit(State.Machine.IDLE)
	
func drop_update() -> void:
	if zone as Pile:
		if zone.status != State.Status.PACKED: return
		update_current_slot()
	if zone as Card:
		if zone.status != State.Status.WAITING: return
		update_current_pile()
	
func update_current_pile() -> void:
	if zone.current_pile.state_machine.current_state != State.Machine.IDLE: return
	var pile_areas = zone.drop_point_detector.get_overlapping_areas()
	pile_areas = pile_areas.filter(func (a): return a.get_parent() as Pile)
	
	if pile_areas.is_empty():
		zone.current_pile.return_card_starting_position(zone)
	elif pile_areas[0].get_parent() == zone.current_pile:
		zone.current_pile.card_reposition(zone)
	else:
		var new_pile: Pile = pile_areas[0].get_parent()
		
		History.undo_redo.create_action("Card to Pile")
		History.undo_redo.add_do_method(new_pile.set_new_card.bind(zone))
		#History.undo_redo.add_do_reference(zone)
		History.undo_redo.add_undo_method(zone.previous_pile.set_new_card.bind(zone))
		History.undo_redo.commit_action()
		#new_pile.set_new_card(zone)
	
func update_current_slot() -> void:
	var slot_areas = zone.drop_point_detector.get_overlapping_areas()
	slot_areas = slot_areas.filter(func (a): return a.get_parent() as Slot)
	
	if slot_areas.is_empty():
		zone.current_slot.return_pile_starting_position(zone)
	elif slot_areas[0].get_parent() == zone.current_slot:
		zone.current_slot.pile_reposition(zone)
	else:
		var new_slot: Slot = slot_areas[0].get_parent()
		
		History.undo_redo.create_action("Pile to Slot")
		History.undo_redo.add_do_method(new_slot.set_new_pile.bind(zone))
		#History.undo_redo.add_do_reference(zone)
		History.undo_redo.add_undo_method(zone.previous_slot.set_new_pile.bind(zone))
		History.undo_redo.commit_action()
		#new_slot.set_new_pile(zone)
	
func on_input(event_: InputEvent) -> void:
	if zone as Pile:
		if zone.status != State.Status.PACKED: return
	if zone as Card:
		if zone.status != State.Status.WAITING: return
	match current_state:
		State.Machine.CLICK:
			if event_ is InputEventMouseMotion:
				transitioned.emit(State.Machine.DRAG)
		State.Machine.DRAG:
			var mouse_motion := event_ is InputEventMouseMotion
			var confirm = event_.is_action_released("mouse_left")
			
			if mouse_motion:
				zone.global_position = zone.get_global_mouse_position() - zone.pivot_offset
			
			if confirm:
				get_viewport().set_input_as_handled()
				transitioned.emit(State.Machine.RELEASE)
	
func on_gui_input(event_: InputEvent) -> void:
	if zone as Pile:
		if zone.status != State.Status.PACKED: return
	if zone as Card:
		if zone.status != State.Status.WAITING: return
	match current_state:
		State.Machine.HOVER:
			if event_.is_action_pressed("mouse_left"):
				zone.pivot_offset = zone.get_global_mouse_position() - zone.global_position
				transitioned.emit(State.Machine.CLICK)
	
func on_mouse_entered() -> void:
	if zone as Pile:
		if zone.status != State.Status.PACKED: return
	if zone as Card:
		if zone.status != State.Status.WAITING: return
	match current_state:
		State.Machine.IDLE:
			transitioned.emit(State.Machine.HOVER)
	
func on_mouse_exited() -> void:
	if zone as Pile:
		if zone.status != State.Status.PACKED: return
	if zone as Card:
		if zone.status != State.Status.WAITING: return
	match current_state:
		State.Machine.HOVER:
			transitioned.emit(State.Machine.IDLE)
	
func on_child_transition(new_state_: State.Machine) -> void:
	#if zone as Pile:
		#if zone.status != State.Status.PACKED: return
	#if zone as Card:
		#if zone.status != State.Status.WAITING: return
	call_deferred("_enter")
	current_state = new_state_
