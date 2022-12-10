-- Unicode quick input
function Unicode_Translator(input, seg, env)
	if not (input:match("^U") or input:match("^/uc")) then return end
	local segment = env.engine.context.composition:back()
	if input:match("^U$") or input:match("^/uc$") then
		segment.prompt = "输入[0-9a-fA-F],以[^0-9a-fA-F]分割两个字符，Unicode"
	end
	if input:match("^U%x+") or input:match('^/uc%x+') then
		local cand = ''
		local cmt = ''
		local rinput = ''
		if string.match(input, "^/uc%x+") then
			rinput = string.sub(input, 4)
		else
			rinput = string.sub(input, 2)
		end
		for s in string.gmatch(rinput, '%x+') do
			if(tonumber(s, 16) >= 0x20 and tonumber(s, 16) <= 0x10ffff) then
				cand = cand .. utf8.char(tonumber(s, 16))
				cmt = cmt .. '\\u+' .. string.upper(s)
			end
		end
		if cand ~= "" then
			local cc = Candidate("Unicode", seg.start, seg._end, cand, cmt)
			yield(cc)
		end
	end
end

function Unicode_Tips()
	return "U\\x+\\X+\\x+ ...\tUnicode\r/uc\\x+\\X+\\x+ ...\tUnicode"
end
