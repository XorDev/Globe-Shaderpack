#ifdef FRAGMENT
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
#endif

#ifdef VERTEX
    #include "/lib/settings.glsl"

    uniform mat4 gbufferModelView;
    uniform mat4 gbufferModelViewInverse;

    varying vec4 color;

    void main() {
        vec3 pos = (gl_ModelViewMatrix * gl_Vertex).xyz;
        pos = (gbufferModelViewInverse * vec4(pos, 1.0)).xyz;

        pos.y -= dot(pos.xz, pos.xz) / (RADIUS * RADIUS);

        gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(pos, 1.0);
        gl_FogFragCoord = length(pos);

        color = gl_Color;
    }

#endif