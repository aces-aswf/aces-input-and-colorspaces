// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.DJI.ACES_to_DLog2_DGamut2.a2.v1</ACEStransformID>
// <ACESuserName>ACES2065-1 to DJI D-Log2 D-Gamut2</ACESuserName>

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

// AP0 to D-Gamut2 matrix
const float AP0_TO_DGAMUT2_MAT[3][3] = calculate_rgb_to_rgb_matrix(AP0,
                                                                   DJI_DGAMUT2_PRI,
                                                                   CONE_RESP_MAT_CAT02);

float lin_to_DLog2(float lin)
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
    const float lin_limit_1 = high_scale * (pow(2.0, a * b1) - 1.0);
    const float lin_limit_2 = in_limit2; 

    if (lin >= lin_limit_1) {
        // Inverse of high range exponential curve
        return log2(lin / high_scale + 1.0) / a;
    }
    else if (lin >= lin_limit_2) {
        // Inverse of mid range exponential curve
        return k1 * log2(lin / in_limit1) + b1;
    }
    else {
        // Inverse of low range linear segment
        return k2 * (lin - in_limit2) + b2;
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
    float ACES[3] = {rIn, gIn, bIn};

    float lin_DGamut2[3] = mult_f3_f33(ACES, AP0_TO_DGAMUT2_MAT);

    float DLog2_DGamut2[3];
    DLog2_DGamut2[0] = lin_to_DLog2(lin_DGamut2[0]);
    DLog2_DGamut2[1] = lin_to_DLog2(lin_DGamut2[1]);
    DLog2_DGamut2[2] = lin_to_DLog2(lin_DGamut2[2]);

    rOut = DLog2_DGamut2[0];
    gOut = DLog2_DGamut2[1];
    bOut = DLog2_DGamut2[2];
    aOut = aIn;
}