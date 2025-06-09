// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Bloom_PostFX"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_MainTex2("_MainTex2", 2D) = "white" {}
		_Float0("Float 0", Float) = 1
		_Vector0("Vector 0", Vector) = (0.2126,0.7152,0.0722,0)
		_Float1("Float 1", Float) = 4

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
				float4 ase_texcoord4 : TEXCOORD4;
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform sampler2D _MainTex2;
			uniform float3 _Vector0;
			uniform float _Float0;
			uniform float _Float1;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord4 = screenPos;
				
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
				float4 screenPos = i.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float4 tex2DNode19 = tex2D( _MainTex2, ( (ase_screenPosNorm).xy / ase_screenPosNorm.w ) );
				float dotResult20 = dot( tex2DNode19 , float4( _Vector0 , 0.0 ) );
				float4 temp_output_24_0 = ( tex2DNode19 * step( dotResult20 , _Float0 ) );
				

				finalColor = ( ( ( tex2D( _MainTex2, ( temp_output_24_0 + float4( float2( 0.002,0 ), 0.0 , 0.0 ) ).rg ) + tex2D( _MainTex2, ( temp_output_24_0 + float4( float2( -0.002,0 ), 0.0 , 0.0 ) ).rg ) + tex2D( _MainTex2, ( temp_output_24_0 + float4( float2( 0,0.002 ), 0.0 , 0.0 ) ).rg ) + tex2D( _MainTex2, ( temp_output_24_0 + float4( float2( 0,-0.002 ), 0.0 , 0.0 ) ).rg ) ) / _Float1 ) + tex2DNode19 );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
108;269;857;530;3134.594;974.6723;2.018724;False;False
Node;AmplifyShaderEditor.ScreenPosInputsNode;18;-3335.866,-399.4561;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;16;-3129.14,-399.3816;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;15;-3063.258,-791.8591;Inherit;True;Property;_MainTex2;_MainTex2;3;0;Create;True;0;0;0;False;0;False;None;d94d31337019e9142a88b694c3b1d142;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleDivideOpNode;17;-2921.981,-324.8786;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;21;-2725.746,17.26446;Inherit;False;Property;_Vector0;Vector 0;5;0;Create;True;0;0;0;False;0;False;0.2126,0.7152,0.0722;0.21,-0.11,0.04;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;19;-2751.849,-373.4931;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-2517.574,139.7256;Inherit;False;Property;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;1;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;20;-2444.343,-103.3897;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-2356.965,49.49401;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-2397.805,-440.3408;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;34;-2999.022,-1288.405;Inherit;False;Constant;_Vector1;Vector 1;5;0;Create;True;0;0;0;False;0;False;0.002,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;35;-2999.543,-1177.144;Inherit;False;Constant;_Vector2;Vector 2;6;0;Create;True;0;0;0;False;0;False;-0.002,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;36;-2995.191,-1065.714;Inherit;False;Constant;_Vector3;Vector 3;7;0;Create;True;0;0;0;False;0;False;0,0.002;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;37;-2995.712,-954.4533;Inherit;False;Constant;_Vector4;Vector 4;8;0;Create;True;0;0;0;False;0;False;0,-0.002;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-2012.447,-537.5907;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-2016.213,-629.8557;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-2016.209,-816.2666;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-2014.331,-724.0038;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;38;-1814.01,-1141.467;Inherit;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;39;-1809.617,-954.7358;Inherit;True;Property;_TextureSample3;Texture Sample 3;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;41;-1808.403,-588.8564;Inherit;True;Property;_TextureSample5;Texture Sample 5;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;40;-1809.617,-772.4002;Inherit;True;Property;_TextureSample4;Texture Sample 4;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-1286.31,-847.1891;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1391.248,-455.4014;Inherit;False;Property;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;43;-1218.088,-585.8582;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-1187.89,-372.4742;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-826.1774,-1210.329;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1019.34,-1110.209;Inherit;False;Property;_Speed;Speed;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-483.6563,-1801.618;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;ce18f8c887bb2214d9480acc78b8864e;ce18f8c887bb2214d9480acc78b8864e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-771.066,-1555.794;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-463.1181,-1385.524;Inherit;True;Property;_NoiseTex;_NoiseTex;0;0;Create;True;0;0;0;False;0;False;-1;12c89afe141ffb44db0961b50bfb0d10;12c89afe141ffb44db0961b50bfb0d10;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-91.88,-1392.216;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;10;-687.8341,-1918.115;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;1;-1388.126,-1667.725;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1059.172,-1453.681;Inherit;False;Property;_NoiseScale;_NoiseScale;1;0;Create;True;0;0;0;False;0;False;0.8229017;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-618.3461,-1322.153;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;6;-929.8566,-1598.268;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1019.64,-1320.489;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;14;-820.345,-1777.847;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;2;-1162.621,-1739.348;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-798.1292,61.43606;Float;False;True;-1;2;ASEMaterialInspector;0;2;Bloom_PostFX;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;16;0;18;0
WireConnection;17;0;16;0
WireConnection;17;1;18;4
WireConnection;19;0;15;0
WireConnection;19;1;17;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;22;0;20;0
WireConnection;22;1;23;0
WireConnection;24;0;19;0
WireConnection;24;1;22;0
WireConnection;28;0;24;0
WireConnection;28;1;37;0
WireConnection;27;0;24;0
WireConnection;27;1;36;0
WireConnection;25;0;24;0
WireConnection;25;1;34;0
WireConnection;26;0;24;0
WireConnection;26;1;35;0
WireConnection;38;0;15;0
WireConnection;38;1;25;0
WireConnection;39;0;15;0
WireConnection;39;1;26;0
WireConnection;41;0;15;0
WireConnection;41;1;28;0
WireConnection;40;0;15;0
WireConnection;40;1;27;0
WireConnection;42;0;38;0
WireConnection;42;1;39;0
WireConnection;42;2;40;0
WireConnection;42;3;41;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;45;0;43;0
WireConnection;45;1;19;0
WireConnection;7;0;3;0
WireConnection;7;1;5;0
WireConnection;12;0;10;0
WireConnection;12;1;14;0
WireConnection;8;0;6;0
WireConnection;8;1;4;0
WireConnection;11;1;9;0
WireConnection;13;0;12;0
WireConnection;13;1;11;0
WireConnection;9;0;8;0
WireConnection;9;1;7;0
WireConnection;6;0;2;0
WireConnection;6;1;1;4
WireConnection;2;0;1;0
WireConnection;0;0;45;0
ASEEND*/
//CHKSM=6B18F7AE888D5100EE673CF27640A86763366F82