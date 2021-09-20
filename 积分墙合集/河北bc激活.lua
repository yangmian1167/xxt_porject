
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





bid={}
bid.花上钱贷款 = {	["appid"] =  "1278376336", ["appbid"] = "com.jiucang.huashangqian", ["adid"]= '1032', ["keyword"]="花上钱贷款" }



screen.init(0)
var = {}
var.source = "www"
var.adid = '215369'


function sign(adid,timestamp)
	local str = var.source.."|"..adid.."|"..idfa.."|"..var.key.."|"..timestamp
	log(str)
	return string.md5(str)
end

--全局变量

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
	idfalist.device =json.encode(fakerdevice) 
	return post(url,idfalist)
end
function up_hb(name,other)
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = name
	postdate.idfa = idfa 
--	postdate.phone = phone
	postdate.password = password 
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other 
--	postdate.account = bid[work]['adid'] or ''

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
	log('checkidfa-->'..name)
	local url = "http://m.moneyli.top/IDFA/repeat"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.idfa = idfa
	postArr.ip=ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.source = var.source
	postArr.keyword = bid[name]['keyword']
	postArr.os_version = os_version or sys.version()
	postArr.device = model
	postArr.udid = udid
	postArr.product = model
	

	post_data = ''
	for k,v in pairs(postArr)do
		post_data = post_data..k..'='..v..'&'
	end
	
	local url = url..'?'..post_data
	log(url)
	log(postArr)

	local getdata = get(url)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if tonumber(data[idfa]) == 0 then
			log("idfa: OK.",true)
			return true
		else
			log("idfa----排重失败",true)
		end
	end
end


function clickidfa(name)
	log("clickidfa->"..name)
	local url = "http://m.moneyli.top/IDFA/checkClick"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.idfa = idfa
	postArr.ip=ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.source = var.source
	postArr.keyword = bid[name]['keyword']
	postArr.os_version = os_version or sys.version()
	postArr.device = model
	postArr.udid = udid
	postArr.product = model

	if callback_key  then
		log("回调")
		local curl = require('lcurl')
		local e = curl.easy()
		postArr.callbackurl  = e:escape( "http://idfa888.com/Public/idfa/?service=idfa.callback&idfa="..idfa )
	end
	
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
		if tonumber(data.status) == 1 or data.message == 'ok' then
			log("点击成功: OK.",true)
			return true
		else
			log("idfa-点击失败",true)
		end
	end
end


function activeidfa(name)
	log('activeidfa-->'..name)
	local url = "http://m.moneyli.top/IDFA/activate"
	local postArr = {}
	postArr.adid = bid[name]['adid']
	postArr.idfa = idfa
	postArr.ip=ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.source = var.source
	postArr.keyword = bid[name]['keyword']
	postArr.os_version = os_version or sys.version()
	postArr.device = model
	postArr.udid = udid

	log(url.."?"..table.concat( postArr ))
	log(postArr)
	local getdata = post(url,postArr)
	if getdata ~= nil then
		local data = json.decode(getdata)
		log(data or "nil")
		if tonumber(data.status) == 1 then
			log("激活成功: OK.",true)
			back_pass(task_id,"ok")
			return true
		else
			log("idfa-激活失败",true)
		end
	end
end

function checkip()
	ip = get_ip() or "192.168.1.1"
	log(ip)
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

