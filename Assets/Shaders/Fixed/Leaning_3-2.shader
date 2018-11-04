Shader "Morning/FixedShader/Leaning_3-2_纹理的Alpha通道与自发光相混合"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "Red" { }
	}

	SubShader
	{
		Tags {"Queue" = "Transparent"}

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

	FallBack "Diffuse"
}
