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

		uniform float3 _Epicentro;
		uniform float _Frecuencia;
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
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_9_0 = sin( ( ( distance( ase_worldPos , _Epicentro ) + _Time.y ) * _Frecuencia ) );
			float3 temp_output_11_0 = ( temp_output_9_0 * _Deformacion * _Altura );
			v.vertex.xyz += temp_output_11_0;
			v.vertex.w = 1;
			v.normal = temp_output_11_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float temp_output_9_0 = sin( ( ( distance( ase_worldPos , _Epicentro ) + _Time.y ) * _Frecuencia ) );
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
142;81;711;679;782.6896;307.9162;1.815046;False;False
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1008.289,-152.0974;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;3;-972.2699,59.27289;Inherit;False;Property;_Epicentro;Epicentro;0;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;6;-634.2699,166.2729;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;4;-695.2699,-44.72711;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-407.2699,57.27289;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-411.9427,238.3304;Inherit;False;Property;_Frecuencia;Frecuencia;7;0;Create;True;0;0;0;False;0;False;5.59;3.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-204.5383,44.82421;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-33.22467,46.41583;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-60.02466,505.4158;Inherit;False;Property;_Altura;Altura;10;0;Create;True;0;0;0;False;0;False;3.72;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;108.3065,-146.2234;Inherit;False;Property;_Color1;Color 1;9;0;Create;True;0;0;0;False;0;False;1,0.1176471,0.9592439,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;101.8066,-315.2233;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;0;False;0;False;0.2971698,1,0.890738,0;0,0.1666664,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;12;-63.22467,324.4158;Inherit;False;Property;_Deformacion;Deformacion;11;0;Create;True;0;0;0;False;0;False;0,10,0;0,4,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;10;177.7753,48.41583;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;17;-1010.513,397.5701;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;14;378.7066,-141.0233;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DistanceOpNode;18;-710.2777,459.8223;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;19;-1010.043,572.7493;Inherit;False;Property;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;-2.29,5.58,1.2;-2.29,5.58,1.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;222.7753,295.4158;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;624.0452,-3.876057;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Distance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;9;0;7;0
WireConnection;10;0;9;0
WireConnection;14;0;15;0
WireConnection;14;1;16;0
WireConnection;14;2;10;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;11;0;9;0
WireConnection;11;1;12;0
WireConnection;11;2;13;0
WireConnection;0;0;14;0
WireConnection;0;11;11;0
WireConnection;0;12;11;0
ASEEND*/
//CHKSM=D2AFB11870B1AB886E58DA858D8A25CDC3777FFD