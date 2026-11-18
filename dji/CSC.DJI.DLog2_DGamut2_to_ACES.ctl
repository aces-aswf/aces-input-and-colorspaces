// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.
 
// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.DJI.DLog2_DGamut2_to_ACES.a2.v1</ACEStransformID>
// <ACESuserName>DJI D-Log2 D-Gamut2 to ACES2065-1</ACESuserName>

//
// ACES Color Space Conversion - DJI D-Log2 D-Gamut2
//
// converts DJI D-Log2 D-Gamut2 to
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

const Chromaticities DJI_DGAMUT2_PRI =
    {
        {0.7347, 0.2653},
        {0.1600, 0.8400},
        {0.0900, -0.0800},
        {0.3127, 0.3290}};

// D-Gamut2 to AP0 matrix
const float DGAMUT2_TO_AP0_MAT[3][3] = calculate_rgb_to_rgb_matrix(DJI_DGAMUT2_PRI,
                                                                   AP0,
                                                                   CONE_RESP_MAT_CAT02);

float DLog2_to_lin(float x) 
{
    const float H = 475.0;
    const float a = 16.285770761945304;
    const float k1 = 0.059439938321493;
    const float b1 = 0.304985337243402;
    const float k2 = 2.960935245492250;
    const float b2 = 0.148314799066323;
    const float in_limit1 = 0.18;
    const float in_limit2 = 0.028961695254132;
    
    const float high_scale = H / (pow(2.0, a) - 1.0);

    if (x >= b1) {
        // High range exponential curve
        return high_scale * (pow(2.0, a * x) - 1.0);
    } 
    else if (x >= b2) { 
        // Mid range exponential curve
        return in_limit1 * pow(2.0, (x - b1) / k1);
    } 
    else {
        // Low range linear segment
        return (x - b2) / k2 + in_limit2;
    }
}

void main(
    input varying float rIn,
    input varying float gIn,
    input varying float bIn,
    input varying float aIn,
    output varying float rOut,
    output varying float gOut,
    output varying float bOut,
    output varying float aOut)
{
    float lin_DGamut2[3];
    lin_DGamut2[0] = DLog2_to_lin(rIn);
    lin_DGamut2[1] = DLog2_to_lin(gIn);
    lin_DGamut2[2] = DLog2_to_lin(bIn);

    float ACES[3] = mult_f3_f33(lin_DGamut2, DGAMUT2_TO_AP0_MAT);

    rOut = ACES[0];
    gOut = ACES[1];
    bOut = ACES[2];
    aOut = aIn;
}