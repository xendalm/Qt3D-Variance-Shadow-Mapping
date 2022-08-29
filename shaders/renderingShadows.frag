#version 150 core

uniform mat4 viewMatrix;

uniform vec3 lightPosition;
uniform vec3 lightIntensity;

uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;
uniform float shininess;
uniform float opacity;
uniform float ka;   // Ambient reflection coefficient
uniform float kd;   // Diffuse reflection coefficient
uniform float ks;   // Specular reflection coefficient
uniform bool renderShadows;

uniform sampler2D shadowMapTexture;
uniform vec2 shadowMapTextureSize;
uniform float samplesNumberPCF;

in vec4 positionInLightSpace;

in vec3 position;
in vec3 normal;

float linstep(float low, float high, float v){
    return clamp((v - low) / (high - low), 0.0, 1.0);
}

float sampleVarianceShadowMap(sampler2D shadowMap, vec2 coords, float compare){
    vec2 moments = texture2D(shadowMap, coords).xy;
    float p = step(compare, moments.x);
    float variance = max(moments.y - moments.x * moments.x, 5 * 1e-7);
    float d = compare - moments.x;
    float pMax = linstep(0.2, 1.0, variance / (variance + d * d));

    return pow(min(max(p, pMax), 1.0), 5);
}

float sampleShadowMapPCF(sampler2D shadowMap, vec2 coords, float compare, vec2 texelSize, float samplesNum){
    float SAMPLES_NUM = samplesNum;
    float SMAPLES_START = (SAMPLES_NUM - 1.0f) / 2.0f;
    float SAMPLES_NUM_SQUARED = SAMPLES_NUM * SAMPLES_NUM;

    float result = 0.0f;
    for(float y = -SMAPLES_START; y <= SMAPLES_START; y += 1.0f){
        for(float x = -SMAPLES_START; x <= SMAPLES_START;  x+= 1.0f){
            vec2 coordsOffset = vec2(x, y) * texelSize;
            result += sampleVarianceShadowMap(shadowMap, coords + coordsOffset, compare);
        }
    }
    return result / SAMPLES_NUM_SQUARED;
}

float calcShadowAmount(sampler2D shadowMap, vec4 initialShadowMapCoords){
    vec3 shadowMapCoords = (initialShadowMapCoords.xyz / initialShadowMapCoords.w);

    return sampleShadowMapPCF(shadowMap, shadowMapCoords.xy, shadowMapCoords.z, 1.0 / shadowMapTextureSize, samplesNumberPCF);
}

vec3 phongShading(const in vec3 pos) {
    vec3 n = normalize(normal);
    vec3 l = normalize(vec3(viewMatrix * vec4(lightPosition, 1.0)) - pos);
    vec3 v = normalize(-pos);
    vec3 r = reflect(-l, n);

    float lambertian = max(dot(n, l), 0.0);
    float specular = 0.0;
    if (lambertian > 0.0)
        specular = pow(max(dot(r, v), 0.0), shininess);
    return (kd * lambertian * diffuseColor +
            ks * specular * specularColor);
}

void main() {
    vec3 result = ka * ambientColor;
    float shadowAmount = renderShadows ? calcShadowAmount(shadowMapTexture, positionInLightSpace) : 1.0;
    result += phongShading(position) * shadowAmount;
    gl_FragColor = vec4(result * lightIntensity, opacity);
}
