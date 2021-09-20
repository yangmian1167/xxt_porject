
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
				RetStr = get('http://sms.wenfree.cn/public/?service=App.SmsNew.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
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
				RetStr = get("http://sms.wenfree.cn/public/?service=App.SmsNew.GetMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				RetStr = json.decode(RetStr)
				log(RetStr);
				if RetStr then
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then 
							log(Msg); return Msg 
						else
							log(Msg)
--							local arr = string.split(Msg,"：") 
--							Msg = arr[2]
							local i,j = string.find(Msg,"%d+")
							Msg = string.sub(Msg,i,j)
							if type(tonumber(Msg))== "number" then 
								log(Msg); return Msg 
							end
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
--	postdate.phone = bid[name]['keyword']
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




page = {}
page.注册界面 = {{{463, 288, 0xff7a2b},{406, 283, 0xff8e4b},{302, 292, 0xff843b},}, 85, 264, 260, 484, 310}
page.注册界面_获取验证码 = {{{543, 490, 0xf95415},{442, 488, 0xf9672e},}, 85, 424, 467, 570, 504}
page.注册界面_登录 = {{{335, 638, 0xffffff},{146, 625, 0xf95415},{494, 651, 0xf95415},}, 85, 63, 591, 545, 676}
page.注册界面_打钩 = {{{119, 755, 0xffffff},{115, 757, 0xbbbbbb},{136, 756, 0xbebebe},}, 85, 114, 744, 140, 772}
page.tips_满14周岁 = {{{453, 728, 0xff6422},{371, 729, 0xff7a41},{219, 731, 0x2f3338},{163, 729, 0x2f3338},}, 85, 138, 698, 498, 752}
page.tips_同意 = {{{479, 1078, 0xffffff},{398, 1074, 0xff6422},{229, 1074, 0xffffff},{163, 1079, 0xff6422},}, 85, 104, 1035, 573, 1114}
page.选择宝贝年龄 = {{{ 60, 199, 0x7a7a7a},{ 57, 241, 0xd9d9d9},{333, 198, 0xbababa},{336, 242, 0x8a8a8a},}, 85, 53, 189, 352, 247}
page.推荐人跳过 = {{{340, 1088, 0xffffff},{106, 1074, 0xff6422},{522, 1111, 0xff6422},}, 85, 58, 1041, 594, 1128}
page.选择宝贝年龄_确定 = {{{336, 1072, 0xffffff},{234, 1048, 0xf95415},{403, 1078, 0xf95415},}, 85, 168, 1025, 480, 1106}

page.滑动验证码界面_点1={{{249, 383, 0x161523},{249, 387, 0x222127},{249, 449, 0x292d30},{249, 452, 0x313538},}, 85, 188, 332, 508, 607}
page.滑动验证码界面_点2={{{322, 403, 0x393939},{322, 408, 0x444444},{322, 468, 0x4b4b49},{322, 464, 0x474745},}, 85, 188, 332, 508, 607}
page.滑动验证码界面_点3={{{290, 374, 0x28291b},{290, 378, 0x2b2c21},{290, 436, 0x2e2c1d},{290, 433, 0x2f2d1d},}, 85, 188, 332, 508, 607}

page.点击验证码={{{543, 488, 0xf95415},{475, 492, 0xfc9d78},}, 85, 414, 464, 576, 508}
page.滑块={{{150, 670, 0x66d200},{136, 675, 0x66d200},}, 85, 114, 649, 542, 705}
page.请正确拼合图像={{{106, 576, 0xde715b},{324, 599, 0xde715b},}, 85, 94, 568, 332, 610}

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
			if d(page.注册界面,'page.注册界面') then
				if 取号 then
					phone = dxcode.getPhone()
					number = phone
					if phone ~= nil or phone ~= '' then
						delay(2.8)
						if type(tonumber(phone)) == "number" then
							click(266, 368)
							phoneKey(phone)
							取号 = false
							短信 = true
						end
					end
--				elseif d(page.注册界面_打钩,'page.注册界面_打钩',true) then
				elseif d(page.注册界面_登录,'page.注册界面_登录',true) then
				elseif d(page.注册界面_获取验证码,'page.注册界面_获取验证码',true) then
				elseif 短信 then
					yzm = dxcode.getMessage()
--						log(yzm)
					if yzm ~= nil or yzm ~= '' then
						click(172, 489)
						phoneKey(yzm)	
						click(253, 98)
						click(78, 715)
						提交 = true
						短信 = false
--						else
--							return false
					end
				end	
			elseif d(page.tips_满14周岁,'page.tips_满14周岁',true) then
			elseif d(page.tips_同意,'page.tips_同意',true) then
			elseif d(page.滑块,"page.滑块") then
				if d(page.滑动验证码界面_点1,"page.滑动验证码界面_点1") or d(page.滑动验证码界面_点2,"page.滑动验证码界面_点2")or d(page.滑动验证码界面_点3,"page.滑动验证码界面_点3")  then
					moveTo(102, 675,x,675,20)
					delay(1)
					if d(page.请正确拼合图像,"page.请正确拼合图像") then
						delay(3)
						click(174, 781)
						delay(3)
					end
				else
					click(174, 781)
					delay(5)
				end
			elseif d(page.选择宝贝年龄,'page.选择宝贝年龄') then
				local suiji1 = 184 * math.random(0,2)
				local suiji2 = 112 * math.random(0,4)
				click(132+suiji1, 381+suiji2)
				if d(page.选择宝贝年龄_确定,'page.选择宝贝年龄_确定',true) then
					up_hb("注册成功")
					return true
				end	
			elseif d(page.推荐人跳过,'page.推荐人跳过',true) then	
				up_hb("注册成功")
				return true
			end
		end
		delay(2)
	end
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
			bid_app = bid[work]['appbid']
			callbackapi(work)
		end
		vpnx()
		delay(2)
	end
end




















