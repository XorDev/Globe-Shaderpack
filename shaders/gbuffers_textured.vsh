#version 120

#include "/lib/settings.glsl"

attribute float mc_Entity;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

varying vec4 color;
varying vec2 coord0;
varying vec2 coord1;

void main()
{
    vec3 pos = (gl_ModelViewMatrix * gl_Vertex).xyz;
    pos = (gbufferModelViewInverse * vec4(pos,1)).xyz;

    pos.y -= dot(pos.xz,pos.xz)/RADIUS/RADIUS;

    gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(pos,1);
    gl_FogFragCoord = length(pos);

    vec3 normal = gl_NormalMatrix * gl_Normal;
    normal = (mc_Entity==1.) ? vec3(0,1,0) : (gbufferModelViewInverse * vec4(normal,0)).xyz;

    float light = .8-.25*abs(normal.x*.9+normal.z*.3)+normal.y*.2;

    color = vec4(gl_Color.rgb * light, gl_Color.a);
    coord0 = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    coord1 = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
}
