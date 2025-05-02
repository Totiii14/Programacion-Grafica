// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Vertex"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform sampler2D _Texture1;
		uniform float4 _Texture1_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float RVertex18 = v.color.r;
			v.vertex.xyz += ( RVertex18 * float3(0,1,0) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode34 = tex2D( _Texture0, uv_Texture0 );
			float GVertex24 = i.vertexColor.g;
			float4 lerpResult10 = lerp( tex2DNode34 , tex2DNode34 , GVertex24);
			float2 uv_Texture1 = i.uv_texcoord * _Texture1_ST.xy + _Texture1_ST.zw;
			float BVertex28 = i.vertexColor.b;
			float4 lerpResult40 = lerp( lerpResult10 , tex2D( _Texture1, uv_Texture1 ) , BVertex28);
			o.Albedo = lerpResult40.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
193;73;854;622;1163.344;504.1583;1.3;False;False
Node;AmplifyShaderEditor.CommentaryNode;30;-1989,-251.4716;Inherit;False;485.3726;474.0031;Variables;1;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;1;-1948.905,-57.48541;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;35;-1329.015,-39.83331;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;0;False;0;False;1c16f265fad610f4a9be41aafec2f490;1c16f265fad610f4a9be41aafec2f490;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-1728.397,-18.1714;Inherit;False;GVertex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;36;-1365.561,-266.0266;Inherit;True;Property;_Texture1;Texture 1;1;0;Create;True;0;0;0;False;0;False;a450bb1629c519140ab6a5598ef9070e;a450bb1629c519140ab6a5598ef9070e;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-1728.975,66.42623;Inherit;False;BVertex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-1016.285,-41.13315;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;1c16f265fad610f4a9be41aafec2f490;1c16f265fad610f4a9be41aafec2f490;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-1727.186,-91.52831;Inherit;False;RVertex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-690.6971,89.51965;Inherit;False;24;GVertex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;-452.1447,-343.5171;Inherit;False;28;BVertex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-990.859,-267.3264;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;19;-187.9331,290.2322;Inherit;False;18;RVertex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;10;-482.865,-42.11411;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;2;-177.0223,363.0092;Inherit;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;62.13158,298.4411;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;40;-216.256,-284.0688;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;230.4002,22.4;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Vertex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;1;2
WireConnection;28;0;1;3
WireConnection;34;0;35;0
WireConnection;18;0;1;1
WireConnection;37;0;36;0
WireConnection;10;0;34;0
WireConnection;10;1;34;0
WireConnection;10;2;26;0
WireConnection;3;0;19;0
WireConnection;3;1;2;0
WireConnection;40;0;10;0
WireConnection;40;1;37;0
WireConnection;40;2;29;0
WireConnection;0;0;40;0
WireConnection;0;11;3;0
ASEEND*/
//CHKSM=BB4021CC7C3428379CAA0A8375C6FF31E45B89F9