class_name Knot
extends Node2D


var resource: KnotResource:
	set(value_):
		resource = value_
		position = resource.position


func _ready() -> void:
	pass
