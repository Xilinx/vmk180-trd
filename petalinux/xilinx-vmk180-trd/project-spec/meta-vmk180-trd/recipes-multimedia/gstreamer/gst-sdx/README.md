Gstreamer SDx plug-in cmake build
=================================

The Cmake flow allows building supported SDx accelerator Gstreamer plug-ins as
shared libraries.

# Prerequisites
1.   Source the Petalinux environment setup script to set up the SYSROOT for
     cross-compilation. The environment script is packaged as part of the sdk.sh
     installer.
2.   Source the Xilinx SDx tools setup script. This sets the XILINX_SDX env
     variable which is used to find the sds-lib includes and headers.
     Alternatively, the user can pass the XILINX_SDX variable as command line
     option to the cmake command (see build options below). This step is only
     needed if the legacy SDSoC mode is used and can be skipped in XRT mode.

# Example
```bash
source environment-setup-aarch64-xilinx-linux
mkdir build
cd build
CC=/path/to/gcc CXX=/path/to/g++ cmake ..
make
```

# Build Options
The build can be customized via the following build options that can be
enabled/disabled by adding -D<OPTION>=<on|off> to the cmake command line.
*   `XILINX_SDX`: Path to Xilinx SDx installation (default: '')
*   `SAMPLESDIR`: Path to SDSoC accelerator install dir (default: '')
                  Applies to SDSoC mode only!
*   `SDSHW_LIBRARIES`: SDSoC accelerator shared library name (default: '')
                       Applies to SDSoC mode only!
*   `EXAMPLES`: Build GstSDx Examples (default: off)
*   `SDSOC_MODE`: Use legacy SDSoC mode (on) or XRT mode (off) (default: off)

# Available Accelerator Plugins
To build a plugin, add -D<PLUGIN_X>=<on> to the cmake command line.
*   `PLUGIN_ALL`: All plugins
*   `PLUGIN_FILTER2D`: 2D convolution filter (supports XRT mode)
