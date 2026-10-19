#!/usr/bin/env python3
# web/patch_web.py — SNKRX 웹(love.js) 빌드용 소스 패치 + .love 패키징
#
# 원본 코드는 건드리지 않고, 스테이징 복사본에 아래 최소 패치만 적용한다.
#   1. main.lua 맨 앞에 `web = true` (엔진의 기존 web 분기 활성화)
#   2. 옵션 메뉴의 창 크기/풀스크린/비디오 리셋 버튼을 웹에서 숨김
#   3. FPS 오버레이 추가 (성능 확인용, `if web` 가드)
#   4. engine/sound.lua: 웹에서 사운드 파일이 없으면 무음 더미 반환
#   5. conf.lua 창 크기 960x540 (16:9 비율 맞춤)
#   6. (HIDPI=1 일 때만) 옵션 C: 내부 캔버스 2배 해상도 + 한글 16px 래스터 (patch_hidpi)
#   7. 사운드(52MB)·데스크톱 런타임(engine/love)·개발 파일 제외하고 .love 패키징
import os, shutil, sys, zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HIDPI = os.environ.get('HIDPI') == '1'
_sfx = '_hidpi' if HIDPI else ''
STAGING = os.path.join(ROOT, 'web', 'build', 'staging' + _sfx)
OUT = os.path.join(ROOT, 'web', 'build', 'game' + _sfx + '.love')

EXCLUDE_DIRS = {'.git', 'builds', 'dist', 'web'}
EXCLUDE_PREFIXES = (os.path.join('engine', 'love'), os.path.join('assets', 'sounds'))
EXCLUDE_FILES = {'devlog.md', 'todo', '.ctrlp', '.gitignore', 'run.sh', 'build.sh', 'build_all.sh', 'build_love.sh'}

def fail(msg):
    print('PATCH FAILED: ' + msg); sys.exit(1)

def stage():
    if os.path.exists(STAGING): shutil.rmtree(STAGING)
    os.makedirs(STAGING)
    for dirpath, dirnames, filenames in os.walk(ROOT):
        rel = os.path.relpath(dirpath, ROOT)
        dirnames[:] = [d for d in dirnames if d not in EXCLUDE_DIRS or rel != '.']
        if rel == '.': dirnames[:] = [d for d in dirnames if d not in EXCLUDE_DIRS]
        for f in filenames:
            src = os.path.join(dirpath, f)
            r = os.path.relpath(src, ROOT)
            if any(r == p or r.startswith(p + os.sep) for p in EXCLUDE_PREFIXES): continue
            if f in EXCLUDE_FILES and os.path.dirname(r) == '': continue
            dst = os.path.join(STAGING, r)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            shutil.copy2(src, dst)

def patch_main():
    p = os.path.join(STAGING, 'main.lua')
    s = open(p, encoding='utf-8').read()
    # 1. web 플래그
    anchor = "require 'engine'"
    if anchor not in s: fail('main.lua: engine require not found')
    s = s.replace(anchor, "-- [web] love.js 웹 빌드 플래그 (엔진의 기존 web 분기 활성화)\nweb = true\n\n" + anchor, 1)
    # 2. 비디오 버튼 숨김
    a1 = "    self.video_button_1 = Button{group = self.ui, x = gw/2 - 136,"
    if a1 not in s: fail('main.lua: video_button_1 anchor not found')
    s = s.replace(a1, "    if not web then -- [web] 창 크기/풀스크린 버튼은 웹에서 숨김\n" + a1, 1)
    a2 = "      love.window.setMode(window_width, window_height)\n      system.save_state()  -- v0.1.20\n    end}"
    if a2 not in s: fail('main.lua: video_button_4 end anchor not found')
    s = s.replace(a2, a2 + "\n    end -- [web] if not web", 1)
    # 3. FPS 오버레이
    s += """
-- [web] FPS 오버레이 (웹 성능 확인용)
if web then
  local _draw_web = draw
  function draw()
    _draw_web()
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.print(tostring(love.timer.getFPS()) .. ' fps', 6, 6)
    love.graphics.setColor(1, 1, 1, 1)
  end
end
"""
    open(p, 'w', encoding='utf-8').write(s)

