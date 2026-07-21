# MODIFIED.md — SNKRX 한국어화 + 개선

이 문서는 [a327ex/SNKRX](https://github.com/a327ex/SNKRX)의 fork에서
**무엇이 변경되었는지** 명시합니다 (MIT 라이선스 §원본 저작권 의무 준수).

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
| 목적 | 한국어화 + UI 개선 + 향후 콘텐츠 확장 + 자동위임 |
| 작성자 | sigco3111 (희정) |

## 변경 이력

### v0.1 (2026-07-21) — 한국어화 + Steam 비의존 실행

**한국어화 기반 (모드팩 패턴)**
- [x] `lang/ko.lua` — 한국어 번역 테이블 (~80 키)
- [x] `shared.lua`에 `T(key, default)` 함수 + `lang` 모듈 추가
- [x] `lang.current = 'ko'/'en'` 한 줄로 전체 UI 언어 전환 가능 (향후 ja/zh 추가 용이)
- [x] 메인 메뉴 5개 버튼 한국어화: 아레나 런 / 옵션 / 종료 / 사운드트랙 구매 / 디스코드
- [x] 상점 탭 5개 + 골드/NG+ 라벨 한국어화
- [x] 튜토리얼 9줄 한국어화 (WELCOME TO SNKRX + 설명 + 클래스 안내)

**CJK 폰트 자동 fallback**
- [x] `engine/graphics/font.lua` — `Font:has_cjk()` + `get_font_for_text()` 메서드 추가
- [x] `engine/graphics/graphics.lua` — `print/print_centered`에서 CJK 감지 시 NotoSansKR 사용
- [x] `engine/graphics/text.lua` — Text 객체 포맷팅 시 CJK 너비 정확 측정
- [x] `engine/graphics/text.lua`의 `parse` 함수 — UTF-8 character 단위 반복 (원본은 byte 단위라 한글 깨짐)
- [x] `assets/fonts/NotoSansKR-Regular.ttf` 임베드 (4.6MB)

**Steam 비의존 실행 (오프라인 플레이)**
- [x] `engine/external/luasteam.lua` shim 추가 — Steam 클라이언트 없이 게임플레이 가능
- [x] `engine/external/init.lua` 수정 — shim을 require하도록
- [x] Steam 업적/친구/RichPresence 모두 no-op 처리
- [x] Steamworks SDK 의존성 제거 → MIT 코드만으로 완전 동작

**창 크기 비례 확대 (UI 개선)**
- [x] `conf.lua` — `t.window.width/height = 1280x720`, `usedpiscale = false`
- [x] `main.lua` `engine_run` — window_width=1280, game_width=480 → sx=2.67 비례 확대
- [x] `engine/init.lua` — `setMode`에 fullscreen/borderless/resizable 명시, state.sx 분기 단순화
- [x] `usedpiscale = false` — Retina에서 DPI 자동 축소 방지
- [x] 옵션 메뉴의 'window size±' 버튼 비활성화 (sx/sy 분기 단순화로 자체 충돌 방지)

**수치/타입 안전 가드**
- [x] `Font:has_cjk()` — `type(text) ~= "string"` 가드 (숫자 전달 시 crash 방지)
- [x] `Font:get_text_width()` — 동일 가드

**라이선스/문서**
- [x] `MODIFIED.md` 작성 (이 파일) — MIT §4(a) 변경 표시 의무
- [x] `LICENSE` 원본 그대로 보존
- [x] `README.md` 한국어판 작성

## 라이선스 준수 사항

- 원본 MIT LICENSE 파일 그대로 보존 (`/LICENSE`)
- 모든 원본 저작권 표시 유지
- 원본 자산(스프라이트, 사운드) 라이선스 — 게임 내 크레딧 화면 참조 (변경 없음)
- 본 fork의 파생 저작물도 MIT 라이선스 적용

## 향후 계획 (로드맵)

- **v0.2** — 콘텐츠 확장 (새 영웅/클래스, 추가 시너지)
- **v0.3** — 신 게임 모드 (보스 레이드, 데일리 챌린지)
- **v0.4** — 풀 자동위임 (sango 결정 큐 패턴)