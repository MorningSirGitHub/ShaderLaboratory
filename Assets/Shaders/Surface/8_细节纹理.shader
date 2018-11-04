Shader "Morning/SurfaceShader/8_细节纹理"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
		_Detail("Detail", 2D) = "gray"{}
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Detail;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_Detail;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Albedo *= tex2D(_Detail, IN.uv_Detail).rgb * 2;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
