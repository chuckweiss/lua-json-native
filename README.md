# lua-json-native

JSON decoder and encoder for Lua

```Lua
local lua_json_native = require('lua-json-native')

lua_json_native.encode()
lua_json_native.decode()
lua_json_native.null
```

## decode

### Synopsis

```Lua
table = lua_json_native.decode(json_string, [, config])
```

### Arguments

**json_string**
A JSON value string to be decoded.

**config**
A optional table that contains the following optional field:

- `use_null` boolean: Set `true` to parse `null` values as `lua_json_native.null`. Default is false, meaning nulls are treated as `nil`

### Returns

Stringified JSON

## encode

### Synopsis

```Lua
json_string = lua_json_native.encode(table, [, config])
```

### Arguments

**table**
A Lua table or value to encode into a JSON string

**config**
A optional table that contains the following optional fields:

- `sort_keys` boolean: Set `true` to sort keys. Default is `false`
- `pretty` boolean: Set `true` to pretty format the JSON string. Default is `false`
- `spaces` integer: The amount of spaces in an indent. Default is `2`. Ignored if `pretty` is `false`
- `escape_string_values` boolean: Set `false` to not escape string values in `table`. Default is `true`

### Returns

A JSON string

## null

### Synopsis

```Lua
null = lua_json_native.null
```

A table that represents a `null`.
When decoding, this table takes the place of nulls found in JSON strings when `use_null` is enabled.
When encoding, if this table is found, a `null` will take its place.
