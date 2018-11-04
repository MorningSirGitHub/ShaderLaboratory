Shader "Morning/FixedShader/Leaning_4-4_基本Alpha测试"
{
	Properties
	{
		_MainTex("MainTexture", 2D) = "white"{}
	}

	SubShader
	{
		Pass
		{
			AlphaTest Greater 0.6

			SetTexture[_MainTex]
			{
				Combine Primary * Texture
			}
		}
	}
}
