################################################
# Setup Mor1kx env
################################################
cd mor1kx_dev_env
./scripts/bash/setup.sh
cd ..
cp src/UART0_pin_assignments.tcl mor1kx-dev-env/boards/altera/de0_nano/syn/quartus/tcl/

################################################
# Build and install openocd
################################################
cd openocd
./bootstrap
./configure --enable-ftdi --enable-usb_blaster_libftdi --enable-maintainer-mode --prefix=${TOOLCHAIN_ROOT}/openocd
make
make install
echo "++++++++++++++++++++++++++++++++++++++++++++++"
echo "++ Built openocd successfully."
echo "++ Run '. environment.sh' or add set those variables manually:"
echo '++    export OPENOCD=${TOOLCHAIN_ROOT}/openocd/'
echo '++    export PATH=`pwd`/tools/openocd/bin:$${PATH}'

################################################
# Build and install or1ksim
################################################
mkdir build-or1ksim
cd build-or1ksim
../or1ksim/configure --prefix=${TOOLCHAIN_ROOT}/or1ksim --program-prefix=or1k-
make
make install
echo "++++++++++++++++++++++++++++++++++++++++++++++"
echo "++ Built or1ksim successfully."
echo "++ Run '. environment.sh' or add set those variables manually:"
echo '++    export PATH=${TOOLCHAIN_ROOT}/or1ksim/bin:$${PATH}'
