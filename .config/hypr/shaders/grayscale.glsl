
#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 FragColor;

uniform sampler2D tex;

//normal
// void main() {
//     vec4 color = texture(tex, v_texcoord);
//
//     // Perceptual luminance
//     float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
//
//     FragColor = vec4(vec3(gray), color.a);
// }
//
// almost black and white

void main() {
    vec4 color = texture(tex, v_texcoord);

    // Perceptual grayscale
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 grayColor = vec3(gray);

    // 0.0 = full color
    // 1.0 = pure black & white
    float desat = 0.99;

    vec3 mixed = mix(color.rgb, grayColor, desat);

    FragColor = vec4(mixed, color.a);
}
