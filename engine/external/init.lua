local path = ...
if not path:find("init") then
  binser = require(path .. ".binser")
  mlib = require(path .. ".mlib")
  -- if not web then clipper = require(path .. ".clipper") end
  ripple = require(path .. ".ripple")
  -- v0.1 (한국어화 fork): Steam 클라이언트 없이 실행하기 위해 같은 디렉토리의 luasteam.lua shim 사용
  -- 원본은 require 'luasteam' (Steamworks SDK 바인딩)
  steam = require(path .. ".luasteam")
end
