// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.vivo.vivoLog_to_ACES.a2.v1</ACEStransformID>
// <ACESuserName>vivo Log to ACES2065-1</ACESuserName>

//
// ACES Color Space Conversion - vivo Log to ACES2065-1
//
// converts vivo Log to
//          ACES2065-1 (AP0 w/ linear encoding)
//

import "Lib.Academy.Utilities";
import "Lib.Academy.ColorSpaces";

const Chromaticities AP0 = // ACES Primaries from SMPTE ST2065-1
    {
        {0.73470, 0.26530},
        {0.00000, 1.00000},
        {0.00010, -0.07700},
        {0.32168, 0.33767}};

const Chromaticities VIVO_WIDE_GAMUT_PRI =
    {
        {0.7063, 0.2957},
        {0.1913, 0.9623},
        {0.1115, -0.0492},
        {0.3127, 0.3290}};

const float VIVO_WG_to_AP0_MAT[3][3] = calculate_rgb_to_rgb_matrix(VIVO_WIDE_GAMUT_PRI,
                                                                AP0,
                                                                CONE_RESP_MAT_CAT02);

float vivoLog_to_linear(float x) {
    if (x > 0.128231 ) {
		return (pow(10, (x - 0.382516) / 0.265817) - 0.076581) / 5.558556;
	} else {
		return (x - 0.092813) / 5.775961;
	}
}

void main(input varying float rIn,
          input varying float gIn,
          input varying float bIn,
          input varying float aIn,
          output varying float rOut,
          output varying float gOut,
          output varying float bOut,
          output varying float aOut)
{
    float lin_vivoWG[3];
    lin_vivoWG[0] = vivoLog_to_linear(rIn);
    lin_vivoWG[1] = vivoLog_to_linear(gIn);
    lin_vivoWG[2] = vivoLog_to_linear(bIn);

    float ACES[3] = mult_f3_f33(lin_vivoWG, VIVO_WG_to_AP0_MAT);

    rOut = ACES[0];
    gOut = ACES[1];
    bOut = ACES[2];
    aOut = aIn;
}