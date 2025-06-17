// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Distance+Object"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_WaveOrigin("WaveOrigin", Vector) = (0,0,0,0)
		_Frecuencia("Frecuencia", Float) = 5.59
		_WaveActive("WaveActive", Float) = 0
		_Color0("Color 0", Color) = (0.2971698,1,0.890738,0)
		_RangeWater("Range Water", Float) = 10
		_Deformacion("Deformacion", Vector) = (0,5,0,0)
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

		uniform float3 _WaveOrigin;
		uniform float _Frecuencia;
		uniform float _RangeWater;
		uniform float2 _Deformacion;
		uniform float _Altura;
		uniform float _WaveActive;
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
			float temp_output_4_0 = distance( ase_vertex3Pos , _WaveOrigin );
			float temp_output_13_0 = sin( ( ( ( 1.0 - temp_output_4_0 ) + _Time.y ) * _Frecuencia ) );
			float clampResult11 = clamp( ( temp_output_4_0 / _RangeWater ) , 0.0 , 1.0 );
			float2 temp_output_28_0 = ( ( ( temp_output_13_0 * ( 1.0 - clampResult11 ) ) * _Deformacion * _Altura ) * _WaveActive );
			v.vertex.xyz += float3( temp_output_28_0 ,  0.0 );
			v.vertex.w = 1;
			v.normal = float3( temp_output_28_0 ,  0.0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_4_0 = distance( ase_vertex3Pos , _WaveOrigin );
			float temp_output_13_0 = sin( ( ( ( 1.0 - temp_output_4_0 ) + _Time.y ) * _Frecuencia ) );
			float4 lerpResult20 = lerp( _Color0 , _Color1 , (0.0 + (temp_output_13_0 - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)));
			o.Albedo = ( lerpResult20 * _WaveActive ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
826;168;670;692;827.0501;187.0612;1.484171;True;False
Node;AmplifyShaderEditor.Vector3Node;23;-1960.161,49.67093;Inherit;False;Property;_WaveOrigin;WaveOrigin;6;0;Create;True;0;0;0;False;0;False;0,0,0;-2.29,5.58,1.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;3;-1960.41,212.4626;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;4;-1708.33,266.2865;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-1521.622,250.4497;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;7;-1544.983,46.4679;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1728.172,545.1654;Inherit;False;Property;_RangeWater;Range Water;9;0;Create;True;0;0;0;False;0;False;10;6.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-1533.409,444.756;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1276.607,19.05137;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1242.154,137.9367;Inherit;False;Property;_Frecuencia;Frecuencia;7;0;Create;True;0;0;0;False;0;False;5.59;3.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;11;-1333.099,431.6816;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1067.879,20.75554;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;13;-929.1158,19.84325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;14;-1132.046,418.1819;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-796.5193,-196.1207;Inherit;False;Property;_Color1;Color 1;11;0;Create;True;0;0;0;False;0;False;1,0.1176471,0.9592439,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;16;-691.8335,-15.38547;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;19;-704.1763,412.1248;Inherit;False;Property;_Deformacion;Deformacion;10;0;Create;True;0;0;0;False;0;False;0,5;0,5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-805.8619,251.5998;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-710.814,560.9152;Inherit;False;Property;_Altura;Altura;12;0;Create;True;0;0;0;False;0;False;3.72;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-803.0193,-365.1207;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;0;False;0;False;0.2971698,1,0.890738,0;0.2980391,0.371743,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;20;-526.1193,-190.9207;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-367.3099,604.1293;Inherit;False;Property;_WaveActive;WaveActive;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-353.0248,263.7869;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;24;-2452.121,441.7691;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-193.6779,455.8904;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-152.8797,-248.5779;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Distance+Object;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;4;1;23;0
WireConnection;5;0;4;0
WireConnection;10;0;4;0
WireConnection;10;1;6;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;11;0;10;0
WireConnection;12;0;8;0
WireConnection;12;1;9;0
WireConnection;13;0;12;0
WireConnection;14;0;11;0
WireConnection;16;0;13;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;20;0;1;0
WireConnection;20;1;17;0
WireConnection;20;2;16;0
WireConnection;21;0;15;0
WireConnection;21;1;19;0
WireConnection;21;2;18;0
WireConnection;28;0;21;0
WireConnection;28;1;27;0
WireConnection;29;0;20;0
WireConnection;29;1;27;0
WireConnection;0;0;29;0
WireConnection;0;11;28;0
WireConnection;0;12;28;0
ASEEND*/
//CHKSM=5DF33DC7E15BA0973E280288957B8694A36CF607