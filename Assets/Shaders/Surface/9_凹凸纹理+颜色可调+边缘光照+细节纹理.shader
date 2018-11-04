Shader "Morning/SurfaceShader/9_凹凸纹理+颜色可调+边缘光照+细节纹理"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
		_BumpMap("BumpMap", 2D) = "bump"{}
		_Detail("Detail", 2D) = "gray"{}
		_Color("Color", Color) = (1,1,1,1)
		_RimColor("RimColor", Color) = (0.26,0.19,0.16,0.0)
		_RimPow("RimPow", Range(.5, 5)) = 1
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert finalcolor:SetColor

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Detail;
		fixed _Color;
		float4 _RimColor;
		float _RimPow;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_Detail;
			float viewDir;
		};

		void SetColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _Color;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Albedo *= tex2D(_Detail, IN.uv_Detail).rgb * 2;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPow);
		}

		ENDCG
	}

	FallBack "Diffuse"
}
