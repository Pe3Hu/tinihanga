shader_type canvas_item;

uniform vec4 bottomleft: source_color = vec4(0.0, 0.0, 0.9, 1.0);
uniform vec4 topleft: source_color = vec4(0.0, 0.9, 0.0, 1.0);
uniform vec4 bottomright: source_color = vec4(0.9, 0.0, 0.0, 1.0);
uniform vec4 topright: source_color = vec4(0.9, 0.9, 0.1, 1.0);

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 top = mix(topleft, topright, UV.x);
	vec4 bottom = mix(bottomleft, bottomright, UV.x);
	vec4 custom_color = mix(top, bottom, UV.y);
	COLOR = texture_color * custom_color;
}