#ifdef FRAGMENT
    void main() {
        discard;
    }
#endif

#ifdef VERTEX
    void main() {
        gl_Position = vec4(0.0);
    }
#endif