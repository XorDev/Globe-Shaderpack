#version 120

#define Radius 16. //[4. 10. 12. 16. 24. 32.]

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

varying vec4 color;

void main()
{
    vec3 pos = (gl_ModelViewMatrix * gl_Vertex).xyz;
    pos = (gbufferModelViewInverse * vec4(pos,1)).xyz;

    pos.y -= dot(pos.xz,pos.xz)/Radius/Radius;

    gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(pos,1);
    gl_FogFragCoord = length(pos);

    color = gl_Color;
}
