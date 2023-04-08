shader_type canvas_item;
uniform vec4 color : source_color = vec4(1.0); // White color

void fragment() {
	vec4 color_circle = color;
	vec2 center = vec2(0.5, 0.5);
	float r = (UV.x - center.x) * (UV.x - center.x) + (UV.y - center.y) * (UV.y - center.y);
	if (r > 0.25) {
		color_circle.a = 0.0;
	}
    COLOR = color_circle;
}