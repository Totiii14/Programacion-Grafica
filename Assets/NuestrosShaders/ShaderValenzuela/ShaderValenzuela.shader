// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ShaderValenzuela"
{
	Properties
	{
		_Texture1("Texture 0", 2D) = "white" {}
		_Color0("Color 0", Color) = (0.3987629,0.9716981,0.9373954,0)
		_Amplitude("Amplitude", Float) = 2
		_Texture3("Texture 1", 2D) = "white" {}
		_Frequency("Frequency", Float) = 2
		_Vector4("Vector 2", Vector) = (0,0.5,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Frequency;
		uniform float _Amplitude;
		uniform float4 _Color0;
		uniform sampler2D _Texture1;
		uniform float4 _Texture1_ST;
		uniform sampler2D _Texture3;
		uniform float2 _Vector4;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 break11 = ase_vertex3Pos;
			float4 appendResult13 = (float4(break11.x , ( break11.y + ( sin( ( ( ase_vertex3Pos.x * _Frequency ) - ( _Time.y * 3.0 ) ) ) * _Amplitude ) ) , break11.z , 0.0));
			v.vertex.xyz += appendResult13.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture1 = i.uv_texcoord * _Texture1_ST.xy + _Texture1_ST.zw;
			o.Albedo = ( _Color0 * tex2D( _Texture1, uv_Texture1 ) ).rgb;
			float mulTime19 = _Time.y * 3.0;
			o.Alpha = ( 1.0 - tex2D( _Texture3, (i.uv_texcoord*4.0 + ( _Vector4 * mulTime19 )) ) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
108;81;677;555;1576.658;658.2188;3.327289;False;False
Node;AmplifyShaderEditor.PosVertexDataNode;2;-1248.822,-15.69278;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-519.8712,441.627;Inherit;False;Constant;_Speed2;Speed2;4;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-1163.186,388.1393;Inherit;False;Property;_Frequency;Frequency;6;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-541.824,337.8324;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-297.8177,364.212;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-789.2161,221.6762;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-1374.673,1233.307;Inherit;False;1;0;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;20;-1355.173,1063.556;Inherit;False;Property;_Vector4;Vector 2;7;0;Create;True;0;0;0;False;0;False;0,0.5;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-189.1895,150.4302;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;4;-45.29925,147.8764;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;22;-1145.852,1006.351;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1084.499,1173.017;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-135.7018,450.5807;Inherit;False;Property;_Amplitude;Amplitude;3;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;28;-431.847,-278.5497;Inherit;True;Property;_Texture1;Texture 0;1;0;Create;True;0;0;0;False;0;False;36be8d528a4fa024faa4680d7658642c;84508b93f15f2b64386ec07486afc7a3;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;49.80326,239.0955;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;23;-973.0631,800.8972;Inherit;True;Property;_Texture3;Texture 1;5;0;Create;True;0;0;0;False;0;False;80ee511a5808d8d499a8ca850b8a2129;80ee511a5808d8d499a8ca850b8a2129;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.BreakToComponentsNode;11;16.36542,-30.14482;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ScaleAndOffsetNode;24;-845.5558,1047.808;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;4;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;25;-612.6286,806.955;Inherit;True;Property;_TextureSample3;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;183.5665,154.2267;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-30.30518,-520.8586;Inherit;False;Property;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;0.3987629,0.9716981,0.9373954,0;0.3987629,0.9716981,0.9373954,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-64.84693,-286.5497;Inherit;True;Property;_TextureSample1;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;13;274.8525,-8.758306;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-921.3503,114.7525;Inherit;False;Property;_Speed;Speed;4;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-742.8259,51.34606;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-920.1786,30.2212;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;303.2361,-372.9973;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;26;-253.2163,620.2205;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;490.0354,-240.5948;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;ShaderValenzuela;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;7;0;2;1
WireConnection;7;1;1;0
WireConnection;18;0;7;0
WireConnection;18;1;16;0
WireConnection;4;0;18;0
WireConnection;21;0;20;0
WireConnection;21;1;19;0
WireConnection;9;0;4;0
WireConnection;9;1;10;0
WireConnection;11;0;2;0
WireConnection;24;0;22;0
WireConnection;24;2;21;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;12;0;11;1
WireConnection;12;1;9;0
WireConnection;27;0;28;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;13;2;11;2
WireConnection;5;0;3;0
WireConnection;5;1;8;0
WireConnection;3;0;2;2
WireConnection;29;0;14;0
WireConnection;29;1;27;0
WireConnection;26;0;25;0
WireConnection;0;0;29;0
WireConnection;0;9;26;0
WireConnection;0;11;13;0
ASEEND*/
//CHKSM=7207C116CC7F301B68D7B16A0223D015C5212A50