function callbackapi(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		udid = XXTfakerGetinfo(bid[name]["appbid"])['UDID']
		
		local dtassss = up(name,bid[name]['keyword'])
		if dtassss ~= nil then
			callbackid = json.decode(dtassss)['data']['id']
			if callbackid ~= nil then
				if checkidfa(name)then
					if clickidfa(name,true)then
						delay(rd(50,60))
						newidfa(name,1)
					end
				end
			end
		end
	end
end

function activeapi(name)
	log("name->" .. name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		fakerdevice = XXTfakerGetinfo(bid[name]['appbid'])
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		udid = XXTfakerGetinfo(bid[name]["appbid"])['UDID']
		log(model)
		log(os_version)
--		if checkidfa(name)then
--			if clickidfa(name)then
--				delay(rd(20,30))
				newidfa1(name,1)
--				if activeidfa(name)then
--					up(name,bid[name]['keyword'].."-激活成功")
--				end
--			end
--		end
	end
end

function onlyactive(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		
		local dtassss = up(name,bid[name]['keyword'])
		if dtassss ~= nil then
			callbackid = json.decode(dtassss)['data']['id']
			if callbackid ~= nil then
				if checkidfa(name)then
					delay(rd(3,6))
					newidfa(name,1)
					if activeidfa(name)then
						up(name,bid[name]['keyword'].."-激活成功")
					end

				end
			end
		end
	end
end


function idfaisok(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		return checkidfa(name)
	end
end

function clickisok(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		if checkidfa(name)then
			return clickidfa(name)
		end
	end
end

function beesign(appid,idfa)
	local txt = var.source.."|"..appid.."|"..idfa.."|"..var.key
	log("md5---"..txt)
	return string.md5(txt)
end


function rd(n,k)
	return math.random(n,k)
end

function appname(bid)
	return app.localized_name(bid) or '未安装'
end

apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}

function newidfa(name)
	local TIMEline = os.time()
	local OUTtime = rd(80,85)
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
		delay(2)
	end
	up(name,bid[name]['keyword'])
end


bc_游客登录={{{98, 537, 0xffffff},{90, 487, 0x45d15f},{99, 650, 0x4bdb5b},}, 85, 59, 424, 141, 702}
bc_快速开始={{{247, 653, 0xd78f29},{274, 489, 0xe1a853},{207, 469, 0x9a2614},{247, 694, 0xc7381e},}, 85, 195, 454, 313, 711}
bc_选项={{{589, 59, 0x909998},{571, 55, 0xa1f0cc},{561, 41, 0x302c36},{596, 72, 0x17141e},}, 85, 556, 26, 612, 86}
bc_返回={{{580, 142, 0xb7eee5},{573, 174, 0x79cbc2},{594, 174, 0xe8fffb},}, 85, 557, 38, 608, 192}
bc_签到={{{102, 590, 0xffffff},{ 92, 547, 0xff7419},{ 90, 488, 0xf6b800},{110, 644, 0xfac700},{142, 601, 0x23505e},}, 85, 54, 421, 182, 721}
bc_tips免费大奖={{{532, 997, 0xf8f1df},{509, 990, 0xe94917},{521, 979, 0xffcfac},{497, 965, 0x208454},}, 85, 491, 959, 559, 1017}

bc1_游客登录={{{140, 425, 0x5e3a14},{120, 415, 0xeab755},{165, 240, 0xebcb88},}, 85, 96, 202, 194, 465}
bc1_快速开始={{{145, 539, 0x7f3002},{147, 478, 0x9f6228},{169, 650, 0xedcd8b},}, 85, 90, 405, 206, 720}
bc1_选项={{{600, 38, 0xffd878},{600, 56, 0x373038},{610, 37, 0x3a333b},}, 85, 571, 12, 631, 74}
bc1_返回={{{606, 139, 0xe6e6e6},{600, 124, 0x3d4048},{606, 109, 0xe6e6e6},}, 85, 584, 87, 624, 164}
bc1_签到={{{386, 457, 0xffff92},{482, 290, 0xcca36a},{486, 173, 0xd5250f},{461, 188, 0xa48050},}, 85, 297, 164, 534, 541}
bc1_tips退出确认={{{217, 685, 0xe7c279},{217, 475, 0x8ca4ea},{213, 641, 0x5e3a14},}, 85, 195, 410, 241, 734}
bc1_tips摇奖={{{563, 950, 0xefdbc9},{548, 950, 0x8b4017},{582, 952, 0xc88549},}, 85, 535, 906, 592, 977}

bc2_游客登录={{{ 87, 412, 0xfdf7e5},{ 75, 326, 0xe5633d},{105, 511, 0xf28f11},}, 85, 36, 268, 129, 541}
bc2_立即领取={{{137, 597, 0x953f0a},{125, 535, 0xfecf19},{153, 690, 0xffeb50},}, 85, 99, 505, 179, 724}
bc2_选项={{{601, 30, 0xcaefff},{588, 15, 0x077cd1},{615, 48, 0x1969b6},}, 85, 580, 3, 632, 60}
bc2_返回={{{583, 152, 0xe7e9ff},{575, 175, 0x1a1d64},{582, 198, 0xe7e9ff},}, 85, 556, 136, 604, 215}
bc2_签到={{{428, 271, 0xffeb80},{358, 299, 0xfff08a},{420, 355, 0xf9cf52},}, 85, 297, 204, 450, 386}
bc2_tips退出确认={{{203, 693, 0xffffff},{204, 624, 0xf59709},{222, 721, 0xfcd60d},}, 85, 182, 601, 237, 734}
bc2_tips允许={{{193, 719, 0xffffff},{177, 643, 0xee8d09},{196, 749, 0xfbb909},}, 85, 165, 619, 213, 776}

function newidfa1(name)
	local TIMEline = os.time()
	local OUTtime = rd(80,85)
	local 签到key = rd(1,10)
	while os.time()- TIMEline < OUTtime do
		if active(bid[name]['appbid'],4)then
			if d(bc_游客登录,"bc_游客登录",true)then
			elseif d(bc1_游客登录,"bc1_游客登录",true)then
			elseif d(bc2_游客登录,"bc2_游客登录",true)then
			elseif 签到key < 8 then
				if d(bc_快速开始,"bc_快速开始",true)then
				elseif d(bc_选项,"bc_选项",true)then
				elseif d(bc_返回,"bc_返回",true)then
				elseif d(bc_签到,"bc_签到",true)then
				elseif d(bc_tips免费大奖,"bc_tips免费大奖",true)then		
				
				elseif d(bc1_快速开始,"bc1_快速开始",true)then
				elseif d(bc1_选项,"bc1_选项",true)then
				elseif d(bc1_返回,"bc1_返回",true)then
				elseif d(bc1_签到,"bc1_签到",true)then
				elseif d(bc1_tips退出确认,"bc1_tips退出确认",true)then
				elseif d(bc1_tips摇奖,"bc1_tips摇奖",true)then			
				
				elseif d(bc2_立即领取,"bc2_立即领取",true)then
				elseif d(bc2_选项,"bc2_选项",true)then
				elseif d(bc2_返回,"bc2_返回",true)then
				elseif d(bc2_签到,"bc2_签到",true)then
				elseif d(bc2_tips退出确认,"bc2_tips退出确认",true)then
				elseif d(bc2_tips允许,"bc2_tips允许",true)then
				end
			else

			end
		else
			log("启动一次")
		end
		delay(2)
	end
	--up(name,bid[name]['keyword'])
	up_hb(name,bid[name]['keyword'])
end





--期货掌中宝
function beewallidfa(name)
	if clickisok(name)then
		delay(rd(2,3))
		newidfa(name,1)
	end
	delay(1)
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

function main(v)
	----------------------------------
	if vpn() then
		if false or checkip()then
			log(v)
			work = v.work
			task_id = v.task_id
			bid={}
			bid[work]={}
			bid[work]['adid']=v.adid
			bid[work]['keyword']=v.keyword
			bid[work]['appbid']=v.appbid
			bid[work]['appid']=v.appid
			log("act")
			callback_key = false
			if v.note == "回调" then
				callback_key = true
			end
			activeapi(work)
			back_pass(task_id,"ok")
		end
		vpnx()
		delay(2)
	end
end


















