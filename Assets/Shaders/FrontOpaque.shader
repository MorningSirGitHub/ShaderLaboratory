Shader "Unlit/FrontOpaque"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Alpha("alpha", Range(1 , 0)) = 1
	}
		SubShader
	{
		Tags{ "RenderType" = "Transparent " "Queue" = "Transparent-500"  } // "Queue"="Transparent"将其设置为透明，不然无法看见后面的东西（即使透明）  
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha //实现Alpha的核心，使用语句进行Alpha混合  
		/*ZTest Off
		ZWrite Off*/
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Alpha;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);

				col.w *= _Alpha;

				return col;
			}
			ENDCG
		}
	}
}
