// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_HueShift("HueShift", Range( 0 , 1)) = 0
		_SaturationShift("SaturationShift", Range( 0 , 1)) = 0
		_BrightnessShift("BrightnessShift", Range( 0 , 1)) = 0

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			

			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _HueShift;
			uniform float _SaturationShift;
			uniform float _BrightnessShift;
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float3 RGBToHSV(float3 c)
			{
				float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
				float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
				float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
				float d = q.x - min( q.w, q.y );
				float e = 1.0e-10;
				return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 texCoord2 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float3 hsvTorgb3 = RGBToHSV( tex2D( _MainTex, texCoord2 ).rgb );
				float3 hsvTorgb7 = HSVToRGB( float3(frac( ( hsvTorgb3.x + _HueShift ) ),( hsvTorgb3.y + _SaturationShift ),( hsvTorgb3.z + _BrightnessShift )) );
				

				finalColor = float4( hsvTorgb7 , 0.0 );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
184;73;798;658;759.8981;98.54423;1.289327;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-953.7902,102.5568;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;15;-891.6107,-29.98761;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-726.0858,5.631517;Inherit;True;Property;_Tex;Tex;0;0;Create;True;0;0;0;False;0;False;-1;ce18f8c887bb2214d9480acc78b8864e;ce18f8c887bb2214d9480acc78b8864e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RGBToHSVNode;3;-290.6862,14.10141;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;4;-318.1043,-125.6198;Inherit;False;Property;_HueShift;HueShift;0;0;Create;True;0;0;0;False;0;False;0;0.51;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;53.78946,-11.64458;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-349.2098,276.3864;Inherit;False;Property;_SaturationShift;SaturationShift;1;0;Create;True;0;0;0;False;0;False;0;0.85;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-297.1295,493.6064;Inherit;False;Property;_BrightnessShift;BrightnessShift;2;0;Create;True;0;0;0;False;0;False;0;0.48;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;10.81926,415.2238;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;6;250.7364,40.89257;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;101.4538,184.0863;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;7;386.8034,38.98217;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;12;464.5317,373.5846;Inherit;False;Constant;_Contrast;Contrast;4;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;14;894.4193,39.10426;Float;False;True;-1;2;ASEMaterialInspector;0;2;New Amplify Shader;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;1;0;15;0
WireConnection;1;1;2;0
WireConnection;3;0;1;0
WireConnection;5;0;3;1
WireConnection;5;1;4;0
WireConnection;10;0;3;3
WireConnection;10;1;11;0
WireConnection;6;0;5;0
WireConnection;8;0;3;2
WireConnection;8;1;9;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;7;2;10;0
WireConnection;14;0;7;0
ASEEND*/
//CHKSM=5B1936A6C9F65D36E5B94C11D4477EBCB0251E99