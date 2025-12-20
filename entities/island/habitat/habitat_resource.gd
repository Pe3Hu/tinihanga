class_name HabitatResource
extends Node


var island: IslandResource
var coord: Vector3i
var ring: int
var index: int

var ditch_to_habitat: Dictionary
var habitat_to_ditch: Dictionary


var pits: Array[PitResource]


func _init(island_: IslandResource, coord_: Vector3i) -> void:
	island = island_
	coord = coord_
	
	update_ring()
	init_pits()

func update_ring() -> void:
	ring = max(abs(coord.x), abs(coord.y))
	ring = max(abs(coord.z), ring)
	
	if !island.ring_to_habitat.has(ring):
		island.ring_to_habitat[ring] = []
	
	index = island.ring_to_habitat[ring].size()
	island.ring_to_habitat[ring].append(self)
	island.coord_to_habitat[coord] = self

func init_pits() -> void:
	var offset = Vector2()
	var ls = []
	ls.append(coord.x)
	ls.append(coord.y)
	ls.append(coord.z)
	var angle = {}
	angle.step = PI * 2 / ls.size()
	
	for _i in ls.size():
		var l = ls[_i]
		angle.current = angle.step * (_i)
		offset += Vector2.from_angle(angle.current) * Catalog.HABITAT_L * l
	
	for origin_vertex in Catalog.HEXAGON_VERTEXS:
		var vertex = offset + origin_vertex * Catalog.HABITAT_L
		vertex.x = snapped(vertex.x, 0.01)
		vertex.y = snapped(vertex.y, 0.01)
		add_pit(vertex)
	
func add_pit(vertex_: Vector2) -> void:
	var pit: PitResource
	if island.vertex_to_pit.has(vertex_):
		pit = island.vertex_to_pit[vertex_]
	else:
		pit = PitResource.new(island, vertex_)
		island.vertex_to_pit[vertex_] = pit
		island.pits.append(pit)
	
	pits.append(pit)
	pit.habitats.append(self)
