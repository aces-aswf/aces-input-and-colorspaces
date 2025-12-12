// SPDX-License-Identifier: Apache-2.0
// Copyright Contributors to the ACES Project.

// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.Arri.LogC3-EI2000_to_ACES.a2.v1</ACEStransformID>
// <ACESuserName>ARRI LogC3 EI2000 to ACES2065-1</ACESuserName>

//
// ACES Color Space Conversion - Arri LogC3 EI2000 to ACES2065-1
//
// converts Arri LogC3 EI2000 to
//          ACES2065-1 (AP0 w/ linear encoding)
//

import "Lib.Academy.Utilities";
import "Lib.Arri.LogC3";

const float EI = 2000.0;

void main(input varying float rIn,
          input varying float gIn,
          input varying float bIn,
          input varying float aIn,
          output varying float rOut,
          output varying float gOut,
          output varying float bOut,
          output varying float aOut)
{
    float lin_AWG3[3];
    lin_AWG3[0] = normalizedLogC3ToRelativeExposure(rIn, EI);
    lin_AWG3[1] = normalizedLogC3ToRelativeExposure(gIn, EI);
    lin_AWG3[2] = normalizedLogC3ToRelativeExposure(bIn, EI);

    float ACES[3] = mult_f3_f33(lin_AWG3, AWG3_to_AP0_MAT);

    rOut = ACES[0];
    gOut = ACES[1];
    bOut = ACES[2];
    aOut = aIn;
}