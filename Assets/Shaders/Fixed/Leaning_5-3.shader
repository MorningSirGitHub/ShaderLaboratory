// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Morning/FixedShader/Leaning_5-3_可编程Shader"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Specular("Specular", Color) = (1,1,1,1)
		_Shininess("Shininess", Float) = 10
	}

	SubShader
	{
		Tags{"LightMode" = "ForwardBase"}

		Pass
		{
			CGPROGRAM

			#pragma vertex vert 
			#pragma fragment frag

			uniform float4 _Color;
			uniform float4 _Specular;
			uniform float _Shininess;

			uniform float4 _LightColor0;

			struct VertexInput
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
			};

			struct VertexOutput
			{
				float4 pos:SV_POSITION;
				float4 col:COLOR;
			};

			VertexOutput vert(VertexInput v)
			{
				VertexOutput o;

				float3 normalDirection = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz);
				float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - mul(unity_ObjectToWorld, v.vertex).xyz));
				float3 lightDirection;

				float atten = 1.0;

				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 diffuseReflection = atten * _LightColor0.xyz * max(0.0, dot(normalDirection, lightDirection));
				float3 specularReflection = atten * _LightColor0.xyz * _Specular.rgb * max(0.0, dot(normalDirection, lightDirection)) * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
				float3 lightFinal = diffuseReflection + specularReflection + UNITY_LIGHTMODEL_AMBIENT;

				o.col = float4(lightFinal * _Color.rgb, 1.0);
				o.pos = UnityObjectToClipPos(v.vertex);

				return o;
			}

			float4 frag(VertexOutput i) :Color
			{
				return i.col;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
