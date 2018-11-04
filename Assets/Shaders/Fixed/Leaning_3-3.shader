Shader "Morning/FixedShader/Leaning_3-3_纹理Alpha与自发光混合可调色版"
{
	Properties
	{
		_CustomColor("CustomColor", Color) = (1,1,1,1)
		_MainTex("MainTexture", 2D) = "White" { }
	}

	SubShader
	{
		Pass
		{
			Material
			{
				Diffuse(1,1,1,1)
				Ambient(1,1,1,1)
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

		}
	}
}
