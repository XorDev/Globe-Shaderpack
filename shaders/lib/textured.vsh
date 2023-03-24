#include "/lib/settings.glsl"
#include "/lib/util.glsl"

attribute float mc_Entity;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

varying vec4 color;
varying vec2 coord0;
varying vec2 coord1;

void main() {
    vec3 pos = (gl_ModelViewMatrix * gl_Vertex).xyz;
    pos = (gbufferModelViewInverse * vec4(pos, 1.0)).xyz;

    #ifdef APPLY_CURVATURE
        pos.y -= dot(pos.xz, pos.xz) / (RADIUS * RADIUS);
    #endif

    gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(pos, 1.0);
    gl_FogFragCoord = length(pos);

    vec3 normal = gl_NormalMatrix * gl_Normal;
    normal = (float_cmp(mc_Entity, 1.0) == 0) ? vec3(0.0, 1.0, 0.0) : (gbufferModelViewInverse * vec4(normal, 0.0)).xyz;

    float light = 0.8 - 0.25 * abs(normal.x * 0.9 + normal.z * 0.3) + normal.y * 0.2;

    color = vec4(gl_Color.rgb * light, gl_Color.a);
    coord0 = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    coord1 = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
}
