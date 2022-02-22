shader_type canvas_item;

uniform sampler2D noise_tex;
uniform vec4 burn_color : hint_color = vec4(1.0, 0.3, 0.05, 1.0);
uniform float process_value : hint_range(0, 1) = 0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec4 burn_vfx(vec4 tx, float noise, float value, vec4 _color)
{
	vec4 color = vec4(smoothstep(value * 0.8, value + 0.15, noise));
	color = tx * color;
	color.r = mix(color.r, color.r * (1. - color.a) * _color.r * 150.0, value);
	color.g = mix(color.g, color.g * (1. - color.a) * _color.g * 150.0, value);
	color.b = mix(color.b, color.b * (1. - color.a) * _color.b * 150.0 , value);
	color.rgb = mix(clamp(color.rbg, 0.0, 1.0), color.rgb, 2.0);
	return color;
}


void fragment()
{
	vec4 main_texture = texture(TEXTURE, UV);
	float noise = texture(noise_tex, UV).r;
	vec4 output_color = burn_vfx(main_texture, noise, process_value, burn_color);

	output_color.a *= fade;
	COLOR = output_color;
}
