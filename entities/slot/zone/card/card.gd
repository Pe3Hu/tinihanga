class_name Card
extends Zone


@onready var power_token: Token = %PowerToken
@onready var state_label: Label = %StateLabel
@onready var current_pile: Pile:
	set(value_):
		previous_pile = current_pile
		current_pile = value_
		
		if previous_pile == null:
			previous_pile = current_pile
@onready var previous_pile: Pile

@export var resource: CardResource:
	set(value_):
		resource = value_
		power_token.material = ShaderMaterial.new()
		power_token.type = State.Token.ELEMENT
		power_token.element = resource.element
		power_token.value_int = resource.power


#func reset_shape_size() -> void:
	#var card_size = Vector2(50, 32)
	#var collision_shape = drop_point_detector.get_child(0)
	#collision_shape.shape.size = card_size
	#collision_shape.position = card_size / 2
	#collision_shape = zones_detector.get_child(0)
	#collision_shape.shape.size = card_size
	#collision_shape.position = card_size / 2
