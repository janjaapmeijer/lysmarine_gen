# Bareboat Necessities OS for the RockPi
This is a fork of:
- [https://github.com/lysmarine/lysmarine_gen.git](https://github.com/lysmarine/lysmarine_gen.git) and
- [https://github.com/bareboat-necessities/lysmarine_gen](https://github.com/bareboat-necessities/lysmarine_gen)

## Choose which Armbian image your device needs
The archive of different Armbian images for different device can be found [here](https://armbian.tnahosting.net/archive) and need to be changed in /cross-build-release/armbian.sh.

## Steps to create your own BBN Marine OS image

* Create GitHub account
* Fork this project on GitHub
* Create CircleCi account (Use logging in with GitHub)
* Register .circleci/config.yml in CircleCi
* Create CloudSmith account (Use logging in with GitHub)
* Import CloudSmith key into circleci project settings (via env variable)
* Edit publish-cloudsmith.sh options in .circleci/config.yml to put location of your cloudsmith repository and push the changes into github
* After circleci build completes it will create and upload image to cloudsmith
* You can edit files inside install-scripts directory push them into github and customize your image.

## [Optional] Flash image on NVME

### 1. Write U-Boot image to SPI flash from USB OTG port
[SPI install](https://wiki.radxa.com/Rockpi4/dev/spi-install)
[NVME install](http://wiki.radxa.com/Rockpi4/install/NVME)
* Step 1 : Method 1 or Method 3
* Step 2 : Option 2
  
on pi:
- boot pi in maskrom mode
	- power off
	- remove microSD card
	- remove NVME disk
	- plug in USB male A to A with Linux PC (upper USB3 port on Pi)
	- connect PIN23 and PIN25
	- power on

on linux pc:
- Install rkdeveloptool on linux pc

		lsusb
			Bus 003 Device 005: ID 2207:330c
		rkdeveloptool ld
			DevNo=1	Vid=0x2207,Pid=0x330c,LocationID=102	Maskrom

**(!) before going further remove PIN 23 and 25**
- download SPI loader .bin and u-boot and trust.img to linux pc:
[https://dl.radxa.com/rockpi/images/loader/spi/](https://dl.radxa.com/rockpi/images/loader/spi/)

		sudo rkdeveloptool db ~/Downloads/rk3399_loader_spinor_v1.15.114.bin
		sudo rkdeveloptool wl 0 ~/Downloads/rockpi4b-uboot-trust-spi_2017.09-2697-ge41695afe3_20201219.img
		sudo rkdeveloptool rd

	**or remove image from SPI by creating zero.img and follow Method 3**:

		dd if=/dev/zero of=./zero.img bs=1M count=4
	
		rkdeveloptool db rk3399_loader_spinor_v1.15.114.bin
		rkdeveloptool wl 0 zero.img
		rkdeveloptool rd    # will output: Reset Device OK.
	
		lsusb        # will outputL Bus 003 Device 005: ID 2207:330c

- if Creating Comm Object failed!

		echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666",GROUP="plugdev"' | sudo tee /etc/udev/rules.d/51-android.rules

		or

		echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend

- reboot pi and connect microSD and NVME

[Install on M.2 NVME SSD](http://wiki.radxa.com/Rockpi4/install/NVME)
* Step 1 : Method 1
* Step 2 : Option 2

   dd if=/dev/zero of=./zero.img bs=1M count=4
Secondly, on your Linux PC, create zero.img.

   dd if=/dev/zero of=./zero.img bs=1M count=4
Thirdly, flash zero.img to SPI device.

   rkdeveloptool db rk3399_loader_spinor_v1.15.114.bin
   rkdeveloptool wl 0 zero.img
   rkdeveloptool rd    # will output: Reset Device OK.
Finally, on your Linux PC, lsusb command show show the following usb devices

   Bus 003 Device 005: ID 2207:330c

- flash BBN OS image to microSD with balenaEtcher
- insert microSD into Rockpi
- insert NVME into Rockpi
- (possibly shortcut PIN **23** and **25**)
- flash BBN OS image to NVME with (make sure to remove PIN **23** and **25** before flashing):

        sudo dd if=lysmaine-bbn-lite-bookworm_*-armbian-arm64.img.xz of=/dev/nvme0n1 bs=1M

# 3. Write image to SPI flash from USB OTG port




### Format NVME
    sudo fdisk -l
    umount /dev/nvme0n1
    sudo wipefs -a /dev/nvme0n1
    sudo gdisk -l /dev/nvme0n1
    sudo gdisk /dev/nvme0n1
    > L 8305 Linux ARM64
    > n
    > w
    sudo mkfs -t ext4 /dev/nvme0n1p1
    #sudo mount /dev/nvme0n1p1 /mnt


## License

BBN Marine OS and Lysmarine scripts distributed under GPLv3

Copyright © 2020 Frederic Guilbault

Copyright © 2021-2024 mgrouch

Included content copyrighted by other entities distributed under their respective licenses.
