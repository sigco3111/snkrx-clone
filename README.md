# SNKRX 한국어화 fork

> 🎮 **SNKRX**의 한국어 + UI 개선 + Steam 비의존 fork
>
> **한글화 v0.1.12 완료** — 13개 영역 한글화 + 적 이름 표면 표시 (새 기능)

[SNKRX](https://store.steampowered.com/app/915310/SNKRX/)는 영웅들이 자동으로 공격하는 뱀(snake)을 조종하는 아케이트 슈터 로그라이크입니다. 이 fork는 한국어 환경에 맞게 UI를 번역하고, Steam 클라이언트 없이도 플레이 가능하도록 만들었습니다.

## 📦 다운로드 (v0.1.12)

**[GitHub Releases 페이지에서 다운로드](https://github.com/sigco3111/snkrx-clone/releases/tag/v0.1.12)**

| 플랫폼 | 파일 | 크기 | 설치 |
|---|---|---|---|
| **macOS** | `snkrx-kr-macos-v0.1.12.zip` | 86M | 압축 해제 → `SNKRX-한국어.app`을 Applications로 드래그 |
| **Windows** | `snkrx-kr-windows-v0.1.12.zip` | 4.3M | 압축 해제 → `love-11.5-win64/run.bat` 더블클릭 |
| **Linux** | `snkrx-kr-linux-v0.1.12.tar.gz` | 65M | 압축 해제 → `./run.sh` 실행 |
| **크로스 플랫폼** | `snkrx-kr-v0.1.12.love` | 62M | love2d 설치 후 `love snkrx-kr-v0.1.12.love` |

### 직접 실행 (소스 코드)

```bash
git clone https://github.com/sigco3111/snkrx-clone.git
cd snkrx-clone
love .  # 또는 brew install --cask love 후 love .
```

## 🎬 게임 영상

https://user-images.githubusercontent.com/409773/119258159-ea982b00-bb9e-11eb-8082-37e2c65591ea.mp4

([원본 a327ex/SNKRX README](https://github.com/a327ex/SNKRX)에서 동일한 영상 사용)

## ✨ 한글화 (v0.1.12)

**완전히 한글화된 영역** (13개):

| # | 영역 | 예시 |
|---|---|---|
| 1 | 메인 메뉴 (5버튼) | 아레나 런, 옵션, 종료, 사운드트랙 구매, 디스코드 |
| 2 | 상점 탭 4종 | 상점, 파티, 클래스, 아이템 |
| 3 | 튜토리얼 9줄 | SNKRX에 오신 걸 환영합니다! |
| 4 | 옵션 메뉴 전체 | 창 크기 +/-, 전체화면, 음악/효과음 볼륨, 화면 흔들림, 뱀 쿨다운, 뱀 화살표, 화면 이동 |
| 5 | 일시정지 화면 | 컨트롤 안내 |
| 6 | NG+ 라벨 | 런 계속하기, 새 런 |
| 7 | Arena 승리/패배/엔딩 | 축하합니다!, 게임 오버, credits |
| 8 | 안내 메시지 | 골드 부족, 최대 유닛 초과, 최대 레벨 도달 |
| 9 | **Hover: 영웅 (5영역)** | 이름 / 클래스 / 비용 / 설명 / Lv.3 효과 — 모든 항목 한글화 |
| 10 | **Hover: 클래스** | 16개 클래스 패시브 설명 한글화 |
| 11 | **Hover: 패시브 (84개)** | 이름 / 짧은 설명 / 레벨별 설명 — 자동 번역 |
| 12 | **Hover: 상점 레벨** | 상점 확률 / 현재-다음 상점 / 등급 |
| 13 | **새 기능: 적 이름 표시** | 잡몹 / 추적자 / 보스 라벨이 HP바 위에 표시 |

## 🔧 기술적 개선

- **CJK 폰트 자동 fallback**: Noto Sans KR-Regular.ttf 임베드. 한글/일본어/중국어 감지 시 자동 적용.
- **UTF-8 character 단위 파싱**: 원본 byte 단위 파싱 버그 동시 수정.
- **Steam 비의존 실행**: `engine/external/luasteam.lua` shim 추가. Steam 클라이언트 없이도 게임플레이 가능.
- **큰 창 + 비례 확대 UI**: 1280x720 윈도우 + sx/sy=2.67 비례 확대. 원본 960x540의 1.78배 큰 UI.
- **DPI 스케일링 비활성화**: `usedpiscale=false`로 Retina에서 자동 축소 회피.
- **풀스크린 함정 회피**: state.sx/sy 분기 단순화 + `fullscreen=false` 명시.

## 🚀 실행 방법

```bash
# macOS — LÖVE 설치
brew install --cask love
xattr -dr com.apple.quarantine /Applications/love.app

# 프로젝트 디렉토리에서 실행
cd /Users/mac/work/snkrx-clone
love .
```

### 첫 실행
1. 메인 메뉴에 "아레나 런", "옵션", "종료" 등 한글 표시
2. "아레나 런" 클릭 → 상점 화면 (상점/파티/클래스/아이템 탭, 골드 표시 모두 한글)
3. "?" 버튼 → 튜토리얼 (WELCOME TO SNKRX! 등 한글)

### 조작
- **A/D** 또는 **←/→** — 뱀 좌/우 조종
- **Space** — 일시정지
- **마우스 클릭** — 유닛 구매/판매, 아이템 사용
- **창 크기 조절** — 창 모서리 드래그 (resizable)

## 📁 프로젝트 구조

```
snkrx-clone/
├── main.lua              # 엔트리포인트 + love.run (1280x720 설정)
├── conf.lua              # love.conf (DPI 스케일링 비활성화)
├── mainmenu.lua          # 메인 메뉴
├── buy_screen.lua        # 상점 화면 (영웅/패시브 hover 한글)
├── arena.lua             # 전투 화면 (승리/패배 한글)
├── player.lua            # 플레이어/영웅
├── enemies.lua           # 적 (v0.1.11: 이름 라벨 추가)
├── objects.lua           # 게임 오브젝트
├── shared.lua            # 공유 함수 + T() + lang 모듈
├── media.lua             # 크레딧 화면
│
├── lang/                 # ★ 한글화 모듈 (6개)
│   ├── ko.lua                          # 메인 한글 사전 (130+ 키)
│   ├── character_descriptions_ko.lua   # 영웅 설명 57개
│   ├── character_effect_descriptions_ko.lua  # Lv.3 효과 설명 57개
│   ├── class_descriptions_ko.lua       # 클래스 패시브 16개
│   ├── passive_names_ko.lua            # 패시브 이름 + 짧은 설명 84개
│   └── passive_descriptions_level_ko.lua  # 패시브 레벨별 설명 84개
│
├── engine/               # 자체 엔진 (CJK 지원 패치)
│   ├── graphics/
│   │   ├── font.lua      # ★ Font:has_cjk, get_font_for_text
│   │   ├── text.lua      # ★ UTF-8 character 단위 파싱
│   │   └── graphics.lua  # ★ CJK 폰트 자동 선택
│   └── external/
│       ├── init.lua      # luasteam shim 경로
│       └── luasteam.lua  # ★ Steam shim (no-op)
│
├── assets/
│   ├── fonts/
│   │   ├── FatPixelFont.ttf
│   │   ├── PixulBrush.ttf
│   │   └── NotoSansKR-Regular.ttf  # ★ 한글 폰트
│   └── images/           # 스프라이트 (원본 자산)
│
├── MODIFIED.md           # 변경 이력 (라이선스 의무)
├── README.md             # 이 파일
└── LICENSE               # 원본 MIT 라이선스
```

## 📊 버전 통계 (v0.1 ~ v0.1.12)

| 메트릭 | 값 |
|---|---|
| **커밋 수** | 12개 |
| **한국어 키 (lang/ko.lua)** | 130+ 개 |
| **한국어 데이터 모듈** | 6개 |
| **한글화 영역** | 13개 카테고리 |
| **자동 번역** | 패시브 84개 (단어 매핑 기반) |
| **수동 번역** | 메뉴/옵션/UI/메시지 (단일 키 단위) |

## 📜 라이선스

- **코드**: 원본과 동일하게 MIT 라이선스
- **자산** (스프라이트, 사운드): 각 자산별 라이선스는 게임 내 크레딧 화면 참조
- **Noto Sans KR**: SIL Open Font License 1.1

## 🙏 크레딧

- **원본 개발**: [adn (a327ex)](https://github.com/a327ex)
- **사운드 라이브러리**: Blue Fairy, InspectorJ, Phil Blank, Yongmin Park, Jofer, Vlad, Ge0force, David Khachaturov, DefineDoddy
- **한글 폰트**: [Noto Sans KR (Google Fonts)](https://fonts.google.com/noto/specimen/Noto+Sans+KR)
- **한국어화 + fork**: [sigco3111](https://github.com/sigco3111)

## 📝 자세한 변경 이력

[`MODIFIED.md`](./MODIFIED.md) 참조. MIT §4(a) 변경 표시 의무 준수.

---

## 🔗 관련 링크

- 원본 저장소: [a327ex/SNKRX](https://github.com/a327ex/SNKRX)
- Steam: [SNKRX on Steam](https://store.steampowered.com/app/915310/SNKRX/)
- 이 fork: [sigco3111/snkrx-clone](https://github.com/sigco3111/snkrx-clone)

이슈/PR 환영합니다.