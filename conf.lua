function love.conf(t)
  t.version = "11.3"
  -- v0.1 (한국어화 fork): 1280x720 — love.conf 콜백에서 초기 윈도우 크기 결정.
  -- main.lua의 engine_run이 setMode로 덮어쓰기 전까지 이 값이 적용됨.
  -- game_width/height은 main.lua에서 480x270으로 지정 → sx = 1280/480 ≈ 2.67 비율.
  t.window.width = 1280
  t.window.height = 720
  t.window.vsync = 1
  t.window.msaa = 0
  t.window.resizable = true
  -- DPI 스케일링 비활성화 (Retina에서 자동 축소 방지).
  t.window.usedpiscale = false
end
