// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BrightnessButton"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_Speed("Speed", Float) = 0.35
		_Angle("Angle", Range( 0 , 90)) = 23.87807
		_Min("Min", Float) = 0.5
		_Brightness("Brightness", Float) = 2
		_Color1("Color 1", Color) = (0.990566,0.03270739,0.03270739,1)
		_Sharpness("Sharpness", Range( 1 , 4)) = 2.84
		_Color0("Color 0", Color) = (0.5377358,0.0228284,0.0228284,1)

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			#include "UnityShaderVariables.cginc"

			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform float4 _Color0;
			uniform float4 _Color1;
			uniform float _Angle;
			uniform float _Speed;
			uniform float _Min;
			uniform float _Brightness;
			uniform float _Sharpness;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 break8 = IN.texcoord.xy;
				float temp_output_6_0 = radians( _Angle );
				float4 lerpResult32 = lerp( _Color0 , _Color1 , pow( ( 1.0 - ( abs( ( frac( ( ( ( break8.x * cos( temp_output_6_0 ) ) + ( break8.y * sin( temp_output_6_0 ) ) ) + ( _Time.y * _Speed ) ) ) - _Min ) ) * _Brightness ) ) , _Sharpness ));
				
				half4 color = lerpResult32;
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
356;73;604;707;-275.6094;521.6418;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;34;-1819.821,-146.6429;Inherit;False;1095.434;412.1287;Angulo de línea;9;4;6;5;9;7;8;10;11;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1762.821,66.57624;Inherit;False;Property;_Angle;Angle;1;0;Create;True;0;0;0;False;0;False;23.87807;23.87807;0;90;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;6;-1450.556,108.3732;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;5;-1676.912,-82.10339;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;9;-1265.335,24.50046;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;7;-1277.713,155.3257;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;8;-1319.842,-96.64293;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;33;-690.5712,-56.18903;Inherit;False;1715.048;324.309;Brillo;13;14;15;17;18;19;20;21;22;23;24;26;25;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1059.833,64.96119;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1080.15,-73.19685;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;14;-640.5712,31.75098;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-628.7194,141.6522;Inherit;False;Property;_Speed;Speed;0;0;Create;True;0;0;0;False;0;False;0.35;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-457.9771,70.27397;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-876.9759,-44.75264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-271.8695,-6.189058;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-131.6388,99.57819;Inherit;False;Property;_Min;Min;2;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;19;-114.2967,-0.6921434;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;21;83.13198,32.97448;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;22;234.1319,31.97449;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;241.886,134.7799;Inherit;False;Property;_Brightness;Brightness;3;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;421.4312,38.27448;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;26;640.7781,34.93377;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;517.2722,152.9598;Inherit;False;Property;_Sharpness;Sharpness;5;0;Create;True;0;0;0;False;0;False;2.84;2.344706;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;772.0886,-241.8707;Inherit;False;Property;_Color1;Color 1;4;0;Create;True;0;0;0;False;0;False;0.990566,0.03270739,0.03270739,1;0.990566,0.03270739,0.03270739,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;27;844.8277,131.0801;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;791.6508,-426.498;Inherit;False;Property;_Color0;Color 0;6;0;Create;True;0;0;0;False;0;False;0.5377358,0.0228284,0.0228284,1;0.5377356,0.0228284,0.0228284,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;32;1143.563,39.03521;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1490.418,90.02847;Float;False;True;-1;2;ASEMaterialInspector;0;4;BrightnessButton;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;6;0;4;0
WireConnection;9;0;6;0
WireConnection;7;0;6;0
WireConnection;8;0;5;0
WireConnection;11;0;8;1
WireConnection;11;1;7;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;17;0;14;0
WireConnection;17;1;15;0
WireConnection;12;0;10;0
WireConnection;12;1;11;0
WireConnection;18;0;12;0
WireConnection;18;1;17;0
WireConnection;19;0;18;0
WireConnection;21;0;19;0
WireConnection;21;1;20;0
WireConnection;22;0;21;0
WireConnection;24;0;22;0
WireConnection;24;1;23;0
WireConnection;26;0;24;0
WireConnection;27;0;26;0
WireConnection;27;1;25;0
WireConnection;32;0;29;0
WireConnection;32;1;31;0
WireConnection;32;2;27;0
WireConnection;0;0;32;0
ASEEND*/
//CHKSM=6B6E4D766A20C34C8ED8AD1FD09FDBC74CA8AA8C