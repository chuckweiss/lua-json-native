local inside_string = false
local escape = false
local stack = {}
local tbl = {}

local char_map = {
  ['['] = '{',
  [']'] = '}',
  [':'] = '='
}

local function default(c)
  if c == '{' then
    table.insert(stack, 'tbl')
  elseif c == '[' then
    table.insert(stack, 'arr')
  elseif c == '}' or c == ']' then
    table.remove(stack)
  end

  if stack[#stack] == 'tbl' and (c == '{' or c == ',') then
    tbl = {']', '['}
  end

  if c == '"' then
    inside_string = true
    return (table.remove(tbl) or '') .. c
  end

  return char_map[c] or c
end

local function string_parser(c)
  if escape then
    escape = false
  elseif c == '\\' then
    escape = true
  elseif c == '"' then
    inside_string = false
    return c .. (table.remove(tbl) or '')
  end
  return c
end

local function handler(c)
  return inside_string and string_parser(c) or default(c)
end

return function(str)
  return load('return ' .. str:gsub('.', handler), 'json-lua', 't', {})()
end
