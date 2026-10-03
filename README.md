# mayxcloudos

Hệ điều hành Linux (Debian 13 "trixie" + KDE Plasma) chạy được file Windows `.exe` / `.msi`
thông qua **MâyX Engine** = Wine + DXVK, mỗi ứng dụng một môi trường riêng.

## Cách hoạt động của phần chạy .exe

- `config/includes.chroot/etc/binfmt.d/mayxcloudos-exe.conf` đăng ký định dạng PE (`MZ`) với kernel,
  nên gõ `./app.exe` trong terminal là chạy luôn.
- `/usr/local/bin/mayx-run-exe` tạo prefix Wine riêng cho từng app tại
  `~/.local/share/mayxcloud/prefixes/`, cài DXVK, rồi chạy file.
- `mayx-exe.desktop` + `mimeapps.list` gán `.exe` / `.msi` vào MâyX Engine, nên nhấp đúp trong Dolphin là chạy.
- Hook `0010` thêm kiến trúc i386 để chạy cả app 32-bit.

## Build ISO

Cần ~15 GB trống và mạng. Mất khoảng 30-90 phút.

**Cách 1: máy Debian** (Ubuntu không dùng được vì live-build của Ubuntu quá cũ, hãy dùng cách 2)

    sudo bash build.sh

**Cách 2: máy khác có Docker**

    docker run --rm --privileged -v "$PWD":/work -w /work debian:trixie bash build.sh

**Cách 3: GitHub Actions (không cần máy mạnh)**

Đẩy thư mục này lên một repo GitHub, vào tab *Actions* → *Build mayxcloudos ISO* → *Run workflow*.
ISO nằm ở mục *Artifacts* khi chạy xong.

**Build nhanh:** thêm `FAST=1` (nén zstd thay xz, nhanh hơn khoảng 15-25 phút, ISO to hơn ~15-20%):

    sudo FAST=1 bash build.sh

Trên GitHub Actions, ô *fast* được bật sẵn khi chạy thủ công. Bản phát hành chính thức nên tắt để ISO nhỏ hơn.

Kết quả: `out/mayxcloudos-amd64.hybrid.iso` và `out/SHA256SUMS`.

## Thử ISO

    qemu-system-x86_64 -enable-kvm -m 4G -smp 4 -cdrom out/mayxcloudos-amd64.hybrid.iso -boot d

Hoặc dùng VirtualBox/VMware (bật EFI, cấp 4 GB RAM trở lên). Có thể ghi ra USB bằng balenaEtcher hoặc `dd`.

- Tài khoản live: `may` / mật khẩu `live`
- Cài vào ổ cứng: mở **Install System** (Calamares) trong menu ứng dụng
- Bộ gõ tiếng Việt: Unikey (fcitx5), thêm trong *System Settings → Input Method*

## Cấu trúc

    auto/                      lệnh lb config / build / clean
    config/package-lists/      danh sách gói cài sẵn
    config/hooks/normal/       script chạy trong chroot khi build (i386, branding, binfmt)
    config/includes.chroot/    file chép thẳng vào hệ thống (wrapper, binfmt, hình nền, SDDM)
      usr/share/calamares/branding/mayxcloudos/   giao diện trình cài đặt (logo, slideshow, màu)
      usr/share/plasma/look-and-feel/org.mayxcloudos.desktop/   bố cục desktop (thanh tác vụ giữa, hình nền, nút Start logo)
      usr/share/plymouth/themes/mayxcloudos/      màn hình khởi động
      usr/share/icons/hicolor/*/apps/mayxcloudos.png   logo dùng cho nút Start và "About"
      usr/share/plymouth/themes/mayxcloudos/      màn hình khởi động (logo + thanh tiến độ)

## Giới hạn

Giống mọi hệ chạy Wine: game có anti-cheat kernel, driver Windows (`.sys`) và một số phần mềm
nặng (Adobe, Office mới) có thể không chạy. Mỗi app cần thử riêng.
