Introduction
============

The PCIe base platform demonstrates the PCIe capabilities of Versal Devices. The Platform design demonstrates a video file being transferred from a x86 host
machine (root complex) to the endpoint (VMK180 evaluation board) processes the data with a 2d filter,  through the PCIe QDMA
bridge interface and finally displayed at host machine.
The design uses the CPM PCI Express (PCIe) Endpoint Hard block in an Gen3 x8 configuration
along with QDMA for data transfers between the host system memory and the endpoint.
The QDMA provides protocol conversion between PCIe transaction layer packets (TLPs) and AXI
transactions.The DMA can transfer data between host and the memory controller (DDR) of 
Endpoint and from the Endpoint DDR to the host.The CPM has an AXI Bridge core for AXI-to-host communication. The downstream AXI4-Lite slaves 
include user-space registers, which are responsible for a hand-shaking mechanism between the host and the endpoint.

Video Type
----------
  * This design supports YUY2 format at 1080p30 and 4kp30 resolutions. 

Platform
---------

The following is a list of supported platforms including key I/O interfaces:


  * Sources:

    * File source
    
  * Processing:

    * 2D filter in PL.


  * Sinks:

    * QT based widget displays media content on the Host Monitor.


.. image:: images/system-bd.png
    :width: 800px
    :alt: System Design Block Diagram

Software Stack
--------------

Test application running on the endpoint receives control information using the PCIe BAR
map memory and data through the QDMA. The applicaiton receives data from the host, Processes it through 2D filter and sends the processed data  back to the host.
The PCIe BAR map address space is used to transfer control information between the host and
the endpoint. Details on how the control information is interpreted between the x86 host and
the target is shown in the following figure

.. image:: images/sw-stack.JPG
    :width: 700px
    :alt: Software Stack Overview

Data is transferred between the host and the target using the QDMA. QDMA device drivers are
installed on the host, and are used to configure the QDMA IP on the endpoint to initiate data
transfer from the host.
The host application reads the media file from the disk, sends control information to the endpoint, and
initiates the DMA transfer to send the media file to the endpoint. After receiving data
back from the endpoint, the data is displayed on the host monitor.
At the target side, pcie_testapp is used to receive the data, processes it and send the data back to the host. 

*Design Components
  The reference design package contains the following software components.

* pcie-testapp(EP application): This application receives frame buffer data from host, processes it and sends frame buffer to host.
 
* pcie_host_package(Host application): The host package installs the PCIe QDMA driver on the host machine. It identifies the PCIe endpoint VMK180 board connected to the host machine. This package includes the application for parsing raw file and sendi frames from the host machine  to endpoint and receive frames from end point and displays on the monitor of the host machine.

Design File Hierarchy
---------------------

The reference design zip file has the following contents:

* Documentation (html webpages)

* Petalinux Board Support Package (BSP)

* Pre-built SD card image

* Vivado hardware design project

* README file

* Design sources zip file

* Licenses zip file

The design file hierarchy is shown below:

.. image:: images/directory.JPG
    :width: 500px
    :alt: Directory structure


Licenses
--------

The design includes files licensed by Xilinx and third parties under the terms
of the GNU General Public License, GNU Lesser General Public License,
BSD License, MIT License, and other licenses. The design directory includes two
zip file named ``sources.zip`` and ``license.zip`` containing the complete set of design source files and licenses extracted from
the design source files respectively. You are solely responsible for checking any files you
use for notices and licenses and for complying with any terms applicable to your
use of the design and any third party files supplied with the design.

