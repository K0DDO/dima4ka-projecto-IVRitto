shader_type canvas_item;

uniform vec4 new_color: source_color = vec4(0.369, 0.357, 0.357, 1.0);

void fragment() {
	vec4 curr_color = texture(TEXTURE, UV);
	if (curr_color.gba == vec3(0, 0, 1.0) && curr_color.r > 0.0) {
		COLOR.rgb = new_color.rgb * curr_color.r;
	} else {
		COLOR = curr_color;
	}
}