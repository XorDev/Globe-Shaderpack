#version 120

uniform sampler2D texture;

uniform float blindness;
uniform int isEyeInWater;

varying vec4 color;
varying vec2 coord0;
varying vec2 coord1;

void main()
{
    vec4 col = vec4(vec3(1.-blindness),1) * texture2D(texture,coord0);

    gl_FragData[0] = col;
}
