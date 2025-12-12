// <ACEStransformID>urn:ampas:aces:transformId:v2.0:CSC.Arri.ACES_to_LogC3-EI160.a2.v1</ACEStransformID>
// <ACESuserName>ACES2065-1 to ARRI LogC3 EI160</ACESuserName>

//
// ACES Color Space Conversion - ACES2065-1 to Arri LogC3 EI160
//
// converts ACES2065-1 (AP0 w/ linear encoding) to
//          Arri LogC3 EI160
//

import "Lib.Academy.Utilities";
import "Lib.Arri.LogC3";

const float EI = 160.0;

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

    float lin_AWG3[3] = mult_f3_f33(ACES, AP0_to_AWG3_MAT);

    rOut = relativeExposureToNormalizedLogC3(lin_AWG3[0], EI);
    gOut = relativeExposureToNormalizedLogC3(lin_AWG3[1], EI);
    bOut = relativeExposureToNormalizedLogC3(lin_AWG3[2], EI);
    aOut = aIn;
}