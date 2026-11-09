// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.Huawei.HLog_to_ACES.a2.v1</ACEStransformID>
// <ACESuserName>Huawei H-Log to ACES2065-1</ACESuserName>

//
// ACES Color Space Conversion - H-Log to ACES2065-1
//
// converts H-Log to 
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

const Chromaticities REC2020_PRI =
    {
        {0.70800, 0.29200},
        {0.17000, 0.79700},
        {0.13100, 0.04600},
        {0.31270, 0.32900}};

// ITU-R BT.2020 -to- ACES conversion matrix
const float REC2020_to_ACES_MAT[3][3] = calculate_rgb_to_rgb_matrix(REC2020_PRI,
                                                                    AP0);

float HLog_to_linear(input varying float t)
{
    const float a = 5.555556;
    const float b = 0.035852;
    const float c = 0.290200;
    const float d = 0.470634;
    const float e = 7.624634;
    const float f = 0.092864;
    const float cut2 = 0.169110; 

    if (t >= cut2) {
        return (pow(10.0, (t - d) / c) - b) / a;
    } else {
        return (t - f) / e;
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
    float lin_2020[3];
    lin_2020[0] = HLog_to_linear(rIn);
    lin_2020[1] = HLog_to_linear(gIn);
    lin_2020[2] = HLog_to_linear(bIn);

    float ACES[3] = mult_f3_f33(lin_2020, REC2020_to_ACES_MAT);

    rOut = ACES[0];
    gOut = ACES[1];
    bOut = ACES[2];
    aOut = aIn;
}
