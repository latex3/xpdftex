require('expl3.lua')
xpdftex = {}

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


local function write_or_execute()
  local s = token.scan_int()
  if (s==18) then
     local t = token.create("__sys_shell_now:e")
     token.put_next(t)
  else
     if (s<0) then
      local t = token.create("m@ne")
      token.put_next(token.create("tex_write:D"),t)
     else
      token.set_char("@@!tmp",s)
      local t = token.create("@@!tmp")
      token.put_next(token.create("tex_write:D"),t)
     end
  end
end
xpdftex.write_or_execute=write_or_execute
