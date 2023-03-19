require("mydate")
require("unicode")
require("number")
require("emoji")
require("basefunctions")

-- global lua help tips
function Lua_Tips(input,seg, env)
	if input:match("^/$") then 
		local segment = env.engine.context.composition:back()
		segment.prompt = "~? [获得输入帮助]"
		return
	end
	if input:match("^/%?$") then
		local segment = env.engine.context.composition:back()
		segment.prompt = "Lua快捷输入帮助"
		local emoji_tips = Emoji_Tips()
		local daxie_tips = Daxie_Tips()
		local unicode_tips = Unicode_Tips()
		local date_tips = Date_Tips()
		yield(Candidate("tips", seg._start, seg._end, emoji_tips, ""))
		yield(Candidate("tips", seg._start, seg._end, date_tips, ""))
		yield(Candidate("tips", seg._start, seg._end, unicode_tips, ""))
		yield(Candidate("tips", seg._start, seg._end, daxie_tips, ""))
	end
end
--must after function definitions
local english = require("english")()
english_processor = english.processor
english_segmentor = english.segmentor
english_translator = english.translator
english_filter = english.filter
english_filter0 = english.filter0

