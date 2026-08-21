<h1 align="center">
  <img src="https://raw.githubusercontent.com/vernesong/OpenClash/dev/img/logo.png" alt="Clash" width="200">
  <br>OpenClash<br>

</h1>

  <p align="center">
	<a target="_blank" href="https://github.com/Yogxx/OpenClash/releases"><img src="https://img.shields.io/github/downloads/Yogxx/OpenClash/total?label=Total%20Download&labelColor=blue&style=for-the-badge">
	</a>
  </p>

User Manual
---


* [Wiki](https://github.com/vernesong/OpenClash/wiki)


Download link
---


* Download [here](https://github.com/Yogxx/OpenClash/releases)

Auto Installation (Recommended)
---
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Yogxx/OpenClash/master/install-openclash.sh)"
```

Manual Installation
---
OpenWrt (24.05)
---
```sh
opkg update
```
```sh
opkg install luci-app-openclash_*.ipk
```

OpenWrt (25.10)
---
```sh
apk update
```
```sh
apk add --allow-untrusted luci-app-openclash_*.apk
```

ScreenShot
---
<details><summary>Overviews</summary>
 <p>
  <img src="https://raw.githubusercontent.com/Yogxx/OpenClash/refs/heads/master/img/ss.png" alt="overviews">
 </p>
</details>
<details><summary>Version</summary>
 <p>
  <img src="https://raw.githubusercontent.com/Yogxx/OpenClash/refs/heads/master/img/ss1.png" alt="overviews">
 </p>
</details>

Packages
---
<details><summary>Dependecies</summary>
* luci
* luci-base
* dnsmasq-full
* bash
* curl
* ca-bundle
* ipset
* ip-full
* ruby
* ruby-yaml
* unzip
* iptables(iptables)
* kmod-ipt-nat(iptables)
* iptables-mod-tproxy(iptables)
* iptables-mod-extra(iptables)
* kmod-tun(TUN模式)
* luci-compat(Luci >= 19.07)
* ip6tables-mod-nat(iptables-ipv6)
* kmod-inet-diag(PROCESS-NAME)
* kmod-nft-tproxy(Firewall4)
</details>

Credit
---
- [OpenClash](https://github.com/vernesong/OpenClash)






