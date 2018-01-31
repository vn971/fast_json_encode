local next = next
local print = print
local tostring = tostring
local type = type
local table = table

-- WARNING: this code does not do string escaping. See json_format.lua for that.

local function print_table_key(obj, buffer)
	local _type = type(obj)
	if _type == "string" or _type == "number" then
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
		buffer[#buffer + 1] = '{'
		buffer[#buffer + 1] = '"' -- needs to be separate for empty tables {}
		for key, value in next, obj, nil do
			print_table_key(key, buffer)
			buffer[#buffer + 1] = '":'
			format_any_value(value, buffer)
			buffer[#buffer + 1] = ',"'
		end
		buffer[#buffer] = '}' -- note the overwrite
	elseif _type == "string" then
		buffer[#buffer + 1] = '"' .. obj .. '"'
	elseif _type == "boolean" or _type == "number" then
		buffer[#buffer + 1] = tostring(obj)
	elseif _type == "userdata" then
		buffer[#buffer + 1] = '"' .. tostring(obj) .. '"'
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
