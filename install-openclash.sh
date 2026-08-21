#!/bin/sh
# OpenClash Auto Installer for OpenWrt/ImmortalWrt
# Auto-detect package manager (opkg <=24.x / apk >=25.x) lalu install versi terbaru dari GitHub release

set -e

REPO="Yogxx/OpenClash"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"
TMP_DIR="/tmp/openclash_install"

echo ">>> OpenClash Auto Installer"
mkdir -p "$TMP_DIR"

# 1. Deteksi package manager berdasarkan versi OpenWrt
PKG_MODE=""
if [ -f /etc/openwrt_release ]; then
    . /etc/openwrt_release
    VER_MAJOR=$(echo "$DISTRIB_RELEASE" | cut -d'.' -f1)
else
    VER_MAJOR=""
fi

if command -v apk >/dev/null 2>&1 && [ -n "$VER_MAJOR" ] && [ "$VER_MAJOR" -ge 25 ] 2>/dev/null; then
    PKG_MODE="apk"
elif command -v opkg >/dev/null 2>&1; then
    PKG_MODE="ipk"
elif command -v apk >/dev/null 2>&1; then
    PKG_MODE="apk"
else
    echo "!!! Tidak terdeteksi opkg maupun apk. Keluar."
    exit 1
fi

echo ">>> Terdeteksi OpenWrt release: ${DISTRIB_RELEASE:-unknown} -> mode paket: $PKG_MODE"

# 2. Update package list (biar dependency resolve dari feeds)
echo ">>> Update package list ($PKG_MODE)..."
if [ "$PKG_MODE" = "ipk" ]; then
    opkg update
else
    apk update
fi

# 3. Ambil metadata release terbaru
echo ">>> Cek release terbaru OpenClash..."
curl -L --retry 3 -s "$API_URL" -o "${TMP_DIR}/release.json"

if [ ! -s "${TMP_DIR}/release.json" ]; then
    echo "!!! Gagal ambil data release. Cek koneksi internet."
    exit 1
fi

# 4. Cari download URL sesuai ekstensi (.ipk atau .apk)
DOWNLOAD_URL=$(jsonfilter -i "${TMP_DIR}/release.json" -e '@.assets[*].browser_download_url' | grep "\.${PKG_MODE}\$" | head -n1)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "!!! Tidak ada asset .${PKG_MODE} di release terbaru."
    exit 1
fi

FILENAME=$(basename "$DOWNLOAD_URL")
echo ">>> Download: $FILENAME"
curl -L --retry 3 "$DOWNLOAD_URL" -o "${TMP_DIR}/${FILENAME}"

# 5. Install (dependency otomatis ke-resolve dari Depends: di package)
echo ">>> Install OpenClash..."
if [ "$PKG_MODE" = "ipk" ]; then
    opkg install "${TMP_DIR}/${FILENAME}"
else
    apk add --allow-untrusted "${TMP_DIR}/${FILENAME}"
fi

rm -rf "$TMP_DIR"

echo ">>> Selesai! Akses OpenClash di menu Services > OpenClash pada LuCI."
