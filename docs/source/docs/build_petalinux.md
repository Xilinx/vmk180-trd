<table class="sphinxhide">
 <tr>
   <td align="center"><img src="media/xilinx-logo.png" width="30%"/><h1> Versal Prime -VMK180 Evaluation Kit Tutorial</h1>
   </td>
 </tr>
 <tr>
 <td align="center"><h1>Building Petalinux</h1>

 </td>
 </tr>
</table>

Building Petalinux
================================================

Introduction
------------
This tutorial walks through the typical steps of creating and customizing a
bootable Linux image for the VMK180 Evaluation Board. 

In the following sections, you will:

1. Build the BSP with the default rootfs configuration.
2. Learn how to add your own Vivado or Vitis generated bitstream/xclbin firmware
   components.

Prerequisites
--------------
1. PetaLinux 2022.1 tools installation

Accessing the Tutorial Reference Files
--------------------------------------

> **Note**: Skip the following steps if the design files have already been cloned and extracted to a working repository

1. To access the reference files, type the following into a terminal:

   ```
   git clone --branch 2022.1 --recursive https://github.com/Xilinx/vmk180-trd.git

   ```

2. Navigate to the `vmk180-trd-2022.1` which is the working directory.


To Build Designs and Petalinux in one step:
-------------------------------------------

1. Go to the working directory 

```
cd $working_dir/
``` 
2   To build and  generate sdcard image (wic), run the following command. The Makefile calls a lower level Makefile to build petalinux. If a platform is not already available it builds and integrate overlay as well.
```
make all sdcard PFM=<val> OVERLAY=<val> YES=1

```


   |Application name |Platform name(PFM)| Overlay(OVERLAY) Supported |
   |----|----|----|
   |VMK180 (Multimedia-PCIe) TRD |vmk180_trd| filter2d_pl |


Modifying/Configure the petalinux project manually
--------------------------------

* Source the PetaLinux 2022.1 tool settings.sh script.

Run the following command to create a new Petalinux project from the working directory

```
cd petalinux/xilinx-vmk180-trd
```

Next the project needs to be configured with the xsa file from the Vivado project.

```
petalinux-config --get-hw-description=<path of xsa> --silentconfig

```

> **Note**: The xsa needs to match the platform and design selected in the previous step. 

Build the Image
---------------
Run the below commands to build and package the wic image in compressed format:

```
petalinux-build
petalinux-package --boot --plm --psmfw --u-boot --dtb --force
petalinux-package --wic --extra-bootfiles "binary_container_1.xclbin" --wic-extra-args "-c xz"
```
> **Note** : Before running above command copy binary_container_1.xclbin into images/linux folder. 

The generated compressed image file will be located at
`images/linux/petalinux-sdimage.wic.xz`.

**Tip:** The generated wic file assumes a fixed partition size.
         The file size can be significantly lower by compressing the file e.g.
         using xz:

To uncompress wic file use following command 

```
xz -d -v images/linux/petalinux-sdimage.wic.xz
```

This generates a output file named
`images/linux/petalinux-sdimage.wic` with uncompressed wic file 

Flash the image on an SD card using Balena Etcher. This image is functionally
equivalent to the prebuilt sdcard image provided with package


Build the SDK
---------------
A cross-compilation SDK is useful for application development on a host machine
for a specific target architecture e.g. X86 host and ARM 64-bit target. Run the
below command to generate a cross-compilation that can be used outside the
PetaLinux:

```
petalinux-build -s
```

The resulting self-extracting shell script installer file is located at
`images/linux/sdk.sh`.

The SDK installer script can be copied to the application developer's host
machine and installed by simply running the script. Follow the prompts on the
screen.

```
$ images/linux/sdk.sh
PetaLinux SDK installer version 2022.1
============================================
Enter target directory for SDK (default: /opt/petalinux/2022.1): ./images/linux/sdk
```

Once the SDK is installed, source the file
`images/linux/sdk/environment-setup-aarch64-xilinx-linux`
to set up the cross-development environment.



**Next Step**

* Setting up the Board and Application Deployment Tutorial
  * [VMK180 TRD](./platform1/docs/app_deployment.md)
* Go back to the [VMK180 Targeted Reference Designs start page](../index.html)

**References**

* Petalinux user guide [UG1144](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2020_2/ug1144-petalinux-tools-reference-guide.pdf)

**License**

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at
[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

<p align="center">Copyright&copy; 2022 Xilinx</p>
