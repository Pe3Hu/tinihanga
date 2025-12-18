class_name PlayerResource
extends Node



var referee: RefereeResource
var adviser: AdviserResource = AdviserResource.new(self)
var faction: State.Faction
var table: TableResource = TableResource.new(self)
var knots: Array[KnotResource]


func _init(referee_: RefereeResource, faction_: State.Faction) -> void:
	referee = referee_
	faction = faction_
