class_name Avatar
extends Control


@export var battlefield: Battlefield

@onready var tribute_token: Token = %TributeToken

var resource: AvatarResource


func _ready() -> void:
	make_tribute_token_unique()
	
func make_tribute_token_unique() -> void:
	tribute_token.material = ShaderMaterial.new()
	tribute_token.element = tribute_token.element
	
func roll_element() -> void:
	resource.roll_element()
	update_tribute_token()
	
func update_tribute_token() -> void:
	tribute_token.value_int = resource.tribute
	tribute_token.element = resource.element
