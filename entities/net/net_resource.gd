class_name NetResource
extends Node


var knots: Array[KnotResource]
var ring_to_knots: Dictionary
var faction_to_knots: Dictionary


func _init() -> void:
	init_knots()
	
func init_knots() -> void:
	var axis_angle = PI * 2 / Catalog.NET_TOTAL_AXIS
	
	for _axis in Catalog.NET_TOTAL_AXIS:
		var angle = axis_angle * _axis + PI / 2
		for _ring in Catalog.NET_TOTAL_RING:
			var faction = Catalog.FACTIONS[_axis]
			var position = Vector2.from_angle(angle) * Catalog.NET_AXIS_OFFSET * (_ring + 0.66)
			add_knot(faction, _ring, position)
	
	fill_faction_knots()
	
func add_knot(faction_: State.Faction, ring_: int, position_: Vector2) -> void:
	var knot = KnotResource.new(self, faction_, ring_, position_)
	knots.append(knot)
	
	if !faction_to_knots.has(faction_):
		faction_to_knots[faction_] = []
	
	faction_to_knots[faction_].append(knot)
	
func fill_faction_knots() -> void:
	var n = Catalog.FACTIONS.size()
	var angle_bias = PI / 360 * 60
	
	for faction in faction_to_knots:
		var faction_index = Catalog.FACTIONS.find(faction)
		var next_index = (faction_index + 1) % n
		var previous_index = (faction_index + n - 1) % n
		var next_knots = faction_to_knots[Catalog.FACTIONS[next_index]]
		var previous_knots = faction_to_knots[Catalog.FACTIONS[previous_index]]
		
		for _ring in Catalog.NET_TOTAL_RING:
			var parts = _ring * 2 + 1
			var origin_knot = faction_to_knots[faction][_ring]
			var next_knot = next_knots[_ring]
			var previous_knot = previous_knots[_ring]
			var next_shift = (next_knot.position - origin_knot.position) / parts
			next_shift = next_shift.rotated(-angle_bias)
			var previous_shift = (previous_knot.position - origin_knot.position) / parts
			previous_shift = previous_shift.rotated(angle_bias)
			
			for _i in range(1, _ring + 1):
				var next_position = origin_knot.position + next_shift * _i
				add_knot(faction, _ring, next_position)
				var previous_position = origin_knot.position + previous_shift * _i
				add_knot(faction, _ring, previous_position)
