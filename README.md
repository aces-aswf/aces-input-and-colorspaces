<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- Copyright Contributors to the ACES Project. -->

# ACES Input and Color Space Conversion Transforms

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CLA
assistant](https://cla-assistant.io/readme/badge/aces-aswf/aces-input-and-colorspaces)](https://cla-assistant.io/aces-aswf/aces-input-and-colorspaces)

This repository provides Color Space Conversion Transforms for use with ACES.
Some transforms may require code from the
[`aces-core`](https://github.com/aces-aswf/aces-core) repository. 

In earlier versions of ACES, Input Transforms used the `IDT` token in filenames
and TransformIDs. In ACES 2, the `CSC` token is used, indicating that a
transform may function either as an Input Transforms or as a general CSC.

## Input Transforms
Input Transforms, i.e. CSCs converting _to_ ACES2065-1, included here are
supplied manufacturers or derived from manufacturer-published documentation.
They are provided for convenience only and may not represent the latest
recommendations from the manufacturer. While efforts are made to maintain
accuracy, users should confirm with the manufacturer that they are using the
most current IDTs for their camera.

## Contributing

Before the project can accept any code submissions through GitHub, you must fulfill these prerequisites:

1. **Contributor License Agreement (CLA):** All contributors **must** have a signed CLA on file to ensure the project can freely use your contributions.

2. **Developer Certificate of Origin (DCO):** All commits **must** be signed off (e.g., `git commit -s`) to verify that you have the right to submit the code.

3. **AI Assistance Disclosure:** While not currently blocked by CI checks, any commits or PRs built with AI assistance are expected to include an `Assisted-by: TOOL/MODEL` line to maintain transparency and human accountability.

Please see [Contributing Guidelines](https://github.com/aces-aswf/.github/blob/main/CONTRIBUTING.md) for more details.

## Reporting Issues

### General Issues
To report a problem with any Input or Color Space Conversion Transforms, please open an
[issue](https://github.com/aces-aswf/aces-input-and-colorspaces/issues) in this repository.

### Security
If the issue is sensitive in nature or a security related issue, please do not
report in the issue tracker. Instead refer to [SECURITY](https://github.com/aces-aswf/.github/blob/main/SECURITY.md) for more information about the project security policy.

## Governance

This repository is part of ACES, a project governed by the Academy Software Foundation.

For details about how the ACES project operates, please see
[GOVERNANCE](https://github.com/aces-aswf/.github/blob/main/GOVERNANCE.md).

## License

The ACES Project is licensed under the [Apache 2.0 license](./LICENSE).