def patch_sound():
    p = os.path.join(STAGING, 'engine', 'sound.lua')
    open(p, 'w', encoding='utf-8').write('''-- [web] 웹 빌드에서는 사운드 파일을 제외하고 무음 더미로 대체한다 (로딩 경량화).
local function web_dummy_sound()
  -- volume/pitch는 수치 필드로 둔다: 메뉴 진입 시 main_song_instance 대상
  -- trigger:tween(..., {volume = 0.5, pitch = 1})이 초기값을 읽기 때문.
  local instance = setmetatable({volume = 0.5, pitch = 1}, {__index = function() return function() return nil end end})
  return setmetatable({volume = 0.5, pitch = 1}, {__index = function(_, k)
    if k == 'play' then return function() return instance end end
    return function() return nil end
  end})
end

Sound = function(asset_name, options)
  local path = 'assets/sounds/' .. asset_name
  if web and not love.filesystem.getInfo(path) then return web_dummy_sound() end
  return ripple.newSound(love.audio.newSource(path, 'static'), options)
end
SoundTag = ripple.newTag
Effect = love.audio.setEffect
''')


def patch_group():
    # engine/game/group.lua: goto/::continue:: 는 LuaJIT 전용 — love.js 호환 모드(PUC Lua 5.1)에서 문법 오류.
    p = os.path.join(STAGING, 'engine', 'game', 'group.lua')
    s = open(p, encoding='utf-8').read()
    old = """    if tostring(cx) == tostring(0/0) or tostring(cy) == tostring(0/0) then goto continue end
    if not self.cells[cx] then self.cells[cx] = {} end
    if not self.cells[cx][cy] then self.cells[cx][cy] = {} end
    table.insert(self.cells[cx][cy], object)
    ::continue::"""
    new = """    -- [web] PUC Lua 5.1에는 goto가 없어 조건 반전으로 대체
    if not (tostring(cx) == tostring(0/0) or tostring(cy) == tostring(0/0)) then
      if not self.cells[cx] then self.cells[cx] = {} end
      if not self.cells[cx][cy] then self.cells[cx][cy] = {} end
      table.insert(self.cells[cx][cy], object)
    end"""
    if old not in s: fail('group.lua: goto continue block not found')
    open(p, 'w', encoding='utf-8').write(s.replace(old, new, 1))


def patch_trigger():
    # trigger.lua tween: 초기값/목표값이 숫자가 아니면 건너뛴다.
    # (웹 무음 더미처럼 수치가 아닌 필드가 섞일 때 lerp 크래시 방지; 데스크톱 동작과 동일)
    p = os.path.join(STAGING, 'engine', 'game', 'trigger.lua')
    s = open(p, encoding='utf-8').read()
    old = """      for k, v in pairs(trigger.source) do
        trigger.target[k] = math.lerp(t, trigger.initial_values[k], v)
      end"""
    new = """      for k, v in pairs(trigger.source) do
        -- [web] 숫자가 아닌 값은 트윈 불가 → 건너뜀
        local iv = trigger.initial_values[k]
        if type(iv) == 'number' and type(v) == 'number' then
          trigger.target[k] = math.lerp(t, iv, v)
        end
      end"""
    if old not in s: fail('trigger.lua: tween update block not found')
    open(p, 'w', encoding='utf-8').write(s.replace(old, new, 1))


