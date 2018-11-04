// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Morning/Vertex&FragmentShader/径向模糊特效标准版"
{
	Properties
	{
		_MainTex ("MainTexture", 2D) = "white" {}
		_InterationCount("InterationCount", int) = 16
	}

	SubShader
	{
		Pass
		{
			ZTest Always

			CGPROGRAM

			#pragma target 3.0

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float _Value1;
			uniform float _Value2;
			uniform float _Value3;
			uniform int _InterationCount;

			struct vertexInput
			{
				float4 vertex:POSITION;
				float4 color:COLOR;
				float2 texcoord :TEXCOORD0;
			};

			struct vertexOutput
			{
				half2 texcoord:TEXCOORD0;
				float4 vertex:POSITION;
				fixed4 color : COLOR;
			};

			vertexOutput vert (vertexInput Input)
			{
				vertexOutput Output;
				Output.vertex = UnityObjectToClipPos(Input.vertex);
				Output.texcoord = Input.texcoord;
				Output.color = Input.color;
				return Output;
			}
			
			float4 frag (vertexOutput i) : COLOR
			{
				float2 center = float2(_Value2, _Value3);
				float2 uv = i.texcoord.xy;
				uv -= center;
				float4 color = float4(0, 0, 0, 0);
				_Value1 *= 0.085;
				float scale = 1;
				for (int j = 0; j < _InterationCount; j++)
				{
					color += tex2D(_MainTex, uv * scale + center);
					scale = 1 + (float(j * _Value1));
				}
				color /= (float)_InterationCount;
				return color;
			}

			ENDCG
		}
	}
}
