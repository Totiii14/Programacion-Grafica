// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Lens Flares"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Sensitivitylight("Sensitivity light", Range( 0 , 1)) = 0
		_LightPos("Light Pos", Vector) = (0,0,0,0)
		_Intensity("Intensity", Color) = (0,0,0,0)
		_FlareOffset("Flare Offset", Float) = 0

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
			
			uniform float _Sensitivitylight;
			uniform float2 _LightPos;
			uniform float _FlareOffset;
			uniform float4 _Intensity;


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
				float4 tex2DNode3 = tex2D( _MainTex, screenPos.xy );
				float dotResult4 = dot( tex2DNode3 , float4( float3(0.2126,0.7152,0.0722) , 0.0 ) );
				float2 temp_cast_2 = (step( dotResult4 , _Sensitivitylight )).xx;
				

				finalColor = ( ( tex2D( _MainTex, ( screenPos + float4( ( ( temp_cast_2 - _LightPos ) * _FlareOffset ), 0.0 , 0.0 ) ).xy ) * _Intensity ) + tex2DNode3 );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
2107;71;682;733;1101.307;684.9443;2.051009;False;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1181.726,-120.8748;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-1216.911,-5.604221;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;5;-993.6858,142.0139;Inherit;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;0;False;0;False;0.2126,0.7152,0.0722;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;3;-993.0864,-69.27584;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-781.4604,199.9647;Inherit;False;Property;_Sensitivitylight;Sensitivity light;0;0;Create;True;0;0;0;False;0;False;0;0.331;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;4;-640.0867,-2.285985;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;17;-1008.115,313.7825;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StepOpNode;6;-513.7658,-4.215878;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-488.223,103.5019;Inherit;False;Property;_LightPos;Light Pos;1;0;Create;True;0;0;0;False;0;False;0,0;0.59,0.14;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;19;-561.4833,390.1924;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-326.7435,105.0096;Inherit;False;Property;_FlareOffset;Flare Offset;3;0;Create;True;0;0;0;False;0;False;0;0.32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-348.4816,-3.23808;Inherit;False;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;18;-104.6778,310.7987;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-180.6084,-1.857704;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-6.493989,0.5021933;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;13;163.8602,-204.2984;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;236.6496,9.167621;Inherit;False;Property;_Intensity;Intensity;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;482.2148,-196.4894;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;659.3324,-77.64462;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;801.7956,-78.26797;Float;False;True;-1;2;ASEMaterialInspector;0;2;Lens Flares;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;17;0;2;0
WireConnection;6;0;4;0
WireConnection;6;1;7;0
WireConnection;19;0;17;0
WireConnection;9;0;6;0
WireConnection;9;1;8;0
WireConnection;18;0;19;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;12;0;18;0
WireConnection;12;1;10;0
WireConnection;13;0;1;0
WireConnection;13;1;12;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;16;0;14;0
WireConnection;16;1;3;0
WireConnection;0;0;16;0
ASEEND*/
//CHKSM=AD9874F8EF815B93D9E6D1424BDA269D9A4C6183