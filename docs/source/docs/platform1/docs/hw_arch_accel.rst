Accelerator - 2D Filter
=======================

This chapter provides the hardware and software architecture of the 2D Filter accelerator integrated into platform.

Software Architecture
=====================

The accelerator uses Vitis Video Analytics (VVAS) as a framework to realize tranform and solutions that can easily and seamlessly interface with other GStreamer elements such as video sources and sinks. VVAS provides a simplified interface to developers, exposing certain API to program the accleration kernel without having to worry about handeling buffer allocations.

**vvas_xfilter** is a generic VVAS infrastructure plugin that interact with the acceleration kernel through a set of APIs exposed by an acceleration software library corresponding to that kernel. An accelerator element has one source and one sink pad; vvas_xfilter can consume one temporal input frame from its source pad, data transform and produce one output frame on its sink pad. vvas_xfilter plug-in wraps the acceleration software library and prepares the acceleration software library handle (VVASKernel) to be passed to the core APIs as shown in the figure.

The vvas_xfilter plug-in provide many input properties to config the kerenl. Below are significant

kernels-config (mandatory) : Is a path to configuration file in JSON format and contains information required by the kernel, such as path to xclbin, acceleration software library and many more.

dynamic-config (optional) : configures one or many input parameters of the kernel during runtime, refer to all parameters under config from the JSON file above.

**Acceleration software libraries:** vvas_xfilter loads the shared acceleration software library, where acceleration software library controls the acceleration kernel, like register programming, or any other core logic that is required to implement the transform functions.

**vvas_xfilter2d_sw** is a shared acceleration software library that uses OpenCV libraries to perform filter2d computation as a pure software implmentation performed on the APU cores.

**vvas_xfilter2d_pl** is a shared acceleration software library that operates on PL-based kernel obtained by high level synthesis (HLS) from Xilinx Vitis Vision libraries.

below are the examples where VVAS framework is used with an acceleration software library developed for a hard-kernel IP / software library (e.g., OpenCV)

.. image:: ../../media/vvas.png
  :width: 1000
  :alt: VVAS framework for Acclerator Kernels

For detailed documentaion of VVAS infrastructure plugins, plugin properties and JSON configuration file refer the below URL https://xilinx.github.io/VVAS/index.html

Hardware Architecture
=====================

Processing Pipeline
-------------------

A memory-to-memory (M2M) pipeline reads video frames from memory, does certain processing,
and then writes the processed frames back into memory. A block diagram of the process pipeline
is shown in the following figure.

.. image:: ../../media/M2M_Processing_Pipeline_Showing_Hardware_Accelerator_and_DataMotion.png
   :width: 800

The M2M processing pipeline with the 2D convolution filter in the design is entirely generated
by the Vitis™ tool based on a C-code description. The 2D filter function is translated to RTL using
the Vivado® HLS compiler. The data motion network used to transfer video buffers to/from
memory and to program parameters (such as video dimensions and filter coefficients) is inferred
automatically by the v++ compiler within the Vitis tool.

**Resource usage of current design**

.. csv-table:: **Table 1: Key Component Clock Frequencies**
	:file: ../../../tables/resource_accel1.csv
	:widths: 20, 20, 20, 20, 20 
	:header-rows: 1


**Next Steps**

.. toctree::
   :maxdepth: 1


   app_deployment.md



**License**

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at
[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)


Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


