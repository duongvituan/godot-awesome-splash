shader_type canvas_item;

uniform float hologram_value : hint_range(0, 1) = 0.75;
uniform float hologram_noise_x : hint_range(0, 20) = 10;
uniform float hologram_speed : hint_range(0, 4) = 1.0;
uniform vec4 tint_color : hint_color = vec4(0.2, 0.92, 0.15, 1);

uniform float fade : hint_range(0.0, 1.0) = 1.0;


float holo_noise(sampler2D source, vec2 p, float time)
{
	float sample = texture(source, vec2(.2, 0.2 * cos(time)) * time * 8. + p * 1.).x;
	return sample * sample;
}


float holo_on(float a, float b, float c, float time)
{
	return step(c, sin(time + a * cos(time * b)));
}


float generate_noise(vec2 uv)
{
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453);
}


float horizontal_row_mark(vec2 uv, float time)
{
	return (9. + fract(uv.y * 20. + time)) * 0.1;
}


vec4 hologram(vec2 uv, sampler2D source, float value, float noise_x, float speed, float time)
{
	vec4 txt = texture(source, uv);
	float _time = time * speed;
	vec2 _uv = uv;
	
	float atm_shift_x = 1. / (1. + 30. * (_uv.y - fract(_time / 4.0)) * (_uv.y - fract(_time / 4.0)));
	float horizontal_shift = atm_shift_x * sin(_uv.y * noise_x * 100.0 + _time) / (50. * value) * holo_on(4., 4., .3, time) * (1. + cos(_time * 70.));
	_uv.x += horizontal_shift;
	
	float vertical_shift = .02 * holo_on(2., 3., .9, time) * (sin(_time) * sin(_time * 20.) + (0.5 + 0.1 * sin(_time * 20.) * cos(_time)));
	_uv.y = fract(_uv.y + vertical_shift);
	
	vec4 holo_txt = texture(source, _uv);
	holo_txt.rb = texture(source, _uv - vec2(.05, 0.) * holo_on(2., 1.5, .9, time)).rb;
	
	float noise = holo_noise(source, _uv * vec2(0.5, 1.) + vec2(6., 3.), time) * value * 3.;
	holo_txt *= horizontal_row_mark(_uv, _time);
	holo_txt.a = (holo_txt.a + generate_noise(_uv) * 0.5) * txt.a * 0.8;
	
	return mix(txt, holo_txt, value);
}


vec4 tint_holo_color(vec4 txt, vec4 color)
{
	vec3 tint = vec3(dot(txt.rgb, vec3(.22, .7, .07)));
	tint.rgb *= color.rgb;
	txt.rgb = mix(txt.rgb,tint.rgb,color.a);
	return txt;
}


void fragment() 
{
	vec4 hologram = hologram(UV, TEXTURE, hologram_value, hologram_noise_x, hologram_speed, TIME);
	vec4 _tint_color = tint_holo_color(hologram, tint_color);
	vec4 output_color = _tint_color;

	output_color.a *= fade;
	COLOR = output_color;
}


