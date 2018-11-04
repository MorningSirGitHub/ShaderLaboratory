Shader "Morning/FixedShader/Leaning_2_5"
{
	Properties
	{
		_Color("MainCorlor", Color) = (1,.3,.5,1)
		_SpecularColor("SpecularColor", Color) = (.5,.2,.5,1)
		_Emission("Emission", Color) = (.9,.5,1,1)
		_Shininess("Shininess", Range(.01,1)) = .7
		_MainTex("MainTexture",2D) = "White"{}
	}

	SubShader
	{
		Pass
		{
			Material
			{
				Diffuse[_Color]
				Ambient[_Color]

				Shininess[_Shininess]

				Specular[_Specular]

				Emission[_Emission]
			}
			Lighting On

			SeparateSpecular On

			SetTexture[_MainTex]
			{
				Combine texture * primary DOUBLE, texture * primary
			}
		}
	}

	FallBack "Diffuse"
}
