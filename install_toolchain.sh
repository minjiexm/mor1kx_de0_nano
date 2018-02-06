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

