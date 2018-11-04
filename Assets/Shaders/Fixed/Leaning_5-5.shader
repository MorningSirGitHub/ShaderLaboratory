Shader "Morning/FixedShader/Leaning_5-5_玻璃效果v2&v3"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("MainTexture", 2D) = "white"{}
		_Reflections("Reflection", Cube) = "skybox" {TexGen CubeReflect}
	}

	SubShader
	{
		Tags{"Queue" = "Transparent"}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			Material
			{
				Diffuse[_Color]
			}

			Lighting On

			SetTexture[_MainTex]
			{
				combine texture * primary double,texture * primary
			}
		}

		Pass
		{
			Blend One One

			Material
			{
				Diffuse[_Color]
			}

			Lighting On

			SetTexture[_Reflections]
			{
				Combine texture
				Matrix[_Reflection]
			}
		}
	}
}
