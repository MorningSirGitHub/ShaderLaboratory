Shader "Morning/FixedShader/Leaning_3-1_Alpha纹理融合"
{
	Properties
	{
		_MainTex("MainTexture",2D) = "White"{}
		_BlendTex("BlendTexture",2D) = "White"{}
	}

	SubShader
	{
		Tags {"Queue" = "Transparent"}

		Pass
		{
			SetTexture[_MainTex]{Combine texture}

			SetTexture[_BlendTex]{Combine texture * previous}
		}
	}

	FallBack "Diffuse"
}
