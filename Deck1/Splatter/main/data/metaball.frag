#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float mbr1, mbr2, mbr3, mbr4, mbr5;
uniform vec2 mb1, mb2, mb3, mb4, mb5;
uniform vec3 color;
uniform vec2 uRes;

float circleSum(float x, float y, float r, vec2 mb) {
    if (r == -1.0 || mb.x == -1.0 || mb.y == -1.0) return 0.0;
    return pow(r, 2.0) / ( pow(x-mb.x, 2.0) + pow(y-mb.y, 2.0) );
}

void main() {
    float x = float(gl_FragCoord.x);
    float y = float(gl_FragCoord.y);
    float summation = 0.0;
    summation += circleSum(x, y, mbr1, mb1);
    summation += circleSum(x, y, mbr2, mb2);
    summation += circleSum(x, y, mbr3, mb3);
    summation += circleSum(x, y, mbr4, mb4);
    summation += circleSum(x, y, mbr5, mb5);

    if (summation >= 0.000000000001) {
        gl_FragColor = vec4(color.r/255.0, color.g/255.0, color.b/255.0, 1.0);
    } else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}