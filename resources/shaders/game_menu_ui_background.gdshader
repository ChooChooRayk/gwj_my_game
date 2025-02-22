shader_type canvas_item;

uniform float repeat_x     : hint_range(1.0, 20.0, 1) = 10.; // [1]
uniform float repeat_y     : hint_range(1.0, 20.0, 1) = 10.; // [1]
uniform float angle        : hint_range(0.0, 360., 1) = 0.0; // [deg]
uniform float scroll_speed : hint_range(0.0, 5.0, .1)     = 1.; // [pxl/s]
uniform vec4 color1 : source_color = vec4(1.);
uniform vec4 color2 : source_color = vec4(0.);



void fragment() {
    float agl_rad  = radians(angle);
    vec2 dir_vec   = vec2(cos(agl_rad),sin(agl_rad));
    vec2 uv_offset = UV - (dir_vec * TIME*0.1 * scroll_speed);
    // ---
    vec2 uv_scaled = vec2(fract(uv_offset.x * repeat_x), fract(uv_offset.y * repeat_y));
    uv_scaled      = uv_scaled / vec2(TEXTURE_PIXEL_SIZE.x/TEXTURE_PIXEL_SIZE.y, 1.);
    vec2 texel_size= vec2(1.0)/vec2(textureSize(TEXTURE, 0));
    vec2 uv_snapped= round(uv_scaled / texel_size)*texel_size;
    // ---
    COLOR = texture(TEXTURE, uv_snapped) * color1;
	// Called for every pixel the material is visible on.
}
