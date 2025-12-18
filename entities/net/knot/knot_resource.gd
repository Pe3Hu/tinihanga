class_name KnotResource
extends Node


var net: NetResource
var faction: State.Faction
var ring: int 
var sub_index: int 
var position: Vector2
var slot: State.Slot



func _init(net_: NetResource, faction_:  State.Faction, ring_: int, sub_index_: int, position_: Vector2) -> void:
	net = net_
	faction = faction_
	ring = ring_
	sub_index = sub_index_
	position = position_
	
	update_slot()

func update_slot() -> void:
	match ring:
		0:
			slot = State.Slot.FANG
		1:
			match abs(sub_index):
				0:
					slot = State.Slot.HEART
				1:
					slot = State.Slot.CLAW
		2:
			match abs(sub_index):
				0:
					slot = State.Slot.STOMACH
				1:
					slot = State.Slot.LUNG
				2:
					slot = State.Slot.TAIL
			
