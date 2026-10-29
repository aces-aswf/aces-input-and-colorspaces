// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.vivo.ACES_to_vivoLog_vivoWG.a2.v1</ACEStransformID>
// <ACESuserName>ACES2065-1 to vivo Log</ACESuserName>

//
// ACES Color Space Conversion - ACES2065-1 to vivo Log / vivo Wide Gamut
//
// converts ACES2065-1 (AP0 w/ linear encoding) to 
//          vivo Log / vivo Wide Gamut
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

const float AP0_to_VIVO_WG_MAT[3][3] = calculate_rgb_to_rgb_matrix(AP0,
                                                                   VIVO_WIDE_GAMUT_PRI,
                                                                   CONE_RESP_MAT_CAT02);

float linear_to_vivoLog(float y) {
    if (y > 0.006132) {
        return 0.265817 * log10(5.558556 * y + 0.076581) + 0.382516;
    } else {
        return y * 5.775961 + 0.092813;
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
    float ACES[3] = {rIn, gIn, bIn};
    
    float lin_vivoWG[3] = mult_f3_f33( ACES, AP0_to_VIVO_WG_MAT);

    float vivoWG[3];
    vivoWG[0] = linear_to_vivoLog(lin_vivoWG[0]);
    vivoWG[1] = linear_to_vivoLog(lin_vivoWG[1]);
    vivoWG[2] = linear_to_vivoLog(lin_vivoWG[2]);

    rOut = vivoWG[0];
    gOut = vivoWG[1];
    bOut = vivoWG[2];
    aOut = aIn;
}
