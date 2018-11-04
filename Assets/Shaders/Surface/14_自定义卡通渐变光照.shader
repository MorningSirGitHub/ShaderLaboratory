Shader "Morning/SurfaceShader/14_自定义卡通渐变光照"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
		_Ramp("Ramp", 2D) = "gray"{}
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Ramp

		sampler2D _MainTex;
		sampler2D _Ramp;

		half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten)
		{
			half NdotL = max(0, dot(s.Normal, lightDir));
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
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
