require('expl3.lua')
local char    = string.char
local byte    = string.byte
local utfchar = utf8.char
local utfbyte = utf8.codepoint

local function fake_utf_read(buf)
    return utfchar(byte(buf, 1, -1))
end

local function fake_utf_write(buf)
    return char(utfbyte(buf, 1, -1))
end

luatexbase.add_to_callback('process_output_buffer', fake_utf_write, "utf8 writing")
luatexbase.add_to_callback('process_input_buffer', fake_utf_read, "utf8 reading")