def patch_system():
    # engine/system.lua: love.js는 love.filesystem.load/write 경로에서 메인 스레드가 멈추는
    # 문제가 있어 웹에서는 세이브/로드를 비활성화한다 (새로고침 시 진행 초기화, caveat로 명시).
    p = os.path.join(STAGING, 'engine', 'system.lua')
    s = open(p, encoding='utf-8').read()
    a = "function system.save_state()"
    if a not in s: fail('system.lua: save_state not found')
    s = s.replace(a, a + "\n  if web then return end -- [web] love.js FS 행 방지", 1)
    a = "function system.load_state()"
    if a not in s: fail('system.lua: load_state not found')
    s = s.replace(a, a + "\n  if web then state = state or {} return end -- [web] love.js FS 행 방지", 1)
    a = "function system.save_run(level, loop, gold, units, passives, shop_level, shop_xp, run_passive_pool, locked_state)"
    if a not in s: fail('system.lua: save_run not found')
    s = s.replace(a, a + "\n  if web then return end -- [web] love.js FS 행 방지", 1)
    a = "function system.load_run()"
    if a not in s: fail('system.lua: load_run not found')
    s = s.replace(a, a + "\n  if web then return {} end -- [web] love.js FS 행 방지", 1)
    open(p, 'w', encoding='utf-8').write(s)

def patch_conf():
    # conf.lua: 웹에서는 엔진이 sx=2, ww/wh=960x540 고정으로 그린다(engine/init.lua web 분기).
    # 그런데 conf 창 크기가 1280x720이라 캔버스가 더 크게 잡혀 왼쪽 위에 960x540만 그려졌다.
    # → 캔버스를 960x540(16:9, 게임 해상도 480x270의 정수 2배)으로 맞추고 리사이즈를 끈다.
    #   화면 맞춤 확대는 CSS가 담당(build.sh): 마우스 좌표는 Emscripten이 CSS 배율을 보정한다.
    p = os.path.join(STAGING, 'conf.lua')
    s = open(p, encoding='utf-8').read()
    for old, new in (('t.window.width = 1280', 't.window.width = 960'),
                     ('t.window.height = 720', 't.window.height = 540'),
                     ('t.window.resizable = true', 't.window.resizable = false')):
        if old not in s: fail('conf.lua: ' + old + ' not found')
        s = s.replace(old, new, 1)
    open(p, 'w', encoding='utf-8').write(s)

def _sub(path, old, new, count=1):
    p = os.path.join(STAGING, path)
    s = open(p, encoding='utf-8').read()
    if s.count(old) < count: fail(path + ': anchor not found: ' + old[:60])
    open(p, 'w', encoding='utf-8').write(s.replace(old, new))

