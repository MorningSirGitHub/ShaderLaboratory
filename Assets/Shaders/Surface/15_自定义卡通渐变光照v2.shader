Shader "Morning/SurfaceShader/15_自定义卡通渐变光照v2"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
		_Ramp("Ramp", 2D) = "gray"{}
		_BumpMap("BumpMap", 2D) = "bump"{}
		_Detail("Detail", 2D) = "gray"{}
		_RimColor("RimColor", Color) = (1,1,1,1)
		_RimPow("RimPow", Range(.5, 5)) = 1
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Cartoon

		sampler2D _MainTex;
		sampler2D _Ramp;
		sampler2D _BumpMap;
		sampler2D _Detail;
		float4 _RimColor;
		float _RimPow;

		half4 LightingCartoon(SurfaceOutput s, half3 lightDir, half atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			float diff = NdotL * 0.5 + 0.5;
			half3 ramp = tex2D(_Ramp, float2(diff, diff)).rgb;
			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten * 2);
			color.a = s.Alpha;

			return color;
		}

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_Detail;
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Albedo *= tex2D(_Detail, IN.uv_Detail).rgb * 2;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor * pow(rim, _RimPow);
		}

		ENDCG
	}

	FallBack "Diffuse"
}
