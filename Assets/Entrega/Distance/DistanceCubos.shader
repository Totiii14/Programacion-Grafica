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
			half filler;
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
			float4 transform49 = mul(unity_WorldToObject,float4( 0,0,0,1 ));
			float temp_output_9_0 = sin( ( ( distance( transform49 , float4( _Epicentro , 0.0 ) ) + _Time.y ) * _Frecuencia ) );
			float3 temp_output_26_0 = ( temp_output_9_0 * _Altura * float3(0,10,0) );
			v.vertex.xyz += temp_output_26_0;
			v.vertex.w = 1;
			v.normal = temp_output_26_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 transform49 = mul(unity_WorldToObject,float4( 0,0,0,1 ));
			float temp_output_9_0 = sin( ( ( distance( transform49 , float4( _Epicentro , 0.0 ) ) + _Time.y ) * _Frecuencia ) );
			float4 lerpResult14 = lerp( _Color0 , _Color1 , (0.0 + (temp_output_9_0 - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)));
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
1015;73;502;726;2527.151;948.7178;2.725594;False;False
Node;AmplifyShaderEditor.Vector3Node;3;-1090.605,4.254694;Inherit;False;Property;_Epicentro;Epicentro;0;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldToObjectTransfNode;49;-1093.194,-173.7759;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;6;-849.0029,20.89898;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;4;-832.2317,-119.7533;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-618.2333,-89.84187;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-576.4652,35.4841;Inherit;False;Property;_Frecuencia;Frecuencia;6;0;Create;True;0;0;0;False;0;False;5.59;1.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-407.141,-71.19621;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-272.9491,-70.48279;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;10;140.9217,20.76212;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;108.3065,-146.2234;Inherit;False;Property;_Color1;Color 1;9;0;Create;True;0;0;0;False;0;False;1,0.1176471,0.9592439,0;1,0.1176461,0.9592438,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;101.8066,-315.2233;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;0;False;0;False;0.2971698,1,0.890738,0;0.2971689,1,0.890738,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-91.20405,247.5951;Inherit;False;Property;_Altura;Altura;10;0;Create;True;0;0;0;False;0;False;3.72;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;35;-91.99015,328.9084;Inherit;False;Constant;_Deformacion;Deformacion;7;0;Create;True;0;0;0;False;0;False;0,10,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;185.283,215.8928;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;19;-1402.576,538.5093;Inherit;False;Property;_Vector0;Vector 0;7;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;-2.29,5.58,1.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;14;456.1043,-147.4731;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DistanceOpNode;18;-1067.311,465.4821;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;17;-1552.046,380.4295;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;656.2169,-107.3592;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Distance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;49;0
WireConnection;4;1;3;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;9;0;7;0
WireConnection;10;0;9;0
WireConnection;26;0;9;0
WireConnection;26;1;13;0
WireConnection;26;2;35;0
WireConnection;14;0;15;0
WireConnection;14;1;16;0
WireConnection;14;2;10;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;0;0;14;0
WireConnection;0;11;26;0
WireConnection;0;12;26;0
ASEEND*/
//CHKSM=CA1D32358153FCC8DFF412F4BEF72B4C0DFAA793