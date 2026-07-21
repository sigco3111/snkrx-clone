# MODIFIED.md — SNKRX 한국어화 + 개선

이 문서는 [a327ex/SNKRX](https://github.com/a327ex/SNKRX)의 fork에서
**무엇이 변경되었는지** 명시합니다 (MIT 라이선스 §4(a) 변경 표시 의무 준수).

## 원본 정보

| 항목 | 값 |
|------|-----|
| 원본 저장소 | https://github.com/a327ex/SNKRX |
| 원본 라이선스 | MIT (코드) / 자산별 별도 (크레딧 참조) |
| 원본 저작권자 | adn (2021) |
| Steam | https://store.steampowered.com/app/915310/SNKRX/ |

## Fork 정보

| 항목 | 값 |
|------|-----|
| Fork 저장소 | https://github.com/sigco3111/snkrx-clone |
| 업스트림 remote | `upstream` → a327ex/SNKRX |
| fork remote | `origin` → sigco3111/snkrx-clone |
| 목적 | 한국어화 + UI 개선 + 적 이름 표시 + Steam 비의존 실행 |
| 작성자 | sigco3111 (희정) |

## 변경 이력

### v0.1 (2026-07-21) — 초기 한국어화 + Steam 비의존 + UI 개선

**한국어화 기반 (모드팩 패턴)**
- [x] `lang/ko.lua` — 한국어 번역 테이블 (~80 키)
- [x] `shared.lua`에 `T(key, default)` 함수 + `lang` 모듈 추가
- [x] `lang.current = 'ko'/'en'` 한 줄로 전체 UI 언어 전환 가능
- [x] 메인 메뉴 5개 버튼 한국어화
- [x] 상점 탭 5개 + 골드/NG+ 라벨 한국어화
- [x] 튜토리얼 9줄 한국어화

**CJK 폰트 자동 fallback**
- [x] `engine/graphics/font.lua` — `Font:has_cjk()`, `get_font_for_text()` 메서드 추가
- [x] `engine/graphics/graphics.lua` — `print/print_centered` CJK 감지 시 NotoSansKR 사용
- [x] `engine/graphics/text.lua` — Text 객체 포맷팅 시 CJK 너비 정확 측정
- [x] `engine/graphics/text.lua`의 `parse` 함수 — UTF-8 character 단위 반복
- [x] `assets/fonts/NotoSansKR-Regular.ttf` 임베드 (4.6MB)

**Steam 비의존 실행**
- [x] `engine/external/luasteam.lua` shim 추가
- [x] `engine/external/init.lua` 수정
- [x] Steam 업적/친구/RichPresence 모두 no-op
- [x] Steamworks SDK 의존성 제거

**창 크기 비례 확대**
- [x] `conf.lua` — 1280x720, usedpiscale=false
- [x] `main.lua` `engine_run` — sx/sy=2.67 비례 확대
- [x] 풀스크린 함정 회피 (state.sx/sy 분기 단순화)

**수치/타입 안전 가드**
- [x] `Font:has_cjk()` — `type(text) ~= "string"` 가드
- [x] `Font:get_text_width()` — 동일 가드

### v0.1.1 — 영웅 이름 + 옵션 메뉴 한국어화
- [x] `lang/ko.lua`에 70+ 영웅 이름 추가
- [x] 적 이름 추가
- [x] 옵션 메뉴 라벨 추가
- [x] `buy_screen.lua` CharacterIcon T() 적용
- [x] `main.lua` 옵션 버튼 4개 T() 적용

### v0.1.2 — Hover 영웅 이름 + 라벨 한국어화
- [x] `buy_screen.lua` CharacterIcon:on_mouse_enter T() 적용
- [x] 영웅 이름 / 비용 / 클래스 / 효과 라벨 한글화

### v0.1.3 — Hover 설명 본문 + 클래스명 + 효과 이름 한글화
- [x] `character_class_strings` 16개 클래스명 한글화
- [x] `character_effect_names` / `_gray` 60+ 효과 이름 한글화
- [x] `character_descriptions` 57개 영웅 설명 한글화 (`lang/character_descriptions_ko.lua`)
- [x] `character_descriptions_ko` 로딩 추가

### v0.1.4 — Lv.3 효과 설명 + 옵션 토글 한글화
- [x] `character_effect_descriptions` 57개 설명 한글화 (`lang/character_effect_descriptions_ko.lua`)
- [x] 옵션 토글 4개 (cooldowns on snake, arrow on snake, screen movement, screen shake) T() 적용

### v0.1.5 — Arena 승리/패배 + 일시정지 + 옵션 볼륨 한글화
- [x] 게임 오버, 축하합니다, 도달한 레벨, 런 재시작 등 11개 메시지
- [x] 일시정지 화면 controls_move/controls_turn T()
- [x] 음악/효과음 볼륨 라벨 T() 적용 (action_2 동시)

### v0.1.6 — 안내 메시지 + 승리 메시지 + 외부 게임 추천 한글화
- [x] buy_screen.lua 안내 메시지 5종
- [x] arena.lua 승리/엔딩 메시지 11종
- [x] nimble quest / dota underboards 게임 추천

### v0.1.7 — Hover info_text 전면 한글화 (5개 영역)
- [x] LevelButton hover (상점 확률)
- [x] TutorialCharacterPart hover (튜토리얼의 영웅)
- [x] CharacterPart hover (파티/클래스의 영웅)
- [x] TutorialClassIcon + ClassIcon hover (튜토리얼의 클래스)
- [x] ItemCard hover 라벨

### v0.1.8 — 버그 수정
- [x] `class_descriptions_ko.lua` local ylb1/2/3 함수 정의 추가
  - main.lua 내부 local 함수 → ko.lua 모듈은 접근 불가
  - 자체 정의로 해결

### v0.1.9 — 패시브 84개 한글화
- [x] `passive_names_ko.lua` — 84개 패시브 한글 이름 + 짧은 설명
- [x] `passive_descriptions_level_ko.lua` — 84개 함수 테이블 (ts() 유지, 정적 텍스트만 번역)

### v0.1.10 — 버그 수정
- [x] `passive_descriptions_level_ko.lua` local ts/ylb1/2/3 정의 추가

### v0.1.11 — 적 이름 표시 추가 (새 기능)
- [x] `enemies.lua` `EnemyCritter:draw()`에 한글 라벨 추가
- [x] 잡몹 / 추적자 / 보스 라벨이 HP바 위에 표시

### v0.1.12 — 패시브 매핑 보완 (긴 패턴 우선)
- [x] `passive_descriptions_level_ko.lua`: 풀 문장 매핑 (긴 패턴 우선)
- [x] 84개 항목 모두 풀 문장 패턴 매칭 적용
- [x] 매칭 안 된 단어만 단어 단위로 처리

## 라이선스 준수 사항

- 원본 MIT LICENSE 파일 그대로 보존 (`/LICENSE`)
- 모든 원본 저작권 표시 유지
- 원본 자산(스프라이트, 사운드) 라이선스 — 게임 내 크레딧 화면 참조 (변경 없음)
- 본 fork의 파생 저작물도 MIT 라이선스 적용

## 누적 통계

| 메트릭 | 값 |
|---|---|
| **커밋 수** | 12개 (v0.1 ~ v0.1.12) |
| **한국어 키 (lang/ko.lua)** | 130+ 개 |
| **한국어 데이터 모듈** | 6개 |
| **한글화 영역** | 13개 카테고리 |
| **자동 번역** | 패시브 84개 (단어 매핑 기반) |
| **수동 번역** | 메뉴/옵션/UI/메시지 (단일 키 단위) |
| **새 기능** | 적 이름 표면 표시 |

## 향후 계획 (로드맵)

- **v0.2** — 콘텐츠 확장 (새 영웅/클래스, 추가 시너지)
- **v0.3** — 신 게임 모드 (보스 레이드, 데일리 챌린지)
- **v0.4** — 풀 자동위임 (sango 결정 큐 패턴)
- **추가 한글화** — 잔여 미번역 단어 보완 (LLM API 활용)