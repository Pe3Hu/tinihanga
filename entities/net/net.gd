class_name Net
extends Node2D


@export var knot_scene: PackedScene
@export var battlefield: Battlefield

@onready var knots: Node2D = %Knots

var resource: NetResource

var type_to_faction_to_slot: Dictionary


func _ready() -> void:
	position = get_parent().size / 2#Catalog.NEX_PANEL_SIZE / 2#get_tree().get_root().size / 2
	#init_knots()
	
func init_knots() -> void:
	for knot in resource.knots:
		add_knot(knot)
	
func add_knot(knot_resource_: KnotResource) -> void:
	var knot = knot_scene.instantiate()
	knots.add_child(knot)
	knot.resource = knot_resource_
	
	if !type_to_faction_to_slot.has(knot.slot.type):
		type_to_faction_to_slot[knot.slot.type] = {}
		
	if !type_to_faction_to_slot[knot.slot.type].has(knot.slot.faction):
		type_to_faction_to_slot[knot.slot.type][knot.slot.faction] = {}
	
	if knot.resource.sub_index == 0:
		type_to_faction_to_slot[knot.slot.type][knot.slot.faction][knot.slot.faction] = knot.slot
	else:
		var opponent_faction = (Catalog.FACTIONS.find(knot.slot.faction) + sign(knot.resource.sub_index) + Catalog.FACTIONS.size()) % Catalog.FACTIONS.size()
		type_to_faction_to_slot[knot.slot.type][knot.slot.faction][opponent_faction] = knot.slot
