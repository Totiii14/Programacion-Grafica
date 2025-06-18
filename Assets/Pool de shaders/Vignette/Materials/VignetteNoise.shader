// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VignetteNoise"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_NoiseTex("_NoiseTex", 2D) = "white" {}
		_SpeedVignette("SpeedVignette", Float) = 0
		_Edge1Min("Edge1Min", Float) = 0.5
		_SpeedNoise("SpeedNoise", Float) = 0
		_Limit2("Limit2", Float) = 0
		_Limit1("Limit1", Float) = 0
		_NoiseScale2("NoiseScale2", Float) = 0
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
			uniform float _NoiseScale2;
			uniform float _SpeedNoise;
			uniform float _Edge1Min;
			uniform float _SpeedVignette;
			uniform float _Limit1;
			uniform float _Limit2;


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
				float2 texCoord21 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float smoothstepResult14 = smoothstep( _Edge1Min , (_Limit1 + (sin( ( _Time.y * _SpeedVignette ) ) - 0.0) * (_Limit2 - _Limit1) / (1.0 - 0.0)) , length( ( texCoord21 - float2( 0.5,0.5 ) ) ));
				

				finalColor = ( ( tex2D( _MainTex, uv_MainTex ) * tex2D( _NoiseTex, ( ( texCoord41 * _NoiseScale2 ) + ( _Time.y * _SpeedNoise ) ) ) ) * ( 1.0 - smoothstepResult14 ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
177;81;657;720;1753.822;1006.685;3.59792;False;False
Node;AmplifyShaderEditor.CommentaryNode;48;-1284.728,687.9521;Inherit;False;1486.054;672.6508;Vignette;14;10;8;9;11;17;18;14;26;12;22;25;21;23;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;45;-1281.738,-92.2713;Inherit;False;1090.237;431.0936;Mueve las UV de la textura del ruido. Ahora usa Texture Coordinates;7;37;43;33;29;30;50;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;8;-987.6968,1093.834;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-999.9855,1161.076;Inherit;False;Property;_SpeedVignette;SpeedVignette;1;0;Create;True;0;0;0;False;0;False;0;2.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;30;-1231.738,106.8896;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;23;-980.8832,928.2886;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-990.1011,796.2609;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1228.563,197.3422;Inherit;False;Property;_SpeedNoise;SpeedNoise;4;0;Create;True;0;0;0;False;0;False;0;4.71;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1279.527,26.30573;Inherit;False;Property;_NoiseScale2;NoiseScale2;7;0;Create;True;0;0;0;False;0;False;0;7.58;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-1373.152,-236.4952;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-821.2246,1114.928;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-691.2275,1115.615;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1054.273,142.0486;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-1038.61,-39.39675;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-734.4792,818.9898;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-691.1104,1273.07;Inherit;False;Property;_Limit2;Limit2;5;0;Create;True;0;0;0;False;0;False;0;1.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-690.6185,1198.161;Inherit;False;Property;_Limit1;Limit1;6;0;Create;True;0;0;0;False;0;False;0;1.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;12;-528.5002,1115.918;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-896.8398,61.61709;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;3;-861.7496,-305.623;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LengthOpNode;25;-581.7503,797.6946;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-592.4881,885.9135;Inherit;False;Property;_Edge1Min;Edge1Min;3;0;Create;True;0;0;0;False;0;False;0.5;0.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-778.981,-19.91668;Inherit;True;Property;_NoiseTex;_NoiseTex;0;0;Create;True;0;0;0;False;0;False;-1;12c89afe141ffb44db0961b50bfb0d10;12c89afe141ffb44db0961b50bfb0d10;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-689.3503,-310.7232;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;14;-361.3347,797.9626;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;26;-42.27273,800.2309;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2709.188,-904.645;Inherit;False;1035.007;451.5089;Este no se usa porque necesita UV independientes. ;6;35;27;28;32;34;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-170.0819,-33.30464;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;219.4547,-27.90509;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;32;-2167.65,-854.645;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-2013.926,-587.535;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2322.754,-568.2961;Inherit;False;Property;_NoiseScale;NoiseScale;2;0;Create;True;0;0;0;False;0;False;0.8229017;0.39;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-1826.771,-589.0457;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;28;-2369.054,-853.6454;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;27;-2659.188,-853.4622;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;469.0166,-28.57373;Float;False;True;-1;2;ASEMaterialInspector;0;2;VignetteNoise;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;11;0;9;0
WireConnection;33;0;30;0
WireConnection;33;1;29;0
WireConnection;49;0;41;0
WireConnection;49;1;50;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;12;0;11;0
WireConnection;12;3;17;0
WireConnection;12;4;18;0
WireConnection;43;0;49;0
WireConnection;43;1;33;0
WireConnection;25;0;22;0
WireConnection;37;1;43;0
WireConnection;5;0;3;0
WireConnection;14;0;25;0
WireConnection;14;1;15;0
WireConnection;14;2;12;0
WireConnection;26;0;14;0
WireConnection;40;0;5;0
WireConnection;40;1;37;0
WireConnection;7;0;40;0
WireConnection;7;1;26;0
WireConnection;32;0;28;0
WireConnection;32;1;27;4
WireConnection;34;0;32;0
WireConnection;34;1;31;0
WireConnection;35;0;34;0
WireConnection;28;0;27;0
WireConnection;1;0;7;0
ASEEND*/
//CHKSM=FE8E47DF4741A86D891C2B98A53E4B721EDAF1FB