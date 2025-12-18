class_name Slot
extends MarginContainer


@onready var pile_drop_area_top: Area2D = %PileDropAreaTop
@onready var pile_drop_area_down: Area2D = %PileDropAreaDown
@onready var piles_holder: VBoxContainer = %PilesHolder
@onready var name_label: Label = %NameLabel
@onready var color_rect: ColorRect = %ColorRect

@export var type: State.Slot
@export var pack: State.Pack
@export var is_loner: bool = true
@export var faction: State.Faction


func _ready() -> void:
	recreate_collision_shapes()
	resize_collision_shapes()
	name_label.text = Catalog.slot_to_string[type]
	
	for child in piles_holder.get_children():
		var pile := child as Pile
		pile.current_slot = self
	
func recreate_collision_shapes() -> void:
	var collision_shape = pile_drop_area_top.get_child(0)
	collision_shape.shape = RectangleShape2D.new()
	collision_shape = pile_drop_area_down.get_child(0)
	collision_shape.shape = RectangleShape2D.new()
	
func resize_collision_shapes() -> void:
	var collision_shape = pile_drop_area_top.get_child(0)
	collision_shape.shape.size = Vector2(size.x, size.y / 2)
	collision_shape.position = Vector2(size.x / 2, size.y / 4)
	pile_drop_area_down.position.y = size.y / 2
	collision_shape = pile_drop_area_down.get_child(0)
	collision_shape.shape.size = Vector2(size.x, size.y / 2)
	collision_shape.position = Vector2(size.x / 2, size.y / 4)
	
func return_pile_starting_position(pile_: Pile) -> void:
	piles_holder.remove_child(pile_)
	piles_holder.add_child(pile_)
	#pile_.reparent(piles_holder)
	piles_holder.move_child(pile_, pile_.index)
	
func set_new_pile(pile_: Pile) -> void:
	if is_loner and piles_holder.get_child_count() == 1 or pile_.resource.faction != faction:
		pile_.current_slot.return_pile_starting_position(pile_)
		return
	
	if pack != State.Pack.ANY:
		pile_.status = State.Status.PINNED
	
	pile_reposition(pile_)
	pile_.current_slot = self
	
func pile_reposition(pile_: Pile) -> void:
	var slot_areas = pile_.drop_point_detector.get_overlapping_areas()
	var pile_areas = pile_.zones_detector.get_overlapping_areas()
	var index: int = 0
	
	if pile_areas.is_empty():
		#print(slot_areas.has(pile_drop_area_down))
		if slot_areas.has(pile_drop_area_down):
			index = piles_holder.get_children().size()
	elif pile_areas.size() == 1:
		if slot_areas.has(pile_drop_area_top):
			index = pile_areas[0].get_parent().get_index()
		else:
			index = pile_areas[0].get_parent().get_index() + 1
	else:
		index = pile_areas[0].get_parent().get_index()
		if index > pile_areas[1].get_parent().get_index():
			index = pile_areas[1].get_parent().get_index()
		
		index += 1
	
	pile_.reparent(piles_holder)
	piles_holder.remove_child(pile_)
	piles_holder.add_child(pile_)
	piles_holder.move_child(pile_, index)
	
func recolor(recolor_layer_: State.Recolor = State.Recolor.DEFAULT) -> void:
	match recolor_layer_:
		State.Recolor.DEFAULT:
			color_rect.color = Color("525252")
		State.Recolor.FACTION:
			color_rect.color = Catalog.faction_to_color[faction]
