class_name Zone
extends Control


@onready var state_machine: StateMachine = %StateMachine
@onready var drop_point_detector: Area2D = %DropPointDetector
@onready var zones_detector: Area2D = %ZonesDetector
@onready var zone_container: MarginContainer = %ZoneContainer

@export var is_locked: bool = true:
	set(value_):
		is_locked = value_

var index: int = 0


func _ready() -> void:
	#name_label.text = name
	pass
	
func _input(event_: InputEvent) -> void:
	state_machine.on_input(event_)
	
func _on_gui_input(event_: InputEvent) -> void:
	state_machine.on_gui_input(event_)
	
func _on_mouse_entered() -> void:
	state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	state_machine.on_mouse_exited()
