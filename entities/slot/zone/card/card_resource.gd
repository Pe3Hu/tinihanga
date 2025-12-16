class_name CardResource
extends Node


@export var element: State.Element
@export var power: int = 0



func _init(element_: State.Element, power_: int) -> void:
	element = element_
	power = power_
