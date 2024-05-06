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
[http://wiki.radxa.com/Rockpi4/install/NVME](Install on M.2 NVME SSD)
* Step 1 : Method 1
* Step 2 : Option 2

- flash BBN OS image to microSD with balenaEtcher and insert into Rockpi
- flash BBN OS image to NVME

    sudo dd if=lysmaine-bbn-lite-bookworm_*-armbian-arm64.img.xz of=/dev/nvme0n1 bs=1M

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
