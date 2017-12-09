local next = next
local print = print
local tostring = tostring
local type = type
local gsub = string.gsub
local table = table

local delete_chars = string.char(00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15,
	16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31) -- https://www.ietf.org/rfc/rfc4627.txt
local delete_regexp = "[" .. delete_chars .. "]"

-- escaping takes 2/3 of the time, but we can't avoid it...
local function escape(str)
	return str:gsub(delete_regexp, ""):gsub('\\', '\\\\'):gsub('"', '\\"')
end

local function print_table_key(obj, buffer)
	local _type = type(obj)
	if _type == "string" then
		buffer[#buffer + 1] = escape(obj)
	elseif _type == "number" then
		buffer[#buffer + 1] = obj
	elseif _type == "boolean" then
		buffer[#buffer + 1] = tostring(obj)
	else
		buffer[#buffer + 1] = '???' .. _type .. '???'
	end
end

local function format_any_value(obj, buffer)
	local _type = type(obj)
	if _type == "table" then
		buffer[#buffer + 1] = '{"'
		for key, value in next, obj, nil do
			print_table_key(key, buffer)
			buffer[#buffer + 1] = '":'
			format_any_value(value, buffer)
			buffer[#buffer + 1] = ',"'
		end
		buffer[#buffer] = '}' -- note the overwrite
	elseif _type == "string" then
		buffer[#buffer + 1] = '"' .. escape(obj) .. '"'
	elseif _type == "boolean" or _type == "number" then
		buffer[#buffer + 1] = tostring(obj)
	else
		buffer[#buffer + 1] = '"???' .. _type .. '???"'
	end
end

local function _format_as_json(obj)
	if obj == nil then return "null" else
		local buffer = {}
		format_any_value(obj, buffer)
		return table.concat(buffer)
	end
end

local function _print_as_json(obj)
	print(_format_as_json(obj))
end


format_as_json = _format_as_json
print_as_json = _print_as_json