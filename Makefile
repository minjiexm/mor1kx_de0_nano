help:
	@echo "Please use below predefined commands to download and install tools and compile"
	@echo "[STEP1] make toolchain_download && source install_toolchain.sh"
	@echo "[STEP2] make tools_download && source install_tools.sh"
	@echo "[STEP3] make vmlinux-build"
	@echo "[STEP3] make vmlinux-sim"
	@echo "[STEP4] make fpga-build"
	@echo "[STEP5] make fpga-download #Make sure DE0_NANO connected"

prebuild_toolchain_download:
	@echo "This command will download prebuild toolchains, but it never been verified!"
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
	wget https://github.com/openrisc/or1k-src/archive/or1k.zip -O src/or1k_src.zip
	wget https://github.com/openrisc/or1k-gcc/archive/or1k.zip -O src/or1k_gcc.zip
	unzip src/or1k_src.zip
	mv or1k-src-or1k or1k-src
	unzip src/or1k_gcc.zip
	mv or1k-gcc-or1k or1k-gcc
	@echo "++++++++++++++++++++++++++++++++++++++++++++++"
	@echo "++ Downloaded the toolchain successfully."
	@echo "++ Run '. environment.sh' or add manually to your PATH:"
	@echo '++    export PATH=`pwd`/toolchains/or1k-elf/bin:$${PATH}'

toolchain_git_clone:
	git clone --depth 1 https://github.com/openrisc/or1k-src.git or1k-src
	git clone --depth 1 https://github.com/openrisc/or1k-gcc.git or1k-gcc
	@echo "++++++++++++++++++++++++++++++++++++++++++++++"
	@echo "++ Downloaded the toolchain successfully."
	@echo "++ Run '. environment.sh' or add manually to your PATH:"
	@echo '++    export PATH=`pwd`/toolchains/or1k-elf/bin:$${PATH}'

tools_download:
	wget https://github.com/juliusbaxter/mor1kx-dev-env/archive/master.zip -O src/mor1kx.zip
	#wget https://github.com/bluecmd/or1k-linux/archive/smp.zip -O src/or1k-linux.zip
	wget https://github.com/openrisc/linux/archive/master.zip -O src/linux.zip
	wget https://github.com/openrisc/openOCD/archive/master.zip -O src/openocd.zip
	wget https://github.com/openrisc/or1ksim/archive/or1k-master.zip -O src/or1ksim.zip
	unzip src/mor1kx.zip
	mv mor1kx-dev-env-master mor1kx-dev-env
	unzip src/linux.zip
	mv linux-master linux
	unzip src/openocd.zip
	mv openOCD-master openocd
	unzip src/or1ksim.zip
	mv or1ksim-or1k-master or1ksim

tools_git_clone:
	git clone --branch master --depth 1 https://github.com/openrisc/linux.git linux
	git clone --depth 1 https://github.com/juliusbaxter/mor1kx-dev-env
	git clone --depth 1 https://github.com/openrisc/openOCD.git openocd
	git clone --depth 1 https://github.com/openrisc/or1ksim.git

de0_nano_tools_download:
	wget https://hardwaregeeksblog.files.wordpress.com/2017/01/quartus_setup.pdf
	wget http://www.coffeebrain.org/files/installers/DE0_Nano_SystemBuilder.tar.gz

update_UART_pins:
	cp src/UART0_pin_assignments.tcl mor1kx-dev-env/boards/altera/de0_nano/syn/quartus/tcl/

vmlinux-build:
	cd linux && make defconfig && make

vmlinux-sim:
	or1k-sim -f src/or1ksim.cfg linux/vmlinux

fpga-build:
	cd mor1kx-dev-env/boards/altera/de0_nano/syn/quartus/run && make all

fpga-download:
	cd mor1kx-dev-env/boards/altera/de0_nano/syn/quartus/run && make pgm

clean:
	rm -rf build-*

clean_src:
	rm -rf linux
	rm -rf openocd
	rm -rf or1ksim
	rm -rf mor1kx-dev-env
	rm -rf or1k-gcc
	rm -rf or1k-src
