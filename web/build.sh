#!/bin/bash
# web/build.sh — 웹 빌드: 패치 → .love 패키징 → love.js 변환 (web/build/site 출력)
set -euo pipefail
cd "$(dirname "$0")/.."
python3 web/patch_web.py
npx --yes love.js@11.4.1 web/build/game.love web/build/site -c -t 'SNKRX 한국어 웹' -m 67108864
echo "Done: web/build/site"
ls -la web/build/site
