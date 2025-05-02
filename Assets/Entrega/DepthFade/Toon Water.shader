// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toon Water"
{
	Properties
	{
		_WaveDistorssion("Wave Distorssion", Range( 0 , 1)) = 0.3201282
		_TextureTiling("Texture Tiling", Float) = 1.1
		_WaterMoveSpeed("Water Move Speed", Float) = 1.1
		_Vector0("Vector 0", Vector) = (-0.3,0,0,0)
		_WaterTexture("Water Texture", 2D) = "white" {}
		_Scale("Scale", Range( 0 , 1)) = 0.07
		_Flowmap("Flowmap", 2D) = "white" {}
		_Power("Power", Range( 0 , 10)) = 10
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _WaterTexture;
			uniform float2 _Vector0;
			uniform float _WaterMoveSpeed;
			uniform sampler2D _Flowmap;
			uniform float4 _Flowmap_ST;
			uniform float _TextureTiling;
			uniform float _WaveDistorssion;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _Scale;
			uniform float4 _Color0;
			uniform float _Power;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord2 = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 uv_Flowmap = i.ase_texcoord1.xy * _Flowmap_ST.xy + _Flowmap_ST.zw;
				float4 tex2DNode27 = tex2D( _Flowmap, uv_Flowmap );
				float4 appendResult26 = (float4(tex2DNode27.r , tex2DNode27.g , 0.0 , 0.0));
				float2 temp_cast_0 = (_TextureTiling).xx;
				float2 texCoord11 = i.ase_texcoord1.xy * temp_cast_0 + float2( 0,0 );
				float4 lerpResult16 = lerp( ( appendResult26 + float4( texCoord11, 0.0 , 0.0 ) ) , float4( texCoord11, 0.0 , 0.0 ) , _WaveDistorssion);
				float2 panner18 = ( 1.0 * _Time.y * ( _Vector0 * _WaterMoveSpeed ) + lerpResult16.xy);
				float4 screenPos = i.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth4 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth4 = abs( ( screenDepth4 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
				float4 temp_cast_4 = (_Power).xxxx;
				
				
				finalColor = ( tex2D( _WaterTexture, panner18 ) + ( 1.0 - saturate( pow( ( 1.0 - ( ( distanceDepth4 * _Scale ) * _Color0 ) ) , temp_cast_4 ) ) ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
216;73;918;658;2076.889;588.1359;2.007311;True;True
Node;AmplifyShaderEditor.CommentaryNode;2;-1505.787,-130.5269;Inherit;False;1439.41;511.3426;Comment;10;21;20;15;13;9;8;4;32;30;33;Depth Fade;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;3;-1464.798,-1034.883;Inherit;False;1233.972;822.1364;Comment;13;22;19;18;17;16;14;12;11;10;25;26;27;29;Texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1326.811,186.4555;Inherit;False;Property;_Scale;Scale;5;0;Create;False;0;0;0;False;0;False;0.07;0.84;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;4;-1435.315,-80.52689;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-1459.115,-953.9848;Inherit;True;Property;_Flowmap;Flowmap;6;0;Create;True;0;0;0;False;0;False;-1;28788f2dcdc613e4f88ba773b87c3bb7;28788f2dcdc613e4f88ba773b87c3bb7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;30;-1001.52,170.7757;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.03137255,0.0283464,0.9647059,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-928.6251,1.875232;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1424.775,-697.3116;Inherit;False;Property;_TextureTiling;Texture Tiling;1;0;Create;False;0;0;0;False;0;False;1.1;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-783.4799,77.29452;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1203.511,-713.5034;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1156.283,-936.6274;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;33;-690.1918,-45.45279;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-781.2003,273.8387;Inherit;False;Property;_Power;Power;7;0;Create;True;0;0;0;False;0;False;10;5.25;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1228.322,-327.907;Inherit;False;Property;_WaterMoveSpeed;Water Move Speed;2;0;Create;False;0;0;0;False;0;False;1.1;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1179.394,-582.7507;Inherit;False;Property;_WaveDistorssion;Wave Distorssion;0;0;Create;False;0;0;0;False;0;False;0.3201282;0.628;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;12;-1241.92,-495.5143;Inherit;False;Property;_Vector0;Vector 0;3;0;Create;False;0;0;0;False;0;False;-0.3,0;0.44,0.27;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1010.968,-865.6672;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;16;-910.8572,-749.8596;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1017.596,-446.5604;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;15;-540.9805,66.74901;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;18;-723.3655,-749.7781;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;19;-879.4806,-984.8832;Inherit;True;Property;_WaterTexture;Water Texture;4;0;Create;True;0;0;0;False;0;False;None;efa2302ad859d1b48ba53c27fb1ff409;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SaturateNode;20;-397.4696,66.43023;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;-548.5258,-784.5817;Inherit;True;Property;_WaterTextureSamp;Water Texture Samp;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;21;-251.9075,56.90896;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;195.0503,-118.2355;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;447.5347,-116.0782;Float;False;True;-1;2;ASEMaterialInspector;100;1;Toon Water;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;13;0;4;0
WireConnection;13;1;8;0
WireConnection;32;0;13;0
WireConnection;32;1;30;0
WireConnection;11;0;29;0
WireConnection;26;0;27;1
WireConnection;26;1;27;2
WireConnection;33;0;32;0
WireConnection;25;0;26;0
WireConnection;25;1;11;0
WireConnection;16;0;25;0
WireConnection;16;1;11;0
WireConnection;16;2;14;0
WireConnection;17;0;12;0
WireConnection;17;1;10;0
WireConnection;15;0;33;0
WireConnection;15;1;9;0
WireConnection;18;0;16;0
WireConnection;18;2;17;0
WireConnection;20;0;15;0
WireConnection;22;0;19;0
WireConnection;22;1;18;0
WireConnection;21;0;20;0
WireConnection;23;0;22;0
WireConnection;23;1;21;0
WireConnection;1;0;23;0
ASEEND*/
//CHKSM=0C23C913EFA3422A0258E8C756710761C94EEFDA