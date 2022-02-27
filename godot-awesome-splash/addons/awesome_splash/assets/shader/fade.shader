shader_type canvas_item;

uniform vec4 color : hint_color = vec4(1, 1, 1, 1);
uniform float process_value: hint_range(0, 1) = 0;


void fragment() 
{

	vec4 txt = texture(TEXTURE, UV);
	vec4 output_color = txt;
	output_color.rgb = mix(txt.rgb, color.rgb, process_value);
	COLOR = output_color;
}
