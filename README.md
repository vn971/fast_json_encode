Fast JSON encoder (formatter, printer) for Lua.

Pros:

* It uses [String Buffers](https://www.lua.org/pil/11.6.html) for fast string concatenation
* It's written in Lua, 1 file, 101 LoC
* It's fast (not as fast as a C library would be though)

Cons:

* It only allows formatting (encoding). Decoding is not supported.
* It only produces "minimized" JSON.
* Only `string`, `number` and `boolean` can be used as table keys. Everything else is converted "lossy".
* It does not distinguish "arrays" and "tables", because making such distinction would be too expensive in Lua. On the upside, all tables are handled uniformly.

Implementations:
* "simple" -- minimum LoC. No string escaping.
* "correct" -- as fast as I could write it while being correct.

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
If you'll use the project, please "star" it, so that others would know it's in use.
