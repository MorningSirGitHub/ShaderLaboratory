// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Morning/Test"
{
	Properties
	{
		_MainTex("Base(RGB)",2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			Tags{"RenderType" = "Opaque"}

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;

			struct VertexOutPut
			{
				float4 pos:SV_POSITION;
				float2 uv_Maintex:TEXCOORD0;
			};

			VertexOutPut vert(appdata_base input)
			{
				VertexOutPut o;
				o.pos = UnityObjectToClipPos(input.vertex);
				o.uv_Maintex = input.texcoord.xy;
				return o;
			}

			float4 frag(VertexOutPut i) :COLOR
			{
				float4 col = tex2D(_MainTex,i.uv_Maintex);
				return col;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}