Fast JSON encoder (formatter, printer) for Lua.

Pros:

* It uses [String Buffers](https://www.lua.org/pil/11.6.html) for fast string concatenation
* It's written in Lua
* It's fast (not as fast as a C library would be though)

Cons:

* It only allows formatting (encoding). Decoding is not supported.
* It only produces "minimized" JSON.
* Only `string`, `number` and `boolean` can be used as table keys. Everything else is converted "lossy".
* It does not distinguish "arrays" and "tables", because making such distinction would be too expensive in Lua. On the upside, all tables are handled uniformly.
* It's not battle-tested. If you'll use the project, please start it, so that others (and me) would know it's really in use.

Examples:

* `"test"` => `"test"`
* `1` => `1`
* `true` => `true`
* `{a = "b"}` => `{"a":"b"}`
* `{"arr"}` => `{"1":"arr"}`
* `{a = "arr", [1] = 1}` => `{"1":1,"a":"arr"}`
* `userdata` => `"???userdata???"`
* `{ [{}] = 1 }` => `{"???table???":1}` -- (a table is used as a key)
* `{[1] = 1, ["1"] = 2}` => `{"1":1,"1":2}` -- (Collision! You were warned.)
* `nil` => `null`

License: Public Domain.