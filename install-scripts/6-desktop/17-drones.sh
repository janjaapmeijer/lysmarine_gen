#!/bin/bash -e

# https://github.com/ArduPilot/apm_planner

if [ "$LMARCH" == 'armhf' ]; then
  wget https://github.com/bareboat-necessities/apm_planner_4rpi/releases/download/v2.0.29-rc1-36-g1fba2b8fc/apmplanner2_2.0.29-rc1-36-g1fba2b8fc_armhf.deb -O apmplanner2.deb
fi
if [ "$LMARCH" == 'arm64' ]; then
  wget https://github.com/bareboat-necessities/apm_planner_4rpi/releases/download/v2.0.29-rc1-36-g1fba2b8fc/apmplanner2_2.0.29-rc1-36-g1fba2b8fc_arm64.deb -O apmplanner2.deb
fi

dpkg -i apmplanner2.deb && rm -f apmplanner2.deb

bash -c 'cat << EOF > /usr/local/share/applications/apmplanner2.desktop
[Desktop Entry]
Type=Application
Name=ApmPlanner2
GenericName=ApmPlanner2
Comment=Drone Control Station
Exec=onlyone apmplanner2
Terminal=false
Icon=gnome-globe
Categories=Navigation;
EOF'
