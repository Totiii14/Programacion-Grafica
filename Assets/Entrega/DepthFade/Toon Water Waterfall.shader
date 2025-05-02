// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toon Water Waterfall"
{
	Properties
	{
		_Flowdir("Flow dir", Vector) = (0.1,1,0,0)
		_FlowTextureZoom("Flow Texture Zoom", Range( 0 , 1)) = 0.2
		_FlowPlace("Flow Place", Vector) = (-0.3,0,0,0)
		_FlowSpeed("Flow Speed", Float) = 1.1
		_WaterTexture("Water Texture", 2D) = "white" {}

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
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _WaterTexture;
			uniform float2 _FlowPlace;
			uniform float _FlowSpeed;
			uniform float2 _Flowdir;
			uniform float _FlowTextureZoom;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

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
				float2 texCoord5 = i.ase_texcoord1.xy * _Flowdir + float2( 0,0 );
				float2 lerpResult3 = lerp( texCoord5 , float2( 0,0 ) , _FlowTextureZoom);
				float2 panner7 = ( 1.0 * _Time.y * ( _FlowPlace * _FlowSpeed ) + lerpResult3);
				
				
				finalColor = tex2D( _WaterTexture, panner7 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
193;73;854;622;1094.413;588.9654;1.6;False;False
Node;AmplifyShaderEditor.Vector2Node;4;-1613.722,-195.5898;Inherit;False;Property;_Flowdir;Flow dir;0;0;Create;False;0;0;0;False;0;False;0.1,1;0.1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1436.69,-214.6136;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1460.897,-51.09988;Inherit;False;Property;_FlowTextureZoom;Flow Texture Zoom;1;0;Create;False;0;0;0;False;0;False;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-1433.5,89.6139;Inherit;False;Property;_FlowPlace;Flow Place;2;0;Create;False;0;0;0;False;0;False;-0.3,0;-0.3,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;9;-1428.337,212.3927;Inherit;False;Property;_FlowSpeed;Flow Speed;3;0;Create;False;0;0;0;False;0;False;1.1;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;-1171.382,-214.5791;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1216.52,95.92034;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;12;-1078.405,-442.4026;Inherit;True;Property;_WaterTexture;Water Texture;4;0;Create;True;0;0;0;False;0;False;None;e24b2c680edaa90458d31f11544d79ca;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;7;-971.8899,-215.0785;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-747.4503,-242.1012;Inherit;True;Property;_WaterTextureSamp;Water Texture Samp;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;-361.8363,-119.4733;Float;False;True;-1;2;ASEMaterialInspector;100;1;Toon Water Waterfall;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;5;0;4;0
WireConnection;3;0;5;0
WireConnection;3;2;6;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;7;0;3;0
WireConnection;7;2;10;0
WireConnection;11;0;12;0
WireConnection;11;1;7;0
WireConnection;1;0;11;0
ASEEND*/
//CHKSM=73871CEF2E8B02785FBC12C07B4E63940F05D2B0