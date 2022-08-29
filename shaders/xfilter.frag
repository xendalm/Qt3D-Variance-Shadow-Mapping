#version 150 core

uniform sampler2D xfilterShadowMapTexture;
uniform vec2 shadowMapTextureSize;
uniform float blurScale;

void main() {
    vec4 color = vec4(0.0);
    vec2 texCoord = gl_FragCoord.xy / shadowMapTextureSize;
    vec2 blur = vec2(blurScale, 0.0);

    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(-3.0) * blur)) * (1.0 / 64.0);
    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(-2.0) * blur)) * (6.0 / 64.0);
    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(-1.0) * blur)) * (15.0 / 64.0);
    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(0.0) * blur)) * (20.0 / 64.0);
    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(1.0) * blur)) * (15.0 / 64.0);
    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(2.0) * blur)) * (6.0 / 64.0);
    color += texture2D(xfilterShadowMapTexture, texCoord + (vec2(3.0) * blur)) * (1.0 / 64.0);

    gl_FragColor = color;
}
