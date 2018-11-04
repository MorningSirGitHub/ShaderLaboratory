Shader "Morning/FixedShader/Leaning_5-2_表面着色器SurfaceShader"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
		_BumpMap("BumpMap", 2D) = "bump"{}
		_RimColor("RimColor", Color) = (.17,.36,.81,0)
		_RimPow("RimPow", Range(0, 10)) = 1
	}

	SubShader
	{
		Tags{"RenderType" = "OPaque"}

		CGPROGRAM

		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPow;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));

			o.Emission = _RimColor.rgb * pow(rim, _RimPow);
		}

		ENDCG
	}

	FallBack "Diffuse"
}
