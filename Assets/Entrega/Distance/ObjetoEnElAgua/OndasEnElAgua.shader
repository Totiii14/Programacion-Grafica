// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OndasEnElAgua"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Vector0("Vector 0", Vector) = (-2.29,5.58,1.2,0)
		_Frecuencia("Frecuencia", Float) = 5.59
		_Color0("Color 0", Color) = (0.2971698,1,0.890738,0)
		_Float0("Float 0", Float) = 10
		_Color1("Color 1", Color) = (1,0.1176471,0.9592439,0)
		_Altura("Altura", Float) = 3.72
		_Deformacion("Deformacion", Vector) = (0,10,0,0)
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

		uniform float3 _Vector0;
		uniform float _Frecuencia;
		uniform float _Float0;
		uniform float3 _Deformacion;
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
			float temp_output_14_0 = distance( ase_vertex3Pos , _Vector0 );
			float temp_output_8_0 = sin( ( ( ( 1.0 - temp_output_14_0 ) + _Time.y ) * _Frecuencia ) );
			float clampResult26 = clamp( ( temp_output_14_0 / _Float0 ) , 0.0 , 1.0 );
			float3 temp_output_16_0 = ( ( temp_output_8_0 * ( 1.0 - clampResult26 ) ) * _Deformacion * _Altura );
			v.vertex.xyz += temp_output_16_0;
			v.vertex.w = 1;
			v.normal = temp_output_16_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_14_0 = distance( ase_vertex3Pos , _Vector0 );
			float temp_output_8_0 = sin( ( ( ( 1.0 - temp_output_14_0 ) + _Time.y ) * _Frecuencia ) );
			float4 lerpResult18 = lerp( _Color0 , _Color1 , (0.0 + (temp_output_8_0 - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)));
			o.Albedo = lerpResult18.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
118;81;601;679;1074.935;205.3145;1.9;False;False
Node;AmplifyShaderEditor.Vector3Node;15;-1771.054,452.5067;Inherit;False;Property;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;-2.29,5.58,1.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;17;-1771.524,277.3281;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;14;-1519.444,331.1521;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1506.495,95.61054;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1513.241,636.0759;Inherit;False;Property;_Float0;Float 0;9;0;Create;True;0;0;0;False;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;19;-1332.736,330.394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;22;-1339.04,516.4755;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-1087.721,83.91693;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1053.268,202.8022;Inherit;False;Property;_Frecuencia;Frecuencia;7;0;Create;True;0;0;0;False;0;False;5.59;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;26;-1177.111,515.7382;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-878.993,85.62109;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;8;-740.23,84.70881;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;-934.935,514.5756;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-614.1334,-300.2551;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;0;False;0;False;0.2971698,1,0.890738,0;0.2971698,1,0.890738,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;13;-535.9673,459.3843;Inherit;False;Property;_Deformacion;Deformacion;12;0;Create;True;0;0;0;False;0;False;0,10,0;0,4,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;11;-521.9281,625.7807;Inherit;False;Property;_Altura;Altura;11;0;Create;True;0;0;0;False;0;False;3.72;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-607.6335,-131.2552;Inherit;False;Property;_Color1;Color 1;10;0;Create;True;0;0;0;False;0;False;1,0.1176471,0.9592439,0;1,0.1176471,0.9592437,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-616.9761,316.4654;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;10;-502.9476,49.48009;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-337.2334,-126.0552;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-262.7638,316.784;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1724.23,-137.1292;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;2;-1750.677,4.677545;Inherit;False;Property;_Epicentro;Epicentro;5;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;4;-1523.366,-59.57188;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;OndasEnElAgua;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;17;0
WireConnection;14;1;15;0
WireConnection;19;0;14;0
WireConnection;22;0;14;0
WireConnection;22;1;23;0
WireConnection;5;0;19;0
WireConnection;5;1;3;0
WireConnection;26;0;22;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;8;0;7;0
WireConnection;24;0;26;0
WireConnection;25;0;8;0
WireConnection;25;1;24;0
WireConnection;10;0;8;0
WireConnection;18;0;12;0
WireConnection;18;1;9;0
WireConnection;18;2;10;0
WireConnection;16;0;25;0
WireConnection;16;1;13;0
WireConnection;16;2;11;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;0;0;18;0
WireConnection;0;11;16;0
WireConnection;0;12;16;0
ASEEND*/
//CHKSM=FE598FCBEFFA4242E7E9AAB66B97CF447CBF153B