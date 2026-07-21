-- passive_descriptions_level_ko.lua — 패시브 레벨별 설명 한글 (84개)
-- v0.1.10: main.lua의 local ts/ylb1/ylb2/ylb3를 자체 정의.
-- v0.1.12: 풀 문장 매핑 (긴 패턴 우선) + 단어 매핑 보완.
local ylb1 = function(lvl)
  if lvl == 3 then return 'light_bg'
  elseif lvl == 2 then return 'light_bg'
  elseif lvl == 1 then return 'yellow'
  else return 'light_bg' end
end
local ylb2 = function(lvl)
  if lvl == 3 then return 'light_bg'
  elseif lvl == 2 then return 'yellow'
  else return 'light_bg' end
end
local ylb3 = function(lvl)
  if lvl == 3 then return 'yellow'
  else return 'light_bg' end
end
local ts = function(lvl, a, b, c)
  return '[' .. ylb1(lvl) .. ']' .. tostring(a) .. '[light_bg]/[' .. ylb2(lvl) .. ']' .. tostring(b) .. '[light_bg]/[' .. ylb3(lvl) .. ']' .. tostring(c) .. '[fg]'
end

return {

  ['centipede'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. '이동속도' end,
  ['ouroboros_technique_r'] = function(lvl) return '[fg]오른쪽으로 회전하며 발사' .. ts(lvl, '2', '3', '4') .. '투사체 /초' end,
  ['ouroboros_technique_l'] = function(lvl) return '[fg]왼쪽으로 회전하며 부여' .. ts(lvl, '+15%', '25%', '35%') .. '모든 유닛 방어력' end,
  ['amplify'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. '광역 데미지' end,
  ['resonance'] = function(lvl) return '[fg]모든 광역 공격이 주는' .. ts(lvl, '+3%', '5%', '7%') .. '유닛당 데미지' end,
  ['ballista'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. '투사체 데미지' end,
  ['call_of_the_void'] = function(lvl) return ts(lvl, '+30%', '60%', '90%') .. '지속 데미지' end,
  ['crucio'] = function(lvl) return '[fg]피격 데미지를 모든 적에게' .. ts(lvl, '20%', '30%', '40%') .. 'its value' end,
  ['speed_3'] = function(lvl) return '[fg]위치 [yellow]3[fg] has [yellow]+50%[fg] 공격속도' end,
  ['damage_4'] = function(lvl) return '[fg]위치 [yellow]4[fg] has [yellow]+30%[fg] 데미지' end,
  ['shoot_5'] = function(lvl) return '[fg]위치 [yellow]5[fg] shoots [yellow]3[fg] 투사체 /초' end,
  ['death_6'] = function(lvl) return '[fg]위치 [yellow]6[fg] 받음 [yellow]10%[fg] 체력의 데미지 매 [yellow]3[fg] 초' end,
  ['lasting_7'] = function(lvl) return '[fg]위치 [yellow]7[fg] will stay alive for [yellow]10[fg] 초 후 dying' end,
  ['defensive_stance'] = function(lvl) return '[fg]첫/마지막 위치 have' .. ts(lvl, '+10%', '20%', '30%') .. '방어력' end,
  ['offensive_stance'] = function(lvl) return '[fg]첫/마지막 위치 have' .. ts(lvl, '+10%', '20%', '30%') .. '데미지' end,
  ['kinetic_bomb'] = function(lvl) return '[fg]아군 사망 시 폭발하며 적을 밀침' end,
  ['porcupine_technique'] = function(lvl) return '[fg]아군 사망 시 폭발하며 관통 투사체 발사' end,
  ['last_stand'] = function(lvl) return '[fg]the 마지막 생존 유닛 완전 치유 and receives a [yellow]+20%[fg] 모든 능력치 보너스' end,
  ['seeping'] = function(lvl) return '[fg]지속 데미지 받는 적은' .. ts(lvl, '-15%', '25%', '35%') .. '방어력' end,
  ['deceleration'] = function(lvl) return '[fg]지속 데미지 받는 적은' .. ts(lvl, '-15%', '25%', '35%') .. '이동속도' end,
  ['annihilation'] = function(lvl) return '[fg]when a voider dies deal its 지속 데미지 to 모든 적 for [yellow]3[fg] 초' end,
  ['malediction'] = function(lvl) return ts(lvl, '+1', '3', '5') .. '모든 아군 커서 최대 저주 대상' end,
  ['hextouch'] = function(lvl) return '[fg]적 take' .. ts(lvl, '10', '15', '20') .. '초당 데미지 for [yellow]3[fg] 초 저주 시' end,
  ['whispers_of_doom'] = function(lvl) return '[fg]저주가 파멸 부여,' .. ts(lvl, '100', '150', '200') .. '매' .. ts(lvl, '4', '3', '2') .. '파멸 누적' end,
  ['tremor'] = function(lvl) return '[fg]when 벽 충돌 시 장판 생성 based to the 밀침 강도' end,
  ['heavy_impact'] = function(lvl) return '[fg]벽 충돌 시 밀침 강도 비례 데미지' end,
  ['fracture'] = function(lvl) return '[fg]벽 충돌 시 투사체 폭발' end,
  ['meat_shield'] = function(lvl) return '[fg]잡몹 [yellow]block[fg] enemy 투사체' end,
  ['hive'] = function(lvl) return '[fg]잡몹 have' .. ts(lvl, '+1', '2', '3') .. 'HP' end,
  ['baneling_burst'] = function(lvl) return '[fg]잡몹 접촉 시 즉시 사망 but also deal' .. ts(lvl, '50', '100', '150') .. '광역 데미지' end,
  ['blunt_arrow'] = function(lvl) return '[fg]레인저 화살' .. ts(lvl, '+10%', '20%', '30%') .. '확률 to knockback' end,
  ['explosive_arrow'] = function(lvl) return '[fg]레인저 화살' .. ts(lvl, '+10%', '20%', '30%') .. '확률 to deal' .. ts(lvl, '10%', '20%', '30%') .. '광역 데미지' end,
  ['divine_machine_arrow'] = function(lvl) return '[fg]레인저 화살 a' .. ts(lvl, '10%', '20%', '30%') .. '확률 to seek and pierce' .. ts(lvl, '1', '2', '3') .. '회' end,
  ['chronomancy'] = function(lvl) return '[fg]마법사 cast their 주문s' .. ts(lvl, '15%', '25%', '35%') .. 'faster' end,
  ['awakening'] = function(lvl) return ts(lvl, '+50%', '75%', '100%') .. '공격속도 and 데미지 to [yellow]1[fg] 매 라운드 1명의 마법사' end,
  ['divine_punishment'] = function(lvl) return '[fg]마법사 수 비례 모든 적에게 데미지' end,
  ['assassination'] = function(lvl) return '[fg]도적 치명타 deal' .. ts(lvl, '8x', '10x', '12x') .. '데미지 but normal 공격s deal [yellow]half[fg] 데미지' end,
  ['flying_daggers'] = function(lvl) return '[fg]도적 투사체 연쇄' .. ts(lvl, '+2', '3', '4') .. '회' end,
  ['ultimatum'] = function(lvl) return '[fg]연쇄 투사체' .. ts(lvl, '+10%', '20%', '30%') .. '데미지 연쇄마다' end,
  ['magnify'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. '범위 size' end,
  ['echo_barrage'] = function(lvl) return ts(lvl, '10%', '20%', '30%') .. '확률 to create' .. ts(lvl, '1', '2', '3') .. '보조 광역 광역 타격 시' end,
  ['unleash'] = function(lvl) return '[fg]모든 누커 gain [yellow]+1%[fg] 범위 size and 데미지 매 초' end,
  ['reinforce'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. '전체 데미지/방어력/공격속도 인챈터 1명 이상 시' end,
  ['payback'] = function(lvl) return ts(lvl, '+2%', '5%', '8%') .. '데미지 to 인챈터 피격 시 모든 아군' end,
  ['enchanted'] = function(lvl) return ts(lvl, '+33%', '66%', '99%') .. '인챈터 2명 이상 시 무작위 유닛 공격속도' end,
  ['freezing_field'] = function(lvl) return '[fg]감속 장판 생성 적 by [yellow]50%[fg] for [yellow]2[fg] 초 소서러 주문 반복 시' end,
  ['burning_field'] = function(lvl) return '[fg]데미지 장판 생성 [yellow]30[fg] 초당 데미지 [yellow]2[fg] 초 소서러 주문 반복 시' end,
  ['gravity_field'] = function(lvl) return '[fg]끌어당김 장판 생성 for [yellow]1[fg] 초 소서러 주문 반복 시' end,
  ['magnetism'] = function(lvl) return '[fg]골드/치유 오브 더 먼 거리에서 뱀으로 끌려감' end,
  ['insurance'] = function(lvl) return "[fg]heroes have [yellow]4[fg] times the chance of mercenary's bonus to drop [yellow]2[fg] gold on death" end,
  ['dividends'] = function(lvl) return '[fg]머서너리 [yellow]+X%[fg] 데미지, 보유 골드 비례' end,
  ['berserking'] = function(lvl) return '[fg]모든 전사 최대' .. ts(lvl, '+50%', '75%', '100%') .. '잃은 체력 비례 공격속도' end,
  ['unwavering_stance'] = function(lvl) return '[fg]모든 전사 gain' .. ts(lvl, '+4%', '8%', '12%') .. '방어력 매 [yellow]5[fg] 초' end,
  ['unrelenting_stance'] = function(lvl) return ts(lvl, '+2%', '5%', '8%') .. '방어력 to 전사 피격 시 모든 아군' end,
  ['blessing'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. '치유 효율' end,
  ['haste'] = function(lvl) return '[yellow]+50%[fg] 이동속도 that decays over [yellow]4[fg] 초 치유 오브 획득 시' end,
  ['divine_barrage'] = function(lvl) return ts(lvl, '20%', '40%', '60%') .. '확률 to release a 반사 포격 치유 오브 획득 시' end,
  ['orbitism'] = function(lvl) return ts(lvl, '+25%', '50%', '75%') .. '사이커 오브 이동속도' end,
  ['psyker_orbs'] = function(lvl) return ts(lvl, '+1', '2', '4') .. '사이커 오브' end,
  ['psychosense'] = function(lvl) return ts(lvl, '+33%', '66%', '99%') .. '오브 거리' end,
  ['psychosink'] = function(lvl) return '[fg]사이커 오브 deal' .. ts(lvl, '+40%', '80%', '120%') .. '데미지' end,
  ['rearm'] = function(lvl) return '[fg]설치물 공격 1회 반복' end,
  ['taunt'] = function(lvl) return ts(lvl, '10%', '20%', '30%') .. '공격 시 도발 확률' end,
  ['construct_instability'] = function(lvl) return '[fg]소멸 시 폭발, dealing' .. ts(lvl, '100', '150', '200%') .. '데미지' end,
  ['intimidation'] = function(lvl) return '[fg]적 스폰 시' .. ts(lvl, '-10', '20', '30%') .. 'max HP' end,
  ['vulnerability'] = function(lvl) return '[fg]적 take' .. ts(lvl, '+10', '20', '30%') .. '데미지' end,
  ['temporal_chains'] = function(lvl) return '[fg]적이' .. ts(lvl, '10', '20', '30%') .. 'slower' end,
  ['ceremonial_dagger'] = function(lvl) return '[fg]적 처치 시 유도 단도 발사' end,
  ['homing_barrage'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '확률 to 유도 포격 적 처치 시' end,
  ['critical_strike'] = function(lvl) return ts(lvl, '5', '10', '15%') .. '공격 시 치명타 확률, dealing [yellow]2x[fg] 데미지' end,
  ['noxious_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '공격 시 독 확률, dealing [yellow]20%[fg] 초당 데미지 [yellow]3[fg] 초' end,
  ['infesting_strike'] = function(lvl) return ts(lvl, '10', '20', '30%') .. '확률 for 공격s to spawn [yellow]2[fg] 잡몹 처치 시' end,
  ['kinetic_strike'] = function(lvl) return ts(lvl, '10', '20', '30%') .. '공격 시 적 강하게 밀침 확률' end,
  ['burning_strike'] = function(lvl) return '[yellow]15%[fg] 공격 시 연소 확률, dealing [yellow]20%[fg] 초당 데미지 [yellow]3[fg] 초' end,
  ['lucky_strike'] = function(lvl) return '[yellow]8%[fg] 공격 시 적 골드 드롭 확률' end,
  ['healing_strike'] = function(lvl) return '[yellow]8%[fg] 공격 시 치유 오브 생성 확률' end,
  ['stunning_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '확률 for 기절 for [yellow]2[fg] 초' end,
  ['silencing_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '확률 for 침묵 for [yellow]2[fg] 초 hit' end,
  ['warping_shots'] = function(lvl) return '투사체 벽 무시, 화면 워프' .. ts(lvl, '1', '2', '3') .. '회' end,
  ['culling_strike'] = function(lvl) return '[fg]정예 즉사 (' .. ts(lvl, '10', '20', '30%') .. 'max HP' end,
  ['lightning_strike'] = function(lvl) return ts(lvl, '5', '10', '15%') .. '투사체 연쇄 번개 확률, dealing' .. ts(lvl, '60', '80', '100%') .. '데미지' end,
  ['psycholeak'] = function(lvl) return '[fg]위치 [yellow]1[fg] generates [yellow]1[fg] 사이커 오브 매 [yellow]10[fg] 초' end,
  ['divine_blessing'] = function(lvl) return '[fg]generate [yellow]1[fg] 치유 오브 매 [yellow]8[fg] 초' end,
  ['hardening'] = function(lvl) return '[yellow]+150%[fg] 모든 아군 방어력 for [yellow]3[fg] 초 아군 사망 시' end,
}
