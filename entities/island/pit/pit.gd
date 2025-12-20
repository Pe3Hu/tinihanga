class_name Pit
extends Sprite2D


var resource: PitResource:
	set(value_):
		resource = value_
		position = resource.vertex
