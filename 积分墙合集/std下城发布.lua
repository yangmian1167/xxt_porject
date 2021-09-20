
--[[
local cloud_cc = require("cloud_cc")(
	"2BA695C9633E1E712764746FFD90649C",
	{
		"/lua/scripts/faker.lua",
		"/lua/scripts/xxtsp.lua",
		"/lua/scripts/nLog.xxt",
	}
)

]]


nLog = require('nLog')()
require('faker')
require('xxtsp')
require('lzdm')
local curl = require('lcurl')
local e = curl.easy()

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
			--closeX(appbids)
		end
		sys.msleep(500)
	end)
--]]



--服务器对接取号

function _Server_get()
	phone_name = device.name()
	phone_imei = device.serial_number()
	log(phone_name)
	log(phone_imei)
	return{
		login=(function()
			return	
		end),
		addBlack=(function()
			return	
		end),
		getPhone = (function()
				RetStr = get('http://sms.wenfree.cn/public/?service=App.Sms.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						phone = RetStr.data.phone
						log(phone)
					end
				else
					log(RetStr)
				end
				delay(3)
				return phone
		end),
		 getMessage=(function()
			local Msg
            for i=1,25,1 do
				sys.msleep(3000)
				RetStr = get("http://sms.wenfree.cn/public/?service=App.Sms.GetMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				RetStr = json.decode(RetStr)
				log(RetStr);
				if RetStr then
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then log(Msg); return Msg 
						else
							log(Msg)
--							local arr = string.split(Msg,"：") 
--								Msg = arr[2]
								local i,j = string.find(Msg,"%d+")
								Msg = string.sub(Msg,i,j)
								if type(tonumber(Msg))== "number" then log(Msg); return Msg end
						end
					end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
				delay(3)
            end
            return false
        end),
	
	
	}
	
end
--dxcode = _Server_get()


--德芙
function _vCode_df() --德芙平台

	local	User = 'yangmian1167'
	local	Pass = 'yangmian121'
	local PID = '60604'
    local token,number = "VeBTwh2GOFFAy41Wl+exynmcfVzH6l7R1Ozv05WEDrWNHN0dFqcRRN+MXiO5tmwwLfxG31Xsdd7gSCsyN4U7tQ3dtz/O8aDIaciii7IOi677PZT0LzXCsAV+8E1kKn68U8zKpFO22onDtRCvRzwis0WomQ6yRV4yuVdY4ihqCE0=",""	

    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://cf.do668.com:81/api/logins?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.message == '登录成功' then
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
			local url___ = "http://cf.do668.com:81/api/get_mobile?token="..token.."&project_id="..PID.."&operator=4"
			log(url___)
			RetStr = get(url___)
			RetStr = json.decode(RetStr)
			log(RetStr)
			delay(3)
			if  RetStr.message == 'ok' then
				number = RetStr.mobile
				log(number)
				local phone_title = (string.sub(number,1,3))
--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://www.wocaopt.net/sms/api.php?a=addBlacklist&sid'..PID..'&phone='..number..'&token='..token
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
				
				local url___ = "http://cf.do668.com:81/api/get_message?token="..token.."&phone_num="..number.."&project_id="..PID
				log(url___)
				RetStr = get(url___)
				if RetStr then
					RetStr = json.decode(RetStr)
					log(RetStr)
					if  RetStr.message == 'ok' then
						Msg = RetStr.data[1].modle
						local i,j = string.find(Msg,"%d+")
						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(RetStr).."\n"..i.."次共25次")
				delay(3)
            end
            return false
        end),
        addBlack=(function()
			local lx_url =	'http://dev.wanzhongma.com/open/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
dxcode = _vCode_df()

function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = name
	idfalist.idfa = idfa
	idfalist.ip = ip or get_ip() or '192.168.1.1'
	idfalist.account = bid[name]['keyword'] or account
	idfalist.password = password
	idfalist.phone = phone
	idfalist.other = other
	return post(url,idfalist)
end

function up_hb(other)
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = work
	postdate.idfa = idfa
	postdate.phone = phone
--	postdate.password = password
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other
	postdate.account = account
	log(post(url,postdate))
	-- body
end

function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	log( post(url,postArr) )
end

function checkidfa(name)
	local url = "http://api.check.adzshd.com/RemoveEcho.ashx"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.appid = bid[name]['appid']
	postArr.idfa = idfa
	postArr.udid = udid
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.os = model
	postArr.KeyWords = bid[name]['keyword']
	postArr.osversion = os_version or sys.version()
	postArr.btype ='1'

	local post_data = ''
	for k,v in pairs(postArr)do
		post_data = post_data..k..'='..v..'&'
	end
	url = url..'?'..post_data
	
	log(url)
	log(postArr)
	
	local getdata = get(url)
--	log(getdata)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if data[idfa] == '0' or data[idfa] == 0 then
			log(" 排重成功: OK.",true)
			return true
		else
			log("idfa-排重失败",true)
		end
	end
end

function clickidfa(name,callbackkey)
	local url = "http://api.check.adzshd.com/SourceClick.ashx"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.appid = bid[name]['appid']
	postArr.idfa = idfa
	postArr.udid = udid
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.mac = '02:00:00:00:00:00'
	postArr.os = model
	postArr.KeyWords = bid[name]['keyword']
	postArr.osversion = os_version or sys.version()
	postArr.btype ='1'
	
	local index = 0
	local post_data = ''
	for k,v in pairs(postArr)do
		post_data = post_data..k..'='..v..'&'
	end
	url = url..'?'..post_data
	
	log(url)
	log(postArr)
	
	local getdata = get(url)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if data["message"] == 'ok' or data["success"] == true then
			log("点击成功: OK.",true)
			return true
		else
			log("idfa-点击失败",true)
		end
	end
end

function activeidfa(name,callbackkey)
	local url = "https://wenfree.cn/api/app.php"
	local postArr = {}
	postArr.service = "App.SharkIdfa.Activate"
	postArr.channel_id = '4'
	postArr.task_id = bid[name]['appid']
	postArr.idfa = idfa
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.os_version = os_version or sys.version()
	postArr.device_type = model
	postArr.keyword = bid[name]['keyword']
	postArr.udid = udid
	local post_data = ''
	for k,v in pairs(postArr)do
		post_data = post_data..k..'='..v..'&'
	end
	url = url..'?'..post_data
	
	log(url)
	log(postArr)
	
	local getdata = get(url)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if tonumber(data.data.code) == 0 or data.data.msg == '请求数据成功!' then
			log("上报成功: OK.",true)
			return true
		else
			log("idfa-上报失败",true)
		end
	end
end

function checkip()
	ip = get_ip() or false
	if ip then
		local url = 'http://wenfree.cn/api/Public/idfa/?service=Ip.Checkip&ip='..ip
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
end

function callbackapi(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		udid = XXTfakerGetinfo(bid[name]["appbid"])['UDID']
--		if checkidfa(name)then
--			if clickidfa(name)then
				delay(rd(3,5))
--				if newidfa(name) then
				if reg(name) then
					back_pass(task_id,"ok")
--					up(name,bid[name]['keyword'])
				end
--			end
--		end
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

--主界面点我的 = {{{592, 1088, 0x919191},{292, 1080, 0x3a89ec},{ 72, 1091, 0x378fff},{ 51, 1085, 0x9fc9ff},{ 48, 1085, 0xf5f9ff},}, 85, 5, 1040, 637, 1128}
--登录注册 = {{{354, 290, 0x343434},{246, 277, 0xffffff},{401, 306, 0xffffff},{321, 200, 0xd0d0d0},{294, 236, 0x378fff},{358,  83, 0x378fff},}, 85, 206, 49, 443, 333}
--新用户注册 = {{{151, 608, 0x797979},{119, 575, 0xffffff},{142, 545, 0xcccccc},{119, 446, 0x77b3ff},{288, 454, 0x65a8ff},}, 85, 86, 419, 309, 629}
--注册界面 = {{{ 38, 460, 0x4497ff},{215, 452, 0x9cc7ff},{394, 458, 0x78b4ff},{246, 620, 0x378fff},{397, 628, 0x61a7ff},}, 85, 16, 422, 546, 670}
--tips同意 = {{{459, 945, 0x378fff},{487, 939, 0x5aa3ff},{134, 928, 0xc2c2c2},{215, 950, 0xa7a7a7},}, 85, 39, 882, 566, 979}
--tips发码确认 = {{{477, 648, 0x67affd},{442, 647, 0x1e8aff},{173, 650, 0x007aff},{133, 637, 0xf9f9f9},}, 85, 85, 607, 521, 678}
--发送验证码 = {{{487, 374, 0x6d6d6d},{606, 390, 0x8c8c8c},{605, 373, 0xb9b9b9},{482, 394, 0xf4f4f4},}, 85, 474, 361, 615, 400}
--打码获取验证码 = {{{329, 442, 0x378fff},{257, 425, 0x94c3ff},{387, 449, 0x61a7ff},{387, 426, 0xa2cbff},}, 85, 243, 421, 398, 456}
--6s
tips同意 = {{{570,  992, 0x5aa3ff},{521,  991, 0x9fc9ff},{162,  981, 0x8d8d8d},{243, 1004, 0xebebeb},}, 85, 145, 961, 588, 1019}
主界面点我的 = {{{662, 1280, 0x828282},{408, 1276, 0x3a89ec},{ 89, 1273, 0x3890ff},{ 60, 1281, 0x66a9ff},{ 59, 1281, 0xf5f9ff},}, 85, 39, 1253, 692, 1298}
新用户注册 = {{{169, 656, 0x666666},{150, 578, 0xcccccc},{168, 527, 0xcccccc},{125, 480, 0x3f93ff},{342, 476, 0x3c92ff},}, 85, 100, 453, 482, 699}
注册界面 = {{{274, 520, 0x509dff},{ 38, 526, 0x7cb6ff},{337, 724, 0x378fff},{476, 717, 0x9cc8ff},}, 85, 24, 500, 570, 752}
登录注册 = {{{354, 290, 0x343434},{246, 277, 0xffffff},{401, 306, 0xffffff},{321, 200, 0xd0d0d0},{294, 236, 0x378fff},{358,  83, 0x378fff},}, 85, 206, 49, 443, 333}
发送验证码 = {{{571, 438, 0x676767},{709, 436, 0xa5a5a5},{709, 461, 0xd3d3d3},}, 85, 564, 426, 717, 468}
tips发码确认 = {{{534, 747, 0x007aff},{479, 752, 0x81bcfc},{269, 748, 0x007aff},{210, 733, 0x88bffc},}, 85, 196, 714, 549, 769}
打码获取验证码1 = {{{370, 533, 0x64a8ff},{306, 526, 0x98c5ff},{442, 525, 0xa0caff},{441, 549, 0x88bdff},}, 85, 303, 517, 448, 556}
打码获取验证码2 = {{{370, 533, 0x64a8ff},{306, 526, 0x98c5ff},{442, 525, 0xa0caff},{441, 549, 0x88bdff},}, 85, 302, 732, 449, 772}

注册 = {{{403, 625, 0xeef6ff},{360, 623, 0xffffff},{ 45, 595, 0x378fff},{498, 658, 0x378fff},}, 85, 28, 574, 522, 686}
注册成功界面 = {{{382, 176, 0xd0d0d0},{423, 176, 0xffffff},{301, 179, 0x378fff},{454, 222, 0x378fff},{313, 234, 0x378fff},}, 85, 270, 150, 495, 336}

function reg(name)
	local TimeLine = os.time()
	local OutTime = 60*3

	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 密码 = false
	local 提交 = false
	local 后退 = false
	local 打码key = true
	local 提交过了 = false
	local movekey = 1
	取短信次数 = 0
	发验证码次数 = 0
	sex = rd(1,100)
	sex_key = 50
--	password = myRand(4,rd(8,12))
	password = 'AaDd112211'
	while os.time()-TimeLine < OutTime do
		if active(bid[name]['appbid'],4) then
			if d(注册界面,'注册界面') then
				if 取号 then
					phone = dxcode.getPhone()
					number = phone
					if phone ~= nil or phone ~= '' then
						delay(1)
						if type(tonumber(phone)) == "number" then
							click(130, 276)
							input(phone)
							密码 = true
							取号 = false
								
						end
					end
				elseif 密码 then
					click(128, 369)
					input(password)
					密码 = false
					短信 = true
				elseif 短信 then
					if d(发送验证码,'发送验证码',true) then
					else
						yzm = dxcode.getMessage()
						if yzm ~= nil or yzm ~= '' then
							click(143, 453)
							input(yzm)			
							提交 = true
							短信 = false
						end
					end
				elseif 提交 then
					if d(注册,'注册',true) then
					end
				end	
			elseif d(主界面点我的,'主界面点我的',true) then
			elseif d(登录注册,'登录注册',true) then
			elseif d(新用户注册,'新用户注册',true) then
			elseif d(tips同意,'tips同意',true) then
			elseif d(tips发码确认,'tips发码确认',true) then
			elseif 提交 and d(注册成功界面,'注册成功界面') then
				up(name,'注册成功')
				return true
			elseif d(打码获取验证码1,'打码获取验证码1') then
				if 打码key then
					screen.image(498, 376, 633, 423):save_to_png_file("/private/var/mobile/yzm.jpg")
					orcYZM()
					click(162, 398)
					app.input_text(yzm_jg)
					delay(2)
					打码key = false
				end
				d(打码获取验证码1,'打码获取验证码1',true)
			elseif d(打码获取验证码2,'打码获取验证码2') then
				if 打码key then
					screen.image(497, 592, 633, 637):save_to_png_file("/private/var/mobile/yzm.jpg")
					orcYZM()
					click(163, 615)
					app.input_text(yzm_jg)
					delay(2)
					打码key = false
				end
				d(打码获取验证码2,'打码获取验证码2',true)
			end
		end
		delay(1)
	end
	return false
end	




apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}

function newidfa(name)
	local TIMEline = os.time()
	local OUTtime = rd(90,95)
	while os.time()- TIMEline < OUTtime do
		if active(bid[name]['appbid'],4)then
			if d(apparr.right,"apparr.right",true)then
			else
				moveTo(600,300,100,100,30,50)
				delay(1)
				click(321, 978)
				delay(1)
				click(462, 666)
				delay(1)
			end
		else
			log("启动一次")
		end
	end
--	up(name,bid[name]['keyword'])
	up_hb('激活成功')
	return true
end

function beewallidfa(name)
	if clickisok(name)then
		delay(rd(2,3))
		newidfa(name)
	end
	delay(1)
end

--bid.万博娱乐 = {	["appid"] =  "1434066842", ["appbid"] = "com.qq.FindWord", ["adid"]= '1032', ["keyword"]="万博娱乐" }
function main(v)
	dxcode.login()
	if vpn() then
		if checkip()then
			work = v.work
			task_id = v.task_id
			bid={}
			bid[work]={}
			bid[work]['keyword']=v.keyword
			bid[work]['appbid']=v.appbid
			bid[work]['appid']=v.appid
			bid[work]['adid']=v.adid
			callbackapi(work)
		end
		vpnx()
		delay(2)
	end
end




















