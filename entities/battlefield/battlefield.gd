class_name Battlefield
extends CanvasLayer


@export var table_scene: PackedScene

@onready var net: Node2D = %Net
@onready var tables: Control = %Tables
@onready var avatar: Avatar = %Avatar

var resource: BattlefieldResource = BattlefieldResource.new()


func _ready() -> void:
	net.resource = resource.net
	avatar.resource = resource.avatar
	net.init_knots()
	init_tables()
	start_round()
	
	for knot in net.knots.get_children():
		knot.slot.recolor(State.Recolor.FACTION)
	
func init_tables() -> void:
	for player_resource in resource.referee.players:
		add_table(player_resource)
	
func add_table(player_resource_: PlayerResource) -> void:
	var table = table_scene.instantiate()
	table.resource = player_resource_.table
	var direction = player_resource_.knots[2].position
	tables.add_child(table)
	table.position = direction * Catalog.NET_TABLE_SCALE
	
func start_round() -> void:
	avatar.roll_element()
	
	for table in tables.get_children():
		table.fill_hand()
		
		table.resource.player.adviser.fill_pile_as_rnd_claw()
		table.pack_field_pile_from_adviser()
		var new_slot = net.type_to_faction_to_slot[State.Slot.FANG][table.field_pile.resource.faction][table.field_pile.resource.faction]
		new_slot.set_new_pile(table.field_pile)
			
