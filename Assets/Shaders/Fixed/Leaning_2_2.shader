Shader "Morning/FixedShader/Leaning_2_2"
{
	SubShader
	{
		Pass
		{
			Material
			{
				// 将漫反射和环境光反射颜色设为相同
				Diffuse(0.9,0.5,0.4,1)
				Ambient(0.9,0.5,0.4,1)
			}
			Lighting On
		}
	}
}
