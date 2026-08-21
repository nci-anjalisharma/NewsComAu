//Metal Shaders

#include <metal_stdlib>
using namespace metal;

struct ShaderUniforms {
    float time;
    float2 resolution;
};

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

vertex VertexOut vertex_main(uint vertexID [[vertex_id]]) {

    float2 positions[4] = {
        float2(-1.0, -1.0),
        float2( 1.0, -1.0),
        float2(-1.0,  1.0),
        float2( 1.0,  1.0)
    };

    VertexOut out;

    float2 pos = positions[vertexID];

    out.position = float4(pos, 0.0, 1.0);
    out.uv = pos * 0.5 + 0.5;

    return out;
}

float random(float n) {
    return fract(sin(n) * 43758.5453123);
}

fragment float4 fragment_main(
    VertexOut in [[stage_in]],
    constant ShaderUniforms &uniforms [[buffer(0)]]
)
{
    float2 uv = in.uv;

    float3 color = float3(0.09, 0.06, 0.18);

    const int particleCount = 35;

    for (int i = 0; i < particleCount; i++)
    {
        float fi = float(i);

        float seed = fi * 17.381;

        float2 pos = float2(
            random(seed),
            random(seed + 30.0)
        );

        float speed =
            0.10 +
            random(seed + 100.0) * 0.25;

        float t = uniforms.time * speed;

        pos += float2(
            t * 0.12,
            t * 0.04
        );

        pos.x +=
            0.02 *
            sin(uniforms.time * 1.8 + fi);

        pos.y +=
            0.03 *
            cos(uniforms.time * 1.3 + fi * 2.0);

        pos = fract(pos);

        float d = distance(uv, pos);

        float twinkle =
            0.65 +
            0.35 *
            sin(uniforms.time * 6.5 + fi * 5.4);

        float radius =
            mix(
                0.003,
                0.008,
                random(seed + 200.0)
            );

        if (i % 9 == 0)
        {
            radius *= 2.4;
        }

        float glow =
            exp(-pow(d / (radius * 4.0), 2.0));

        float core =
            exp(-pow(d / (radius * 0.55), 2.0));

        float3 sparkleColor =
            mix(
                float3(0.70, 0.60, 1.00),
                float3(1.00, 0.95, 1.00),
                random(seed + 400.0)
            );

        color +=
            sparkleColor *
            glow *
            twinkle *
            0.18;

        color +=
            float3(1.0) *
            core *
            twinkle;
    }

    float2 centered = uv - 0.5;

    float vignette =
        smoothstep(
            0.85,
            0.25,
            length(centered)
        );

    color *= vignette;

    return float4(saturate(color), 1.0);
}
