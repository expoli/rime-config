require("wnl")
local date = require("date")
local tb = {'星期日','星期一','星期二','星期三','星期四','星期五','星期六'}
local tb2 = {'一','二','三','四','五','六', '日'}

-- 计算目标时间的相关信息,输出字符串列表
local function CalcDateYmd(year, month,day, hour, minute)
	year = math.type(year)=="integer" and year or os.date("%Y", os.time())
	month = math.type(month)=="integer" and month or os.date("%m", os.time())
	day = math.type(day)=="integer" and day or os.date("%d", os.time())
	hour = math.type(hour)=="integer" and hour or 0
	minute = math.type(minute)=="integer" and minute or 0
	local d = date(year,month,day)
	local wkn = d:getweekday()
	local dateformated = {
		date = d:getyear() .. '年' .. d:getmonth() .. '月' .. d:getday() .. '日',
		dateweekday = d:getyear() .. '年' .. d:getmonth() .. '月' .. d:getday() .. '日' .. tb[wkn],
		lunarday = Lunar(d:getyear(), d:getmonth(), d:getday()),
		weekday = tb[wkn],
		time = string.format("%02d", hour) .. ":" .. string.format("%02d", minute),
		timec = tostring(hour) .. "时" .. tostring(minute) .. "分",
		timewithdate = d:getyear() .. '年' .. d:getmonth() .. '月' .. d:getday() .. '日'.. os.date("%H时%M分")
	}
	return dateformated
end

local function GetNearWeekDayN(n, subfix)
	local cy = tonumber(os.date("%Y", os.time()))
	local cm = tonumber(os.date("%m", os.time()))
	local cd = tonumber(os.date("%d", os.time()))
	local cw = (tonumber(os.date("%w", os.time())) == 0) and 7 or tonumber(os.date("%w", os.time()))
	local offset = (subfix=='z' and (n - cw)) or ((subfix=='x') and ((cw == 0 and 1) or (7-cw+n))) or ((cw == 0 and ( n - 14)) or (n-cw-7))
	return  CalcDateYmd(cy, cm, cd+offset)
end

