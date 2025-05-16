// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Distance"
{
	Properties
	{
		_Epicentro("Epicentro", Vector) = (-2.29,5.58,1.2,0)
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_Frecuencia("Frecuencia", Float) = 5.59
		_Color0("Color 0", Color) = (0.2971698,1,0.890738,0)
		_Color1("Color 1", Color) = (1,0.1176471,0.9592439,0)
		_Altura("Altura", Float) = 3.72
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
		};

		uniform float3 _Epicentro;
		uniform float _Frecuencia;
		uniform float _Altura;
		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_7_0 = ( ( distance( ase_worldPos , _Epicentro ) + _Time.y ) * _Frecuencia );
			float temp_output_10_0 = (0.0 + (sin( temp_output_7_0 ) - 0.0) * (1.0 - 0.0) / (1.0 - 0.0));
			float2 appendResult27 = (float2(0.0 , ( temp_output_10_0 * _Altura * _Altura )));
			float3 appendResult32 = (float3(appendResult27 , 0.0));
			v.vertex.xyz += ( ase_vertex3Pos + appendResult32 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float temp_output_7_0 = ( ( distance( ase_worldPos , _Epicentro ) + _Time.y ) * _Frecuencia );
			float temp_output_10_0 = (0.0 + (sin( temp_output_7_0 ) - 0.0) * (1.0 - 0.0) / (1.0 - 0.0));
			float4 lerpResult14 = lerp( _Color0 , _Color1 , temp_output_10_0);
			o.Albedo = lerpResult14.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
235;81;761;679;-326.2125;217.3082;1.309739;False;False
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-826.4127,-127.9336;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;3;-830.3934,53.03659;Inherit;False;Property;_Epicentro;Epicentro;0;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;6;-608.8048,143.5313;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;4;-595.4886,-43.16804;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-431.5422,201.6302;Inherit;False;Property;_Frecuencia;Frecuencia;6;0;Create;True;0;0;0;False;0;False;5.59;1.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-407.2699,57.27289;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-226.3383,73.92422;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-29.52984,49.51582;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;182.7889,220.7375;Inherit;False;Property;_Altura;Altura;10;0;Create;True;0;0;0;False;0;False;3.72;0.53;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;10;169.7853,48.72828;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;386.3802,99.99962;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;414.1783,253.3995;Inherit;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;594.8766,434.0998;Inherit;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;598.7973,258.5898;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;15;101.8066,-315.2233;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;0;False;0;False;0.2971698,1,0.890738,0;0.297169,1,0.890738,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;108.3065,-146.2234;Inherit;False;Property;_Color1;Color 1;9;0;Create;True;0;0;0;False;0;False;1,0.1176471,0.9592439,0;1,0.1176463,0.9592438,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;32;852.4329,258.5713;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;21;790.3019,4.496637;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;34;1027.051,60.87309;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;18;-1067.311,465.4821;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;17;-1552.046,380.4295;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;19;-1402.576,538.5093;Inherit;False;Property;_Vector0;Vector 0;7;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;-2.29,5.58,1.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;14;456.1043,-147.4731;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1203.845,-148.1762;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Distance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;9;0;7;0
WireConnection;10;0;9;0
WireConnection;26;0;10;0
WireConnection;26;1;13;0
WireConnection;26;2;13;0
WireConnection;27;0;28;0
WireConnection;27;1;26;0
WireConnection;32;0;27;0
WireConnection;32;2;33;0
WireConnection;34;0;21;0
WireConnection;34;1;32;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;14;0;15;0
WireConnection;14;1;16;0
WireConnection;14;2;10;0
WireConnection;0;0;14;0
WireConnection;0;11;34;0
ASEEND*/
//CHKSM=E20759DC75AC8B5D2CB5D1C83D11073DB98E3836