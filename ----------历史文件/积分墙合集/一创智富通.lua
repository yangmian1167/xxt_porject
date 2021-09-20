nLog = require('nLog')()
require('faker')
require('xxtsp')
--require('lianxin')
--require("jiema")
require("name")

--require("LuaDemo")


if not(xxtinstall())then
	log("伪装失效")
	os.exit()
else
	XXTFaker = require("XXTFaker")()
end

function atexit(callback) -- 参数为一个函数，使用 atexit(一个函数) 注册一个函数在脚本结束时执行，建议不要耗时太长
	____atexit_guard____ = ____atexit_guard____ or {}
	if type(____atexit_guard____) == 'table' then
		if not getmetatable(____atexit_guard____) then
			setmetatable(____atexit_guard____, {
					__gc = function(self)
						if type(self.callback) == 'function' then
							pcall(self.callback)
						end
					end
				})
		end
		____atexit_guard____.callback = callback
	else
		error('别用 `____atexit_guard____` 命名你的变量。')
	end
end
--[[
atexit(function() 
		sys.toast('脚本结束了！')
		vpnx()
		local appbids = app.front_bid()
		if appbids ~= "com.apple.springboard" then
			app.quit(appbids)
--			closeX(appbids)
		end
		sys.msleep(500)
	end)
--]]--

phonenamelist = {}

for i=1,40 do
	key = "iPhone"..i
	phonenamelist[key]="nj"..i
end

--[[
local appbids = app.front_bid()
if appbids ~= "com.apple.springboard" then
	app.quit(appbids)
	vpnx()
--	closeX(appbids)
end
--]]


screen.init(0)
var = {}
var.lun = 0


