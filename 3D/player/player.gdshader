shader_type canvas_item;

uniform float colour_offset: hint_range(0.0, 1.0, 0.01);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.rgb += colour_offset;
	if(COLOR.a == 0.0){
		COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	}else{
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
}
