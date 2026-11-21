Shader "Basics/NormalVisualizer"
{
	Properties
	{
		_BaseColor("Base Color", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags
		{
			"RenderPipeline" = "UniversalPipeline"	
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
		}

		Pass 
		{
			HLSLPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

			float4 _BaseColor;

			struct Attributes		// holds info from mesh to vertex shader
			{
				float4 positionOS : POSITION; 
				float3 normalOS : NORMAL;
			};

			struct Varyings		// holds info for vertex shader to fragment shader
			{
				float4 positionCS : SV_POSITION;
				float3 normalWS : TEXCOORD0;
			};

			Varyings vert(Attributes v)
			{
				Varyings output = (Varyings)0;		// default value to avoid errors
				
				output.positionCS = TransformObjectToHClip(v.positionOS.xyz);
				
				output.normalWS = TransformObjectToWorldNormal(v.normalOS);
				
				return output;	
			}

			float4 frag(Varyings i) : SV_TARGET		// float4 because the output is Color
			{
				float3 normal = normalize(i.normalWS);

				float3 color = normal * 0.5 + 0.5;		// range remapping. Normalized vector's components can range from -1 to 1. RGB from 0 to 1.

				return _BaseColor * float4(color, 1);
			}

			ENDHLSL
		}
	}
}