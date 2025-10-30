// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.Leica.LLog_BT2020_to_ACES.a2.v1</ACEStransformID>
// <ACESuserName>Leica L-Log Rec.2020 to ACES2065-1</ACESuserName>

import "Lib.Academy.Utilities";
import "Lib.Academy.ColorSpaces";

const Chromaticities AP0 = // ACES Primaries from SMPTE ST2065-1
    {
        {0.73470, 0.26530},
        {0.00000, 1.00000},
        {0.00010, -0.07700},
        {0.32168, 0.33767}};

const Chromaticities REC2020_PRI =
    {
        {0.70800, 0.29200},
        {0.17000, 0.79700},
        {0.13100, 0.04600},
        {0.31270, 0.32900}};

// ITU-R BT.2020 -to- ACES conversion matrix
const float REC2020_2_ACES_MAT[3][3] = calculate_rgb_to_rgb_matrix(REC2020_PRI, AP0);

const float a = 8;
const float b = 0.09;
const float c = 0.27;
const float d = 1.3;
const float e = 0.0115;
const float f = 0.6;

float LLog_to_linear(float LLog)
{
    float linear = (LLog - b) / a;
    if (LLog > 0.1380)
        linear = (pow(10., (LLog - f) / c) - e) / d;

    return linear;
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
    float lin_2020[3];
    lin_2020[0] = LLog_to_linear(rIn);
    lin_2020[1] = LLog_to_linear(gIn);
    lin_2020[2] = LLog_to_linear(bIn);

    float ACES[3] = mult_f3_f33(lin_2020, REC2020_2_ACES_MAT);

    rOut = ACES[0];
    gOut = ACES[1];
    bOut = ACES[2];
    aOut = aIn;
}