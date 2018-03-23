#Set Env varaibles for tcsh
set curPath = `pwd`

setenv TOOLCHAIN_ROOT $curPath/toolchain

#PREFIX is the path where you want to install the toolchain. setenv ARCH openrisc setenv CROSS_COMPILE or1k-elf-
setenv PREFIX $TOOLCHAIN_ROOT/or1k-elf

#Please make sure $PREFIX is already there and already chown to $USER.
set path = ($path $PREFIX/bin $TOOLCHAIN_ROOT/or1ksim/bin $TOOLCHAIN_ROOT/openocd)
