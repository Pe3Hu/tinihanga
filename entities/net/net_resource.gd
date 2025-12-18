class_name NetResource
extends Node


var battlefield: BattlefieldResource
var referee: RefereeResource
var knots: Array[KnotResource]
var ring_to_knots: Dictionary


func _init(battlefield_: BattlefieldResource) -> void:
	battlefield = battlefield_
	
func init_knots() -> void:
	var axis_angle = PI * 2 / Catalog.NET_TOTAL_AXIS
	
	for _axis in Catalog.NET_TOTAL_AXIS:
		var angle = axis_angle * _axis + PI / 2
		for _ring in Catalog.NET_TOTAL_RING:
			var faction = Catalog.FACTIONS[_axis]
			var l = Catalog.NET_RING_OFFSET * _ring + Catalog.NET_AXIS_OFFSET
			var position = Vector2.from_angle(angle) * l
			var sub_index = 0
			add_knot(faction, _ring, sub_index, position)
	
	fill_faction_knots()
	
func add_knot(faction_: State.Faction, ring_: int, sub_index_: int, position_: Vector2) -> void:
	var knot = KnotResource.new(self, faction_, ring_, sub_index_, position_)
	knots.append(knot)
	var player = referee.faction_to_player[faction_]
	player.knots.append(knot)
	
func fill_faction_knots() -> void:
	var n = Catalog.FACTIONS.size()
	var angle_bias = PI / 360 * 60
	
	for player in referee.players:
		var faction_index = Catalog.FACTIONS.find(player.faction)
		var next_index = (faction_index + 1) % n
		var previous_index = (faction_index + n - 1) % n
		var next_knots = referee.faction_to_player[Catalog.FACTIONS[next_index]].knots
		var previous_knots = referee.faction_to_player[Catalog.FACTIONS[previous_index]].knots
		
		for _ring in Catalog.NET_TOTAL_RING:
			var parts = _ring * 2 + 1
			var origin_knot = player.knots[_ring]
			var next_knot = next_knots[_ring]
			var previous_knot = previous_knots[_ring]
			var next_shift = (next_knot.position - origin_knot.position) / parts
			next_shift = next_shift.rotated(-angle_bias)
			var previous_shift = (previous_knot.position - origin_knot.position) / parts
			previous_shift = previous_shift.rotated(angle_bias)
			
			for _i in range(1, _ring + 1):
				var next_position = origin_knot.position + next_shift * _i
				add_knot(player.faction, _ring, _i, next_position)
				var previous_position = origin_knot.position + previous_shift * _i
				add_knot(player.faction, _ring, -_i,  previous_position)
