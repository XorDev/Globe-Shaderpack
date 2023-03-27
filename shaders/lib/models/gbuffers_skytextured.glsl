#ifdef FRAGMENT
    uniform sampler2D texture;

    uniform float blindness;
    uniform int isEyeInWater;

    varying vec4 color;
    varying vec2 coord0;
    varying vec2 coord1;

    void main() {
        vec4 col = vec4(vec3(1.0 - blindness), 1.0) * texture2D(texture, coord0);

        gl_FragData[0] = col;
    }
#endif

#ifdef VERTEX
    #include "/lib/settings.glsl"

    #include "/lib/textured.vsh"
#endif