def patch_hidpi():
    # 옵션 C: 게임 로직/레이아웃은 480x270(8px 폰트) 기준 그대로 두고,
    # 오프스크린 캔버스만 HD(=2)배 해상도로 렌더링한다. 한글은 16px 폰트를 0.5배로 그려 16px로 래스터.
    #  - 캔버스: HD배 크기로 생성, draw_to 안에서 scale(HD) → 모든 그리기 좌표는 기존 그대로
    #  - Canvas:draw/draw2: 출력 배율 /HD (최종 화면 960x540 = sx(2)/HD * 960)
    #  - 폰트: 측정(getWidth/getHeight)은 8px 폰트 그대로 → 버튼/정렬/물리/마우스(mx/sx) 불변
    #  - 셰이더(shadow/combine/replace/displacement)는 tc 기반이라 해상도 무관
    _sub('main.lua', 'web = true\n', 'web = true\nHD = 2 -- [web] hidpi 내부 렌더 배율\n')
    cv = 'engine/graphics/canvas.lua'
    _sub(cv, 'love.graphics.newCanvas(self.w, self.h,', 'love.graphics.newCanvas(self.w*(HD or 1), self.h*(HD or 1),')
    _sub(cv, 'love.graphics.draw(self.canvas, x or 0, y or 0, r or 0, sx or 1, sy or 1, ox or 0, oy or 0)',
         'love.graphics.draw(self.canvas, x or 0, y or 0, r or 0, (sx or 1)/(HD or 1), (sy or 1)/(HD or 1), (ox or 0)*(HD or 1), (oy or 0)*(HD or 1))', count=2)
    _sub(cv, '  action()\n  love.graphics.setCanvas()',
         '  love.graphics.push()\n  love.graphics.origin()\n  love.graphics.scale(HD or 1, HD or 1)\n  action()\n  love.graphics.pop()\n  love.graphics.setCanvas()')
    _sub('engine/graphics/font.lua', 'function Font:get_font_for_text(text)', """function Font:get_draw_font(text)
  local f = self:get_font_for_text(text)
  if HD and HD > 1 and f ~= self.font then
    if not self.ko_font_hd then
      self.ko_font_hd = love.graphics.newFont("assets/fonts/NotoSansKR-Regular.ttf", self.size*HD)
    end
    return self.ko_font_hd, HD
  end
  return f, 1
end


function Font:get_font_for_text(text)""")
    _sub('engine/graphics/text.lua',
         'love.graphics.print(c.character, active_font, x + c.x - self.w/2, y + c.y - self.h/2, c.r or 0, c.sx or 1, c.sy or c.sx or 1, c.ox or 0, c.oy or 0)',
         """local draw_font, k = active_font, 1
      if line.font.get_draw_font then draw_font, k = line.font:get_draw_font(c.character) end
      love.graphics.print(c.character, draw_font, x + c.x - self.w/2, y + c.y - self.h/2, c.r or 0, (c.sx or 1)/k, (c.sy or c.sx or 1)/k, (c.ox or 0)*k, (c.oy or 0)*k)""")
    g = 'engine/graphics/graphics.lua'
    _sub(g, 'love.graphics.print(text, active_font, x, y, r or 0, sx or 1, sy or 1, ox or 0, oy or 0)',
         """local draw_font, k = active_font, 1
  if font.get_draw_font then draw_font, k = font:get_draw_font(text) end
  love.graphics.print(text, draw_font, x, y, r or 0, (sx or 1)/k, (sy or 1)/k, (ox or 0)*k, (oy or 0)*k)""")
    _sub(g, 'love.graphics.print(text, active_font, x, y, r or 0, sx or 1, sy or 1, (ox or 0) + active_w/2, (oy or 0) + active_h/2)',
         """local draw_font, k = active_font, 1
  if font.get_draw_font then draw_font, k = font:get_draw_font(text) end
  love.graphics.print(text, draw_font, x, y, r or 0, (sx or 1)/k, (sy or 1)/k, ((ox or 0) + active_w/2)*k, ((oy or 0) + active_h/2)*k)""")

def _re(path, pattern, repl, min_count=1):
    import re
    p = os.path.join(STAGING, path)
    s = open(p, encoding='utf-8').read()
    s2, n = re.subn(pattern, lambda m: m.expand(repl), s)
    if n < min_count: fail('%s: pattern matched %d (<%d): %s' % (path, n, min_count, pattern[:60]))
    open(p, 'w', encoding='utf-8').write(s2)
    print('i18n %s: %d x %s' % (path, n, pattern[:40]))

