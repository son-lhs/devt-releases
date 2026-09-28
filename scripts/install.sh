#!/bin/bash
# Cài devt CLI vào /usr/local/bin trên macOS/Linux.
# Dùng: curl -fsSL https://your-domain/install.sh | bash
set -e

REPO="son-lhs/devt-releases"  # Repo PUBLIC chỉ chứa file cài đặt — source code nằm ở repo private khác
INSTALL_DIR="/usr/local/bin"
BIN_NAME="devt"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo "❌ Kiến trúc chưa hỗ trợ: $ARCH"; exit 1 ;;
esac

ASSET="devt-${OS}-${ARCH}"
URL="https://github.com/${REPO}/releases/latest/download/${ASSET}"

echo "📦 Đang tải $ASSET..."
TMP=$(mktemp)
curl -fsSL "$URL" -o "$TMP"
chmod +x "$TMP"

echo "📂 Cài vào ${INSTALL_DIR}/${BIN_NAME} (cần quyền sudo)..."
sudo mv "$TMP" "${INSTALL_DIR}/${BIN_NAME}"

echo "✅ Đã cài xong. Kiểm tra: devt version"
"${INSTALL_DIR}/${BIN_NAME}" version
