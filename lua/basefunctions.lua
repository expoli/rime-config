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

-- 在词典里面候选支持\r, \r\n, \n分割分行
-- 方案patch中要添加以下两行
--  engine/filters/+:
--  - lua_filter@Multiline_filter
function Multiline_filter(input)
	for cand in input:iter() do
		local nt = cand.text
		if nt:match("&nbsp") then
			nt = nt:gsub("&nbsp", " ")	
		end
		if nt:match("\\r\\n") then
			nt = string.gsub(nt, "\\r\\n", "\r")
			local cnd = Candidate("", cand.start, cand._end, nt, cand.comment)
			yield(cnd)
		elseif nt:match("\\r") then
			nt = string.gsub(nt, "\\r", "\r")
			local cnd = Candidate("", cand.start, cand._end, nt, cand.comment)
			yield(cnd)
		elseif nt:match("\\n") then
			nt = string.gsub(nt, "\\n", "\r")
			local cnd = Candidate("", cand.start, cand._end, nt, cand.comment)
			yield(cnd)
		elseif nt:match("<br>") then
			nt = string.gsub(nt, "<br>", "\r")
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
