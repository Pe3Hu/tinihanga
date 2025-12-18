class_name Knot
extends Node2D


var resource: KnotResource:
	set(value_):
		resource = value_
		position = resource.position
		slot.type = resource.slot
		slot.name_label.text = Catalog.slot_to_string[slot.type]
		slot.faction = resource.faction
		#%Sprite2D.modulate = Catalog.faction_to_color[resource.faction]

@onready var slot: Slot = %Slot
