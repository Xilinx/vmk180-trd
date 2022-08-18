<table class="sphinxhide">
 <tr>
   <td align="center"><img src="../../media/xilinx-logo.png" width="30%"/><h1>Versal Prime -VMK180 Evaluation Kit <br>Multimedia TRD Tutorial</h1>
   </td>
 </tr>
 <tr>
 <td align="center"><h1>Debug Issues</h1>

 </td>
 </tr>
</table>

Debug
============

Petalinux build issues :
------------------------


In case of any errors related to checksum or patch hunk failing, please Set `core.autocrlf` to false using following command

```
git config --global core.autocrlf false

```


PCIe Debug
----------

1. QDMA Driver probe is expected to fail if the board is not linked-up with host. After Booting the board, the host machine must be rebooted for PCIe link-up.
2. Bad Link between host and board may cause the DMA transfers to fail even after successfull link-up. To find out if this is the case check for any `Bad TLP ` or `Bad DLLP` error in host dmesg. This is likely to be caused by a bad PCIe Extender cable or a damaged pcie slot.

For extensive details on debugging refer to relevent sections of  [PCIe debug guide](https://xilinx.github.io/pcie-debug-kmap/pciedebug/build/html/index.html)

pcie-gst-app command line application for debug
-----------------------------------------------
This command application is used to provide CPU utilzation numbers for a given usecase without depending on jupyter-lab services running in the background. 

**Build and execution steps**

1. By default pcie gst app commandline application is disabled in petalinux, to enable it add `pcie-gst-app` recipe to `vmk180-trd/petalinux/${PROOT}/project-spec/meta-vmk180-trd/recipes-core/packagegroups/packagegroup-vmk180-trd.bb` 
2. To build `pcie-gst-app` re-build petalinux project by following steps provided in `Building Petalinux` section .
3. Run Pcie host application as recommended in `Run Host and EP applications section`. 
4. Execute pcie_gst_app and observe the output selected usescase. If Usecase 1 (or) Usecase 2 is selected from host application, Make sure to execute `xmediactl.sh` (or) `xmedictl_1080.sh` depending on the selected resolution before running pcie_gst_app from commandline.

**License**

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at
[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)


Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


