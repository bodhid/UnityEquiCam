Shader "Bodhi Donselaar/TinyPlanet"
{
	Properties
	{
		[HideInInspector]_MainTex ("Texture", CUBE) = "white" {}
		_Angle("Angle",range(0,360))=180
		_Pow("Pow",range(0,4))=1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
			uniform float FORWARD;
			v2f vert (float4 v : POSITION,float2 uv : TEXCOORD0)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v);
				o.uv =(uv - .5);
				o.uv.x *= _ScreenParams.x / _ScreenParams.y;
				return o;
			}
			samplerCUBE _MainTex;
			half _Angle, _Pow;
			fixed4 frag (v2f i) : SV_Target
			{
				float angle=_Angle/360.0*6.2829;
				float y = -1+distance(i.uv*angle/2,float2(0,0));
				float x = sin(i.uv.x*angle);
				float z = sin(i.uv.y*angle);
				//return z;
				//y = sign(y)*pow(abs(y), _Pow);
	
				return texCUBE(_MainTex,normalize(float3(x,y,z)));
				float cy = cos(i.uv.y);
				return texCUBE(_MainTex, float3(sin(i.uv.x)*cy, sin(i.uv.y), cos(i.uv.x)*cy));
			}
			ENDCG
		}
	}
}
