-- passive_descriptions_level_ko.lua — 패시브 레벨별 설명 한글 (84개)
-- v0.1.10: main.lua의 local ts/ylb1/ylb2/ylb3를 자체 정의.
-- v0.1.11: 풀 문장 매핑 (긴 패턴 우선) + 단어 정리.
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
  ['ouroboros_technique_r'] = function(lvl) return '[fg]오른쪽으로 회전하며' .. ts(lvl, '2', '3', '4') .. 'projectiles /초' end,
  ['ouroboros_technique_l'] = function(lvl) return '[fg]왼쪽으로 회전하며 부여' .. ts(lvl, '+15%', '25%', '35%') .. '방어력 모든 유닛' end,
  ['amplify'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. '광역 데미지' end,
  ['resonance'] = function(lvl) return '[fg]모든 광역 공격이 주는' .. ts(lvl, '+3%', '5%', '7%') .. '유닛당 데미지' end,
  ['ballista'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. '투사체 데미지' end,
  ['call_of_the_void'] = function(lvl) return ts(lvl, '+30%', '60%', '90%') .. '지속 데미지' end,
  ['crucio'] = function(lvl) return '[fg]tkg 데미지 shs tht cross 모든 적 t' .. ts(lvl, '20%', '30%', '40%') .. 'vlue' end,
  ['speed_3'] = function(lvl) return '[fg]position [yellow]3[fg] [yellow]+50%[fg] 공격속도' end,
  ['damage_4'] = function(lvl) return '[fg]position [yellow]4[fg] [yellow]+30%[fg] 데미지' end,
  ['shoot_5'] = function(lvl) return '[fg]position [yellow]5[fg] shoots [yellow]3[fg] projectiles /초' end,
  ['death_6'] = function(lvl) return '[fg]position [yellow]6[fg] tkes [yellow]10%[fg] helth 데미지 매 [yellow]3[fg] seconds' end,
  ['lasting_7'] = function(lvl) return '[fg]position [yellow]7[fg] will sty live [yellow]10[fg] seconds 사망 후' end,
  ['defensive_stance'] = function(lvl) return '[fg]첫/마지막 위치' .. ts(lvl, '+10%', '20%', '30%') .. '방어력' end,
  ['offensive_stance'] = function(lvl) return '[fg]첫/마지막 위치' .. ts(lvl, '+10%', '20%', '30%') .. '데미지' end,
  ['kinetic_bomb'] = function(lvl) return '[fg]아군 사망 시 폭발하며 적을 밀침' end,
  ['porcupine_technique'] = function(lvl) return '[fg]아군 사망 시 폭발하며 관통 투사체 발사' end,
  ['last_stand'] = function(lvl) return '[fg] 마지막 생존 유닛 fully heled receives [yellow]+20%[fg] bonus 모든 stts' end,
  ['seeping'] = function(lvl) return '[fg]지속 데미지를 받는 적은' .. ts(lvl, '-15%', '25%', '35%') .. '방어력' end,
  ['deceleration'] = function(lvl) return '[fg]지속 데미지를 받는 적은' .. ts(lvl, '-15%', '25%', '35%') .. '이동속도' end,
  ['annihilation'] = function(lvl) return '[fg]when voider dies del 지속 데미지 모든 적 [yellow]3[fg] seconds' end,
  ['malediction'] = function(lvl) return ts(lvl, '+1', '3', '5') .. '모든 아군 커서의 최대 저주 대상' end,
  ['hextouch'] = function(lvl) return '[fg]적 tke' .. ts(lvl, '10', '15', '20') .. '데미지 /초 [yellow]3[fg] seconds cursed' end,
  ['whispers_of_doom'] = function(lvl) return '[fg]저주가 파멸 부여,' .. ts(lvl, '100', '150', '200') .. '매' .. ts(lvl, '4', '3', '2') .. '파멸 누적' end,
  ['tremor'] = function(lvl) return '[fg]when 적이 벽에 충돌 y crete bed 밀침 강도' end,
  ['heavy_impact'] = function(lvl) return '[fg]적이 벽에 충돌 시 밀침 강도에 비례한 데미지' end,
  ['fracture'] = function(lvl) return '[fg]적이 벽에 충돌 시 투사체로 폭발' end,
  ['meat_shield'] = function(lvl) return '[fg]잡몹 [yellow]block[fg] 적 projectiles' end,
  ['hive'] = function(lvl) return '[fg]잡몹' .. ts(lvl, '+1', '2', '3') .. 'HP' end,
  ['baneling_burst'] = function(lvl) return '[fg]잡몹이 접촉 시 즉시 사망 but del' .. ts(lvl, '50', '100', '150') .. '광역 데미지' end,
  ['blunt_arrow'] = function(lvl) return '[fg]레인저 화살' .. ts(lvl, '+10%', '20%', '30%') .. 'chce knockbck' end,
  ['explosive_arrow'] = function(lvl) return '[fg]레인저 화살' .. ts(lvl, '+10%', '20%', '30%') .. 'chce del' .. ts(lvl, '10%', '20%', '30%') .. '광역 데미지' end,
  ['divine_machine_arrow'] = function(lvl) return '[fg]레인저 화살' .. ts(lvl, '10%', '20%', '30%') .. 'chce seek pierce' .. ts(lvl, '1', '2', '3') .. 'times' end,
  ['chronomancy'] = function(lvl) return '[fg]마법사 ct ir spells' .. ts(lvl, '15%', '25%', '35%') .. 'fter' end,
  ['awakening'] = function(lvl) return ts(lvl, '+50%', '75%', '100%') .. '공격속도 데미지 [yellow]1[fg] 마법사 매 라운드 해당 라운드' end,
  ['divine_punishment'] = function(lvl) return '[fg]마법사 수에 비례하여 모든 적에게 데미지' end,
  ['assassination'] = function(lvl) return '[fg]도적 치명타 del' .. ts(lvl, '8x', '10x', '12x') .. '데미지 but nml ttcks del [yellow]hlf[fg] 데미지' end,
  ['flying_daggers'] = function(lvl) return '[fg]도적 투사체 연쇄' .. ts(lvl, '+2', '3', '4') .. 'times' end,
  ['ultimatum'] = function(lvl) return '[fg]projectiles tht ch g' .. ts(lvl, '+10%', '20%', '30%') .. '데미지 ech ch' end,
  ['magnify'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. 'size' end,
  ['echo_barrage'] = function(lvl) return ts(lvl, '10%', '20%', '30%') .. 'chce crete' .. ts(lvl, '1', '2', '3') .. 'secondry AoEs 광역 타격 시' end,
  ['unleash'] = function(lvl) return '[fg]모든 누커 g [yellow]+1%[fg] size 데미지 매 초' end,
  ['reinforce'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. 'globl 데미지, 방어력 pd 인챈터 1명 이상 시' end,
  ['payback'] = function(lvl) return ts(lvl, '+2%', '5%', '8%') .. '데미지 인챈터 피격 시 모든 아군' end,
  ['enchanted'] = function(lvl) return ts(lvl, '+33%', '66%', '99%') .. '공격속도 무작위 유닛 인챈터 2명 이상 시' end,
  ['freezing_field'] = function(lvl) return '[fg]cretes tht slows 적 [yellow]50%[fg] [yellow]2[fg] seconds 소서러 주문 반복 시' end,
  ['burning_field'] = function(lvl) return '[fg]cretes tht dels [yellow]30[fg] dps [yellow]2[fg] seconds 소서러 주문 반복 시' end,
  ['gravity_field'] = function(lvl) return '[fg]cretes tht pulls 적 [yellow]1[fg] seconds 소서러 주문 반복 시' end,
  ['magnetism'] = function(lvl) return '[fg]더 먼 거리에서 골드/치유 오브가 뱀으로 끌려감' end,
  ['insurance'] = function(lvl) return "[fg]heroes have [yellow]4[fg] times the chance of mercenary's bonus to drop [yellow]2[fg] gold on death" end,
  ['dividends'] = function(lvl) return '[fg]머서너리 del [yellow]+X%[fg] 데미지, where X how much gold you' end,
  ['berserking'] = function(lvl) return '[fg]모든 전사 up' .. ts(lvl, '+50%', '75%', '100%') .. '잃은 체력 비례 공격속도' end,
  ['unwavering_stance'] = function(lvl) return '[fg]모든 전사 g' .. ts(lvl, '+4%', '8%', '12%') .. '방어력 매 [yellow]5[fg] seconds' end,
  ['unrelenting_stance'] = function(lvl) return ts(lvl, '+2%', '5%', '8%') .. '방어력 전사 피격 시 모든 아군' end,
  ['blessing'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. 'helg effectiveness' end,
  ['haste'] = function(lvl) return '[yellow]+50%[fg] 이동속도 tht decys over [yellow]4[fg] seconds 치유 오브 획득 시' end,
  ['divine_barrage'] = function(lvl) return ts(lvl, '20%', '40%', '60%') .. 'chce relee 반사 포격 치유 오브 획득 시' end,
  ['orbitism'] = function(lvl) return ts(lvl, '+25%', '50%', '75%') .. '사이커 오브 이동속도' end,
  ['psyker_orbs'] = function(lvl) return ts(lvl, '+1', '2', '4') .. '사이커 오브' end,
  ['psychosense'] = function(lvl) return ts(lvl, '+33%', '66%', '99%') .. 'b rge' end,
  ['psychosink'] = function(lvl) return '[fg]사이커 오브 del' .. ts(lvl, '+40%', '80%', '120%') .. '데미지' end,
  ['rearm'] = function(lvl) return '[fg]설치물 공격 1회 반복' end,
  ['taunt'] = function(lvl) return ts(lvl, '10%', '20%', '30%') .. 'chce 설치물 tunt ner 적 공격 시' end,
  ['construct_instability'] = function(lvl) return '[fg]소멸 시 폭발 소멸 시, delg' .. ts(lvl, '100', '150', '200%') .. '데미지' end,
  ['intimidation'] = function(lvl) return '[fg]적 spwn' .. ts(lvl, '-10', '20', '30%') .. '최대 체력' end,
  ['vulnerability'] = function(lvl) return '[fg]적 tke' .. ts(lvl, '+10', '20', '30%') .. '데미지' end,
  ['temporal_chains'] = function(lvl) return '[fg]적' .. ts(lvl, '10', '20', '30%') .. 'slower' end,
  ['ceremonial_dagger'] = function(lvl) return '[fg]적 처치 시 유도 단도 발사' end,
  ['homing_barrage'] = function(lvl) return ts(lvl, '8', '16', '24%') .. 'chce relee 유도 포격 적 처치 시' end,
  ['critical_strike'] = function(lvl) return ts(lvl, '5', '10', '15%') .. '공격 시 확률로 치명타 strike, delg [yellow]2x[fg] 데미지' end,
  ['noxious_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '공격 시 확률로 poon, delg [yellow]20%[fg] dps [yellow]3[fg] seconds' end,
  ['infesting_strike'] = function(lvl) return ts(lvl, '10', '20', '30%') .. '공격 시 확률로 spwn [yellow]2[fg] 잡몹 생성' end,
  ['kinetic_strike'] = function(lvl) return ts(lvl, '10', '20', '30%') .. '공격 시 확률로 push 적 wy high ce' end,
  ['burning_strike'] = function(lvl) return '[yellow]15%[fg] 공격 시 확률로 burn, delg [yellow]20%[fg] dps [yellow]3[fg] seconds' end,
  ['lucky_strike'] = function(lvl) return '[yellow]8%[fg] 공격 시 확률로 cuse 적 드롭 사망 시 골드' end,
  ['healing_strike'] = function(lvl) return '[yellow]8%[fg] 공격 시 확률로 spwn 치유 오브' end,
  ['stunning_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '공격 시 확률로 stun [yellow]2[fg] seconds' end,
  ['silencing_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. '공격 시 확률로 silence [yellow]2[fg] seconds 타격 시' end,
  ['warping_shots'] = function(lvl) return '투사체 벽 무시, 화면 워프' .. ts(lvl, '1', '2', '3') .. 'times' end,
  ['culling_strike'] = function(lvl) return '[fg]sttly kill elites low' .. ts(lvl, '10', '20', '30%') .. '최대 체력' end,
  ['lightning_strike'] = function(lvl) return ts(lvl, '5', '10', '15%') .. 'chce projectiles crete 연쇄 번개, delg' .. ts(lvl, '60', '80', '100%') .. '데미지' end,
  ['psycholeak'] = function(lvl) return '[fg]position [yellow]1[fg] genertes [yellow]1[fg] 사이커 오브 매 [yellow]10[fg] seconds' end,
  ['divine_blessing'] = function(lvl) return '[fg]generte [yellow]1[fg] 치유 오브 매 [yellow]8[fg] seconds' end,
  ['hardening'] = function(lvl) return '[yellow]+150%[fg] 방어력 모든 아군 [yellow]3[fg] seconds fter 아군 사망 시' end,
}
