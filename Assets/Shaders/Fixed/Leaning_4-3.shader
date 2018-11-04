Shader "Morning/FixedShader/Leaning_4-3_用剔除实现玻璃效果"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,0)
		_Specular("Specular", Color) = (1,1,1,1)
		_Emission("Emission", Color) = (0,0,0,0)
		_Shininess("Shiniess", Range(0.01, 1)) = .6
		_MainTex("MainTexture", 2D) = "white"{}
	}

	SubShader
	{
		Material
		{
			Diffuse[_Color]

			Emission[_Emission]

			Ambient[_Color]

			Shininess[_Shininess]

			Specular[_Specular]
		}

		Lighting On

		SeparateSpecular On

		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			Cull Front

			SetTexture[_MainTex]
			{
				Combine Primary * Texture
			}
		}

		Pass
		{
			Cull Back

			SetTexture[_MainTex]
			{
				Combine Primary * Texture
			}
		}
	}
}
