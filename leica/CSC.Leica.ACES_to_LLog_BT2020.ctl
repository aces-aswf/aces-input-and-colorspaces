// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.Leica.ACES_to_LLog_BT2020.a2.v1</ACEStransformID>
// <ACESuserName>ACES2065-1 to Leica L-Log Rec.2020</ACESuserName>

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

// ACES -to- ITU-R BT.2020 conversion matrix
const float ACES_2_REC2020_MAT[3][3] = calculate_rgb_to_rgb_matrix(AP0, REC2020_PRI);

const float a = 8;
const float b = 0.09;
const float c = 0.27;
const float d = 1.3;
const float e = 0.0115;
const float f = 0.6;

float linear_to_LLog(float lin)
{
    float LLog = a * lin + b;
    if (lin > 0.006)
        LLog = c * log10(d * lin + e) + f;

    return LLog;
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
    float aces[3] = {rIn, gIn, bIn};

    float lin_2020[3] = mult_f3_f33(aces, ACES_2_REC2020_MAT);

    float LLog[3];
    LLog[0] = linear_to_LLog(lin_2020[0]);
    LLog[1] = linear_to_LLog(lin_2020[1]);
    LLog[2] = linear_to_LLog(lin_2020[2]);

    rOut = LLog[0];
    gOut = LLog[1];
    bOut = LLog[2];
    aOut = aIn;
}