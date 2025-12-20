class_name PitResource
extends Node


var island: IslandResource
var vertex: Vector2
var ring: int

var habitats: Array[HabitatResource]
var is_pond: bool = false


func _init(island_: IslandResource, vertex_: Vector2) -> void:
	island = island_
	vertex = vertex_
