
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
				RetStr = get("http://sms.wenfree.cn/public/?s=App.SmsNew.getMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				if RetStr then
					RetStr = json.decode(RetStr)
					log(RetStr);
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
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = work
	postdate.idfa = idfa
	postdate.phone = phone
--	postdate.password = password
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other
	postdate.account = bid[work]['keyword'] or account
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
	local url = "http://h5.yidaocaomao.com/api/quick/check"
	local postArr = {}
	postArr.channel = bid[name]['adid']
	postArr.taskId = bid[name]['appid']
	postArr.idfa = idfa
	postArr.udid = udid
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.deviceType = model
	postArr.keyword = bid[name]['keyword']
	postArr.sysVersion = os_version or sys.version()

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
		if data["msg"] == "未安装，可以做任务！" or data[idfa] == 0 then
			log(" 排重成功: OK.",true)
			return true
		else
			log("idfa-排重失败",true)
		end
	end
end

function clickidfa(name,callbackkey)
	local url = "http://h5.yidaocaomao.com/api/quick/click"
	local postArr = {}
	postArr.channel = bid[name]['adid']
	postArr.taskId = bid[name]['appid']
	postArr.idfa = idfa
	postArr.udid = udid
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.deviceType = model
	postArr.keyword = bid[name]['keyword']
	postArr.sysVersion = os_version or sys.version()
	postArr.callback = e:escape("http://hbapi.honghongdesign.cn/callbackurl/idfa/"..idfa)
	
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
		if data["msg"] == '点击成功' or data["success"] == true then
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
		if checkidfa(name)then
			if clickidfa(name)then
				delay(rd(3,5))
--				if newidfa(name) then
				if reg(name) then
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


bid_app = 'com.qihoo.corp.fenqidai'

page = {}
page.滑动界面 = {{{231, 1073, 0x00d795},{229, 1114, 0x00d795},{383, 1104, 0x00d795},{391, 1079, 0x00d795},{323, 1091, 0x00d795},}, 85, 206, 1065, 423, 1122}
page.立即注册 = {{{342,  960, 0x00c087},{270,  958, 0x00c087},{213,  919, 0xffffff},{427,  984, 0xffffff},{352, 1026, 0x157e3f},}, 85, 179, 789, 447, 1051}
page.同意 = {{{448, 971, 0x22c776},{449, 974, 0xffffff},{487, 972, 0x3bcd86},{193, 967, 0xb1b2b6},{279, 967, 0xffffff},}, 85, 144, 944, 501, 994}
page.我的 = {{{559, 1086, 0xd8d8d8},{548, 1071, 0xffffff},{ 83, 1065, 0x4f576c},{ 80, 1075, 0xffffff},{ 85, 1084, 0x474f64},{ 86, 1094, 0xffffff},}, 85, 55, 1052, 584, 1108}
page.我的1 = {{{558, 1061, 0x0e9ce4},{541, 1112, 0x4c8df5},{580, 1112, 0x80aef8},{576, 1103, 0x4c8df5},}, 85, 532, 1051, 591, 1126}
page.登录注册 = {{{165, 186, 0x333333},{ 49, 163, 0xa9a9a9},{ 45, 202, 0xb3b3b3},{275, 163, 0x606060},}, 85, 19, 137, 290, 223}

page.登录注册手机号界面 = {{{ 44, 176, 0x888888},{ 43, 201, 0x939393},{466, 176, 0xbfbfbf},{464, 205, 0x797979},{465, 201, 0xfefefe},}, 85, 27, 124, 519, 232}
page.登录注册手机号界面_打钩 = {{{61, 548, 0xffffff},{75, 547, 0x55ca80},{48, 540, 0x1bb855},{53, 544, 0xffffff},}, 85, 39, 524, 83, 572}
page.登录注册手机号界面_打钩2 = {{{60, 585, 0xffffff},{54, 575, 0xffffff},{69, 580, 0xffffff},{73, 574, 0x1bb855},{63, 559, 0xffffff},{59, 540, 0x19b955},{61, 527, 0x19b955},}, 85, 34, 520, 80, 600}
page.登录注册手机号界面_下一步 = {{{423, 474, 0x19b955},{326, 474, 0xf6fdf9},{290, 464, 0xffffff},{ 87, 449, 0x19b955},{570, 502, 0x19b955},}, 85, 22, 375, 604, 567}

page.验证码界面 = {{{ 46, 174, 0xa9a9a9},{ 43, 186, 0xb7b7b7},{ 47, 202, 0xc8c8c8},{ 49, 204, 0xbfbfbf},{267, 173, 0xdddddd},{267, 204, 0xdddddd},}, 85, 32, 134, 277, 231}
page.验证码界面_确定 = {{{333, 551, 0xffffff},{309, 551, 0xd1f1dd},{144, 525, 0x19b955},{547, 575, 0x19b955},{563, 529, 0x19b955},}, 85, 29, 460, 604, 616}
page.tips_X = {{{319, 914, 0xffffff},{315, 910, 0xffffff},{324, 909, 0xffffff},{323, 919, 0xd9dadb},{298, 927, 0xffffff},}, 85, 283, 882, 359, 943}
page.tips_X2 = {{{319, 838, 0xfcfcfc},{307, 837, 0x4c4c4c},{340, 823, 0xffffff},{345, 822, 0x4c4c4c},}, 85, 289, 813, 353, 859}
page.登录注册手机号界面_X = {{{582, 308, 0xffffff},{579, 305, 0xffffff},{580, 298, 0xcccccc},{594, 313, 0xcdcdcd},}, 85, 568, 292, 599, 322}
page.完成界面刷脸验证 = {{{352,  76, 0xffffff},{191,  70, 0xffffff},{166,  53, 0x253239},{458, 928, 0x19b955},{367, 934, 0xffffff},}, 85, 148, 34, 510, 981}


page.tips同意 = {{{359, 819, 0xffffff},{223, 822, 0xffffff},{156, 796, 0x4c8df5},{467, 841, 0x4c8df5},{480, 794, 0x4c8df5},}, 85, 108, 744, 534, 866}
page.tips我知道了 = {{{347, 930, 0xffffff},{258, 926, 0xffffff},{159, 913, 0x4c8df5},{474, 957, 0x4c8df5},{468, 894, 0xffffff},}, 85, 125, 886, 523, 976}
page.tips跳过 = {{{537, 78, 0xffffff},{524, 72, 0xffffff},{515, 59, 0xa83a35},{584, 95, 0xa62c2d},}, 85, 484, 39, 614, 113}
page.tips跳过1 = {{{571, 66, 0xffffff},{524, 65, 0xffffff},{541, 70, 0xffffff},}, 85, 503, 43, 595, 95}
page.tip关注品牌 = {{{349, 894, 0xffffff},{308, 896, 0xfefefe},{215, 894, 0x494a4b},{412, 892, 0x494a4b},}, 85, 120, 873, 510, 916}
page.tip尚未注册同意条款 = {{{359, 805, 0xeff5ff},{275, 794, 0xffffff},{132, 766, 0x4c8df5},{492, 821, 0x4c8df5},{161, 527, 0xff0725},{204, 627, 0x4c8df4},}, 85, 103, 435, 536, 851}
page.tips低价保障 = {{{552, 134, 0xffffff},{442, 199, 0x174bb9},{334, 289, 0xfaea32},{223, 342, 0x1b5bc9},}, 85, 138, 80, 575, 415}
page.tips狂欢节 = {{{372, 529, 0xee1038},{358, 479, 0xea5546},{283, 397, 0xffbd9b},{294, 355, 0xae0c0c},{331, 327, 0xffffff},}, 85, 205, 294, 479, 704}
page.tips积分派兑 = {{{405, 536, 0xfff486},{365, 513, 0x64bef2},{457, 411, 0xf6e3aa},{471, 411, 0xfed397},}, 85, 177, 343, 488, 600}
page.tips广告类1 = {{{551, 136, 0xffffff},{316, 927, 0xffffff},{397, 943, 0x113266},{610, 921, 0x737373},{608, 803, 0x737373},}, 85, 26, 90, 626, 954}
page.tips广告类2 = {{{550, 136, 0xffffff},{493, 133, 0x09234c},{579, 209, 0x09234c},{323, 932, 0xffffff},{323, 912, 0x737373},}, 85, 27, 59, 611, 1022}
page.tips广告类3 = {{{551, 136, 0xffffff},{527, 129, 0xffffff},{570, 149, 0xffffff},{548, 150, 0x67573a},{566, 137, 0x67573a},}, 85, 521, 102, 582, 171}
page.tips广告类4 = {{{550, 136, 0xffffff},{528, 128, 0xffffff},{573, 144, 0xffffff},{542, 145, 0xffffff},}, 85, 512, 100, 589, 169}
page.tips广告类5 = {{{550, 136, 0xffffff},{534, 136, 0x706e6d},{527, 136, 0xfafafa},{573, 126, 0xffffff},}, 85, 525, 110, 581, 161}
page.tips首页跳过 = {{{537, 80, 0xffffff},{524, 73, 0xffffff},{572, 91, 0xffffff},{577, 63, 0x7e9aad},}, 85, 483, 46, 615, 112}
page.首页 = {{{79, 1077, 0xf5fbfe},{69, 1067, 0x0292e5},{90, 1079, 0x0292e5},{83, 1087, 0xffffff},}, 85, 57, 1039, 104, 1090}
page.首页2 = {{{549, 1105, 0x333333},{ 91, 1102, 0x0277e4},{568, 1112, 0x363636},{ 98, 1107, 0x0277e4},}, 85, 53, 1092, 591, 1123}
page.我的 = {{{581, 1111, 0x0277e4},{540, 1105, 0x0277e4},}, 85, 526, 1100, 594, 1124}
page.手机号界面 = {{{399, 723, 0xa6c6fa},{250, 723, 0xa5c6fa},{237, 728, 0xa5c6fa},{ 90, 697, 0x4c8df5},{537, 746, 0x4c8df5},}, 85, 64, 191, 558, 785}
page.手机号界面1 = {{{364, 721, 0xffffff},{364, 720, 0xafccfb},{233, 737, 0xfdfeff},{ 76, 689, 0x4c8df5},{538, 747, 0x4c8df5},}, 85, 62, 144, 571, 780}
page.手机号界面_获取验证码 = {{{363, 410, 0xffffff},{332, 412, 0xffffff},{183, 381, 0x266fe2},{475, 435, 0x266fe2},{534, 395, 0x266fe2},}, 85, 39, 344, 596, 475}
page.短信验证码界面 = {{{ 38, 195, 0xbcbcbc},{ 39, 239, 0xadadad},{428, 196, 0xd9d9d9},{427, 239, 0xc5c5c5},{430, 216, 0x8f8f8f},}, 85, 30, 187, 436, 246}
page.设置密码界面 = {{{ 38, 139, 0xb0b0b0},{ 35, 142, 0xaaaaaa},{ 39, 183, 0x9f9f9f},{309, 139, 0xbcbcbc},{308, 138, 0xcbcbcb},{376, 183, 0xbbbbbb},}, 85, 24, 132, 388, 193}
page.设置密码界面_提交 = {{{344, 568, 0xffffff},{285, 561, 0xfafcff},{291, 553, 0xffffff},{ 36, 538, 0x4c8df5},{580, 600, 0x4c8df5},}, 85, 27, 507, 615, 612}
page.注册完成激活小蓝卡 = {{{339, 820, 0xffffff},{240, 798, 0x70bafe},{447, 822, 0x2784cd},{399, 719, 0x272e3a},{346, 427, 0x3384d0},{387, 295, 0x449be0},}, 85, 112, 243, 523, 874}
page.注册完成激活小蓝卡1 = {{{388, 744, 0x1d7ecd},{338, 743, 0xffffff},{341, 665, 0x272d3c},{225, 357, 0x3c96dd},{395, 251, 0x3e98de},{472, 438, 0x4e5871},}, 85, 152, 221, 528, 838}
page.注册完成激活小蓝卡all = {{{339, 745, 0xffffff},{212, 716, 0x77b6fc},{441, 763, 0x2784cd},{437, 691, 0x242b39},{376, 798, 0x1a212c},}, 85, 135, 676, 513, 813}
page.注册完成界面 = {{{134, 150, 0xf7f7f8},{120, 165, 0x774834},{ 60, 165, 0xf4f4f4},{218, 178, 0x164fa9},{309, 208, 0x0a316e},}, 85, 35, 69, 534, 270}

page.新版本体验 ={{{319, 1106, 0xffffff},{301, 1099, 0x676767},{336, 1081, 0xdedede},{249,  912, 0x4c8df4},{383,  955, 0x4c8df4},{403,  951, 0x4c8df4},}, 85, 221, 870, 421, 1130}
page.图形码界面 = {{{193, 277, 0xe9e9e9},{194, 304, 0x959595},{445, 278, 0x8b8b8b},{443, 301, 0xa0a0a0},{445, 304, 0x949494},}, 85, 190, 271, 452, 310}
page.图形码界面_确定 = {{{467, 572, 0x4c8df5},{427, 577, 0x72a5f7},}, 85, 408, 550, 503, 599}

page.手机号界面同意打钩 = {{{68, 1048, 0xffffff},{56, 1048, 0x979797},{79, 1046, 0x979797},{67, 1036, 0x979797},}, 85, 52, 1032, 83, 1063}
require('lzdm')
function reg(name)
	local TimeLine = os.time()
	local OutTime = 60*5

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
			if d(page.手机号界面,'page.手机号界面') or d(page.手机号界面1,'page.手机号界面1') then
				if d(page.手机号界面同意打钩,'page.手机号界面同意打钩',true) then
				elseif 取号 then
					phone = dxcode.getPhone()
					number = phone
					if phone ~= nil or phone ~= '' then
						delay(2.8)
						if type(tonumber(phone)) == "number" then
							click(272, 568)
							phoneKey(phone)
							取号 = false
							短信 = true	
						end
					end
				elseif d(page.手机号界面1,'page.手机号界面1',true) then
					delay(5)
				end	
			elseif d(page.短信验证码界面,'page.短信验证码界面') then	
				if 短信 then
					yzm = dxcode.getMessage()
--						log(yzm)
					if yzm ~= nil or yzm ~= '' then
						delay(2.8)
						phoneKey(yzm)			
						密码 = true
						短信 = false
					end
				end	

			elseif 密码 and d(page.设置密码界面,'page.设置密码界面') then
				if d(page.设置密码界面_提交,'page.设置密码界面_提交',true) then
						提交 = true
--						密码 = false
				else	
					click(62, 400)
					app.input_text(password)
					
				end
			elseif 提交 and d(page.注册完成激活小蓝卡all,'page.注册完成激活小蓝卡all') then
				up_hb('注册成功')
				return true
			elseif 提交 and d(page.注册完成激活小蓝卡,'page.注册完成激活小蓝卡') or 提交 and d(page.注册完成界面,'page.注册完成界面') then
				up_hb('注册成功')
				return true
			elseif d(page.注册完成激活小蓝卡,'page.注册完成激活小蓝卡') or d(page.注册完成激活小蓝卡all,'page.注册完成激活小蓝卡all') then
				up_hb('已注册过')
				return true
			elseif d(page.首页,'page.首页') or d(page.首页2,'page.首页2') then
				click(579, 1079)
			elseif d(page.新版本体验,'page.新版本体验',true) then
			elseif d(page.tips同意,'page.tips同意',true) then
			elseif d(page.tips我知道了,'page.tips我知道了',true) then
			elseif d(page.tips跳过,'page.tips跳过',true) then
			elseif d(page.tips跳过1,'page.tips跳过1',true) then
			elseif d(page.tip关注品牌,'page.tip关注品牌',true) then
			elseif d(page.tip尚未注册同意条款,'page.tip尚未注册同意条款',true) then
			elseif d(page.tips低价保障,'page.tips低价保障',true) then
			elseif d(page.tips广告类3,'page.tips广告类3',true) or d(page.tips广告类4,'page.tips广告类4',true) or d(page.tips广告类5,'page.tips广告类5',true) then
			elseif d(page.tips首页跳过,'page.tips首页跳过',true) then
			elseif d(page.tips广告类1,'page.tips广告类1') or d(page.tips广告类2,'page.tips广告类2') then
				click(550, 137)
			elseif d(page.我的,'page.我的') or d(page.我的1,'page.我的1')  then
				click(193, 175)
			elseif d(page.图形码界面,'page.图形码界面') then
--				return false
--				if 打码key then
					screen.image(386, 358, 546, 455):save_to_png_file("/private/var/mobile/yzm.jpg")
					orcYZM()
					app.input_text(yzm_jg)
					delay(2)
					click(227, 250)
					d(page.图形码界面_确定,'page.图形码界面_确定',true)
					--打码key = false
--				end
			end	
		end
		delay(2)
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




















