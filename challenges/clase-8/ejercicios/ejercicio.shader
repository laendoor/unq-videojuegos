shader_type canvas_item;

uniform float width = 0.05;
uniform float progress: hint_range(0.1, 0.9) = 0.5;
uniform vec4 color_from: hint_color;
uniform vec4 color_to: hint_color;

float sdSegment(in vec2 p, in vec2 a, in vec2 b) {
    vec2 pa = p - a, ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

void fragment() {
	float grayscale = sdSegment(UV, vec2(0.1, 0.5), vec2(0.9, 0.5));
	vec3 lineBackground = vec3(1.0 - smoothstep(width, width + 0.01, grayscale));
	
	float grayscaleForeground = sdSegment(UV, vec2(0.1, 0.5), vec2(progress, 0.5));
	float lineForeground = 1.0 - smoothstep(width, width + 0.01, grayscaleForeground);
	
	vec3 healt_color = mix(color_from.rgb, color_to.rgb, progress);
	vec3 bar = mix(lineBackground, healt_color.rgb, lineForeground);
	COLOR = vec4(bar, 1.0);
}
