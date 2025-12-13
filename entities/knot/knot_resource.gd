class_name KnotResource
extends Node


var net: NetResource
var faction: State.Faction
var ring: int 
var position: Vector2



func _init(net_: NetResource, faction_:  State.Faction, ring_: int, position_: Vector2) -> void:
	net = net_
	faction = faction_
	ring = ring_
	position = position_
