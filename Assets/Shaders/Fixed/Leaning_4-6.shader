Shader "Morning/FixedShader/Leaning_4-6_简单的植被Shader"
{
	Properties
	{
		_Color("Color", Color) = (.5,.5,.5,.5)
		_MainTex("MainTexture", 2D) = "white"{}
		_CullOff("CullOff", Range(0, 1)) = .5
	}

	SubShader
	{
		Material
		{
			Diffuse[_Color]
			Ambient[_Color]
		}

		Lighting On

		Cull Off

		Pass
		{
			AlphaTest Greater [_CullOff]

			SetTexture[_MainTex]
			{
				Combine Texture * Primary, Texture
			}
		}

		Pass
		{
			Zwrite Off

			ZTest Less

			AlphaTest LEqual [_CullOff]

			Blend SrcAlpha OneMinusSrcAlpha

			SetTexture[_MainTex]
			{
				Combine Primary * Texture, Texture
			}
		}
	}
}
