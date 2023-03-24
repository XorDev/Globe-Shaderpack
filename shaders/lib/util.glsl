#include "/lib/config.glsl"

int float_cmp(float alpha, float beta) {
    return (abs(alpha - beta) < CMP_EPS) ? 0 : int(sign(alpha - beta));
}