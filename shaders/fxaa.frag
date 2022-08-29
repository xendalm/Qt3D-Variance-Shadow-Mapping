#version 150 core

uniform sampler2D displayTexture;
uniform vec2 displayTextureSize;

vec4 fxaa(vec2 texCoord){
    float spanMax = 8.0;
    float reduceMin = 1.0/128.0;
    float reduceMul = 1.0/8.0;
    vec2 texCoordOffsetCoef = vec2(1.0 / displayTextureSize);

    vec3 luma = vec3(0.299, 0.587, 0.114);
    float lumaTL = dot(luma, texture2D(displayTexture, texCoord.xy + (vec2(-1.0, -1.0) * texCoordOffsetCoef)).xyz);
    float lumaTR = dot(luma, texture2D(displayTexture, texCoord.xy + (vec2(1.0, -1.0) * texCoordOffsetCoef)).xyz);
    float lumaBL = dot(luma, texture2D(displayTexture, texCoord.xy + (vec2(-1.0, 1.0) * texCoordOffsetCoef)).xyz);
    float lumaBR = dot(luma, texture2D(displayTexture, texCoord.xy + (vec2(1.0, 1.0) * texCoordOffsetCoef)).xyz);
    float lumaM  = dot(luma, texture2D(displayTexture, texCoord.xy).xyz);

    vec2 dir;
    dir.x = -((lumaTL + lumaTR) - (lumaBL + lumaBR));
    dir.y = ((lumaTL + lumaBL) - (lumaTR + lumaBR));

    float dirReduce = max((lumaTL + lumaTR + lumaBL + lumaBR) * (reduceMul * 0.25), reduceMin);
    float inverseDirAdjustment = 1.0/(min(abs(dir.x), abs(dir.y)) + dirReduce);

    dir = min(vec2(spanMax, spanMax),
            max(vec2(-spanMax, -spanMax), dir * inverseDirAdjustment));

    dir.x = dir.x * step(1.0, abs(dir.x));
    dir.y = dir.y * step(1.0, abs(dir.y));

    dir = dir * texCoordOffsetCoef;

    vec3 rgbA = (1.0/2.0) * (
            texture2D(displayTexture, texCoord.xy + (dir * vec2(1.0/3.0 - 0.5))).xyz +
            texture2D(displayTexture, texCoord.xy + (dir * vec2(2.0/3.0 - 0.5))).xyz);

    vec3 rgbB = rgbA * (1.0/2.0) + (1.0/4.0) * (
            texture2D(displayTexture, texCoord.xy + (dir * vec2(0.0/3.0 - 0.5))).xyz +
            texture2D(displayTexture, texCoord.xy + (dir * vec2(3.0/3.0 - 0.5))).xyz);

    float lumaMin = min(lumaM, min(min(lumaTL, lumaTR), min(lumaBL, lumaBR)));
    float lumaMax = max(lumaM, max(max(lumaTL, lumaTR), max(lumaBL, lumaBR)));
    float lumaB = dot(rgbB, luma);

    if((lumaB < lumaMin) || (lumaB > lumaMax)) return vec4(rgbA, 1.0);

    return vec4(rgbB, 1.0);
}

void main() {
    vec2 texCoord = gl_FragCoord.xy / displayTextureSize;
    gl_FragColor = fxaa(texCoord);//texture2D(displayTexture, texCoord);
}












