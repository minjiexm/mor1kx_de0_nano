################################################
# Download all pre requisties.
################################################
# https://github.com/kdgwill/OR1K/wiki/OpenRisc-tools-Install
sudo apt-get -y install autoconf autogen bison build-essential dejagnu dh-autoreconf elfutils flex g++ gcc git libcloog-isl-dev libelf-dev libexpat1-dev libftdi-dev libgmp3-dev libisl-dev libmpc-dev libmpfr-dev libncurses5-dev  libtclcl1-dev libtool libusb-1.0-0-dev libzip-dev make patch pkg-config python-dev subversion texinfo u-boot-tools

cd or1k-gcc
./contrib/download_prerequisites

################################################
# Build the first set of tools, binutils etc.
################################################
mkdir build-or1k-src
cd build-or1k-src
../or1k-src/configure --target=or1k-elf --prefix=$PREFIX --enable-shared --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-libgui --disable-rda --disable-sid --disable-sim --disable-gdb --with-sysroot --disable-newlib --disable-libgloss
make
make install
cd ..

################################################
# Build GCC
################################################
mkdir build-or1k-gcc
cd build-or1k-gcc
../or1k-gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c --disable-shared --disable-libssp
make
make install
cd ..

################################################
# Build newlib and gdb 
# (without or1ksim in this case)
################################################
cd build-or1k-src
../or1k-src/configure --target=or1k-elf --prefix=$PREFIX --enable-shared --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-libgui --disable-rda --disable-sid --enable-sim --disable-or1ksim --enable-gdb --with-sysroot --enable-newlib --enable-libgloss
make
make install
cd ..


################################################
# Build GCC woth newlib
################################################
cd build-or1k-gcc
../or1k-gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib
make
make install
cd ..

