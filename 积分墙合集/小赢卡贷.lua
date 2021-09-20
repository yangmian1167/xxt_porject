
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
				RetStr = get('http://sms.wenfree.cn/public/?service=App.Sms.GetPhone'.."&imei="..phone_imei.."&phonename="..phone_name)
				log(RetStr)
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
	local url = 'http://hb.wenfree.cn/api/Public/idfa/?'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = work
	postdate.idfa = idfa
	postdate.phone = phone
--	postdate.password = password
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other
	postdate.account = bid[work]['appid']
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
	local url = ""
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
	local url = "http://v1.cloud-cube.net/dsp/sendclick"
	local postArr = {}
	postArr.appid = bid[name]['appid']
	postArr.cid = bid[name]['adid']
	postArr.idfa = idfa
--	postArr.ua = e:escape("ua")
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.devicetype = model
	postArr.osversion = os_version or sys.version()
--	postArr.callback =e:escape("http://hb.wenfree.cn/api/Public/idfa/?service=Callback.Idfa&idfa="..idfa)
	postArr.callback =e:escape("https://hbapi.honghongdesign.cn/callbackurl/id/"..hb_data_id)
	
	local index = 0
	local post_data = ''
	for k,v in pairs(postArr)do
		post_data = post_data..k..'='..v..'&'
	end
	url = url..'?'..post_data
	
	log(url)
	log(postArr)
	
	local getdata = get(url)
	local getdata = string.split(getdata,":")
	if getdata ~= nil then
--		local data = string.split(getdata,":")
		local data = string.sub(getdata[2],1,3)
		log(data or "nil")
		if data == "200" or data == 200 then
			log("点击成功: OK.",true)
			return true
		else
			log("idfa-点击失败",true)
		end
	end
end

function activeidfa(name,callbackkey)
	local url = "http://v1.cloud-cube.net/dsp/active"
	local postArr = {}
	postArr.appid = bid[name]['appid']
	postArr.cid = bid[name]['adid']
	postArr.idfa = idfa
--	postArr.ua = e:escape("ua")
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.devicetype = model
	postArr.osversion = os_version or sys.version()
--	postArr.callback =e:escape("http://hb.wenfree.cn/api/Public/idfa/?service=Callback.Idfa&idfa="..idfa)
--	postArr.callback =e:escape("http://hbapi.honghongdesign.cn/callbackurl/idfa/478778")
	local post_data = ''
	for k,v in pairs(postArr)do
		post_data = post_data..k..'='..v..'&'
	end
	url = url..'?'..post_data
	
	log(url)
	log(postArr)
	
	local getdata = get(url)
	local getdata = string.split(getdata,":")
	if getdata ~= nil then
--		local data = string.split(getdata,":")
		local data = string.sub(getdata[2],1,3)
		log(data or "nil")
		if data == "200" or data == 200 then
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
--获取回调必要参数id
function gethbdate_id()
	local url = "http://ymapi.wenfree.cn/?s=App.Bhapione.Get".."&name="..work.."&idfa="..idfa
	log(url)
	local getdata = get(url)
	local data = json.decode(getdata)
	log(data)
	if data.ret == 200 then
		hb_data_id = data.data.id
		log(hb_data_id)
		return hb_data_id
	end
end

