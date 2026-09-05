#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 FragColor;

uniform sampler2D tex;

void main() {
    vec4 color = texture(tex, v_texcoord);

    // ==========================================
    // CONFIGURATION
    // ==========================================
    
    // Desaturation: 0.0 = full color, 1.0 = pure grayscale
    float desat = 1.0; 

    // Blue light filter (Color temperature tint)
    // vec3(1.0, 1.0, 1.0) = no filter
    // vec3(1.0, 0.85, 0.65) = standard warm night mode
    // vec3(1.0, 0.75, 0.50) = intense, very warm night mode
    vec3 nightTint = vec3(1.0, 0.85, 0.65);
    // vec3 nightTint =  vec3(1.0, 0.75, 0.50);
    // Brightness: 1.0 = normal, >1.0 = brighter, <1.0 = darker
    // Lowered from 1.5 to 1.0 for a better baseline, adjust as needed.
    float brightness = 1.0; 

    // Contrast: 1.0 = normal, >1.0 = more contrast, <1.0 = less contrast
    float contrast = 1.0; 

    // ==========================================

    // 1. Grayscale & Desaturation
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 mixed = mix(color.rgb, vec3(gray), desat);

    // 2. Apply Blue Light Filter
    // This reduces the blue and green channels based on the nightTint vector
    mixed *= nightTint;

    // 3. Brightness & Contrast
    mixed = mixed * brightness;
    mixed = ((mixed - 0.5) * contrast) + 0.5;

    // 4. Clamp the output
    // Ensures colors don't blow out past maximum values or drop below black
    mixed = clamp(mixed, 0.0, 1.0);

    FragColor = vec4(mixed, color.a);
}
