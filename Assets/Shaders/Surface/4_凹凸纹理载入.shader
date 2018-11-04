﻿Shader "Morning/SurfaceShader/4_凹凸纹理载入"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
		_BumpMap("BumpMap", 2D) = "bump"{}
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}

		ENDCG
	}

	FallBack "Diffuse"
}