function callbackapi(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		udid = XXTfakerGetinfo(bid[name]["appbid"])['UDID']
--		if checkidfa(name)then
			if clickidfa(name)then
				delay(rd(3,5))
--				if newidfa(name) then
				if reg(name) then
--					if activeidfa(name) then
--						activeidfa(name)
						back_pass(task_id,"ok")
--						up(name,bid[name]['keyword'])
--					end
				end
			end
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


bid_app = 'com.qihoo.corp.fenqidai'

page = {}
注册 = {{{287, 70, 0xb0b0b0},{347, 98, 0xe7e7e7},{347, 69, 0x3d3d3d},{296, 98, 0xa7a7a7},}, 85, 281, 64, 357, 105}
注册_输入手机号界面 = {{{321, 435, 0xffffff},{137, 402, 0x6b8ffe},{484, 463, 0x5a5bf5},{516, 408, 0x5855f3},{536, 399, 0xffffff},}, 85, 74, 380, 570, 486}
注册_验证码界面 = {{{133, 467, 0x626ff9},{506, 532, 0x5853f4},{531, 465, 0xfefdff},{101, 537, 0xffffff},}, 85, 81, 458, 562, 552}
注册_验证码界面_点注册 = {{{328, 503, 0xffffff},{153, 475, 0x6b8ffe},{525, 533, 0x5954f3},{536, 461, 0xffffff},}, 85, 81, 451, 555, 556}
完成界面头像 = {{{ 91, 196, 0xe5355a},{114, 141, 0xff7243},{ 83, 138, 0x101a3b},{116, 150, 0xff9d45},}, 85, 24, 79, 153, 220}

注册打码界面X = {{{ 93, 867, 0x7e7e7e},{478, 867, 0xf6faff},{401, 847, 0x539fff},{561, 891, 0x539fff},{575, 838, 0xe0eeff},}, 85, 65, 834, 586, 909}
我的界面点登陆 = {{{203,  129, 0xffffff},{110,  144, 0xff9d45},{ 90,  197, 0xd33352},{551, 1086, 0x6f5bf8},{565, 1088, 0xffffff},}, 85, 39, 78, 617, 1132}
登陆界面点注册 = {{{517, 685, 0xcecece},{157, 691, 0x639cf8},{311, 592, 0xfdfdff},{ 98, 563, 0x6b8ffe},{555, 625, 0x5956f3},}, 85, 49, 545, 600, 700}
点我的 = {{{560, 1082, 0xbcc0c7},{560, 1093, 0xb9bec6},{548, 1122, 0x9ca5ae},}, 85, 533, 1058, 591, 1133}
tips_同意 = {{{440, 903, 0x574ef3},{440, 902, 0xbcb8fa},{192, 905, 0xc1c1c1},}, 85, 131, 877, 500, 931}
tips_返回箭头 = {{{44, 75, 0x808083},{50, 96, 0x7f7f82},{37, 82, 0x808083},}, 85, 32, 61, 60, 104}
tips_广告X = {{{320, 966, 0xffffff},{307, 966, 0x636363},{332, 947, 0xf7f7f7},{333, 964, 0x636363},}, 85, 289, 934, 355, 994}

滑动条 = {{{118, 681, 0x64cc02},{104, 684, 0x63ca03},{124, 685, 0xf9f9f9},}, 85, 82, 654, 577, 716}
滑动模块加载完成 = {{{111, 344, 0xbde6ff},}, 85, 65, 307, 575, 619}
滑动黑点 = {{{350, 355, 0x062337},{350, 425, 0x203240},}, 85, 164, 309, 572, 618}



require('lzdm')
function reg(name)
--	while true do
		local TimeLine = os.time()
		local OutTime = 60*4

		local 取号 = true
		local 验证码 = false
		local 短信 = false
		local 密码 = false
		local 提交 = false
		local 后退 = false
		local 打码key = true
		
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
			if active(bid[name]['appbid'],4) then
				if d(注册,'注册') then
					if d(注册_输入手机号界面,'注册_输入手机号界面') then
						if 取号 then
							phone = dxcode.getPhone()
							number = phone
							if phone ~= nil or phone ~= '' then
								delay(2.8)
								if type(tonumber(phone)) == "number" then
									click(113, 214)
									phoneKey(phone)
									click(105, 308)
									取号 = false
									短信 = true	
								end
							end
						elseif d(注册_输入手机号界面,'注册_输入手机号界面',true) then
						end	
					
					elseif d(注册_验证码界面,'注册_验证码界面') then	
						if 短信 then
							yzm = dxcode.getMessage()
		--						log(yzm)
							if yzm ~= nil or yzm ~= '' then
								delay(2.8)
								click(133, 214)
								app.input_text(yzm)			
								click(106, 294)
								app.input_text(password)
								提交 = true
								短信 = false
							end
						end		
					elseif d(注册_验证码界面_点注册,'注册_验证码界面_点注册',true) then
					end	
				elseif 提交 and	d(完成界面头像,'完成界面头像') then
					up_hb('注册成功')
					return true
				elseif d(滑动条,'滑动条') then
					if d(滑动模块加载完成,'滑动模块加载完成') then
						if d(滑动黑点,'滑动黑点') then
							
							log(x..","..y)
							moveTo(76, 686,x,686)
						end	
					end
				elseif d(注册打码界面X,'注册打码界面X',true) then
				elseif d(我的界面点登陆,'我的界面点登陆',true) then
				elseif d(登陆界面点注册,'登陆界面点注册',true) then
				elseif d(点我的,'点我的',true) then
				elseif d(tips_同意,'tips_同意',true) then
				elseif d(tips_广告X,'tips_广告X',true) then
				elseif d(tips_返回箭头,'tips_返回箭头',true) then

				end	
			end
			delay(2)
		end
--		closeX(bid[name]['appbid'])
--	end
--	return false
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
			bid[work]['callback_id']=v.id
			callbackapi(work)
		end
		vpnx()
		delay(2)
	end
end




















