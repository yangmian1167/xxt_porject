
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
				RetStr = get('http://sms.wenfree.cn/public/?s=App.SmsNew.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
				if RetStr then
					RetStr = json.decode(RetStr)
					log(RetStr)
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						phone = RetStr.data.phone
						log(phone)
						local phone_title = (string.sub(phone,1,3))
						local blackPhone = {'147'}
						for k,v in ipairs(blackPhone) do
							if phone_title == v then
	--							local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
	--							get(lx_url);
								log("拉黑->"..number)
								delay(3)
								return false
						end
				end
						
					end
				else
					log(RetStr)
				end
				delay(3)
				return phone
		end),
		 getMessage=(function()
			local Msg
            for i=1,30,1 do
				sys.msleep(3000)
				RetStr = get("http://sms.wenfree.cn/public/?s=App.SmsNew.getMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				if RetStr then
					RetStr = json.decode(RetStr)
					log(RetStr)
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then log(Msg); return Msg 
						else
							log(Msg)
							Msg = string.split(Msg,"：")
							Msg = Msg[2]
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
dxcode = _Server_get()

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
		if checkidfa(name)then
			if clickidfa(name)then
				delay(rd(3,5))
--				if newidfa(name) then
				if reg() then
					back_pass(task_id,"ok")
					up(name,bid[name]['keyword'])
				end
			end
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


bid_app = 'com.qihoo.corp.xyqb'

page = {}
page.滑动界面 = {{{231, 1073, 0x00d795},{229, 1114, 0x00d795},{383, 1104, 0x00d795},{391, 1079, 0x00d795},{323, 1091, 0x00d795},}, 85, 206, 1065, 423, 1122}
page.立即注册 = {{{342,  960, 0x00c087},{270,  958, 0x00c087},{213,  919, 0xffffff},{427,  984, 0xffffff},{352, 1026, 0x157e3f},}, 85, 179, 789, 447, 1051}
page.同意 = {{{448, 971, 0x22c776},{449, 974, 0xffffff},{487, 972, 0x3bcd86},{193, 967, 0xb1b2b6},{279, 967, 0xffffff},}, 85, 144, 944, 501, 994}
page.我的 = {{{559, 1086, 0xd8d8d8},{548, 1071, 0xffffff},{ 83, 1065, 0x4f576c},{ 80, 1075, 0xffffff},{ 85, 1084, 0x474f64},{ 86, 1094, 0xffffff},}, 85, 55, 1052, 584, 1108}
page.登录注册 = {{{165, 186, 0x333333},{ 49, 163, 0xa9a9a9},{ 45, 202, 0xb3b3b3},{275, 163, 0x606060},}, 85, 19, 137, 290, 223}

page.登录注册手机号界面 = {{{ 44, 145, 0x888888},{ 43, 170, 0x939393},{189, 143, 0x7b7b7b},{189, 142, 0xe4e4e4},{188, 173, 0x979797},}, 85, 37, 139, 199, 178}
page.登录注册手机号界面1 ={{{ 44, 176, 0x888888},{375, 239, 0x83daa3},{365, 221, 0x8cdcaa},{506, 198, 0x828282},{504, 176, 0x7d7d7d},}, 85, 23, 94, 552, 310}
page.登录注册手机号界面_打钩 = {{{61, 548, 0xffffff},{75, 547, 0x55ca80},{48, 540, 0x1bb855},{53, 544, 0xffffff},}, 85, 39, 524, 83, 572}
page.登录注册手机号界面_打钩2 = {{{60, 585, 0xffffff},{54, 575, 0xffffff},{69, 580, 0xffffff},{73, 574, 0x1bb855},{63, 559, 0xffffff},{59, 540, 0x19b955},{61, 527, 0x19b955},}, 85, 34, 520, 80, 600}
page.登录注册手机号界面_下一步 = {{{423, 474, 0x19b955},{326, 474, 0xf6fdf9},{290, 464, 0xffffff},{ 87, 449, 0x19b955},{570, 502, 0x19b955},}, 85, 22, 375, 604, 567}
page.登录注册手机号界面_使用其他号码 = {{{573, 337, 0x19b955},{520, 342, 0x19b955},{458, 334, 0x19b955},{510, 328, 0x19b955},}, 85, 437, 313, 596, 358}
page.验证码界面 = {{{ 46, 174, 0xa9a9a9},{ 43, 186, 0xb7b7b7},{ 47, 202, 0xc8c8c8},{ 49, 204, 0xbfbfbf},{267, 173, 0xdddddd},{267, 204, 0xdddddd},}, 85, 32, 134, 277, 231}
page.验证码界面_确定 = {{{333, 551, 0xffffff},{309, 551, 0xd1f1dd},{144, 525, 0x19b955},{547, 575, 0x19b955},{563, 529, 0x19b955},}, 85, 29, 460, 604, 616}
page.tips_X = {{{319, 914, 0xffffff},{315, 910, 0xffffff},{324, 909, 0xffffff},{323, 919, 0xd9dadb},{298, 927, 0xffffff},}, 85, 283, 882, 359, 943}
page.tips_X2 = {{{319, 838, 0xfcfcfc},{307, 837, 0x4c4c4c},{340, 823, 0xffffff},{345, 822, 0x4c4c4c},}, 85, 289, 813, 353, 859}
page.登录注册手机号界面_X = {{{582, 308, 0xffffff},{579, 305, 0xffffff},{580, 298, 0xcccccc},{594, 313, 0xcdcdcd},}, 85, 568, 292, 599, 322}
page.完成界面刷脸验证 = {{{352,  76, 0xffffff},{191,  70, 0xffffff},{166,  53, 0x253239},{458, 928, 0x19b955},{367, 934, 0xffffff},}, 85, 148, 34, 510, 981}

page.双11tips = {{{406, 523, 0xfffefe},{313, 565, 0xe9eeff},{305, 585, 0xe6c166},{280, 639, 0xfaf7c7},}, 85, 160, 475, 519, 702}
page.百分百中奖tips = {{{319, 866, 0xffffff},{188, 431, 0x6e19c5},{452, 424, 0x6929dd},{234, 306, 0xffe599},{302, 294, 0x390f96},{390, 291, 0xffffff},}, 85, 110, 265, 555, 898}
page.tips_立即体验 = {{{341, 950, 0xffffff},{272, 951, 0xffffff},{ 82, 919, 0x20cd5f},{537, 995, 0x1cba55},{529, 898, 0xffffff},}, 85, 50, 879, 582, 1029}

page.tips_红包={{{320, 867, 0xffffff},{387, 848, 0x494949},{377, 788, 0xfa5746},{332, 759, 0xfa5746},}, 85, 216, 747, 453, 920}
function reg()
	local TimeLine = os.time()
	local OutTime = 60*5

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
		if active(bid_app,10)then
			if d(page.登录注册手机号界面,'page.登录注册手机号界面') or d(page.登录注册手机号界面1,'page.登录注册手机号界面1') then
				if d(page.登录注册手机号界面_打钩,'page.登录注册手机号界面_打钩',true) then
				elseif d(page.登录注册手机号界面_打钩2,'page.登录注册手机号界面_打钩2',true) then
				elseif 取号 then
					if d(page.登录注册手机号界面_X,'page.登录注册手机号界面_X',true) then
					elseif d(page.登录注册手机号界面_使用其他号码,'page.登录注册手机号界面_使用其他号码',true) then
					else
						phone = dxcode.getPhone()
						number = phone
						if phone ~= nil or phone ~= '' then
							delay(2.8)
							if type(tonumber(phone)) == "number" then
								click(130, 340)
								app.input_text("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b")
								delay(2.8)
								phoneKey(phone)
								取号 = false
								短信 = true
							end
						end
					end	
				elseif d(page.登录注册手机号界面_下一步,'page.登录注册手机号界面_下一步',true) then
				end	
			elseif d(page.验证码界面,'page.验证码界面') then	
				if 短信 then
					yzm = dxcode.getMessage()
--						log(yzm)
					if yzm ~= nil or yzm ~= '' then
						click(101, 350)
						app.input_text("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b")
						delay(2.8)
						phoneKey(yzm)			
						提交 = true
						短信 = false
--						else
--							return false
					end
				elseif d(page.验证码界面_确定,'page.验证码界面_确定',true) then
					up_hb('注册成功')
					return true
				end	

			elseif 提交 and d(page.完成界面刷脸验证,'page.完成界面刷脸验证') then
				up_hb('注册成功')
				return true
			elseif d(page.立即注册,'page.立即注册',true) then
			elseif d(page.同意,'page.同意',true) then
			elseif d(page.我的,'page.我的',true) then
			elseif d(page.登录注册,'page.登录注册',true) then
			elseif d(page.tips_X,'page.tips_X',true) then
			elseif d(page.tips_X2,'page.tips_X2',true) then
			elseif d(page.tips_红包,'page.tips_红包',true) then
			elseif d(page.tips_立即体验,'page.tips_立即体验',true) then
			elseif d(page.百分百中奖tips,'page.百分百中奖tips',true) then
			elseif d(page.双11tips,'page.双11tips') then
				click(552, 136)
			elseif d(page.滑动界面,'page.滑动界面') then
				moveTo(577, 963,80, 958)
			end
		end
		delay(2)
	end
end	
apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}
--[[]]
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

--]]













