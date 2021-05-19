shader_type canvas_item;

uniform vec4 tint: hint_color = vec4(0, 0, 0, 1);

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = color * tint;
}