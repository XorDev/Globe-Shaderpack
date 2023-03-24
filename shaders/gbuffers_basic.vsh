#version 120

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
