class_name IslandResource
extends Node


var habitats: Array[HabitatResource]
var coord_to_habitat: Dictionary
var ring_to_habitat: Dictionary

var pits: Array[PitResource]
var vertex_to_pit: Dictionary

var ditchs: Array[DitchResource]


func _init() -> void:
	init_habitats()
	init_ditchs()
	
func init_habitats() -> void:
	add_habitat(Vector3i())
	
	for _i in Catalog.ISLAND_RING_LIMIT - 1:
		for habitat in ring_to_habitat[_i]:
			add_neighbors(habitat)
	
func add_neighbors(habitat_: HabitatResource) -> void:
	for direction in Catalog.CUBE_DIRCTIONS:
		var coord: Vector3i = habitat_.coord + direction
		
		if !coord_to_habitat.has(coord):
			add_habitat(coord)
	
func add_habitat(coord_: Vector3i) -> void:
	var habitat = HabitatResource.new(self, coord_)
	habitats.append(habitat)
	
func init_ditchs() -> void:
	for habitat in habitats:
		for direction in Catalog.CUBE_DIRCTIONS:
			var coord: Vector3i = direction + habitat.coord
			
			if coord_to_habitat.has(coord):
				var neighbor: HabitatResource = coord_to_habitat[coord]
				
				if !habitat.habitat_to_ditch.has(neighbor):
					add_ditch([habitat, neighbor])
	
func add_ditch(habitats_: Array[HabitatResource]) -> void:
	var ditch = DitchResource.new(self, habitats_)
	ditchs.append(ditch)
	habitats_.front().ditch_to_habitat[ditch] = habitats_.back()
	habitats_.back().ditch_to_habitat[ditch] = habitats_.front()
	habitats_.front().habitat_to_ditch[habitats_.back()] = ditch
	habitats_.back().habitat_to_ditch[habitats_.front()] = ditch
	#var d = habitats_.front().pits
	#var b = habitats_.back().pits
	#var c = d.filter(func (a): b.has(a))
	for pit in habitats_.front().pits:
		if habitats_.back().pits.has(pit):
			ditch.pits.append(pit)
			if !pit.is_pond:
				pit.is_pond = true
	#ditch.pits = habitats_.front().pits.filter(func (a): habitats_.back().pits.has(a))
	
