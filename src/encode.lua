local function pairs_sorted_by_keys(t, f)
  local a = {}
  for n in pairs(t) do
    table.insert(a, n)
  end
  table.sort(a, f)
  local i = 0
  return function()
    i = i + 1
    if a[i] ~= nil then
      return a[i] ~= nil and a[i], t[a[i]]
    end
  end
end

local function gen_spaces(n)
  return string.rep(' ', n)
end

local esc_map = {
  ['\\'] = [[\]],
  ['"'] = [[\"]],
  ['/'] = [[\/]],
  ['\b'] = [[\b]],
  ['\f'] = [[\f]],
  ['\n'] = [[\n]],
  ['\r'] = [[\r]],
  ['\t'] = [[\t]],
  ['\a'] = [[\u0007]],
  ['\v'] = [[\u000b]]
}

local function escape_str(s)
  for k, v in pairs(esc_map) do
    s = s:gsub(k, v)
  end
  return s
end

local function handle(config, null)
  local pairs = config.sort_keys and pairs_sorted_by_keys or pairs
  local nln = config.pretty and '\n' or ''
  local spc = config.pretty and ' ' or ''
  local escape_string = config.escape_string_values and escape_str or tostring
  local function func(tbl, indent)
    local typ = type(tbl)
    if tbl == null then
      return 'null'
    elseif typ == 'table' then
      local is_arr = not (not tbl[1])
      local open = is_arr and '[' or '{'
      local close = is_arr and ']' or '}'
      local str = ''
      for key, val in pairs(tbl) do
        local key_str = is_arr and '' or '"' .. escape_str(key) .. '":' .. spc
        str = str == '' and str or str .. ','
        str = str .. nln .. gen_spaces(indent + config.spaces) .. key_str .. func(val, indent + config.spaces)
      end
      return str ~= '' and open .. str .. nln .. gen_spaces(indent) .. close or '[]'
    elseif typ == 'string' then
      return '"' .. escape_string(tbl) .. '"'
    else
      return tostring(tbl)
    end
  end
  return func
end

return function(null)
  return function(tbl, config)
    config = config or {}
    config.sort_keys = config.sort_keys or false
    config.pretty = config.pretty or false
    config.escape_string_values = config.escape_string_values or config.escape_string_values == nil
    config.spaces = config.pretty and (config.spaces or 2) or 0
    config.append = config.append or '\n'
    return handle(config, null)(tbl, 0) .. config.append
  end
end
