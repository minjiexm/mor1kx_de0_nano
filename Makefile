help:
	@echo "[STEP1 OP1] make toolchain_download && source install_toolchain.sh"
	@echo "[STEP1 OP2] make prebuild_toolchain_download"
	@echo "[STEP2] make tools_download && source install_tools.sh"
	@echo "[STEP3] make vmlinux-build"
	@echo "[STEP3] make vmlinux-sim"

prebuild_toolchain_download:
	mkdir -p toolchains
	rm -f or1k-elf_gcc5.2.0_binutils2.26_newlib2.3.0-1_gdb7.11.tgz
	wget https://github.com/openrisc/newlib/releases/download/v2.3.0-1/or1k-elf_gcc5.2.0_binutils2.26_newlib2.3.0-1_gdb7.11.tgz
	tar -xzf or1k-elf_gcc5.2.0_binutils2.26_newlib2.3.0-1_gdb7.11.tgz -C ${TOOLCHAIN_ROOT}/
	rm or1k-elf_gcc5.2.0_binutils2.26_newlib2.3.0-1_gdb7.11.tgz
	@echo "++++++++++++++++++++++++++++++++++++++++++++++"
	@echo "++ Downloaded the toolchain successfully."
	@echo "++ Run '. environment.sh' or add manually to your PATH:"
	@echo '++    export PATH=`pwd`/toolchains/or1k-elf/bin:$${PATH}'

toolchain_download:
	git clone https://github.com/openrisc/or1k-src.git or1k-src
	git clone https://github.com/openrisc/or1k-gcc.git or1k-gcc
	@echo "++++++++++++++++++++++++++++++++++++++++++++++"
	@echo "++ Downloaded the toolchain successfully."
	@echo "++ Run '. environment.sh' or add manually to your PATH:"
	@echo '++    export PATH=`pwd`/toolchains/or1k-elf/bin:$${PATH}'

tools_download:
	git clone https://github.com/juliusbaxter/mor1kx-dev-env
	git clone https://github.com/bluecmd/or1k-linux linux
	git clone https://github.com/openrisc/openOCD.git openocd
	git clone https://github.com/openrisc/or1ksim.git

de0_nano_tools_download:
	wget https://hardwaregeeksblog.files.wordpress.com/2017/01/quartus_setup.pdf
	wget http://www.coffeebrain.org/files/installers/DE0_Nano_SystemBuilder.tar.gz

update_UART_pins:
	cp src/UART0_pin_assignments.tcl mor1kx-dev-env/boards/altera/de0_nano/syn/quartus/tcl/

vmlinux-build:
	cd linux && make defconfig && make

vmlinux-sim:
	or1k-sim -f src/or1ksim.cfg linux/vmlinux

update:
	make update_UART_pins

clean:
	rm -rf build-*
