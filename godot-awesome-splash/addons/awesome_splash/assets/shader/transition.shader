shader_type canvas_item;

uniform int transition_type = 0;
uniform vec4 color : hint_color = vec4(1, 1, 1, 1);
uniform float diamond_size: hint_range(0, 1) = 0;
uniform float process_value: hint_range(0, 1) = 0;


vec4 fade_transition(vec4 txt, vec4 fade_color, float v)
{
	txt.rgb = mix(txt.rgb, fade_color.rgb, v);
	return txt;
}

vec4 diamond_transition(vec4 txt, vec4 fade_color, vec2 uv, vec2 fragcoord, float size, float v) {
	float diamondPixelSize = size;
	float xFraction = fract(fragcoord.x / diamondPixelSize);
	float yFraction = fract(fragcoord.y / diamondPixelSize);
    
	float xDistance = abs(xFraction - 0.5);
	float yDistance = abs(yFraction - 0.5);
    
	if (xDistance + yDistance + uv.y > v * 3f) {
		return txt;
	}
	return fade_color;
}

void fragment() 
{
	vec4 txt = texture(TEXTURE, UV);
	vec4 output_color = txt;
	
	if (transition_type == 1) // FADE
	{
		output_color = fade_transition(txt, color, process_value);
	}
	else if (transition_type == 2) // DIAMOND
	{
		output_color = diamond_transition(txt, color, UV, FRAGCOORD.xy, diamond_size, process_value);
	}
	
	COLOR = output_color;
}
