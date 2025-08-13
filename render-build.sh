#!/usr/bin/env bash
set -e

# 1) Install Flutter SDK
FLUTTER_VERSION=3.24.3
curl -L -o flutter.tar.xz "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
tar xf flutter.tar.xz
export PATH="$PWD/flutter/bin:$PATH"

# 2) Enable web support & get packages
flutter config --enable-web
flutter pub get

# 3) Build the web app in release mode
flutter build web --release
