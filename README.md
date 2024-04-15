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
* You can burn this image using RaspberryPi imager to SD card and use that SD card to boot your raspberry Pi
* You can edit files inside install-scripts directory push them into github and customize your image.

## [Optional] Add root to NVME

## License

BBN Marine OS and Lysmarine scripts distributed under GPLv3

Copyright © 2020 Frederic Guilbault

Copyright © 2021-2024 mgrouch

Included content copyrighted by other entities distributed under their respective licenses.
