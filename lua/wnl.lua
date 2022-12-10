local date = require('date')
local lunarInfo = {
    0x4bd8, 0x4ae0, 0xa570, 0x54d5, 0xd260, 0xd950, 0x5554, 0x56af, 0x9ad0, 0x55d2,
    0x4ae0, 0xa5b6, 0xa4d0, 0xd250, 0xd295, 0xb54f, 0xd6a0, 0xada2, 0x95b0, 0x4977,
    0x497f, 0xa4b0, 0xb4b5, 0x6a50, 0x6d40, 0xab54, 0x2b6f, 0x9570, 0x52f2, 0x4970,
    0x6566, 0xd4a0, 0xea50, 0x6a95, 0x5adf, 0x2b60, 0x86e3, 0x92ef, 0xc8d7, 0xc95f,
    0xd4a0, 0xd8a6, 0xb55f, 0x56a0, 0xa5b4, 0x25df, 0x92d0, 0xd2b2, 0xa950, 0xb557,
    0x6ca0, 0xb550, 0x5355, 0x4daf, 0xa5b0, 0x4573, 0x52bf, 0xa9a8, 0xe950, 0x6aa0,
    0xaea6, 0xab50, 0x4b60, 0xaae4, 0xa570, 0x5260, 0xf263, 0xd950, 0x5b57, 0x56a0,
    0x96d0, 0x4dd5, 0x4ad0, 0xa4d0, 0xd4d4, 0xd250, 0xd558, 0xb540, 0xb6a0, 0x95a6,
    0x95bf, 0x49b0, 0xa974, 0xa4b0, 0xb27a, 0x6a50, 0x6d40, 0xaf46, 0xab60, 0x9570,
    0x4af5, 0x4970, 0x64b0, 0x74a3, 0xea50, 0x6b58, 0x5ac0, 0xab60, 0x96d5, 0x92e0,
    0xc960, 0xd954, 0xd4a0, 0xda50, 0x7552, 0x56a0, 0xabb7, 0x25d0, 0x92d0, 0xcab5,
    0xa950, 0xb4a0, 0xbaa4, 0xad50, 0x55d9, 0x4ba0, 0xa5b0, 0x5176, 0x52bf, 0xa930,
    0x7954, 0x6aa0, 0xad50, 0x5b52, 0x4b60, 0xa6e6, 0xa4e0, 0xd260, 0xea65, 0xd530,
    0x5aa0, 0x76a3, 0x96d0, 0x4afb, 0x4ad0, 0xa4d0, 0xd0b6, 0xd25f, 0xd520, 0xdd45,
    0xb5a0, 0x56d0, 0x55b2, 0x49b0, 0xa577, 0xa4b0, 0xaa50, 0xb255, 0x6d2f, 0xada0,
    0x4b63, 0x937f, 0x49f8, 0x4970, 0x64b0, 0x68a6, 0xea5f, 0x6b20, 0xa6c4, 0xaaef,
    0x92e0, 0xd2e3, 0xc960, 0xd557, 0xd4a0, 0xda50, 0x5d55, 0x56a0, 0xa6d0, 0x55d4,
    0x52d0, 0xa9b8, 0xa950, 0xb4a0, 0xb6a6, 0xad50, 0x55a0, 0xaba4, 0xa5b0, 0x52b0,
    0xb273, 0x6930, 0x7337, 0x6aa0, 0xad50, 0x4b55, 0x4b6f, 0xa570, 0x54e4, 0xd260,
    0xe968, 0xd520, 0xdaa0, 0x6aa6, 0x56df, 0x4ae0, 0xa9d4, 0xa4d0, 0xd150, 0xf252,
    0xd520}


    local solarMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    local Gan = {"甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"}
    local Zhi = {"子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"}
    local Animals = {"鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"}
    local solarTerm = {"小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "冬至"}
    local sTermInfo = {0, 21208, 42467, 63836, 85337, 107014, 128867, 150921, 173149, 195551, 218072, 240693, 263343, 285989, 308563, 331033, 353350, 375494, 397447, 419210, 440795, 462224, 483532, 504758}
    local nStr1 = {'日', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十'}
    local nStr2 = {'初', '十', '廿', '卅', '□'}
    local monthName = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"}
    local cmonthName = {'正', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '腊'}
    


-- 返回农历y年闰哪个月
local function leapMonths(y)
    local a = (lunarInfo[y-1900+1] & 0x0f)
    if a==0x0f then
        return 0
    else
        return a
    end
end
-- 返回农历y年闰月的总天数
local function leapDays(y)
    if leapMonths(y) ~= 0 then
        if lunarInfo[y-1899+1] & 0x0f == 0x0f then
            return 30
        else
            return 29
        end
    else
        return 0
    end
end

local function monthDays(y,m)
    if lunarInfo[y-1900+1] & (0x10000 >> (m-1)) ~= 0 then
        return 30
    else
        return 29
    end
end
-- 返回农历y年的总天数
local function lYearDays(y)
    local i = 0x8000
    local sum=348

    while i > 0x08 do
        if (lunarInfo[y-1900+1] & i ) ~= 0 then
            sum = sum + 1
        end
        i = i>>1
    end
    return (sum + leapDays(y))
end

-- 计算年份干支
local function Ganzhin(y)
    local gan = {'庚','辛','壬','癸','甲','乙','丙','丁','戊','己'}
    local zhi = {'申', '酉', '戌', '亥', '子', '丑', '寅', '卯', '辰', '巳', '午', '未'}
    local res = gan[(y%10) + 1] .. zhi[y%12 + 1]
    return res
end

local function Ganzhiy(y, m)
	local jiaji = {'丙寅', '丁卯', '戊辰', '己巳', '庚午', '辛未', '壬申', '癸酉', '甲戌', '乙亥', '丙子', '丁丑'}
	local yigeng = {'戊寅', '己卯', '庚辰', '辛巳', '壬午', '癸未', '甲申', '乙酉', '丙戌', '丁亥', '戊子', '己丑'}
	local bingxin = {'庚寅', '辛卯', '壬辰', '癸巳', '甲午', '乙未', '丙申', '丁酉', '戊戌', '己亥', '庚子', '辛丑'}
	local dingren = {'壬寅', '癸卯', '甲辰', '乙巳', '丙午', '丁未', '戊申', '己酉', '庚戌', '辛亥', '壬子', '癸丑'}
	local wugui = {'甲寅', '乙卯', '丙辰', '丁巳', '戊午', '己未', '庚申', '辛酉', '壬戌', '癸亥', '甲子', '乙丑'}

    --local Gan = {"甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"}
    --local Zhi = {"子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"}
	local gn = (y-3)%10
    local res
    if gn == 1 or gn == 6 then
        res = jiaji[m]
    elseif gn == 2 or gn == 7 then
        res = yigeng[m]
    elseif gn == 3 or gn == 8 then
        res = bingxin[m]
    elseif gn == 4 or gn == 9 then
        res = dingren[m]
    elseif gn == 5 or gn == 0 then
        res = wugui[m]
    end
	return res
end

local function Ganzhir(year,month,day)
	local C,y
	if month >2 then
		C = year // 100
		y = year % 100
	else
		C = (year-1) // 100
		y = (year-1) % 100
	end
	local M = ((month < 3) and (12 + month)) or month
	local d = day
	local i = ((month%2==1) and 0) or 6
	local G = (4*C + (C//4) + 5*y + (y//4) + (3*(M+1)//5) + d - 3)%10
	local Z = (8*C + (C//4) + 5*y + (y//4) + (3*(M+1)//5) + d + 7 + i)%12
	local res
	if G ~= 0 then
		res = Gan[G]
	else
		res = Gan[10]
	end
	if Z ~= 0 then 
		res = res .. Zhi[Z]
	else
		res = res .. Zhi[12]
	end
	return res
end

-- 输入年月日，返回 农历信息, 数值year, month, day, isLeap
local function LunarInt(y, m, d)
    local d1 = date(1900,1,31)
    local d2 = date(y,m,d)
    local offset = date.diff(d2,d1):spandays()
    -----
    local i=1900
    local temp = 0
    while i < 2100 and offset > 0 do
        temp = lYearDays(i)
        offset = offset - temp
        i = i+1
    end
    if offset < 0 then
        offset = offset + temp
        i = i - 1
    end
    ----
    local year = i
    local leap = leapMonths(i)
    local isLeap = false
    ---------
    i = 1
    while i < 13 and offset > 0 do
        if (leap > 0) and (i == (leap + 1)) and isLeap == false then
            i = i - 1
            isLeap = true
            temp = leapDays(year)
        else
            temp = monthDays(year, i+1)
        end
        if isLeap == true and i == (leap+1) then
            isLeap = false
        end
        offset = offset - temp
        i = i + 1
    end
    if offset == 0 and leap > 0 and i == (leap+1) then
        if isLeap then
            isLeap = false
        else
            isLeap = true
            i = i - 1
        end
    end

    if offset < 0 then
        offset = offset + temp
        i = i - 1
    end
    local month = i
    local day = offset + 1
	return{year = year, month = month, day = day, isLeap = isLeap}
end
-- 输入年月日，返回 农历信息,
-- .sz 为 二零二一年十二月初六 这样的信息
-- .gz 为 辛丑年十二月初六   这样的信息
function Lunar(y, m, d)
	local lunar = LunarInt(y, m, d)
	local year, month, day, isLeap = lunar.year, lunar.month, lunar.day, lunar.isLeap
	--数字表示农历
    local sz = {'零','一','二','三','四','五','六','七','八','九', '十'}
    local nian = sz[year//1000 + 1] .. sz[year%1000//100 + 1] .. sz[year%100//10 + 1] .. sz[year%10 + 1]
	local yue = ''
	local ri = ''
    if month <= 10 and month > 1 then
        yue = sz[month + 1]
	elseif month == 1 then
        yue = '正'
    else
        yue = '十' .. sz[month%10 + 1]
    end
	if isLeap then
		yue = '闰' .. yue
	end
	if day <= 10 then
		ri = '初'.. sz[day + 1]
	elseif day > 10 and day < 20 then
		ri = '十' .. sz[day%10 + 1]
	elseif ri == 20 then
		ri = '二十'
	elseif day > 20 and day < 30 then
		ri = '廿' .. sz[day%10 + 1]
	else
		ri = '三十'
	end

	local res = {
		sz = (nian .. '年' .. yue .. '月' .. ri),
        gz = (Ganzhin(year) .. '年' .. yue .. '月' .. ri )
	}
	return res
end
-- 农历转公历,返回公历日期 year, month, day
function LunarToCommon(year, month, day, _isLeap)
	local y,m,d,isLeap = year, month, day, _isLeap
	if (leapMonths(y) ~= m or leapMonths(y) == 0) and _isLeap then return nil end
	local tmpLuna = LunarInt(y, m, d)
	while tmpLuna.year ~= year or tmpLuna.month ~= month or math.floor(tmpLuna.day) ~= day or tmpLuna.isLeap ~= _isLeap do
		d = d + 1
		tmpLuna = LunarInt(y, m, d)
		--print("当前公历", y, m, d)
		--print("目标农历", year, month, day, _isLeap)
		--print("当前农历", tmpLuna.year, tmpLuna.month, tmpLuna.day, tmpLuna.isLeap)
		--print(math.floor(tmpLuna.day), day)
		--print("---------------------------------------------------------")
	end

	--local t = os.time({year = y, month = m, day = d})
	--local d = os.date("*t", t)
	local d = date(y, m, d)
	return {year = d:getyear(), month = d:getmonth(), day = d:getday()}
end
