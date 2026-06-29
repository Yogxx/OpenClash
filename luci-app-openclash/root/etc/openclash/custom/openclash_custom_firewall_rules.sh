#!/bin/sh
. /usr/share/openclash/log.sh
. /lib/functions.sh

# This script is called by /etc/init.d/openclash
# Add your custom firewall rules here, they will be added after the end of the OpenClash iptables rules

LOG_TIP "Start Add Custom Firewall Rules..."

# Bypass tailscale0 dari OpenClash interception (fw4/nftables)
nft insert rule inet fw4 openclash iifname "tailscale0" counter return
nft insert rule inet fw4 openclash_mangle iifname "tailscale0" counter return
nft insert rule inet fw4 openclash oifname "tailscale0" counter return

# Bypass Tailscale CGNAT range 100.64.0.0/10
nft insert rule inet fw4 openclash ip daddr 100.64.0.0/10 counter return
nft insert rule inet fw4 openclash_mangle ip daddr 100.64.0.0/10 counter return