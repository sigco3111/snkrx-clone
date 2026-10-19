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
echo "Done: web/build/site"
ls -la web/build/site
