Shader "Morning/SurfaceShader/7_凹凸纹理+颜色可调"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("MainTexture", 2D) = "white"{}
		_BumpMap("BumpMap", 2D) = "bump"{}
		_RimColor("RimColor", Color) = (1,1,1,1)
		_RimPow("RimPow", Range(.5, 10)) = 3
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert finalcolor:SetColor

		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPow;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void SetColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _Color;
		}

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
