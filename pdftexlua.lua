require('expl3.lua')
local gsub=string.gsub
local char =string.char
local byte       = string.byte
local utfchar = unicode.utf8.char
local utfbyte = unicode.utf8.byte
local utfgsub = unicode.utf8.gsub

pdftexlua={}

local function byte_to_utf(ch)
    return utfchar(byte(ch))
end
pdftexlua.byte_to_utf=byte_to_utf

local function fake_utf_read(buf)
    return gsub(buf,"(.)", pdftexlua.byte_to_utf)
end
pdftexlua.fake_utf_read = fake_utf_read


local function utf_to_byte(ch)
    return char(utfbyte(ch))
end
pdftexlua.utf_to_byte = utf_to_byte

local function fake_utf_write(buf)
    return utfgsub(buf,"(.)", pdftexlua.utf_to_byte)
end
pdftexlua.fake_utf_write = fake_utf_write

luatexbase.add_to_callback('process_output_buffer', pdftexlua.fake_utf_write, "utf8 writing")
luatexbase.add_to_callback('process_input_buffer', pdftexlua.fake_utf_read, "utf8 reading")

