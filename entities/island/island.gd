class_name Island
extends Node2D


var resource: IslandResource = IslandResource.new()

@export var habitat_scene: PackedScene
@export var pit_scene: PackedScene
@export var ditch_scene: PackedScene

@onready var habitats: Node2D = %Habitats
@onready var pits: Node2D = %Pits
@onready var ditchs: Node2D = %Ditchs


func _ready() -> void:
	position = get_parent().size/2
	init_habitats()
	init_pits()
	init_ditchs()
	
func init_habitats() -> void:
	for habitat_resource in resource.habitats:
		add_habitat(habitat_resource)
	
func add_habitat(habitat_resource_: HabitatResource) -> void:
	var habitat = habitat_scene.instantiate()
	habitat.resource = habitat_resource_
	habitats.add_child(habitat)
	
func init_pits() -> void:
	for pit_resource in resource.pits:
		add_pit(pit_resource)
	
func add_pit(pit_resource_: PitResource) -> void:
	if pit_resource_.is_pond:
		var pit = pit_scene.instantiate()
		pit.resource = pit_resource_
		pits.add_child(pit)

func init_ditchs() -> void:
	for ditch_resource in resource.ditchs:
		add_ditch(ditch_resource)
	
func add_ditch(ditch_resource_: DitchResource) -> void:
	var ditch = ditch_scene.instantiate()
	ditch.resource = ditch_resource_
	ditchs.add_child(ditch)
