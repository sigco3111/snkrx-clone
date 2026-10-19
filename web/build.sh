#!/bin/bash
# web/build.sh — 웹 빌드: 패치 → .love 패키징 → love.js 변환 (web/build/site 출력)
set -euo pipefail
cd "$(dirname "$0")/.."
python3 web/patch_web.py
npx --yes love.js@11.4.1 web/build/game.love web/build/site -c -t 'SNKRX 한국어 웹' -m 268435456
# JS 에러 훅 삽입 (웹 부팅 실패 진단용 — wasm abort/JS 예외를 DOM에 표시)
python3 - <<'PY'
p = 'web/build/site/index.html'
s = open(p, encoding='utf-8').read()
hook = """<script>
window.addEventListener('error', function(e) {
  var d = document.createElement('pre');
  d.style.cssText = 'position:fixed;top:0;left:0;z-index:99999;background:#fff;color:#c00;font:12px monospace;padding:8px;white-space:pre-wrap;max-width:100vw';
  d.textContent = 'JS ERROR: ' + e.message + ' @ ' + (e.filename||'') + ':' + (e.lineno||'') + '\\n' + (e.error && e.error.stack || '');
  document.documentElement.appendChild(d);
});
window.addEventListener('unhandledrejection', function(e) {
  var d = document.createElement('pre');
  d.style.cssText = 'position:fixed;top:60px;left:0;z-index:99999;background:#fff;color:#c00;font:12px monospace;padding:8px;white-space:pre-wrap;max-width:100vw';
  d.textContent = 'PROMISE REJECTION: ' + (e.reason && (e.reason.stack || e.reason.message) || e.reason);
  document.documentElement.appendChild(d);
});
</script>"""
if '<head>' in s and 'JS ERROR' not in s:
    s = s.replace('<head>', '<head>\n' + hook, 1)
    open(p, 'w', encoding='utf-8').write(s)
PY
# 화면 비율/맞춤: 캔버스(960x540, 16:9)를 브라우저 크기에 맞춰 CSS로 확대/축소 (비율 유지)
python3 - <<'PY'
p = 'web/build/site/index.html'
s = open(p, encoding='utf-8').read()
fit = """<style>
body { overflow: hidden; }
h1 { margin: 6px 0; font-size: 20px; }
#canvas { width: min(100vw, calc((100vh - 70px) * 16 / 9)); height: auto; aspect-ratio: 16 / 9; margin: 0 auto; image-rendering: crisp-edges; image-rendering: pixelated; }
#loadingCanvas { width: min(100vw, calc((100vh - 70px) * 4 / 3)); height: auto; }
#canvas:fullscreen, #canvas:-webkit-full-screen { width: 100vw; height: 100vh; object-fit: contain; background: #000; }
</style>"""
if 'aspect-ratio: 16 / 9' not in s:
    s = s.replace('</head>', fit + '\n</head>', 1)
    open(p, 'w', encoding='utf-8').write(s)
PY
# 캐시 버스팅: Pages는 asset에 max-age=600을 강제 → 재배포 시 구버전 파일이 섞이는 문제 방지
python3 - <<'PY'
import time
ts = str(int(time.time()))
p = 'web/build/site/index.html'
s = open(p, encoding='utf-8').read()
s = s.replace('src="game.js"', 'src="game.js?v=' + ts + '"')
open(p, 'w', encoding='utf-8').write(s)
p = 'web/build/site/game.js'
s = open(p, encoding='utf-8').read()
s = s.replace("var REMOTE_PACKAGE_BASE = 'game.data';", "var REMOTE_PACKAGE_BASE = 'game.data?v=" + ts + "';")
open(p, 'w', encoding='utf-8').write(s)
print('cache-bust ts=' + ts)
PY
echo "Done: web/build/site"
ls -la web/build/site
