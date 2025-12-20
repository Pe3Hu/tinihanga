class_name DitchResource
extends Node


var island: IslandResource
var pits: Array[PitResource]
var habitats: Array[HabitatResource]
var type: State.Ditch


func _init(island_: IslandResource, habitats_: Array[HabitatResource]) -> void:
	island = island_
	habitats.append_array(habitats_)
	
	if habitats.front().ring != habitats.back().ring:
		type = State.Ditch.RIVER