function Date_Translator(input, seg, env)
	if not (input:match("^/date$") 
		or input:match("^/time$")
		or input:match("/%d%d%d%d%d%d[0123]%d[gn]?r?$") 
		or input:match("/%d%d%d%d%d%d[0123]%d[hq]%d+[^0-9]$") 
		or input:match('/%d+[hq]')
		or input:match('/[1-7][xsz]'))
		then
			return
	end
	local t = os.time()
	local cy = tonumber(os.date("%Y", os.time()))
	local cm = tonumber(os.date("%m", os.time()))
	local cd = tonumber(os.date("%d", os.time()))
	local ch = tonumber(os.date("0%H", os.time()))
	local cmn = tonumber(os.date("0%M", os.time()))
	if (input == "/date") then
		local res = CalcDateYmd(cy, cm, cd)
		yield(Candidate("date", seg.start, seg._end, res.date, ""))
		yield(Candidate("date", seg.start, seg._end, res.dateweekday, ""))
		yield(Candidate("weekday", seg.start, seg._end, res.weekday, "" ))
		yield(Candidate("date", seg.start, seg._end, res.lunarday.sz, ""))
		yield(Candidate("date", seg.start, seg._end, res.lunarday.gz, ""))
	elseif (input == "/time") then
		local res = CalcDateYmd(cy, cm, cd, ch, cmn)
		yield(Candidate("time", seg.start, seg._end, res.time, ""))
		yield(Candidate("time", seg.start, seg._end, res.timec, ""))
		yield(Candidate("time", seg.start, seg._end, res.timewithdate, ""))
	elseif input:match("^/%d%d%d%d%d%d[0123]%dnr?$") then
		local segment = env.engine.context.composition:back()
		local of = 1
		local yr =tonumber(input:sub(of+1, of+4))
		local mon=tonumber(input:sub(of+5, of+6))
		local day=tonumber(input:sub(of+7, of+8))
		local isleap = false
		if input:match("nr$") then isleap = true end
		local calcDate = LunarToCommon(yr, mon, day, isleap)
		if calcDate == nil then
			segment.prompt = "闰月错误"
		end
		local subfix = "农历反查"
		local res = CalcDateYmd(calcDate.year, calcDate.month, calcDate.day)
		yield(Candidate("weekday", seg.start, seg._end, res.date, subfix ))
		yield(Candidate("weekday", seg.start, seg._end, res.dateweekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.weekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.sz, ""))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.gz, ""))
	elseif input:match("/%d%d%d%d%d%d[0123]%d$") then
		local of = 1
		local yr = tonumber(input:sub( of+1, of+4))
		local mon= tonumber(input:sub( of+5, of+6))
		local day= tonumber(input:sub( of+7, of+8))
		local res = CalcDateYmd(yr, mon, day)
		yield(Candidate("weekday", seg.start, seg._end, res.date, "日期" ))
		yield(Candidate("weekday", seg.start, seg._end, res.dateweekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.weekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.sz, ""))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.gz, ""))
	elseif input:match("/%d%d%d%d%d%d[0123]%dg$") then
		local of = 1
		local yr  =tonumber(input:sub(of+1, of+4))
		local mon =tonumber(input:sub(of+5, of+6))
		local day =tonumber(input:sub(of+7, of+8))
		local dc = date(false)
		local y,m,d = dc:getdate()
		local d = date.diff(date(yr, mon, day), date(y,m,d))
		local gapstr =   tostring(math.floor(d:spandays()))
		local cmt = "距离今天的日期间隔"
		yield(Candidate("gap", seg.start, seg._end, gapstr, cmt ))
	elseif input:match("/%d%d%d%d%d%d[0123]%d[hq]%d+[^0-9]$") then
		local of = 1
		local yr=input:sub(of+1, of+4)
		local mon=input:sub(of+5, of+6)
		local day=input:sub(of+7, of+8)
		local offset = tonumber(input:sub(of+10, string.len(input)-1))
		local subfix = CalcDateYmd(yr, mon, day).date
		local dd = 0
		if input:match("/%d%d%d%d%d%d[0123]%dh%d+d$") then
			dd = day + offset
			subfix = subfix .. '后第' .. offset .. '天'
		else
			dd = day - offset
			subfix = subfix .. '前第' .. offset .. '天'
		end
		local res = CalcDateYmd(yr, mon, dd)
		yield(Candidate("weekday", seg.start, seg._end, res.date, subfix ))
		yield(Candidate("weekday", seg.start, seg._end, res.dateweekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.weekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.sz, ""))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.gz, ""))
	elseif input:match('/%d+[hq]') then
		local str = input:sub( 2, string.len(input)-1)
		local subfix = (input:match( 'h$') and '天后') or '天前'
		local dateinfo = input:match("h$") and {year = cy, month = cm, day = cd + tonumber(str)} or {year=cy, month=cm, day=cd-tonumber(str)} 
		local res = CalcDateYmd(dateinfo.year, dateinfo.month, dateinfo.day)
		yield(Candidate("dateoffset", seg.start, seg._end, res.date, str..subfix ))
		yield(Candidate("dateoffset", seg.start, seg._end, res.dateweekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.weekday, "" ))
		yield(Candidate("dateoffset", seg.start, seg._end, res.lunarday.sz, ""))
		yield(Candidate("dateoffset", seg.start, seg._end, res.lunarday.gz, ""))
	elseif input:match('/[1-7][xsz]') then
		local wd = tonumber(input:sub(2, string.len(input)-1))
		local le = input:match('[sxz]')
		local prefix = (le=='s' and '上周') or ((le=='x' and '下周') or '这周')
		local res = GetNearWeekDayN(wd, le)
		yield(Candidate("weekday", seg.start, seg._end, res.date, prefix..tb2[wd] ))
		yield(Candidate("weekday", seg.start, seg._end, res.dateweekday, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.sz, "" ))
		yield(Candidate("weekday", seg.start, seg._end, res.lunarday.gz, "" ))
	end
end

function Date_Tips()
	local res = "/date\t日期\r"
	res = res .. "/time\t时间\r"
	res = res .. "/[1-7]x\t下周x\r"
	res = res .. "/[1-7]s\t上周x\r"
	res = res .. "/[1-7]z\t这周x\r"
	res = res .. "/\\d+h\tx天后\r"
	res = res .. "/\\d+q\tx天前\r"
	res = res .. "/20220906\t2022年9月6日的日期\r"
	res = res .. "/20220906n\t二零二二年九月初六的反查\r"
	res = res .. "/20200406nr\t二零二零年闰四月初六的反查\r"
	res = res .. "/20220909g\t2022年9月9日到今天的间隔\r"
	res = res .. "/20220906h\\d+[^0-9]\t2022年9月6日后x天\r"
	res = res .. "/20220906q\\d+[^0-9]\t2022年9月6日前x天"

	return res
end