def patch_i18n():
    # 구매/아레나 화면에서 T() 없이 영어로 하드코딩된 UI 문자열을 스테이징 복사본에서만 T() 호출로 치환한다.
    # (원본 코드 불변. 키가 없으면 T()가 영어 default를 그대로 표시하므로 안전)
    # ko.lua에 새 키 추가
    p = os.path.join(STAGING, 'lang', 'ko.lua')
    s = open(p, encoding='utf-8').read()
    i = s.rstrip().rfind('}')
    extra = """
  -- ===== [web] 추가 번역 키 (patch_i18n) =====
  lock_label        = '잠금',
  unlock_label      = '해제',
  level_word        = '레벨',
  gold_word         = '골드',
  k_gold_gained     = '획득 골드',
  k_interest        = '이자',
  k_total           = '합계',
  arena_clear       = '아레나 클리어!',
  you_died          = '죽었습니다...',
"""
    open(p, 'w', encoding='utf-8').write(s[:i] + extra + s[i:])
    B, A = 'buy_screen.lua', 'arena.lua'
    # 상점/골드/파티 (구매 후 set_text 경로)
    _re(B, r"'\[wavy_mid, fg\]shop \[fg\]- \[fg, nudge_down\]gold: \[yellow, nudge_down\]'",
        "'[wavy_mid, fg]' .. T('shop_label', 'shop') .. ' [fg]- ' .. T('gold_label', '[fg, nudge_down]gold: [yellow, nudge_down]')", 5)
    _re(B, r"\{text = '\[fg, nudge_down\]gold: \[yellow, nudge_down\]'",
        "{text = T('gold_label', '[fg, nudge_down]gold: [yellow, nudge_down]')")
    _re(B, r"'\[wavy_mid, fg\]party '", "'[wavy_mid, fg]' .. T('party_label', 'party') .. ' '", 2)
    # 리롤 / 잠금
    _re(B, r"'\[(fgm5|bg10)\]reroll: ", "'[\\1]' .. T('reroll', 'reroll') .. ': ", 6)
    _re(B, r"tostring\(self\.parent\.locked and 'unlock' or 'lock'\)",
        "tostring(self.parent.locked and T('unlock_label', 'unlock') or T('lock_label', 'lock'))", 4)
    # 재시작/레벨/가이드
    for f in (B, A):
        _re(f, r"\]restarting\.\.\.'", "]' .. T('restarting', 'restarting...')")
    _re(B, r"\]level ' \.\.", "]' .. T('level_word', 'level') .. ' ' ..")
    _re(B, r"'\[fg\]guide'", "'[fg]' .. T('guide_btn', 'guide')")
    # 스팀 홍보 문구
    _re(B, r"'\[(greenm5|fgm5)\]follow me on steam!'", "'[\\1]' .. T('follow_steam', 'follow me on steam!')", 0)
    _re(B, r"'\[(bg10|fgm5)\]w to wishlist'", "'[\\1]' .. T('wishlist_press', 'w to wishlist')", 0)
    _re(B, r"'\[(bg10|fgm5)\]wishlist on steam'", "'[\\1]' .. T('wishlist_steam', 'wishlist on steam')", 0)
    # 아레나
    _re(A, r"'\[light_bg\]turn left\s+turn right'", "'[light_bg]' .. T('controls_turn', 'turn left                                      turn right')")
    _re(A, r"'\[wavy_mid, cbyc\]arena clear!'", "'[wavy_mid, cbyc]' .. T('arena_clear', 'arena clear!')")
    _re(A, r"'\[wavy_mid, fg\]gold: \[yellow\]'", "'[wavy_mid, fg]' .. T('gold_word', 'gold') .. ': [yellow]'")
    _re(A, r"'\[fg, wavy\]choose one'", "T('choose_one', '[fg, wavy]choose one')")
    _re(A, r"'\[wavy_mid, cbyc\]you died\.\.\.'", "'[wavy_mid, cbyc]' .. T('you_died', 'you died...')")
    _re(A, r"\]gold gained: ", "]' .. T('k_gold_gained', 'gold gained') .. ': ", 4)
    _re(A, r"\]interest: ", "]' .. T('k_interest', 'interest') .. ': ", 4)
    _re(A, r"\]total: ", "]' .. T('k_total', 'total') .. ': ", 4)

def package():
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    if os.path.exists(OUT): os.remove(OUT)
    with zipfile.ZipFile(OUT, 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as z:
        for dirpath, _, filenames in os.walk(STAGING):
            for f in filenames:
                fp = os.path.join(dirpath, f)
                z.write(fp, os.path.relpath(fp, STAGING))
    print('Built %s (%.1f MB)' % (OUT, os.path.getsize(OUT)/1e6))

if __name__ == '__main__':
    stage(); patch_main(); patch_sound(); patch_group(); patch_trigger(); patch_system(); patch_conf()
    patch_i18n()
    if HIDPI: patch_hidpi()
    package()
