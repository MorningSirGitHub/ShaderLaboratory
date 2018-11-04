Shader "Morning/FixedShader/Leaning_4-2_渲染对象背面v2"
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
		Pass
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

			SetTexture[_MainTex]
			{
				Combine Primary * Texture
			}
		}

		Pass
		{
			Color(0,0,1,1)
			Cull Front
		}
	}
}
