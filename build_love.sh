#!/bin/bash
# build_love.sh — 프로젝트 폴더를 .love 파일로 패키징
# 사용법: ./build_love.sh
# 출력: dist/snkrx-kr-v0.1.12.love

set -e

VERSION="${VERSION:-v0.1.12}"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIST_DIR="$PROJECT_DIR/dist"
OUTPUT="$DIST_DIR/snkrx-kr-$VERSION.love"

mkdir -p "$DIST_DIR"

# 프로젝트 폴더 내용을 zip으로 묶고 확장자 .love로 변경
# .love는 표준 zip 포맷 (love2d가 직접 실행)
# 단, .git과 같은 불필요 파일은 제외

cd "$PROJECT_DIR"

# macOS의 __MACOSX 폴더는 zip에 포함되지 않게 함
# .git, .DS_Store, dist 폴더 제외
zip -r "$OUTPUT" . \
  -x "*.git*" \
  -x "*.DS_Store" \
  -x "dist/*" \
  -x "*.love" \
  -q

echo "✅ Built: $OUTPUT"
echo "📦 Size: $(du -h "$OUTPUT" | cut -f1)"
echo ""
echo "테스트 실행:"
echo "  macOS:   /Applications/love.app/Contents/MacOS/love $OUTPUT"
echo "  Linux:   love $OUTPUT"
echo "  Windows: love.exe $OUTPUT"
