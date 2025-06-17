// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VignetteNoise"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_VignetteControl("VignetteControl", Range( 0 , 1.5)) = 1.5
		_NoiseTex("_NoiseTex", 2D) = "white" {}
		_SpeedVignette("SpeedVignette", Float) = 0
		_Edge1Min("Edge1Min", Float) = 0
		_SpeedNoise("SpeedNoise", Float) = 0
		_Limit2("Limit2", Float) = 0
		_Limit1("Limit1", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform sampler2D _NoiseTex;
			uniform float _SpeedNoise;
			uniform float _Edge1Min;
			uniform float _SpeedVignette;
			uniform float _Limit1;
			uniform float _Limit2;
			uniform float _VignetteControl;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord41 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float4 temp_output_40_0 = ( tex2D( _MainTex, uv_MainTex ) * tex2D( _NoiseTex, ( texCoord41 + ( _Time.y * _SpeedNoise ) ) ) );
				float2 texCoord21 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float smoothstepResult14 = smoothstep( _Edge1Min , ( (_Limit1 + (sin( ( _Time.y * _SpeedVignette ) ) - 0.0) * (_Limit2 - _Limit1) / (1.0 - 0.0)) * _VignetteControl ) , length( ( texCoord21 - float2( 0.5,0.5 ) ) ));
				

				finalColor = ( temp_output_40_0 * ( 1.0 - smoothstepResult14 ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
704;138;813;692;1370.056;-45.61274;1.817287;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;8;-1373.022,640.1926;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1363.104,823.0465;Inherit;False;Property;_SpeedVignette;SpeedVignette;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1166.225,761.522;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-987.2897,893.7066;Inherit;False;Property;_Limit1;Limit1;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-971.5486,763.923;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1602.767,319.0348;Inherit;False;Property;_SpeedNoise;SpeedNoise;5;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-983.9366,988.7009;Inherit;False;Property;_Limit2;Limit2;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;23;-653.8663,1148.988;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-700.686,995.1248;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;30;-1605.942,228.582;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-403.868,992.9872;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1428.477,263.741;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-1392.336,77.88551;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-907.2415,256.2508;Inherit;False;Property;_VignetteControl;VignetteControl;0;0;Create;True;0;0;0;False;0;False;1.5;1.5;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;12;-790.842,760.0231;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;3;-888.3682,-308.0582;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-1140.508,181.7739;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;25;-222.7978,993.9919;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-646.5411,441.524;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-367.5622,335.5477;Inherit;False;Property;_Edge1Min;Edge1Min;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-719.213,-269.3633;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;14;-40.34504,240.8042;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-914.1638,4.982593;Inherit;True;Property;_NoiseTex;_NoiseTex;1;0;Create;True;0;0;0;False;0;False;-1;12c89afe141ffb44db0961b50bfb0d10;12c89afe141ffb44db0961b50bfb0d10;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-351.687,-71.20962;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2709.188,-904.645;Inherit;False;1035.007;451.5089;Este no se usa porque necesita UV independientes. ;6;35;27;28;32;34;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;26;178.3347,282.871;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;27;-2659.188,-853.4622;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;194.0087,58.21954;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-1826.771,-589.0457;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;28;-2369.054,-853.6454;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;32;-2167.65,-854.645;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-2013.926,-587.535;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2322.754,-568.2961;Inherit;False;Property;_NoiseScale;NoiseScale;3;0;Create;True;0;0;0;False;0;False;0.8229017;0.39;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;649.0961,59.50828;Float;False;True;-1;2;ASEMaterialInspector;0;2;VignetteNoise;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;11;0;9;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;33;0;30;0
WireConnection;33;1;29;0
WireConnection;12;0;11;0
WireConnection;12;3;17;0
WireConnection;12;4;18;0
WireConnection;43;0;41;0
WireConnection;43;1;33;0
WireConnection;25;0;22;0
WireConnection;13;0;12;0
WireConnection;13;1;4;0
WireConnection;5;0;3;0
WireConnection;14;0;25;0
WireConnection;14;1;15;0
WireConnection;14;2;13;0
WireConnection;37;1;43;0
WireConnection;40;0;5;0
WireConnection;40;1;37;0
WireConnection;26;0;14;0
WireConnection;7;0;40;0
WireConnection;7;1;26;0
WireConnection;35;0;34;0
WireConnection;28;0;27;0
WireConnection;32;0;28;0
WireConnection;32;1;27;4
WireConnection;34;0;32;0
WireConnection;34;1;31;0
WireConnection;1;0;7;0
ASEEND*/
//CHKSM=F2F3023E7E653855D8B56549FFB886EDE55CA581