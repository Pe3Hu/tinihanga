class_name Habitat
extends Polygon2D


var resource: HabitatResource:
	set(value_):
		resource = value_
		set_vertexs()
		set_position_based_on_coord()
		recolor_based_on_index()


func set_vertexs() -> void:
	var vertexs = []
	
	for vertex in Catalog.HEXAGON_VERTEXS:
		vertexs.append(vertex  * Catalog.HABITAT_L)
	
	set_polygon(vertexs)

func set_position_based_on_coord() -> void:
	position = Vector2()
	var ls = []
	ls.append(resource.coord.x)
	ls.append(resource.coord.y)
	ls.append(resource.coord.z)
	var angle = {}
	angle.step = PI * 2 / ls.size()
	
	for _i in ls.size():
		var l = ls[_i]
		angle.current = angle.step * (_i)
		position += Vector2.from_angle(angle.current) * Catalog.HABITAT_L * l
	
func recolor_based_on_ring() -> void:
	var h = float(resource.ring) / Catalog.ISLAND_RING_LIMIT
	color = Color.from_hsv(h, 0.75, 1.0)
	
func recolor_based_on_index() -> void:
	if resource.ring == 0:
		color = Color.DIM_GRAY
		return
	var h = float(resource.index) / (resource.ring * 6 + 1)
	var s = 1.0 - 0.8 / (Catalog.ISLAND_RING_LIMIT - 1) * (resource.ring - 1)
	color = Color.from_hsv(h, s, 1.0)
