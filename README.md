<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- Copyright Contributors to the ACES Project -->

# ACES Input and Color Space Conversion Transforms

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![CLA
assistant](https://cla-assistant.io/readme/badge/ampas/aces-input-and-colorspaces)](https://cla-assistant.io/ampas/aces-input-and-colorspaces)


This is a submodule of the [ACES repository](https://github.com/ampas/aces-dev)
and contains Input Transforms and Color Space Conversion Transforms for use
within ACES-based workflows. Color Space Conversion Trasnforms (CSCs) define
conversions between ACES2065-1 and color encodings such as "camera-log" spaces.
When going from camera-log to ACES2065-1, these transforms usually consist of a
log-to-lin function followed by a 3x3 matrix. When going from ACES2065-1 to
camera-log, CSCs usually consist of a 3x3 matrix followed by a lin-to-log
function. CSCs do not change the image state from scene-referred, they re-encode
the scene-referred data to linear ACES.


## Usage
The transforms in this repository import CTL library files to leverage basic
utility functions and reuse a RGB to RGB matrix calculation function. These
imports are a part of the [`aces-core`](https://github.com/ampas/aces-core)
repository. However, color primary chromaticities and lin/log conversion
functions are included locally in each transform rather than importing those
from a color spaces libary file. This was a deliberate choice to allow for quick
reference of the numbers and lin/log functions in line without needing to
cross-reference to a separate library file.


## Note to ACES Implementers

This repository is structured to support accurate implementation of ACES Input
and Color Space Conversion Transforms. Understanding the layout and intended use
of these transforms is crucial for effective integration into your systems.

### Implementation Guidelines
- **Primary Transforms**: All transforms located in each of the subdirectories
  of the root directory, with the exception of the `contrib` directory, are
  essential and should be implemented in all ACES systems. These subdirectories
  contain the standardized, validated transforms necessary for maintaining
  compatibility and functionality across different platforms and devices.
- **Community Contributed Transforms**: The `contrib` directory contains
  additional, community-supplied transforms. These are considered optional and
  should be included at your discretion. They may provide useful extensions but
  vary in their level of testing and support. It is advisable to evaluate their
  reliability and suitability for your specific needs before choosing to
  integrate them.
- **Updates and Maintenance**: Ensure your system includes the most recent
  updates by regularly incorporating new and revised transforms from the main
  subdirectories, keeping in line with the latest ACES specifications and
  industry practices.

Following these guidelines ensures that ACES implementers can build robust,
consistent systems capable of high-fidelity color management, while also
recognizing the flexibility offered by community contributions.


### For camera manufacturers

If you would like CSCs for your cameras to be included in this repository, or
would like to update your transforms currently in the repository, please open a
pull request. 


## License

ACES is licensed under the terms of the [LICENSE](./LICENSE.md) agreement.


## Contributing

Anyone can contribute to ACES, Please see [CONTRIBUTING.md](./CONTRIBUTING.md)
for details and instructions.


## Governance

ACES is goverened by the Academy Software Foundation ASWF. See
[GOVERNANCE.md](GOVERNANCE.md) for detailed information about how the project
operates.


## Reporting Issues

To report a problem, please open an
[issue](https://github.com/ampas/aces-input-and-colorspaces/issues)

For support, please visit [ACESCentral.com](https://acescentral.com)