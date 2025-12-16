class_name Net
extends Node2D


@export var knot_scene: PackedScene
var resource: NetResource = NetResource.new()


func _ready() -> void:
	position = Catalog.NEX_PANEL_SIZE / 2#get_tree().get_root().size / 2
	init_knots()
	
func init_knots() -> void:
	for knot in resource.knots:
		add_knot(knot)
	
func add_knot(knot_resource_: KnotResource) -> void:
	var knot = knot_scene.instantiate()
	%Knots.add_child(knot)
	knot.resource = knot_resource_
