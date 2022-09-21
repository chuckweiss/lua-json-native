local path = debug.getinfo(1).source:match('@(.*[/\\])') or './'

local null = {}

return {
  decode = dofile(path .. 'src/decode.lua')(null),
  encode = dofile(path .. 'src/encode.lua')(null),
  null = null
}
