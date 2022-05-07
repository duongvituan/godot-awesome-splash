shader_type canvas_item;

uniform int transition_type = 0;
uniform vec4 color : hint_color = vec4(1, 1, 1, 1);
uniform float diamond_size: hint_range(0, 1) = 0;
uniform float blur_intensity: hint_range(0, 32) = 4.0;
uniform float min_pixel: hint_range(1, 256) = 1;
uniform float max_pixel: hint_range(1, 256) = 128;
uniform float process_value: hint_range(0, 1) = 0;


vec2 get_pixel_uv(vec2 uv, float x)
{
	uv = floor(uv * x + 0.5) / x;
	return uv;
}

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

vec4 blur(vec2 uv, sampler2D source, float intensity)
{
	float s = 0.004f * intensity;
	vec4 result = vec4 (0);
	result += texture(source, uv + vec2(-s, -s));
	result += 2.0 * texture(source, uv + vec2(-s, 0));
	result += texture(source, uv + vec2(-s, s));
	result += 2.0 * texture(source, uv + vec2(0, -s));
	result += 4.0 * texture(source, uv);
	result += 2.0 * texture(source, uv + vec2(0, s));
	result += texture(source, uv + vec2(s, -s));
	result += 2.0 * texture(source, uv + vec2(s, 0));
	result += texture(source, uv + vec2(s, -s));
	result = result * 0.0625;
	return result;
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
	else if (transition_type == 3) // BLUR
	{
		output_color = blur(UV, TEXTURE, process_value * blur_intensity);
	}
	else if (transition_type == 4) // BLUR AND FADE
	{
		output_color = blur(UV, TEXTURE, process_value * blur_intensity);
		output_color = fade_transition(output_color, color, process_value);
	}
	else if (transition_type == 5) // PIXEL
	{
		float v1 = min_pixel;
		float v2 = max_pixel;
		if (v1 >= v2) {
			v1 = 1.0;
			v2 = 128.0;
		}
		float size = mix(v1, v2, 1.0 - process_value);
		vec2 pixel_uv = get_pixel_uv(UV, size);
		pixel_uv = mix(UV, pixel_uv, vec2(process_value));
		output_color = texture(TEXTURE, pixel_uv);
	}
	
	COLOR = output_color;
}
