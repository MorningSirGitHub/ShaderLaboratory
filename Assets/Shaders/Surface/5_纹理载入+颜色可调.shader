Shader "Morning/SurfaceShader/5_纹理载入+颜色可调"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("MainTexture", 2D) = "white"{}
		_BumpMap("BumpMap", 2D) = "bump"{}
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert finalcolor:SetColor

		float4 _Color;
		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void SetColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _Color;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}

		ENDCG
	}

	FallBack "Diffuse"
}
