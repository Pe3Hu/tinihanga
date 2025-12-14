class_name StateMachine
extends Node


signal transitioned


@export var card: Card
@export var current_state: State.Machine = State.Machine.IDLE


func _ready():
	transitioned.connect(on_child_transition)
	
	if current_state:
		call_deferred("_enter")
	
func _enter():
	match current_state:
		State.Machine.IDLE:
			card.pivot_offset = Vector2.ZERO
		State.Machine.DRAG:
			card.index = card.get_index()
			
			var canvas_layer := get_tree().get_first_node_in_group("fields")
			if canvas_layer:
				card.reparent(canvas_layer)
		State.Machine.RELEASE:
			update_field()
			transitioned.emit(State.Machine.IDLE)
	
func update_field() -> void:
	var field_areas = card.drop_point_detector.get_overlapping_areas()
	
	if field_areas.is_empty():
		card.current_field.return_card_starting_position(card)
	elif field_areas[0].get_parent() == card.current_field:
		card.current_field.card_reposition(card)
	else:
		var new_field: Field = field_areas[0].get_parent()
		new_field.set_new_card(card)
	
func _exit():
	pass
	
func on_input(event_: InputEvent):
	match current_state:
		State.Machine.CLICK:
			if event_ is InputEventMouseMotion:
				transitioned.emit(State.Machine.DRAG)
		State.Machine.DRAG:
			var mouse_motion := event_ is InputEventMouseMotion
			var confirm = event_.is_action_released("mouse_left")
			
			if mouse_motion:
				card.global_position = card.get_global_mouse_position() - card.pivot_offset
			
			if confirm:
				get_viewport().set_input_as_handled()
				transitioned.emit(State.Machine.RELEASE)
	
func on_gui_input(event_: InputEvent):
	match current_state:
		State.Machine.HOVER:
			if event_.is_action_pressed("mouse_left"):
				card.pivot_offset = card.get_global_mouse_position() - card.global_position
				transitioned.emit(State.Machine.CLICK)
	
func on_mouse_entered():
	match current_state:
		State.Machine.IDLE:
			transitioned.emit(State.Machine.HOVER)
	
func on_mouse_exited():
	match current_state:
		State.Machine.HOVER:
			transitioned.emit(State.Machine.IDLE)
	
func on_child_transition(new_state_: State.Machine):
	_exit()
	call_deferred("_enter")
	current_state = new_state_
