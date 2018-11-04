// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Morning/Vertex&FragmentShader/屏幕水幕特效"
{
	Properties
	{
		_MainTex ("MainTexture", 2D) = "white" {}
		_WaterDropTex("WaterDropTexture", 2D) = "white"{}
		_CurrentTime("CurrentTime", Range(0.0, 1.0)) = 1.0
		_SizeX("SizeX", Range(0.0, 1.0)) = 1.0
		_SizeY("SizeY", Range(0.0, 1.0)) = 1.0
		_DropSpeed("DropSpeed", Range(0.0, 10.0)) = 1.0
		_Distortion("Distortion", Range(0.0, 1.0)) = 0.85
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma target 3.0

			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_Precision_hint_fastest
			
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform sampler2D _WaterDropTex;
			uniform float _CurrentTime;
			uniform float _SizeX;
			uniform float _SizeY;
			uniform float _DropSpeed;
			uniform float _Distortion;
			uniform float2 _MainTex_TexelSize;

			struct vertexInput
			{
				float4 vertex:POSITION;
				float4 color:COLOR;
				float2 texcoord :TEXCOORD0;
			};

			struct vertexOutput
			{
				half2 texcoord:TEXCOORD0;
				float4 vertex:SV_POSITION;
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
				float2 uv = i.texcoord.xy;

				#if UNITY_UV_STARTS_AT_TOP

				if (_MainTex_TexelSize.y < 0)
					_DropSpeed = 1 - _DropSpeed;

				#endif

				float3 rainTex1 = tex2D(_WaterDropTex, float2(uv.x * 1.15 * _SizeX, (uv.y * 1.1 * _SizeY) + _CurrentTime * _DropSpeed * 0.15)).rgb / _Distortion;
				float3 rainTex2 = tex2D(_WaterDropTex, float2(uv.x * 1.25 * _SizeX - 0.1, (uv.y * 1.2 * _SizeY) + _CurrentTime * _DropSpeed * 0.2)).rgb / _Distortion;
				float3 rainTex3 = tex2D(_WaterDropTex, float2(uv.x * 0.9 * _SizeX, (uv.y * 1.25 * _SizeY) + _CurrentTime * _DropSpeed * 0.032)).rgb / _Distortion;

				float2 finalRainTex = uv.xy - (rainTex1.xy - rainTex2.xy - rainTex3.xy) / 3;

				float3 finalColor = tex2D(_MainTex, float2(finalRainTex.x, finalRainTex.y)).rgb;

				return fixed4(finalColor, 1.0);
			}

			ENDCG
		}
	}
}
