Shader "Morning/FixedShader/Leaning_4-1_用剔除操作渲染对象背面"
{
	SubShader
	{
		Pass
		{
			Material
			{
				Diffuse(1,1,1,1)

				Emission(.3,.3,.3,.3)
			}

			Lighting On

			Cull Front
		}
	}
}
