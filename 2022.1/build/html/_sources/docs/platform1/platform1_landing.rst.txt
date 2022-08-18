VMK180 TRD
===========================================================

VMK180 TRD 2022.1 demonstrates following functionalities :

* Video being captured from MIPI image sensor, processed with an accelerator and displayed on a HDMI monitor connected to vmk180 board.
* Video being captured from MIPI image sensor , processed (optionally) with an accelerator, sent to a x86 host machine (root complex) via PCIe and displayed on a monitor connected to the host machine.
* Video frames being transferred from a file on the host machine to the VMK180 evaluation board (endpoint) through the PCIe QDMA bridge interface, processed (optionally) with an accelerator, sent back to host and displayed on a monitor connected to the host machine. . 
* Video frames being transferred from a file on the host machine to the VMK180 evaluation board (endpoint) through the PCIe QDMA bridge interface, processed (optionally) with an accelerator and displayed on a monitor connected to the host machine.

Accelerator functions can be added to this platform using Vitis platform. Supported acceleration function in this design is a 2D Filter.


.. image:: ../media/sc_image_landing.PNG
   :width: 1200
   :alt:  Smart Camera Landing
   
Features
--------
 
* 4k resolution images from a sensor
* HDMI display
* Demonstration of VMK180 as PCIe End-Point accelerator Card
* User programmable accelerated 2D filter
* Loop Back of processed 4k Video data over PCIe
* Live Display of Loop backed video on Host
* Jupyter notebook based applications control, power and performance monitoring
* Gstreamer based End point applications


Quick Start
-----------
.. toctree::
   :maxdepth: 1
   

   docs/introduction.md
   docs/app_deployment.md
   

Tutorials
---------
.. toctree::
   :maxdepth: 1
  

   ../building_the_design.md
   ../build_vivado_design.md
   ../build_vitis_platform.md
   ../build_accel.md
   ../build_petalinux.md 


Architecture Documents
----------------------

.. toctree::
   :maxdepth: 1
  

   docs/sw_arch_platform.md
   docs/hw_arch_platform.md
   docs/hw_arch_accel.md


Other
-----

.. toctree::
   :maxdepth: 1
  

   docs/issue_sc.md
   docs/debug_sc.md


Xilinx Support
---------------

GitHub issues will be used for tracking requests and bugs. For questions go to `forums.xilinx.com <http://forums.xilinx.com/>`_.

License
-------

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at `http://www.apache.org/licenses/LICENSE-2.0 <http://www.apache.org/licenses/LICENSE-2.0>`_.




Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


