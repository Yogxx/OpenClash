# luci-app-tailscale-community

Automated build mirror of [`luci-app-tailscale-community`](https://github.com/openwrt/luci/tree/master/applications/luci-app-tailscale-community) from the official [openwrt/luci](https://github.com/openwrt/luci) repository, prebuilt as ready-to-install `.ipk` packages for **OpenWrt 24.10.x**.

This repository does **not** modify the package source in any way. It simply:

1. Syncs the package source from `openwrt/luci` on a scheduled basis
2. Builds it using the official OpenWrt SDK
3. Publishes the resulting `.ipk` package to [GitHub Releases](../../releases)

If you're looking for the original source code or want to report a bug/feature request related to the app itself, please refer to the upstream repository and its [issue tracker](https://github.com/openwrt/luci/issues).

## Why this repository exists

The `tailscale` package bundled with OpenWrt releases is tied to a specific version and doesn't receive updates until the next OpenWrt release. This repo provides a way to grab a freshly built `.ipk` of the LuCI app without needing to set up a full OpenWrt SDK build environment yourself.

## Target

| | |
|---|---|
| Built against | OpenWrt 24.10.7 SDK |
| Package format | `.ipk` |
| Architecture | `all` (noarch) |

This package contains only Lua/JS/HTML/UCI files — no compiled binaries — so the same `.ipk` works across architectures (aarch64, x86, MIPS, etc.), as long as your OpenWrt version is compatible (24.10.x recommended).

> Note: this only provides the LuCI **web interface**. The actual `tailscale` binary is architecture-specific and must be installed separately via `opkg install tailscale` from your device's feed.

## Installation

1. Download the latest `.ipk` from the [Releases page](../../releases)
2. Transfer it to your router (e.g. via `scp`)
3. Install it:

```sh
opkg install luci-app-tailscale-community_*.ipk
```

4. Make sure the actual `tailscale` binary is installed as well (this package only provides the LuCI web interface):

```sh
opkg update
opkg install tailscale
```

5. Go to **Services → Tailscale** in LuCI to configure it.

## Building it yourself

If you'd rather build it yourself instead of using the prebuilt release:

```sh
# Inside an OpenWrt SDK for your target
git clone https://github.com/Yogxx/luci-app-tailscale-community feeds/luci/applications/luci-app-tailscale-community
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig   # select LuCI -> Applications -> luci-app-tailscale-community
make package/luci-app-tailscale-community/compile V=s
```

The build pipeline used by this repository itself is defined in [`.github/workflows/build.yml`](.github/workflows/build.yml), and the upstream sync workflow is in [`.github/workflows/sync.yml`](.github/workflows/sync.yml) — both can be used as a reference.

## Disclaimer

This is an unofficial, community-run mirror/build repository and is not affiliated with the OpenWrt project or Tailscale Inc. Use at your own risk. Always review the source before installing prebuilt binaries on your devices.

## License

This repository redistributes source code from `openwrt/luci`, which is licensed under Apache License 2.0. See the upstream repository for full license details.
