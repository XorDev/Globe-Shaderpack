#version 120

uniform float blindness;
uniform int isEyeInWater;

varying vec4 color;

void main() {
    vec4 col = color;

    float fog = (isEyeInWater > 0) ? 1.0 - exp(-gl_FogFragCoord * gl_Fog.density):
        clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0);

    col.rgb = mix(col.rgb, gl_Fog.color.rgb, fog);

    gl_FragData[0] = col * vec4(vec3(1.0 - blindness), 1);
}
