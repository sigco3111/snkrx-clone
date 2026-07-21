-- class_descriptions_ko.lua — 클래스 패시브 설명 한글 (16개 클래스)
-- v0.1.8 (한국어화 fork): main.lua의 local ylb1/ylb2/ylb3를 자체 정의.
-- 원본 class_descriptions는 main.lua 내부 로컬 함수를 참조하지만,
-- ko.lua는 shared.lua에서 require되므로 별도 정의 필요.

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

return {
  ['ranger'] = function(lvl) return '[' .. ylb1(lvl) .. ']3[light_bg]/[' .. ylb2(lvl) .. ']6 [fg]- [' .. ylb1(lvl) .. ']8%[light_bg]/[' .. ylb2(lvl) .. ']16% [fg]확률로 공격 시 아군 레인저에게 포격 발사' end,
  ['warrior'] = function(lvl) return '[' .. ylb1(lvl) .. ']3[light_bg]/[' .. ylb2(lvl) .. ']6 [fg]- [' .. ylb1(lvl) .. ']+25[light_bg]/[' .. ylb2(lvl) .. ']+50 [fg]방어력 (아군 전사)' end,
  ['mage'] = function(lvl) return '[' .. ylb1(lvl) .. ']3[light_bg]/[' .. ylb2(lvl) .. ']6 [fg]- 적 방어력 [' .. ylb1(lvl) .. ']-15[light_bg]/[' .. ylb2(lvl) .. ']-30' end,
  ['rogue'] = function(lvl) return '[' .. ylb1(lvl) .. ']3[light_bg]/[' .. ylb2(lvl) .. ']6 [fg]- [' .. ylb1(lvl) .. ']15%[light_bg]/[' .. ylb2(lvl) .. ']30% [fg]확률로 치명타 ([yellow]4배[] 데미지, 아군 도적)' end,
  ['healer'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- [' .. ylb1(lvl) .. ']+15%[light_bg]/[' .. ylb2(lvl) .. ']+30% [fg]확률로 치유 오브 생성 시 [yellow]+1[fg] 추가 오브' end,
  ['enchanter'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 모든 아군 공격력 [' .. ylb1(lvl) .. ']+15%[light_bg]/[' .. ylb2(lvl) .. ']+25%' end,
  ['nuker'] = function(lvl) return '[' .. ylb1(lvl) .. ']3[light_bg]/[' .. ylb2(lvl) .. ']6 [fg]- 아군 누커 광역 데미지/범위 [' .. ylb1(lvl) .. ']+15%[light_bg]/[' .. ylb2(lvl) .. ']+25%' end,
  ['conjurer'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- [' .. ylb1(lvl) .. ']+25%[light_bg]/[' .. ylb2(lvl) .. ']+50% [fg]설치물 데미지/지속시간' end,
  ['psyker'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 사이커 오브 [' .. ylb1(lvl) .. ']+2[light_bg]/[' .. ylb2(lvl) .. ']+4, 사이커 1명당 [yellow]+1[fg] 오브' end,
  ['curser'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 아군 커서 최대 저주 대상 [' .. ylb1(lvl) .. ']+1[light_bg]/[' .. ylb2(lvl) .. ']+3' end,
  ['forcer'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 모든 아군 밀침 강도 [' .. ylb1(lvl) .. ']+25%[light_bg]/[' .. ylb2(lvl) .. ']+50%' end,
  ['swarmer'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 잡몹 타격 횟수 [' .. ylb1(lvl) .. ']+1[light_bg]/[' .. ylb2(lvl) .. ']+3' end,
  ['voider'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 아군 보이더 시간당 데미지 [' .. ylb1(lvl) .. ']+20%[light_bg]/[' .. ylb2(lvl) .. ']+40%' end,
  ['sorcerer'] = function(lvl)
    return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4[light_bg]/[' .. ylb3(lvl) .. ']6 [fg]- 소서러 공격 [' ..
      ylb1(lvl) .. ']4[light_bg]/[' .. ylb2(lvl) .. ']3[light_bg]/[' .. ylb3(lvl) .. ']2[fg]회마다 1회 반복'
  end,
  ['mercenary'] = function(lvl) return '[' .. ylb1(lvl) .. ']2[light_bg]/[' .. ylb2(lvl) .. ']4 [fg]- 적 사망 시 [' .. ylb1(lvl) .. ']+8%[light_bg]/[' .. ylb2(lvl) .. ']+16% 확률로 골드 드롭' end,
  ['explorer'] = function(lvl) return '[yellow]+15%[fg] 공격속도와 공격력 (활성 클래스당, 아군 탐험가)' end,
}