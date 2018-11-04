Shader "Morning/SurfaceShader/12_自制简单的Lambert光照"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf CustomLamBert

		half4 LightingCustomLamBert(SurfaceOutput s, half3 lightDir, half atten)
		{
			half NdotL = max(0, dot(s.Normal, lightDir));
			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 2);
			color.a = s.Alpha;

			return color;
		}

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
