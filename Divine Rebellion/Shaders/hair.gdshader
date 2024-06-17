shader_type canvas_item;

uniform vec4 new_color1: source_color = vec4(0.349, 0.196, 0.141, 1.0);
uniform vec4 new_color2: source_color = vec4(1.0, 0.49, 0.983, 1.0);

void fragment() {
	vec4 curr_color = texture(TEXTURE, UV);
	if (curr_color.rba == vec3(0, 0, 1.0) && curr_color.g > 0.0) {
		COLOR.rgb = new_color1.rgb * curr_color.g;
	} else {
		COLOR.rgb = new_color2.rgb * curr_color.r;
	}
}