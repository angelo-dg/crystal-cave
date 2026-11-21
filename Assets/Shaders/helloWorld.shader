Shader "Basics/HelloWorld"
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

			struct Attributes
			{
				float4 positionOS : POSITION; 
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
			};

			Varyings vert(Attributes v)
			{
				Varyings output = (Varyings)0;		// default value to avoid errors
				
				output.positionCS = TransformObjectToHClip(v.positionOS.xyz);
				
				return output;	
			}

			float4 frag(Varyings i) : SV_TARGET		// float4 because the output is Color
			{
				return _BaseColor;
			}

			ENDHLSL
		}
	}
}