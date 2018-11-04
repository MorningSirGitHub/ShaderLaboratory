Shader "Morning/SurfaceShader/1_最基本的Surface Shader"
{
	SubShader
	{
		Tags{"RenderType" = "Opaque"}

		CGPROGRAM

		#pragma surface surf Lambert

		struct Input
		{
			float4 color:Color;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = .6;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
