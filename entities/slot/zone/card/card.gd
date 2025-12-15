class_name Card
extends Zone


#@onready var color_rect: ColorRect = %ColorRect
#@onready var label: Label = %Label
@onready var name_label: Label = %NameLabel
@onready var state_label: Label = %StateLabel
@onready var current_pile: Pile



func _ready():
	is_locked = false
	super._ready()
	update_name_label()
	
func update_name_label() -> void:
	name_label.text = str(get_index())
	
#func reset_shape_size() -> void:
	#var card_size = Vector2(50, 32)
	#var collision_shape = drop_point_detector.get_child(0)
	#collision_shape.shape.size = card_size
	#collision_shape.position = card_size / 2
	#collision_shape = zones_detector.get_child(0)
	#collision_shape.shape.size = card_size
	#collision_shape.position = card_size / 2
