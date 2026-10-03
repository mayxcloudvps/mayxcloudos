#!/usr/bin/env bash
# Build ISO mayxcloudos (Debian 13 + KDE Plasma + Wine).
# Chạy trên Debian/Ubuntu với quyền root:  sudo bash build.sh
set -euo pipefail
cd "$(dirname "$0")"

if [ "$(id -u)" -ne 0 ]; then
  echo "Cần chạy bằng root:  sudo bash build.sh" >&2
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Máy này không phải Debian/Ubuntu. Dùng Docker:" >&2
  echo '  docker run --rm --privileged -v "$PWD":/work -w /work debian:trixie bash build.sh' >&2
  exit 1
fi

need=(live-build debootstrap debian-archive-keyring xorriso squashfs-tools mtools dosfstools
      grub-efi-amd64-bin grub-pc-bin syslinux syslinux-common isolinux)
missing=()
for p in "${need[@]}"; do
  dpkg -s "$p" >/dev/null 2>&1 || missing+=("$p")
done
if [ "${#missing[@]}" -gt 0 ]; then
  echo ">> Cài công cụ build: ${missing[*]}"
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y "${missing[@]}"
fi

chmod +x auto/* config/hooks/normal/*.hook.chroot config/includes.chroot/usr/local/bin/*

echo ">> Dọn bản build cũ"
lb clean --purge >/dev/null 2>&1 || true

echo ">> Cấu hình"
lb config

echo ">> Build (mất khoảng 30-90 phút, tải ~2-3 GB)"
lb build

mkdir -p out
mv -f ./*.iso out/
( cd out && sha256sum ./*.iso > SHA256SUMS )

echo
echo "Xong. File ISO:"
ls -lh out/*.iso
