Shader "Morning/FixedShader/Leaning_2_3"
{
	Properties
	{
		_MainColor("MainCorlor",Color) = (1,.3,.5,1)
	}

	SubShader
	{
		Pass
		{
			Material
			{
				Diffuse[_MainColor]
				Ambient[_MainColor]
			}
			Lighting On
		}
	}
}
