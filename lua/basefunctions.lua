function single_char_first_filter(input)
	local l = {}
	for cand in input:iter() do
		if (utf8.len(cand.text) == 1) then
			yield(cand)
		else
			table.insert(l, cand)
		end
	end
	for i, cand in ipairs(l) do
		yield(cand)
	end
end

-- 在词典里面候选支持\r分割分行
-- 方案patch中要添加以下两行
--  engine/filters/+:
--  - lua_filter@Multiline_filter
function Multiline_filter(input)
	for cand in input:iter() do
		if cand.text:match("\\r") then
			local nt = string.gsub(cand.text, "\\r", utf8.char(13))
			local cnd = Candidate("", cand.start, cand._end, nt, cand.comment)
			yield(cnd)
		else
			yield(cand)
		end
	end
end

function Tip_Filter(input, env, cands)
	for cand in input:iter() do
		if cand.type:match("^tip") then
			cand.comment = cand.text
			cand.text = ""
		end
		yield(cand)
	end
end
