<table class="sphinxhide">
 <tr>
   <td align="center"><img src="docs/source/docs/media/xilinx-logo.png" width="30%"/><h1> Versal Prime -VMK180 Targeted Reference Designs </h1>
   </td>
 </tr>
</table>



The VMK180 TRD consists of a series of platforms, accelerators and Jupyter notebooks to demonstrate various aspects of the design and functionality of various Board interfaces. A platform is a Vivado design with a pre-instantiated set of I/O interfaces and a corresponding PetaLinux BSP and image that includes the required kernel drivers and user-space libraries to exercise those interfaces. Accelerators are mapped to FPGA logic resources and stitched into the platform using the Vitis toolchain. The reference design currently supports the VMK180 evaluation board. 
Following is the list of Platform design available in 2021.1:

| Platform Name  | Description  |  Links |
| -------------- | ------------- |----------------|
| Platform 1: Multimedia TRD  |The multimedia TRD demonstrates video capture either from a file source, USB webcam or MIPI image sensor and displays it on a Jupyter Notebook or a HDMI monitor. Accelerator functions can also be added to this platform using Vitis. Supported acceleration function in this design is a 2D Filter.  |   <ul><li><a href="https://xilinx.github.io/vmk180-trd/platform1/html/index.html">Documentation</a></li><li><a href="https://www.xilinx.com/member/forms/download/xef.html?filename=vmk180_multimedia_trd_prebuilt_2021.1.zip">Pre-Built Package (vmk180_multimedia_trd_prebuilt_2021.1.zip)</a></li></ul>
| Platform 2: PCIe TRD  |  The PCIe TRD demonstrates  video frames being transferred from a x86 host machine (root complex) to the VMK180 evaluation board (endpoint) through the PCIe QDMA bridge interface for data processing.  A 2D filter has been used to demonstrate image processing on the end point and finally transfers it back to host where it is displayed on monitor.  | <ul><li><a href="https://xilinx.github.io/vmk180-trd/platform2/html/index.html">Documentation</a></li><li><a href="https://www.xilinx.com/member/forms/download/xef.html?filename=vmk180_pcie_trd_pre-built_2021.1.zip">Pre-Built Package (vmk180_pcie_trd_pre-built_2021.1.zip)</a></li></ul>



For more information about the VMK180 Evaluation Board , see [Versal Prime Series VMK180 Evaluation Kit](https://www.xilinx.com/products/boards-and-kits/vmk180.html)

## Xilinx Support

GitHub issues will be used for tracking requests and bugs. For questions go to [forums.xilinx.com](http://forums.xilinx.com/).

## Design Licenses

The design includes files licensed by Xilinx and third parties under the terms
of the GNU General Public License, GNU Lesser General Public License,
BSD License, MIT License, and other licenses. The Package includes one
zip file named ``sources.zip`` containing the complete set of design source
files and one zip file named ``licenses.zip`` containing licenses extracted from
the design source files. You are solely responsible for checking any files you
use for notices and licenses and for complying with any terms applicable to your
use of the design and any third party files supplied with the design.

To generate licenses and sources for petalinux BSP use following command. 

``petalinux-build -a``


To obtain  Xilinx image.ub  licenses files:
Licenses for image.ub files are included in the ``/usr/share/licenses`` directory when the image file is built.
DNF package manager can be used to list all packages in image as well as download all the sources for all the packages.


## License

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at
[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

<p align="center">&copy; Copyright 2021 Xilinx, Inc.</p>
