# SNKRX 한국어화 fork

> 🎮 **SNKRX**의 한국어 + UI 개선 + Steam 비의존 fork

[SNKRX](https://store.steampowered.com/app/915310/SNKRX/)는 영웅들이 자동으로 공격하는 뱀(snake)을 조종하는 아케이트 슈터 로그라이크입니다. 이 fork는 한국어 환경에 맞게 UI를 번역하고, Steam 클라이언트 없이도 플레이 가능하도록 만들었습니다.

![screenshot](https://raw.githubusercontent.com/sigco3111/snkrx-clone/main/assets/images/icon.png)

## 원본 정보

- **원본 저장소**: [a327ex/SNKRX](https://github.com/a327ex/SNKRX)
- **원본 라이선스**: MIT (코드), 자산별 별도 (게임 내 크레딧 참조)
- **Steam**: [SNKRX on Steam](https://store.steampowered.com/app/915310/SNKRX/)

## 이 fork의 주요 변경점

### 1. 🇰🇷 한국어 UI (모드팩 패턴)
- 메인 메뉴, 상점, 튜토리얼 한글화
- `lang/ko.lua` 한국어 번역 테이블 (한 줄 추가로 ja/zh 등 추가 가능)
- `T(key, default)` 함수로 안전 fallback

### 2. 🔤 CJK 폰트 자동 fallback
- 한글/일본어/중국어 자동 감지 → Noto Sans KR로 렌더링
- 비트 단위가 아닌 UTF-8 캐릭터 단위 처리 (원본의 한글 깨짐 버그 동시 수정)

### 3. 🚫 Steam 비의존
- `engine/external/luasteam.lua` shim으로 Steamworks SDK 없이도 게임플레이 가능
- Steam 업적/친구/RichPresence 모두 no-op 처리
- Steam 클라이언트 미설치 환경에서도 정상 동작

### 4. 🖥️ 큰 창 + 비례 확대 UI
- 1280x720 윈도우 + sx/sy=2.67 비례 확대
- Retina DPI 스케일링 비활성화로 작은 창 함정 회피
- `resizable=true`로 사용자 직접 크기 조절 가능

자세한 변경 이력은 [`MODIFIED.md`](./MODIFIED.md) 참조.

## 실행 방법

### 필요 환경
- macOS (또는 Linux/Windows)
- [LÖVE 11.x](https://love2d.org/) — Lua 5.1 기반 2D 게임 엔진

### 설치

```bash
# macOS — brew로 LÖVE 설치 (Gatekeeper 해제 필요)
brew install --cask love
xattr -dr com.apple.quarantine /Applications/love.app

# 프로젝트 디렉토리에서 실행
cd /Users/mac/work/snkrx-clone
love .
```

### 첫 실행
1. 메인 메뉴에 **"아레나 런" / "옵션" / "종료"** 버튼이 한국어로 표시됩니다
2. **"아레나 런"** 클릭 → 상점 화면 (상점/파티/클래스/아이템 탭, 골드 표시 모두 한글)
3. **"?" 버튼** 클릭 → 튜토리얼 (WELCOME TO SNKRX! 등 한글)

### 조작
- **A/D** 또는 **←/→** — 뱀 좌/우 조종
- **Space** — 일시정지
- **마우스 클릭** — 유닛 구매/판매, 아이템 사용
- **창 크기 조절** — 창 모서리 드래그 (resizable)

## 파일 구조

```
snkrx-clone/
├── main.lua              # 엔트리포인트 + love.run (1280x720 설정)
├── conf.lua              # love.conf (DPI 스케일링 비활성화)
├── mainmenu.lua          # 메인 메뉴 (T() 한국어 적용)
├── buy_screen.lua        # 상점 화면 (T() 한국어 적용)
├── arena.lua             # 전투 화면
├── player.lua            # 플레이어/영웅
├── enemies.lua           # 적
├── objects.lua           # 게임 오브젝트
├── shared.lua            # 공유 함수 + T() + lang 모듈
├── media.lua             # 크레딧 화면
│
├── lang/                 # ★ 모드팩 (한국어 번역)
│   └── ko.lua
│
├── engine/               # 자체 엔진 (fork에서 CJK 지원 추가)
│   ├── graphics/
│   │   ├── font.lua      # ★ Font:has_cjk, get_font_for_text 추가
│   │   ├── text.lua      # ★ UTF-8 character 단위 파싱 + CJK 너비
│   │   └── graphics.lua  # ★ CJK 폰트 자동 선택
│   ├── math/
│   ├── map/
│   ├── game/
│   ├── external/
│   │   ├── init.lua      # ★ luasteam shim 경로
│   │   └── luasteam.lua  # ★ Steam shim (no-op)
│   └── ...
│
├── assets/
│   ├── fonts/
│   │   ├── FatPixelFont.ttf
│   │   ├── PixulBrush.ttf
│   │   └── NotoSansKR-Regular.ttf  # ★ 한글 폰트 fallback
│   ├── images/           # 스프라이트 (원본 자산, 라이선스 게임 내 크레딧)
│   └── ...
│
├── MODIFIED.md           # 변경 이력 (라이선스 의무)
├── README.md             # 이 파일
└── LICENSE               # 원본 MIT 라이선스
```

## 라이선스

- **코드**: 원본과 동일하게 MIT 라이선스 적용
- **자산** (스프라이트, 사운드): 각 자산별 라이선스는 게임 내 크레딧 화면 참조 — 본 fork에서 변경하지 않음
- **Noto Sans KR**: SIL Open Font License 1.1

## 기여/향후 계획

- [ ] v0.2 — 새 영웅/클래스/시너지 추가
- [ ] v0.3 — 신 게임 모드 (보스 레이드, 데일리 챌린지)
- [ ] v0.4 — 풀 자동위임 (sango 결정 큐 패턴)

이슈/PR 환영합니다.

## 크레딧

- **원본 개발**: [adn (a327ex)](https://github.com/a327ex)
- **사운드 라이브러리**: Blue Fairy, InspectorJ, Phil Blank, Yongmin Park, Jofer, Vlad, Ge0force, David Khachaturov, DefineDoddy
- **한글 폰트**: [Noto Sans KR (Google Fonts)](https://fonts.google.com/noto/specimen/Noto+Sans+KR)
- **한국어화 + fork**: [sigco3111](https://github.com/sigco3111)