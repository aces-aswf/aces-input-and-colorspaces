// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.Huawei.ACES_to_HLog.a2.v1</ACEStransformID>
// <ACESuserName>ACES2065-1 to Huawei H-Log</ACESuserName>

//
// ACES Color Space Conversion - ACES2065-1 to H-Log
//
// converts ACES2065-1 (AP0 w/ linear encoding) to
//          H-Log
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
const float ACES_to_REC2020_MAT[3][3] = calculate_rgb_to_rgb_matrix(AP0,
                                                                    REC2020_PRI);

float linear_to_HLog(input varying float x)
{
    const float a = 5.555556;
    const float b = 0.035852;
    const float c = 0.290200;
    const float d = 0.470634;
    const float e = 7.624634;
    const float f = 0.092864;
    const float t = -0.012179;
    const float cut1 = 0.01;          
    
    if (x >= cut1) {
        return c * log10(a * x + b) + d;
    } else if (x < cut1 && x >= t) {
        return e * x + f;
    } else {
        return 0.0;
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
    float aces[3] = {rIn, gIn, bIn};

    float lin_2020[3] = mult_f3_f33(aces, ACES_to_REC2020_MAT);

    float HLog[3];
    HLog[0] = linear_to_HLog(lin_2020[0]);
    HLog[1] = linear_to_HLog(lin_2020[1]);
    HLog[2] = linear_to_HLog(lin_2020[2]);

    rOut = HLog[0];
    gOut = HLog[1];
    bOut = HLog[2];
    aOut = aIn;
}
