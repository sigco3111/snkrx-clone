-- engine/external/luasteam.lua — SNKRX 한국어화 fork용 Steam shim
-- 원본은 Steamworks SDK와 연동되지만, 우리는 Steam 클라이언트 없이 게임플레이만 사용.
-- 모든 Steam API 호출을 no-op으로 만들어 호환성 유지.
local M = {}

function M.init() return true end
function M.shutdown() end
-- v0.1 (한국어화 fork): love 11.x의 main loop에서 매 프레임 호출됨.
-- 원본 Steamworks SDK는 내부에서 Steam 콜백을 처리하지만, 우리는 Steam을 사용하지 않으므로 no-op.
function M.runCallbacks() end

M.userStats = {
  requestCurrentStats = function() return true end,
  setAchievement = function() end,
  storeStats = function() end,
  getStatInt = function() return 0 end,
  setStatInt = function() end,
}

M.friends = {
  setRichPresence = function() end,
  activateGameOverlay = function() end,
}

M.utils = {
  getAppID = function() return 915310 end,
}

return M