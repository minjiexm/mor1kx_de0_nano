# README #

Up-to-data flow for booting kernel with openrisc on de0_nano board.

### What is this repository for? ###

* Download and install all or1k toolchain submodules.
  - or1k-src
  - ork1-gcc
  - linux : Kernel source files
  - or1ksim : or1k simulator
  - openOCD : GDB debug tool for or1k
  - mor1kx_dev_env : source codes and FPGA build env for mor1kx

* Build linux kernel

* Bootup kernel on simulator (or1ksim)

* Bootup kernel on real hardware DE0-NANO

* Just type make at root dir will print all commands.

* [General tutorial for toolchain](https://github.com/openrisc/tutorials)

### How do I get set up? ###

* Altera Quartus Lite Free Install:
Please follow below Steps to download and install:
https://hardwaregeeksblog.files.wordpress.com/2017/01/quartus_setup.pdf
Env setup for tcsh: 
setenv ALTERA_PATH "/eda/intelFPGA_lite/17.1"
setenv QSYS_ROOTDIR "/eda/intelFPGA_lite/17.1/quartus/sopc_builder/bin" 

set path = ($path $ALTERA_PATH/quartus/bin)

* Set Env varaibles for tcsh
setenv TOOLCHAIN_ROOT /opt/toolchain
setenv PREFIX $TOOLCHAIN_ROOT/or1k-elf #PREFIX is the path where you want to install the toolchain.
setenv ARCH openrisc
setenv CROSS_COMPILE or1k-elf-

set path = ($path $PREFIX/bin $TOOLCHAIN_ROOT/or1ksim/bin $TOOLCHAIN_ROOT/openocd)
Please make sure $PREFIX is already there and already chown to $USER.

*  For setup toolchian, there are two options:
    1. Build and install toolchain from scratch
       make toolchian_download #clone all toolchains from github
       source install_toolchain.sh
       Detail please refer https://github.com/juliusbaxter/mor1kx-dev-env/wiki/OpenRISC-tool-chain-installation-guide
       This will take very long time to download and build

    2. Direct download prebuild toolchains and just untar to the $PREFIX dir.
       make prebuild_toolchain_download #direct download prebuild toolchains
       make tools_download
       Detail please refer https://github.com/openrisc/tutorials
       You can download other version toolchains through below link:
       https://github.com/openrisc/newlib/releases

* Download and install other tools : mor1kx openocd linux or1ksim
    make tools_download
    source install_tools.sh
    For mor1kx install please refer https://github.com/juliusbaxter/mor1kx-dev-env/wiki/OpenRISC-tool-chain-installation-guide

* Build vmlinux
    make vmlinux-build
    This command will compile and generate a kernel file called vmlinux under linux diretory.

* Simulate Kernel by or1ksim
  make vmlinux-sim

* Compile and build FPGA SOF which will load to DE0_NANO evaluation board:
  make fpga-build

* Connect DE0_NANO evaluation board to computer through USB.
  Download FPGA SOF to hardware:
  make fpga-download
