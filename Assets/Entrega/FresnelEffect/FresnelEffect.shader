// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FresnelEffect"
{
	Properties
	{
		_ASEOutlineWidth( "Outline Width", Float ) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_XRayPower("XRayPower", Float) = 0
		_XRayColor("XRayColor", Color) = (0,0,0,0)
		_XRayScale("XRayScale", Float) = 0
		_Speed2("Speed2", Float) = 3
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Pass
		{
			ColorMask 0
			ZWrite On
		}

		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0"}
		ZWrite Off
		ZTest Always
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog alpha:fade  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		#include "UnityShaderVariables.cginc"
		
		
		
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};
		uniform float _XRayScale;
		uniform float _XRayPower;
		uniform float4 _XRayColor;
		uniform float _Speed2;
		float _ASEOutlineWidth;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = 0.0;
			v.vertex.xyz += ( v.normal * _ASEOutlineWidth );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV5 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode5 = ( 0.0 + _XRayScale * pow( 1.0 - fresnelNdotV5, _XRayPower ) );
			o.Emission = ( fresnelNode5 * _XRayColor ).rgb;
			o.Alpha = ( fresnelNode5 * _XRayColor.a * abs( sin( ( _Time.y * _Speed2 ) ) ) );
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+1" }
		Cull Back
		ZWrite On
		ZTest LEqual
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			o.Albedo = tex2D( _TextureSample0, uv_TextureSample0 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
194;73;853;622;1544.941;-13.10708;1.3;False;False
Node;AmplifyShaderEditor.SimpleTimeNode;16;-1461.066,349.5092;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1459.113,434.3031;Inherit;False;Property;_Speed2;Speed2;4;0;Create;False;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1280.061,376.8879;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;-1128.068,375.8154;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-1184.106,64.88152;Float;False;Property;_XRayPower;XRayPower;1;0;Create;False;0;0;0;False;0;False;0;0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1175.951,-45.08295;Float;False;Property;_XRayScale;XRayScale;3;0;Create;False;0;0;0;False;0;False;0;3.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;5;-917.4002,-67.64684;Inherit;False;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-915.101,170.9123;Float;False;Property;_XRayColor;XRayColor;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.01999613,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;22;-913.1411,405.7073;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-628.0062,244.4413;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-629.5129,151.8982;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;11;-393.7202,148.1565;Inherit;False;0;True;Transparent;2;7;Back;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;10;-467.2516,-126.8566;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;a450bb1629c519140ab6a5598ef9070e;a450bb1629c519140ab6a5598ef9070e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-75.58598,-123.4321;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;FresnelEffect;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;True;0;Opaque;0.5;True;True;1;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;True;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;16;0
WireConnection;15;1;14;0
WireConnection;17;0;15;0
WireConnection;5;2;2;0
WireConnection;5;3;1;0
WireConnection;22;0;17;0
WireConnection;8;0;5;0
WireConnection;8;1;4;4
WireConnection;8;2;22;0
WireConnection;9;0;5;0
WireConnection;9;1;4;0
WireConnection;11;0;9;0
WireConnection;11;2;8;0
WireConnection;0;0;10;0
WireConnection;0;11;11;0
ASEEND*/
//CHKSM=C5FEDC282AD93772B80D1F442507BFD4DB085B5F