#!/bin/bash
# build_all.sh — 3개 플랫폼 모두 빌드
# 출력: dist/snkrx-kr-{macos,windows,linux}-v0.1.12.{zip,tar.gz}

set -e

VERSION="${VERSION:-v0.1.12}"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIST_DIR="$PROJECT_DIR/dist"
LOVE_OUTPUT="$DIST_DIR/snkrx-kr-$VERSION.love"

echo "=== SNKRX 한국어화 fork 빌드 ($VERSION) ==="
echo

# 1. .love 파일 빌드
if [ ! -f "$LOVE_OUTPUT" ] || [ -n "$REBUILD" ]; then
    echo "1/3 .love 파일 빌드..."
    "$PROJECT_DIR/build_love.sh"
else
    echo "1/3 .love 파일 (이미 존재): $LOVE_OUTPUT"
fi
echo

# 2. macOS .app 번들
echo "2/3 macOS .app 번들 빌드..."
"$DIST_DIR/macosx/build_macos.sh"
cd "$DIST_DIR"
rm -f snkrx-kr-macos-$VERSION.zip
zip -r "snkrx-kr-macos-$VERSION.zip" "SNKRX-한국어.app" -q
echo "✅ macOS: snkrx-kr-macos-$VERSION.zip"
echo

# 3. Windows zip
echo "3a/3 Windows zip 빌드..."
WINDOWS_DIR="$DIST_DIR/windows"
if [ ! -f "$WINDOWS_DIR/love.exe" ]; then
    echo "  love2d Windows 다운로드..."
    curl -L -o "$WINDOWS_DIR/love.zip" "https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.zip" 2>&1 | tail -1
    (cd "$WINDOWS_DIR" && unzip -q -o love.zip)
    rm "$WINDOWS_DIR/love.zip"
fi
cp "$LOVE_OUTPUT" "$WINDOWS_DIR/"
rm -f "$DIST_DIR/snkrx-kr-windows-$VERSION.zip"
(cd "$WINDOWS_DIR" && zip -r "$DIST_DIR/snkrx-kr-windows-$VERSION.zip" love-11.5-win64/ -q)
echo "✅ Windows: snkrx-kr-windows-$VERSION.zip"
echo

# 4. Linux tar.gz
echo "3b/3 Linux tar.gz 빌드..."
LINUX_DIR="$DIST_DIR/linux"
if [ ! -f "$LINUX_DIR/love.AppImage" ]; then
    echo "  love2d AppImage 다운로드..."
    curl -L -o "$LINUX_DIR/love.AppImage" "https://github.com/love2d/love/releases/download/11.5/love-11.5-x86_64.AppImage" 2>&1 | tail -1
    chmod +x "$LINUX_DIR/love.AppImage"
fi
cp "$LOVE_OUTPUT" "$LINUX_DIR/"
rm -f "$DIST_DIR/snkrx-kr-linux-$VERSION.tar.gz"
(cd "$LINUX_DIR" && tar czf "$DIST_DIR/snkrx-kr-linux-$VERSION.tar.gz" love.AppImage "snkrx-kr-$VERSION.love" run.sh README.txt)
echo "✅ Linux: snkrx-kr-linux-$VERSION.tar.gz"
echo

echo "=== 모든 빌드 완료 ==="
cd "$DIST_DIR"
ls -lh snkrx-kr-*.$VERSION.* 2>/dev/null || ls -lh snkrx-kr-*.zip snkrx-kr-*.tar.gz
