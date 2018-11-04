Shader "Morning/SurfaceShader/2_颜色可调"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert

		float4 _Color;

		struct Input
		{
			float4 color:Color;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
