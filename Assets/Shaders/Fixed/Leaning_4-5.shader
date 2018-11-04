Shader "Morning/FixedShader/Leaning_4-5_顶点光照+可调透明度"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,0)
		_Specular("Specular", Color) = (1,1,1,1)
		_Emission("Emission", Color) = (0,0,0,0)
		_Shininess("Shininess", Range(.01, 1)) = .7
		_MainTex("MainTexture", 2D) = "white"{}
		_CullOff("CullOff", Range(0, 1)) = .5
	}

	SubShader
	{
		Pass
		{
			AlphaTest Greater [_CullOff]

			Material
			{
				Diffuse[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				Specular[_Specular]
				Emission[_Emission]
			}

			Lighting On

			SetTexture[_MainTex]
			{
				Combine Texture * Primary
			}
		}
	}
}
