Shader "Morning/FixedShader/Leaning_5-4_基本纹理载入"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "Black"{}
		_Color("Color", Color) = (1,1,1,0)
	}

	SubShader
	{
		Tags{"Queue" = "Transparent"}

		Pass
		{
			Material
			{
				Diffuse[_Color]
				Ambient[_Color]
			}

			Lighting On

			Blend One OneMinusDstColor

			SetTexture[_MainTex]
			{
				ConstantColor[_Color]

				Combine Constant Lerp(texture) previous
			}
		}
	}

	FallBack "Diffuse"
}
