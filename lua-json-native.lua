local path = debug.getinfo(1).source:match('@(.*[/\\])') or './'

return {
  decode = dofile(path .. 'src/decode.lua'),
  encode = dofile(path .. 'src/encode.lua')
}
