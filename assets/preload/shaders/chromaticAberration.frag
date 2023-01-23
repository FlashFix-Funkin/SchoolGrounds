#pragma header

uniform float rOffset = 2.0;
uniform float gOffset = 0.0;
uniform float bOffset = 2.0;

void main(void)
{
	vec4 col1 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(rOffset, 0.0));
	vec4 col2 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(gOffset, 0.0));
	vec4 col3 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(bOffset, 0.0));
	vec4 toUse = texture2D(bitmap, openfl_TextureCoordv);
	toUse.r = col1.r;
	toUse.g = col2.g;
	toUse.b = col3.b;

	gl_FragColor = toUse;
}