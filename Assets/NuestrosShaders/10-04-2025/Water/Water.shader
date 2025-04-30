// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Water"
{
	Properties
	{
		_FlowMap("FlowMap", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture0;
		uniform sampler2D _FlowMap;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color25 = IsGammaSpace() ? float4(0.9615521,0.9716981,0.1054201,0) : float4(0.914756,0.9368213,0.01088466,0);
			float2 temp_cast_0 = (1.0).xx;
			float2 uv_TexCoord10 = i.uv_texcoord * temp_cast_0;
			float4 tex2DNode6 = tex2D( _FlowMap, uv_TexCoord10 );
			float4 appendResult8 = (float4(tex2DNode6.r , tex2DNode6.g , 0.0 , 0.0));
			float4 lerpResult12 = lerp( float4( uv_TexCoord10, 0.0 , 0.0 ) , ( appendResult8 + float4( uv_TexCoord10, 0.0 , 0.0 ) ) , 0.2);
			float2 panner14 = ( 1.0 * _Time.y * ( float2( 1,1 ) * 0.2 ) + lerpResult12.xy);
			o.Albedo = ( color25 * tex2D( _Texture0, panner14 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
307;81;790;611;947.2824;6.328308;1.7684;False;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-2046.036,653.0397;Inherit;False;Constant;_TextureTilling;Texture Tilling;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1831.139,634.2501;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;24;-1570.102,237.7836;Inherit;False;367.7002;280;ROJO VERDE;1;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;6;-1520.102,287.7836;Inherit;True;Property;_FlowMap;FlowMap;0;0;Create;True;0;0;0;False;0;False;-1;b9f1c2125557bf34c98df0614dff4483;b9f1c2125557bf34c98df0614dff4483;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;23;-1394.432,1021.893;Inherit;False;488.54;289.6805;Movement;3;20;18;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1165.102,362.7836;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;20;-1344.432,1071.893;Inherit;False;Constant;_PanDir;PanDir;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;18;-1345.871,1214.603;Inherit;False;Constant;_PanSpeed;PanSpeed;2;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1029.925,892.2353;Inherit;False;Constant;_DistortionWeight;DistortionWeight;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-997.3278,472.9667;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;12;-851.3278,638.9666;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1084.8,1133.451;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;14;-701.6646,807.0947;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;16;-653.833,528.4391;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;0;False;0;False;9fbef4b79ca3b784ba023cb1331520d5;9fbef4b79ca3b784ba023cb1331520d5;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;25;-326.574,326.1308;Inherit;False;Constant;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;0.9615521,0.9716981,0.1054201,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;22;-1683.685,-669.1511;Inherit;False;761.9854;402.9744;Agua Voronoi;4;3;1;2;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;17;-393.6947,675.3854;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-1446.225,-619.1511;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0.0236294,0.2309226,0.5566038,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-1074.289,-415.639;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VoronoiNode;2;-1412.541,-422.6568;Inherit;False;1;0;1;0;2;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;10;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1633.685,-391.0954;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;7;-1176.102,257.7836;Inherit;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-94.91354,409.2458;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;23.0917,503.9903;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;0
WireConnection;6;1;10;0
WireConnection;8;0;6;1
WireConnection;8;1;6;2
WireConnection;11;0;8;0
WireConnection;11;1;10;0
WireConnection;12;0;10;0
WireConnection;12;1;11;0
WireConnection;12;2;13;0
WireConnection;21;0;20;0
WireConnection;21;1;18;0
WireConnection;14;0;12;0
WireConnection;14;2;21;0
WireConnection;17;0;16;0
WireConnection;17;1;14;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;2;1;3;0
WireConnection;7;0;6;0
WireConnection;26;0;25;0
WireConnection;26;1;17;0
WireConnection;0;0;26;0
ASEEND*/
//CHKSM=CF4867FC8EAC32DC8A0C3A6D3BFBD17D33E92B93