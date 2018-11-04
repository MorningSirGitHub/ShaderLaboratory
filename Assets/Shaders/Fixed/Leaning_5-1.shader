Shader "Morning/FixedShader/Leaning_5-1_固定功能Shader"
{
	Properties
	{
		_Color("Color", Color) = (.5,.5,.5,.5)
		_Specular("Specular", Color) = (1,1,1,1)
		_Emission("Emission", Color) = (0,0,0,0)
		_Shininess("Shininess", Range(.01, 1)) = .7
		_MainTex("MainTexture", 2D) = "white"{}
	}

	SubShader
	{
		Material
		{
			Diffuse[_Color]
			Ambient[_Color]
			Emission[_Emission]
			Specular[_Specular]
			Shininess[_Shininess]
		}

		Lighting On

		SeparateSpecular On

		Pass
		{
			SetTexture[_MainTex]
			{
				Combine Texture * Primary DOUBLE, Texture * Primary
			}
		}
	}
}
