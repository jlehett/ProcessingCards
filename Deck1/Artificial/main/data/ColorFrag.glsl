#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform float resY, resX;

float dist(float x1, float y1, float x2, float y2) {
    return sqrt(pow(x1-x2, 2) + pow(y1-y2, 2));
}

float map(float value, float min1, float max1, float min2, float max2) {
    return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

void main() {
    vec4 color = texture2D(
        texture,
        vec2(gl_FragCoord.x/resX, gl_FragCoord.y/resY)
    );

    float r = map(
        dist(gl_FragCoord.x/resX, gl_FragCoord.y/resY, 0.25, 0.6),
        0, 0.35, 68/255.0, 0/255.0
    );
    float g = map(
        dist(gl_FragCoord.x/resX, gl_FragCoord.y/resY, 0.25, 0.6),
        0, 0.35, 212/255.0, 10/255.0
    );
    float b = map(
        dist(gl_FragCoord.x/resX, gl_FragCoord.y/resY, 0.25, 0.6),
        0, 0.35, 255/255.0, 148/255.0
    );

    gl_FragColor = vec4(r, g, b, color.r);
}