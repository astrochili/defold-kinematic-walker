varying highp vec4 var_position;
varying mediump vec3 var_normal;
varying mediump vec2 var_texcoord0;

uniform lowp sampler2D tex0;

void main() {
    vec4 color = texture2D(tex0, var_texcoord0.xy);

    vec3 ambient = vec3(0.7);
    vec3 diffuse = vec3((1.0 + var_normal.y * 255.0) / 2.0);    
    diffuse = clamp(ambient + diffuse * (vec3(1.0) - ambient), 0.0, 1.0);

    gl_FragColor = vec4(color.rgb * diffuse, color.a);
}