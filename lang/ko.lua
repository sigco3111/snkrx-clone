-- ko.lua — 한국어 번역 테이블
-- 키 = 영문 식별자, 값 = 한국어 번역
-- 누락 시 T(key, default)이 default를 그대로 표시하므로 영어 원본 안전 폴백
--
-- 새 언어 추가: lang/ja.lua, lang/zh.lua 등 만들어 lang.current = 'ja'로 변경
return {
  -- ===== 메인 메뉴 (mainmenu.lua) =====
  arena_run         = '아레나 런',
  options           = '옵션',
  quit              = '종료',
  buy_soundtrack    = '사운드트랙 구매!',
  join_discord      = '커뮤니티 디스코드 가입!',

  -- ===== 게임 시작 / 종료 텍스트 (media.lua, main.lua) =====
  snkrx_title       = 'SNKRX',
  loop_update       = '루프 업데이트',
  starting          = '시작 중...',
  restarting        = '재시작 중...',
  play_now          = '지금 플레이!',

  -- ===== 일시정지 / NG+ (main.lua) =====
  paused            = '일시정지',
  ng_plus           = 'NG+',
  ng_plus_up        = 'NG+ 업',
  ng_plus_down      = 'NG+ 다운',
  current_ng        = '현재: ',
  continue_run      = '런 계속하기 (+난이도):',
  continue_run_max  = '런 계속하기 (+난이도, +최대 뱀 길이 +1):',
  new_run           = '새 런 (+난이도, +최대 뱀 길이 +1):',
  restart_run       = '런 재시작',

  -- ===== 입력 안내 (main.lua) =====
  controls_move     = '<-, A 또는 M1          ->, D 또는 M2',
  controls_turn     = '좌회전                                            우회전',
  controls_screen   = '화면 이동: ',
  controls_shake    = '화면 흔들림: ',
  controls_aim      = '뱀의 화살표: ',
  controls_cd       = '뱀의 쿨다운: ',
  wishlist_steam    = '스팀 위시리스트',
  wishlist_press    = 'W로 위시리스트',

  -- ===== 상점 / 구매 (buy_screen.lua) =====
  reroll_free       = '[bg10]리롤: [yellow]0',
  reroll_cost_2     = '[bg10]리롤: [yellow]2',
  reroll_cost_5     = '[bg10]리롤: [yellow]5',
  gold_label        = '[fg, nudge_down]골드: [yellow, nudge_down]',
  reroll            = '리롤',
  next_round        = '다음 라운드',
  start_round       = '라운드 시작',
  cannot_start_0    = '[fg]0 유닛으로는 라운드를 시작할 수 없습니다',
  not_enough_gold   = '[fg]골드가 부족합니다',
  hire_unit         = '유닛 고용',
  sell_unit         = '유닛 판매',

  -- ===== 영웅 이름 (player.lua에서 사용) =====
  hero_rogue        = '로그',
  hero_mage         = '메이지',
  hero_mercenary    = '머서너리',
  hero_explorer     = '익스플로러',
  hero_psyker       = '사이커',
  hero_berserking   = '버서커',
  hero_artificer    = '아티피서',
  hero_gambler      = '갬블러',
  hero_orbitist     = '오비티스트',
  hero_usurer       = '유저러',

  -- ===== 적 이름 (enemies.lua에서 사용) =====
  enemy_basic       = '기본 적',
  enemy_speed       = '신속한 적',
  enemy_tank        = '탱크',
  enemy_ranged      = '원거리',
  enemy_exploder    = '자폭병',
  enemy_boss        = '보스',
  enemy_elite       = '정예',

  -- ===== 클래스 / 등급 (buy_screen.lua) =====
  class_tier1       = '[fg]1등급: ',
  class_tier2       = '[fg]2등급: ',
  class_tier3       = '[blue]3등급: ',
  class_label       = '[fg]클래스: ',
  library_label     = '[blue]라이브러리: ',
  max_units         = '[fg]최대 유닛 수 [yellow](',
  units_label       = '[fg]유닛',

  -- ===== 튜토리얼 / 가이드 (buy_screen.lua) =====
  welcome_snkrx     = '[fg]SNKRX에 오신 걸 환영합니다!',
  guide_label       = '[fg]가이드',
  welcome_desc1     = '[fg]당신은 자동으로 근처 적을 공격하는 여러 영웅의 뱀을 조종합니다.',
  welcome_desc2     = '[fg]A/D 또는 좌/우 방향키로 뱀을 좌우로 조종할 수 있습니다.',
  welcome_desc3     = '[fg]같은 영웅을 합치면 레벨이 올라갑니다:',
  welcome_desc4     = '[fg]각 영웅은 [yellow]1~3[fg]개의 클래스를 가질 수 있습니다.',
  welcome_desc5     = '[fg]같은 클래스의 영웅을 고용하면 클래스 패시브를 해제합니다:',
  welcome_desc6     = '[fg][yellow]Lv.3[fg]에서 영웅은 특수 효과를 해제합니다.',
  welcome_desc7     = '[fg][yellow]골드 5당 1[fg]의 이자를 얻습니다. 최대 5까지.',
  welcome_classes   = '[fg]클래스: ',
  choose_one        = '[fg, wavy]하나를 선택하세요',
  go_signal         = '[fgm5]출발!',

  -- ===== 크레딧 (media.lua) =====
  credits_main_dev  = '[bg10]메인 개발: ',
  credits_mobile    = '[bg10]모바일: ',
  credits_sound_lib = '[blue]사운드 라이브러리: ',
  credit_blue_fairy = 'Blue Fairy',
  credit_inspectorj = 'InspectorJ',
  credit_philblank  = 'Phil Blank',
  credit_yongmin    = 'Yongmin Park',
  credit_jofer      = 'Jofer',
  credit_vlad       = 'Vlad',
  credit_ge0force   = 'Ge0force',
  credit_david      = 'David Khachaturov',
  credit_definedoddy = 'DefineDoddy',

  -- ===== 능력치 / 상태 =====
  hp_label          = '체력',
  atk_label         = '공격력',
  spd_label         = '속도',
  range_label       = '사거리',
  crit_label        = '치명타',
  level_label       = '[fg]Lv.',

  -- ===== 챌린지 / 모드 (v0.2+ 확장용) =====
  daily_challenge   = '일일 챌린지',
  boss_rush         = '보스 러시',
  endless           = '무한 모드',

  -- ===== 상점 탭 (buy_screen.lua) =====
  shop_label        = '상점',
  party_label       = '파티',
  classes_label     = '클래스',
  items_label       = '아이템',

  -- ===== 튜토리얼 (buy_screen.lua) =====
  welcome_desc8     = "이건 [yellow]25 골드[fg] 이상 모아도 이자가 더 늘지 않는다는 뜻입니다.",
  welcome_luck      = '행운을 빕니다!',
  follow_steam      = '스팀에서 팔로우!',
  restart_btn       = '재시작',
  guide_btn         = '가이드',
  restart_confirm   = '런 재시작',

  -- ===== 옵션 (옵션 화면) =====
  option_sound      = '사운드',
  option_music      = '음악',
  option_sfx        = '효과음',
  option_screen     = '화면',
  option_fullscreen = '전체화면',
  option_vsync      = '수직동기화',
  option_language   = '언어',

  -- ===== 일반 UI =====
  yes               = '예',
  no                = '아니오',
  confirm           = '확인',
  cancel            = '취소',
  back              = '뒤로',
  close             = '닫기',
  continue          = '계속',
}