--[[]]
function _vCode_sf() --顺丰

	local	User = 'wenfree'
	local	Pass = 'AaDd112211'
	local PID = '396'
    local token,number = "75044e220f7e11eb81a2008cfa0433f8",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://103.91.211.167/api/login?userName='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.msg == success or RetStr.msg == 'success' then
						token = RetStr.token
						log('token='..token,true)
						break
					end
				else
					log(RetStr)
				end
			end
			return RetStr;
        end), 
		getPhone=(function()
				local RetStr=""
--				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token.. "&operator=exclude4"
				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token
				log(url___)
				RetStr = get(url___)
				if RetStr ~= "" and  RetStr ~= nil then
					log(RetStr)
					RetStr = string.split(RetStr,"|")
				end
				delay(3)
				if RetStr[1] == 0 or RetStr[1]== '0' then
					number = RetStr[2]
					log(number)
					local phone_title = (string.sub(number,1,3))
	--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
	--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
	--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
					local blackPhone = {}
					for k,v in ipairs(blackPhone) do
						if phone_title == v then
							local lx_url =	'http://103.91.211.167/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..token
							get(lx_url);
							log("拉黑->"..number)
							delay(3)
							return false
						end
					end
					return number
				end
		end),
		getMessage=(function()
			local Msg
            for i=1,25,1 do
				sys.msleep(3000)
				RetStr = get("http://103.91.211.167/api/getMessage?sid="..PID.."&token="..token.."&phone="..number)
				log(RetStr);
				if RetStr then
					local arr = string.split(RetStr,"|") 
					if arr[1] == '0' then 
						Msg = arr[2]
						local i,j = string.find(Msg,"%d+")
						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
            end
            return false
        end),
	   
        addBlack=(function()
			local lx_url =	'http://103.91.211.167/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--]]
--[[
function _vCode_fz() --飞猪
			
	local User = '42b1cb45-6dc0-4f82-afe1-d70278c93969'
	local Pass = 'yangmian121'
	local PID = '11152'
    local token,number = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmIzNWEzZDE3ZWM2NTJjMzAxMDE4ZmMiLCJhcGlBY2NvdW50IjoiNDJiMWNiNDUtNmRjMC00ZjgyLWFmZTEtZDcwMjc4YzkzOTY5IiwiaWF0IjoxNjA1NTkzNzc0fQ.bZP8VltPiZvtS9XvWza1o7F3ahi0mm6rD15V8Sizo28",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://api.tsscode.com/api/yhdl?password='..Pass..'&apiAccount='..User
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.result == '成功' then
						token = RetStr.token
						log('token='..token,true)
						break
					end
				else
					log(RetStr)
				end
			end
			return RetStr;
        end), 
		getPhone=(function()
				local RetStr=""
--				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token.. "&operator=exclude4"
				local url___ = "http://api.tsscode.com/api/yhqh_s?token="..token.."&id="..PID..'&cardType=1'..'&pingtaika=1'
				log(url___)
				RetStr = get(url___)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.result == '成功' then
						number = RetStr.number
						log(number)
					end
					local phone_title = (string.sub(number,1,3))
	--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
	--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
	--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
					local blackPhone = {}
					for k,v in ipairs(blackPhone) do
						if phone_title == v then
							local lx_url =	'http://103.91.211.167/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..token
							get(lx_url);
							log("拉黑->"..number)
							delay(3)
							return false
						end
					end
					return number
				end
		end),
		getMessage=(function()
			local Msg
            for i=1,25,1 do
				sys.msleep(3000)
				local url___ = "http://api.tsscode.com/api/yhjm?token="..token.."&id="..PID.."&number="..number..'&apiAccount='..User
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					RetStr = json.decode(RetStr)
					if  RetStr.result == '成功' then
						Msg = RetStr.verificationCode
--						local i,j = string.find(Msg,"%d+")
--						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
            end
            return false
        end),
	   
        addBlack=(function()
			local lx_url =	'http://api.tsscode.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--]]
function _vCode_fz() --飞猪新
			
	local User = '42b1cb45-6dc0-4f82-afe1-d70278c93969'
	local Pass = 'yangmian121'
	local PID = '11152'
    local token,number = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmIzNWEzZDE3ZWM2NTJjMzAxMDE4ZmMiLCJhcGlBY2NvdW50IjoiNDJiMWNiNDUtNmRjMC00ZjgyLWFmZTEtZDcwMjc4YzkzOTY5IiwiaWF0IjoxNjA1NTkzNzc0fQ.bZP8VltPiZvtS9XvWza1o7F3ahi0mm6rD15V8Sizo28",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://api.yumoyumo.com/api/yhdl?password='..Pass..'&apiAccount='..User
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.result == '成功' then
						token = RetStr.token
						log('token='..token,true)
						break
					end
				else
					log(RetStr)
				end
			end
			return RetStr;
        end), 
		getPhone=(function()
				local RetStr=""
--				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token.. "&operator=exclude4"
				local url___ = "http://api.yumoyumo.com/api/yhqh_s?token="..token.."&id="..PID..'&cardType=1'..'&pingtaika=1'
				log(url___)
				RetStr = get(url___)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.result == '成功' then
						number = RetStr.number
						log(number)
					end
					local phone_title = (string.sub(number,1,3))
	--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
	--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
	--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
					local blackPhone = {}
					for k,v in ipairs(blackPhone) do
						if phone_title == v then
							local lx_url =	'http://api.yumoyumo.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
							get(lx_url);
							log("拉黑->"..number)
							delay(3)
							return false
						end
					end
					return number
				end
		end),
		getMessage=(function()
			local Msg
            for i=1,25,1 do
				sys.msleep(3000)
				local url___ = "http://api.yumoyumo.com/api/yhjm?token="..token.."&id="..PID.."&number="..number..'&apiAccount='..User
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					RetStr = json.decode(RetStr)
					if  RetStr.result == '成功' then
						Msg = RetStr.verificationCode
--						local i,j = string.find(Msg,"%d+")
--						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
            end
            return false
        end),
	   
        addBlack=(function()
			local lx_url =	'http://api.yumoyumo.com/api/yhlh?token='..token..'&number='..number..'&id='..PID
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
dxcode = _vCode_sf()
--dxcode = _vCode_fz()


function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = '一创智富通'
	idfalist.idfa = idfa or phone
	idfalist.ip = '192.168.1.1'
	idfalist.ip = ip or '192.168.1.1'
	idfalist.account = account or locals or get_local() or '未知'
	idfalist.password = password
	idfalist.phone = phone
	idfalist.other = other
	return post(url,idfalist)
end

function checkip()
	local url = 'http://idfa888.com/Public/idfa/?service=idfa.checkip&ip='..ip
	local getdata = get(url)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if data.data.state == "ok" then
			log("ip可以用:OK.",true)
			return true
		else
			log("ip, 排重失败",true)
		end
	end
end

function checkphone()
--	ip = get_ip() or "192.168.1.1"
--	log(ip)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=Ip.Checkphone&name=婚恋网&phone='..phone
	local getdata = get(url)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if data.data.state == "ok" then
			log("手机号可以用:OK.",true)
			return true
		else
			log("手机重复, 排重失败",true)
		end
	end
end

function rd(n,k)
	return math.random(n,k)
end

function appname(bid)
	return app.localized_name(bid) or '未安装'
end

phonekeyArr = {
	{104,  760, 0xffffff},
	{317,  768, 0xffffff},
	{526,  755, 0xffffff},
	{112,  866, 0xffffff},
	{330,  869, 0x696969},
	{522,  874, 0xffffff},
	{115,  977, 0xffffff},
	{322,  978, 0x000000},
	{544,  962, 0x000000},
	[0]={316, 1081, 0xffffff},
}

function phoneKey(phone)
	for i =1,string.len(phone) do
		local phone_mun = tonumber(string.sub(phone,i,i))
		click(phonekeyArr[phone_mun][1],phonekeyArr[phone_mun][2],0.3)
	end
end

function get_local()
    local done = false
	local outtime = os.time()
    thread.dispatch(function()
		outtime = os.time()
        while (os.time()-outtime < 30) do
            if (done) then
                sys.toast("", -1)
                return
            else
                sys.toast("正在获取 IP 地址...", device.front_orien())
            end
            sys.msleep(2000)
        end
    end)
    while (os.time() - outtime < 30) do
--		local c, h, b = http.get("http://ip.chinaz.com/getip.aspx?ts="..tostring(sys.rnd()), 30)
--		local c, h, b = http.get("http://pv.sohu.com/cityjson?ie=utf-8", 30)
--		local c, h, b = http.get("https://wenfree.cn/api/app.php?s=App.IP.GetInfo", 30)
		local c, h, b = http.get("http://idfaapi.wenfree.cn/?s=App.IP.GetInfo", 30)
--        local c, h, b = http.get("https://www.ipip.net/",30)
        if (c==200) then
            sys.toast("", -1)
            done = true
--            return b:match('%d+%.%d+%.%d+%.%d+'),b:match('所在地理位置：<code>.*</code>')
            return b:match('%d+%.%d+%.%d+%.%d+'),b:match('cname.*}')
        end
    end
end

function get_task()
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.gettask'
	local postArr = {}
	postArr.phonename = phonename or device.name()
	postArr.imei = phoneimei or sys.mgcopyanswer("SerialNumber")
	local taskData = post(url,postArr)
	
	if taskData ~= nil then
		taskData = json.decode(taskData)
		log(taskData)
		
		if taskData.data == "新增手机" or taskData.data == "暂无任务" then
			log(taskData.data,true)
			delay(30)
			return false
		else
			return taskData.data
		end
	end
end

function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	log( post(url,postArr) )
end

bid={}
bid.app = 'com.fcsc.tztiphone'

url确认打开界面 = {{{358, 334, 0xffffff},{328, 325, 0xffffff},{282, 325, 0x007aff},{106, 277, 0xe61602},{150, 222, 0xf8e6b4},}, 85, 31, 143, 512, 369}
function open_url()
	local TimeLine = os.time()
	local OutTime = 20
	openUrl('https://apps.apple.com/cn/app/id948148133')
	while os.time()-TimeLine < OutTime do
		if d(url确认打开界面,'url确认打开界面') then
			return true
		else
			delay(2)
		end
	end	
	return false
end


tips = {}
tips_同意并继续 = {{{504, 914, 0xed3e26},{456, 915, 0xffffff},{377, 912, 0xf48475},{174, 918, 0x898989},{178, 919, 0xffffff},}, 85, 69, 855, 566, 961}
tips_跳过 = {{{530, 77, 0xf6dedd},{500, 71, 0xcd403b},{518, 64, 0xf6d9d8},{561, 66, 0xffffff},{566, 66, 0xd0423d},}, 85, 481, 32, 602, 126}
tips_网络超时 = {{{336, 640, 0xdadada},{277, 635, 0xf24957},{382, 646, 0xf24957},{414, 622, 0xf24957},}, 85, 180, 586, 465, 690}
tips_系统提示确定= {{{384, 806, 0xf24957},{258, 788, 0xf24957},{399, 776, 0xf24957},{336, 791, 0xdadada},}, 85, 193, 748, 448, 834}
tips_输入股票取消= {{{604,  88, 0xffffff},{611,  88, 0x3b3a3e},{556,  61, 0x3b3a3e},{572,  73, 0xffffff},{617, 110, 0x3b3a3e},}, 85, 546, 40, 634, 123}
首页 = {{{63, 1091, 0xffffff},{63, 1075, 0xcda76e},{44, 1059, 0xffffff},{52, 1111, 0xcda76e},{81, 1108, 0xffffff},}, 85, 32, 1047, 108, 1132}
行情 = {{{192, 1073, 0xcda76e},{177, 1072, 0xcda76e},{175, 1110, 0xd0ad78},{206, 1114, 0xfcf9f5},{211, 1088, 0xcda76e},}, 85, 162, 1061, 228, 1127}
我的 = {{{576, 1101, 0xffffff},{577, 1090, 0xcda76e},{577, 1076, 0xfaf6f0},{576, 1064, 0xcda76e},{567, 1119, 0xd0ad78},}, 85, 548, 1051, 613, 1129}
手机号码验证界面 = {{{428,  83, 0xffffff},{308,  83, 0xffffff},{308,  82, 0xffffff},{205,  62, 0x3b3a3e},{449, 105, 0x3b3a3e},}, 85, 193, 55, 455, 112}
手机号码验证界面_获取验证码 = {{{498, 359, 0xffffff},{436, 350, 0xc1975b},{586, 377, 0xc1975b},}, 85, 396, 311, 624, 410}
手机号码验证界面_下一步 = {{{325, 514, 0xffffff},{103, 479, 0xc1975b},{564, 547, 0xc1975b},}, 85, 12, 452, 631, 576}
注册成功登陆账户 = {{{456, 633, 0x2287d6},{437, 633, 0x2287d6},{195, 628, 0xe5e5e5},{199, 628, 0xffffff},{406, 637, 0xffffff},}, 85, 12, 452, 631, 576}
注册成功登陆账户2 = {{{460, 636, 0x2287d6},{413, 634, 0x2287d6},{202, 639, 0x999999},{202, 635, 0xffffff},{242, 416, 0x9e9e9e},{241, 415, 0xffffff},}, 85, 132, 368, 541, 668}
已注册过_个人信息界面 = {{{354, 649, 0xffffff},{276, 648, 0xffffff},{ 94, 637, 0xff6138},{555, 679, 0xff6138},{553, 608, 0xf5f5f5},}, 85, 29, 595, 621, 710}

编辑自选_完成 = {{{100, 77, 0xffffff},{ 90, 72, 0x8d8d8f},{ 61, 75, 0xffffff},{ 49, 97, 0xc2c1c3},{ 71, 97, 0x656468},}, 85, 38, 59, 115, 107}
网络故障_重新加载 = {{{343, 827, 0xffffff},{296, 819, 0xffffff},{259, 807, 0xffffff},{197, 795, 0xd64113},{480, 852, 0xd64113},{491, 787, 0xd64113},}, 85, 123, 758, 513, 876}




function reg()
	local TimeLine = os.time()
	local OutTime = 60*3

	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 提交 = false
	local 后退 = false
--	local 密码 = true
	local 提交过了 = false
	local movekey = 1
	取短信次数 = 0
	发验证码次数 = 0
	sex = rd(1,100)
	sex_key = 50
--	password = myRand(4,rd(8,12))
	password = 'AaDd112211'

	while os.time()-TimeLine < OutTime do
		if active(bid.app,10)then
			if d(手机号码验证界面,'手机号码验证界面') then
				
				if 取号 then
					phone = dxcode.getPhone()
--					log(phone)
					number = phone
					if phone ~= nil or phone ~= '' then
						if type(tonumber(phone)) == "number" then
							delay(1)
							click(136, 284)
							input(phone)
							取号 = false
							短信 = true
						end
					end
				elseif 短信 then
					if d(手机号码验证界面_获取验证码,'手机号码验证界面_获取验证码',true) then
					else
						yzm = dxcode.getMessage()
--						log(yzm)
						if yzm ~= nil or yzm ~= '' then
							click(143, 367)
							delay(1)
							input(yzm)			
							短信 = false
							提交 = true
--						else
--							return false
						end
					end	
				elseif d(手机号码验证界面_下一步,'手机号码验证界面_下一步',true)  then
				end	
			elseif 提交 and d(注册成功登陆账户,'注册成功登陆账户') or 提交 and d(注册成功登陆账户2,'注册成功登陆账户2') then
				up('一创智富通','注册成功')
				dxcode.addBlack()
				delay(3)	
				return true
			elseif 提交 and d(已注册过_个人信息界面,'已注册过_个人信息界面')then
--				up('一创智富通','注册成功')
				dxcode.addBlack()
				delay(3)
				return false
			elseif d(tips_同意并继续,'tips_同意并继续') then
				click(104, 827)
				d(tips_同意并继续,'tips_同意并继续',true)
			elseif d(tips_网络超时,'tips_网络超时',true) then
			elseif d(tips_跳过,'tips_跳过',true) then
			elseif d(tips_系统提示确定,'tips_系统提示确定',true) then
			elseif d(编辑自选_完成,'编辑自选_完成',true) then
			elseif d(tips_输入股票取消,'tips_输入股票取消',true) then
			elseif d(网络故障_重新加载,'网络故障_重新加载') then
				return false
			elseif d(首页,'首页') or d(行情,'行情') then
				click(578, 1079)
			elseif d(我的,'我的')  then
				click(239, 233)
			end
		end
		delay(1)
	end
end	








--[[]]
function main(v)
	task_id = v.task_id
	vpnx()
--	dxcode.login()
	delay(3)
	if false or vpn() then
		ip,locals = get_local()
		if ip ~= "192.168.1.1" and ip~= nil then
			if true or checkip()then
				if false or XXTfakerNewPhone(bid.app)then
					idfa = XXTfakerGetinfo(bid.app)['IDFA']
					delay(2)
					XXTfakerNewPhone('com.apple.mobilesafari')
					if open_url() then
						if reg()then
							back_pass(task_id,"ok")
	--					else
							--yzm.get.cancelRecv()
						end	
					end
				end
	
			end
		end
	end
--	app.quit(bid.app)
--	delay(2)
end

--]]

















