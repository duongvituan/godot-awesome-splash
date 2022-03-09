shader_type canvas_item;

uniform float min_zoom = 1.0;
uniform float max_zoom = 1.1;
uniform float process_value : hint_range(0.0, 1.0) = 0.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;

void fragment() 
{	float range_zoom = max_zoom - min_zoom;
	if (range_zoom == 0.0)
	{
		COLOR = texture(TEXTURE, UV);
		return;
	}
	
	vec2 center = vec2(0.5, 0.5);
	vec2 uv = (UV - center) * (1.0 - range_zoom * process_value) + center;
	vec4 output_color = texture(TEXTURE, uv);
	output_color.a *= fade;
	COLOR = output_color;
}
