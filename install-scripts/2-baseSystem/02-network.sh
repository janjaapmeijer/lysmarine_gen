#!/bin/bash -e

# Network manager
apt-get install -y -q network-manager make avahi-daemon bridge-utils wakeonlan #createap

# Resolve lysmarine.local
install -v "$FILE_FOLDER"/hostname "/etc/"
cat "$FILE_FOLDER"/hosts >> /etc/hosts
if [ $thisArch == "armbian"]; then
  sed -i '/"${hostname,}"/d' /etc/hosts
else
  sed -i '/raspberrypi/d' /etc/hosts
fi

# Access Point management
install -m0600 -v "$FILE_FOLDER"/lysmarine-hotspot.nmconnection "/etc/NetworkManager/system-connections/"
if service --status-all | grep -Fq 'dnsmasq'; then
  systemctl disable dnsmasq || true
fi

##  NetworkManager provide its own wpa_supplicant, stop the others to avoid conflicts.
if service --status-all | grep -Fq 'dhcpcd'; then
  systemctl disable dhcpcd.service
fi
systemctl disable wpa_supplicant.service
if service --status-all | grep -Fq 'hostapd'; then
  systemctl disable hostapd.service || true
fi

## Disable some useless networking services
systemctl disable NetworkManager-wait-online.service # if we do not boot remote user over the network this is not needed
if service --status-all | grep -Fq 'ModemManager'; then
  systemctl disable ModemManager.service # for 2G/3G/4G
fi
systemctl disable pppd-dns.service || true # For dial-up Internet LOL

install -v -m 0644 "$FILE_FOLDER"/wifi_powersave@.service "/etc/systemd/system/"
systemctl disable wifi_powersave@on.service
systemctl mask wifi_powersave@on.service
systemctl enable wifi_powersave@off.service

sed -i 's/\[main\]$/[main]\ndns=dnsmasq/' /etc/NetworkManager/NetworkManager.conf

echo 'ap_scan=1' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'country=US' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'options cfg80211 ieee80211_regdom=US' > /etc/modprobe.d/cfg80211.conf
