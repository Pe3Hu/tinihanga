class_name Knot
extends Node2D


var resource: KnotResource:
	set(value_):
		resource = value_
		position = resource.position
		#%Sprite2D.modulate = Catalog.faction_to_color[resource.faction]


func _ready() -> void:
	pass
