#ifdef FRAGMENT
    uniform sampler2D texture;
    uniform sampler2D lightmap;

    uniform vec4 entityColor;
    uniform float blindness;
    uniform int isEyeInWater;

    varying vec4 color;
    varying vec2 coord0;
    varying vec2 coord1;

    void main() {
        vec3 light = (1.0 - blindness) * texture2D(lightmap, coord1).rgb;
        vec4 col = color * vec4(light, 1.0) * texture2D(texture, coord0);
        col.rgb = mix(col.rgb, entityColor.rgb, entityColor.a);

        float fog = (isEyeInWater > 0.0) ? 1.0 - exp(-gl_FogFragCoord * gl_Fog.density):
        clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0);

        col.rgb = mix(col.rgb, gl_Fog.color.rgb, fog);

        gl_FragData[0] = col;
    }
#endif

#ifdef VERTEX
    #include "/lib/settings.glsl"

    #define APPLY_CURVATURE
    #include "/lib/textured.vsh"
    #undef APPLY_CURVATURE
#endif