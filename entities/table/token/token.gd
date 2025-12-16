@tool
class_name Token
extends TextureRect


@onready var value_label: Label = %ValueLabel

@export var genesis: State.Genesis:
	set(value_):
		genesis = value_
		
		if genesis != State.Genesis.NONE and type == State.Token.ELEMENT:
			var path = "res://entities/table/token/images/genesis/{genesis}.png".format({"genesis": Catalog.genesis_to_string[genesis]})
			texture = load(path)
@export var type: State.Token:
	set(value_):
		type = value_
		
		if type == State.Token.ELEMENT:
			genesis = State.Genesis.BASIC
		else:
			genesis = State.Genesis.NONE
		
		match type:
			State.Token.ELEMENT:
				pass
			State.Token.HEALTH:
				var path = "res://entities/table/token/images/{type}.png".format({"type": Catalog.token_to_string[type]})
				texture = load(path)
				element = State.Element.FIRE
			State.Token.POWER:
				var path = "res://entities/table/token/images/{type}.png".format({"type": Catalog.token_to_string[type]})
				texture = load(path)
@export var element: State.Element:
	set(value_):
		element = value_
		
		if element == State.Element.CHAOS:
			genesis = State.Genesis.NONE
			type = State.Token.NONE
			material.shader = load("res://entities/table/token/shaders/4 corner gradient.gdshader")
		else:
			if type != State.Token.POWER and type != State.Token.HEALTH:
			#if genesis == State.Genesis.NONE:
				type = State.Token.ELEMENT
				for _genesis in Catalog.GENESISES:
					if Catalog.genesis_to_element[_genesis].has(element):
						genesis = _genesis
						break
			
			material.shader = load("res://entities/table/token/shaders/split gradient.gdshader")
			update_element_hues()
@export var value_int: int = 0:
	set(value_):
		value_int = value_
		
		if value_label:
			value_label.text = str(value_int)


func update_element_hues() -> void:
	var max_h = 360.0
	var h_start = 0.0
	var h_mid = 0.0
	var h_end = 0.0
	var s_start = 0.9
	var s_mid = 0.6
	var s_end = 0.9
	var v_start = 0.9
	var v_mid = 0.6
	var v_end = 0.9
	var angle = 0
	
	
	match genesis:
		State.Genesis.BASIC:
			angle = 90
			material.set_shader_parameter("midpos_enabled", false)
			h_start = float(Catalog.element_to_hue[element])
			h_mid = h_start
			h_end = float(Catalog.element_to_hue[element])
			v_end = 0.5
		State.Genesis.HYBRID:
			material.set_shader_parameter("midpos_enabled", false)
			h_start = float(Catalog.element_to_hue[Catalog.element_to_component[element].front()])
			h_end = float(Catalog.element_to_hue[Catalog.element_to_component[element].back()])
		State.Genesis.ANCESTOR:
			angle = 45
			material.set_shader_parameter("midpos_enabled", true)
			h_start = float(Catalog.element_to_hue[Catalog.element_to_component[element].front()])
			h_mid = float(Catalog.element_to_hue[element])
			h_end = float(Catalog.element_to_hue[Catalog.element_to_component[element].back()])
	
	var shader_color_start = Color.from_hsv(h_start / max_h, s_start, v_start)
	var shader_color_end = Color.from_hsv(h_end / max_h, s_end, v_end)
	var shader_color_mid = Color.from_hsv(h_mid / max_h, s_mid, v_mid)
	
	#material = ShaderMaterial.new()
	#material.shader = load("res://entities/table/token/table/token gradient.gdshader")
	material.set_shader_parameter("color_start", shader_color_start)
	material.set_shader_parameter("color_end", shader_color_end)
	material.set_shader_parameter("color_mid", shader_color_mid)
	material.set_shader_parameter("angle", angle)
	
