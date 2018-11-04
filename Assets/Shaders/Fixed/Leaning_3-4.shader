Shader "Morning/FixedShader/Leaning_3-4_顶点光照+纹理Alpha自发光混合"
{
	Properties
	{
		_CustomColor("CustomColor", Color) = (1,1,1,1)
		_MainColor("MainColor", Color) = (1,1,1,1)
		_SpecularColor("SpecularColor", Color) = (1,1,1,1)
		_Emission("Emission", Color) = (0,0,0,0)
		_Shiniess("Shiniess", Range(0.01, 1)) = .7
		_MainTex("MainTexture", 2D) = "White" { }
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
				Specular[_SpecColor]
				Emission[_Emission]
			}

			Lighting On

			SetTexture[_MainTex]
			{
				constantColor(1,1,1,1)
				combine constant lerp(texture) previous
			}

			SetTexture[_MainTex]
			{
				combine previous * texture
			}

			SetTexture[_MainTex]
			{
				Combine previous * primary DOUBLE, previous * primary
			}

		}
	}
}
