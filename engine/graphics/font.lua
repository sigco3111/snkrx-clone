-- The base Font class.
-- v0.1: 한국어 폰트 fallback 추가 — love.graphics.newFont가 한글을 못 그리면
-- NotoSansKR-Regular.ttf를 자동으로 사용.
Font = Object:extend()
function Font:init(asset_name, font_size)
  local primary_path = "assets/fonts/" .. asset_name .. ".ttf"
  self.font = love.graphics.newFont(primary_path, font_size)
  self.h = self.font:getHeight()
  self.asset_name = asset_name
  self.size = font_size

  -- 한글 fallback 폰트 (lazy init: 필요할 때만 로드)
  self.ko_font = nil
end


function Font:get_text_width(text)
  if text == nil or type(text) ~= "string" then return 0 end
  -- v0.1: CJK 감지 시 ko_font 사용 (정확한 한글 폭 측정)
  if self.ko_font and self:has_cjk(text) then
    return self.ko_font:getWidth(text)
  end
  return self.font:getWidth(text)
end


function Font:get_height()
  return self.font:getHeight()
end


-- v0.1: 한글 렌더링 지원. 텍스트에 CJK 문자가 있으면 ko_font로 전환.
-- love2d 11.x의 BitmapFont(TTF)는 한글 glyph가 없으면 fallback이 깨지므로
-- 명시적으로 NotoSansKR을 사용.
function Font:_ensure_ko_font()
  if self.ko_font then return self.ko_font end
  local ko_path = "assets/fonts/NotoSansKR-Regular.ttf"
  if love.filesystem.getInfo(ko_path) then
    self.ko_font = love.graphics.newFont(ko_path, self.size)
  else
    self.ko_font = self.font  -- fallback to primary
  end
  return self.ko_font
end


function Font:has_cjk(text)
  if text == nil then return false end
  if type(text) ~= "string" then return false end  -- 숫자/boolean 등 호출 시 안전
  -- v0.1: UTF-8 character 단위로 확인 (lead byte 검사만으로 충분)
  --   0xC0~0xDF: 2-byte (Latin extended)
  --   0xE0~0xEF: 3-byte (한글 AC00~D7A3, CJK Unified Ideographs 4E00~9FFF, Hiragana/Katakana)
  --   0xF0~0xF7: 4-byte (CJK Extension B+, Emoji)
  -- 2-byte (Latin extended) 는 CJK 아님 → 한글/한자만 감지하려면 0xE0 이상 + 한국어/한자 범위 추가 검증.
  -- 단순화: 0xE0 이상이면 CJK 가능성 있다고 보고 ko_font로 전환.
  for i = 1, #text do
    local b = text:byte(i)
    if b >= 0xE0 then return true end
  end
  return false
end


function Font:get_font_for_text(text)
  if self:has_cjk(text) then
    return self:_ensure_ko_font()
  end
  return self.font
end