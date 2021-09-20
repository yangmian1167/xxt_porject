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
function _vCode_yh() --云海

	local	User = 'api_wenfree_q7m'
	local	Pass = 'AaDd112211'
	local PID = '10555'
    local token,number = "a7d707e52c4712cc1e469123d87fa4a3",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://uasea.cn/yhapi.ashx?act=login&ApiName='..User..'&PassWord='..Pass
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
--				local url___ = "http://uasea.cn/yhapi.ashx?act=getPhone&iid="..PID.."&token="..token.."&seq=2"
				local url___ = "http://uasea.cn/yhapi.ashx?act=getPhone&iid="..PID.."&token="..token
				log(url___)
				RetStr = get(url___)
				if RetStr ~= "" and  RetStr ~= nil then
					log(RetStr)
					RetStr = string.split(RetStr,"|")
				end
				delay(3)
				if RetStr[1] == 1 or RetStr[1]== '1' then
					number = RetStr[5]
					_pid = RetStr[2]
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
				RetStr = get("http://uasea.cn/yhapi.ashx?act=getPhoneCode&token="..token.."&pid=".._pid)
				log(RetStr);
				if RetStr then
					local arr = string.split(RetStr,"|") 
					if arr[1] == '1' then 
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
function _vCode_df() --德芙
			
	local User = 'yangmian1167'
	local Pass = 'yangmian121'
	local PID = '14623'
    local token,number = "PBZiItELYmHOTyEOqD2pM/KmorJ4OfdFy5G1Hg6GZUxofrDJXnmOXTyam/NyNyvXMABif1umv1gYMTMNgBds1bWtpusTEB1fp6hgUN9NbWYUCEdXMliUtMncTDqTvwyRlcEroLnuDSEPFYgw4WZyiyKCi5PXl5eOX2ER2cFByNo=",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://api.do889.com:81/api/logins?username='..User..'&password='..Pass
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
				local url___1 = "http://api.do889.com:81/api/get_mobile?token="..token.."&project_id="..PID.."&operator=4"
				local url___2 = "http://api.do889.com:81/api/get_mobile?token="..token.."&project_id="..PID
				math_ = math.random(6,10)
				log(math_)
				if math_ <= 5 then
					url___ = url___1
				else
					url___ = url___2
				end	
				log(url___)
				RetStr = get(url___)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.message == 'ok' then
						number = RetStr.mobile
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
				local url___ = "http://api.do889.com:81/api/get_message?token="..token.."&project_id="..PID.."&phone_num="..number
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					RetStr = json.decode(RetStr)
					if  RetStr.message == 'ok' then
						Msg = RetStr.code
--						local i,j = string.find(Msg,"%d+")
--						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				delay(3)
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

--dxcode = _vCode_yh()
dxcode = _vCode_df()
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
bid.app = 'com.lexue.lexuegaokao'

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
tips_重新登录确定 = {{{337, 652, 0x007aff},{290, 651, 0x007aff},{305, 496, 0x101010},{345, 541, 0x272727},}, 85, 265, 472, 364, 670}
tips_同意并进入 = {{{461, 817, 0xe7f4ff},{328, 790, 0x0082ff},{507, 838, 0x0082ff},{173, 822, 0xa8a8a8},}, 85, 77, 772, 573, 869}
tips_广告X = {{{319, 863, 0xfcfcfc},{291, 835, 0xf8f8f8},{289, 884, 0xf7f7f7},{350, 884, 0xf8f8f8},}, 85, 282, 822, 359, 897}
首页点我的 = {{{534, 1070, 0xd7dce5},{534, 1079, 0xffffff},{109, 1075, 0x0082fe},{106, 1084, 0xffffff},{112, 1117, 0x0082ff},}, 85, 67, 1049, 578, 1129}
手机号注册界面 = {{{ 56, 173, 0x9f9f9f},{410, 211, 0xb0b0b0},{406, 214, 0x818181},{ 64, 217, 0x6c6c6c},{408, 174, 0xebebeb},}, 85, 48, 161, 424, 231}
手机号注册界面_获取验证码 = {{{571, 539, 0x2795ff},{513, 544, 0x0082ff},}, 85, 464, 525, 597, 564}
手机号注册界面_登录 = {{{345, 683, 0xf6fbff},{152, 663, 0x0082fe},{553, 686, 0x0082fe},{546, 666, 0x0082fe},}, 85, 50, 640, 598, 703}

注册成功 = {{{141, 250, 0x967950},{137, 245, 0x95641e},{ 58, 176, 0x8e8e8e},{ 79, 213, 0x747474},}, 85, 33, 136, 167, 270}



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
			if d(手机号注册界面,'手机号注册界面') then
				if 取号 then
					phone = dxcode.getPhone()
--					log(phone)
					number = phone
					if phone ~= nil or phone ~= '' then
						if type(tonumber(phone)) == "number" then
							delay(5)
							click(98, 416)
							phoneKey(phone)
							取号 = false
							短信 = true
						end
					end
				elseif 短信 then
					if d(手机号注册界面_获取验证码,'手机号注册界面_获取验证码',true) then
					else
						yzm = dxcode.getMessage()
--						log(yzm)
						if yzm ~= nil or yzm ~= '' then
							click(97, 552)
							delay(1)
							input(yzm)			
							短信 = false
							提交 = true
--						else
--							return false
						end
					end	
				elseif d(手机号注册界面_登录,'手机号注册界面_登录',true)  then
				end	
			elseif 提交 and d(注册成功,'注册成功') or 提交 and d(注册成功,'注册成功') then
				click(311, 474)
				click(324, 778)
				up('乐学高考','注册成功')
--				dxcode.addBlack()
				delay(3)	
				return true
--			elseif 提交 and d(已注册过_个人信息界面,'已注册过_个人信息界面')then
----				up('一创智富通','注册成功')
--				dxcode.addBlack()
--				delay(3)
--				return false
			elseif d(tips_同意并进入,'tips_同意并进入',true) then
			elseif d(首页点我的,'首页点我的',true) then
			elseif d(tips_广告X,'tips_广告X',true) then
			elseif d(tips_重新登录确定,'tips_重新登录确定',true) then
			
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
--					if open_url() then
						if reg()then
							back_pass(task_id,"ok")
	--					else
							--yzm.get.cancelRecv()
						end	
--					end
				end
	
			end
		end
	end
--	app.quit(bid.app)
--	delay(2)
end

--]]

















