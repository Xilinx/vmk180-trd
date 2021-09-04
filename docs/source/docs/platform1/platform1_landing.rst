VMK180 TRD
===========================================================

VMK180 TRD demonstrates the following functionalities,

* Video captured from MIPI image sensor is processed and displayed on a Jupyter Notebook or a HDMI monitor connected to x86 host machine (root complex).
* Video frames are looped from a x86 host machine (root complex) to the VMK180 evaluation board (endpoint) through the PCIe QDMA bridge interface for data processing and displayed onto the HDMI monitor connected to the host. 
* Video frames are transferred from x86 host machine (root complex) to VMK180 evaluation board (end point) processed and displayed onto the HDMI monitor connected to VMK180 evaluation board.

Accelerator functions can also be added to this platform using Vitis. Supported acceleration function in this design is a 2D Filter this 2D Filter is used to demonstrate image processing on the end point and finally transfers it back to host where it is displayed on monitor.

.. image:: ../media/sc_image_landing.jpg
   :width: 1200
   :alt:  Smart Camera Landing
   
Features
--------
 
* 4k resolution images from a sensor
* HDMI or Jupyter notebook display
* Demonstration of Board as PCIe End-Point accelerator Card
* User programmable 2D filter
* Loop Back of processed 4k Video data over PCIe
* Live Display of Loop backed video on Host
* Jupyter notebook based power and performance monitoring


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


Xilinx Support
---------------

GitHub issues will be used for tracking requests and bugs. For questions go to [forums.xilinx.com](http://forums.xilinx.com/).

License
-------

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at
[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)




Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


