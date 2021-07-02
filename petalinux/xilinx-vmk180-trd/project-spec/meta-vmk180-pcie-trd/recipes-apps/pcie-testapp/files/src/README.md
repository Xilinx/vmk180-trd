Build
--------------------------------

Set the following env vars:

0. CXX
1. SDKTARGETSYSROOT
2. HLS_DIR
3. OPENCV

make -j32

or

make CXX=aarch64-linux-gnu-g++ SDKTARGETSYSROOT=/mypath HLS_DIR=/mypath OPENCV=/mypath

Run
--------------------------------
./xf_filter2d_tb <file> <width> <height>


