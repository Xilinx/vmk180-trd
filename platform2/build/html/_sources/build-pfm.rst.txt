Create the Vitis Platform
=========================

Prerequisites
-------------

* Reference Design zip file

* Vitis Unified Software Platform 2020.2

Build Flow Tutorial
-------------------

.. tip::

   You can skip this tutorial and move straight to the next tutorial if desired.
   A pre-built Vitis platform file is provided at
   *$working_dir/vmk180_trd_platform2_2020.2/platform/vmk180_trd_platform2*

**Download Reference Design Files:**

Skip the following steps if the design zip file has already been downloaded and
extracted to a working directory

#. Download the VMK180 Targeted Reference Design ZIP file

#. Unzip Contents

The directory structure is described in the Introduction Section

**Create a Vitis Extensible Platform:**

#. Use XSCT to generate the Vitis platform

   To create the Vitis platform, run the following xsct tcl script:

   .. code-block:: bash

      cd $working_dir/vmk180_trd_platform_2020.2/platform
      xsct pfm.tcl -xsa $working_dir/vmk180_trd_platform2_2020.2/vivado/project/vmk180_trd_platform2.sdk/vmk180_trd_platform2.xsa

   The generated platform will be located at:

   *$working_dir/vmk180_trd_platform2_2020.2/platform/ws/vmk180_trd_platform2/export/vmk180_trd_platform2*

   It will be used as input when building the Vitis accelerator projects.
