
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







screen.init(0)
var = {}

function sign(adid,timestamp)
	local str = var.source.."|"..adid.."|"..idfa.."|"..var.key.."|"..timestamp
	log(str)
	return string.md5(str)
end

--ćšć±ćé

function up_wenfree(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = name
	idfalist.idfa = idfa
	idfalist.ip = ip or get_ip() or '192.168.1.1'
	idfalist.account = bid[name]['keyword'] or account
	idfalist.password = var.password
	idfalist.phone = var.phone
	idfalist.other = other
	idfalist.device =json.encode(fakerdevice) 
	return post(url,idfalist)
end

function up_hb(name,other,account)
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = name
	postdate.idfa = idfa
	postdate.phone = var.phone
	postdate.password = var.password
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
	log('checkidfa-->'..name)
	local url = "http://aff.ihmedia.com.cn/channelinterface/SelfSelectIdfa?"
	local postArr = {}
--	postArr.adid = bid[name]['adid']
	postArr.taskid= '2066'
	postArr.appid ='841386224'
	postArr.channelid = '126'
	postArr.IDFA = idfa
	postArr.IP=ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
--	postArr.source = var.source
	postArr.keyword = bid[name]['keyword']
	postArr.os = os_version
	postArr.device = model
	postArr.udid = udid
--	postArr.product = model
	

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
			log("idfa----æéć€±èŽ„",true)
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
		log("ćè°")
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
			log("çčć»æć: OK.",true)
			return true
		else
			log("idfa-çčć»ć€±èŽ„",true)
		end
	end
end


function activeidfa(name)
	log('activeidfa-->'..name)
	local url = "http://aff.ihmedia.com.cn/channelinterface/toclick"
	local postArr = {}
	postArr.Grant_type = default
	postArr.isUpIDFA = '1'
	postArr.taskid= '2066'
	postArr.appid ='841386224'
	postArr.channelid = '126'
	postArr.IDFA = idfa
	postArr.IP=ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
--	postArr.source = var.source
	postArr.keyword = bid[name]['keyword']
	postArr.os = os_version
	postArr.device = model
	postArr.udid = udid
	postArr.type = '0'
	
	
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
		if data.messages == 'OK' then
			log("æżæŽ»æć: OK.",true)
			back_pass(task_id,"ok")
			return true
		else
			log("idfa-æżæŽ»ć€±èŽ„",true)
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
			log("ipćŻä»„çš:OK.",true)
			return true
		else
			log("ip, æéć€±èŽ„",true)
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

		if checkidfa(name)then
--			if clickidfa(name)then
				if reg1() then
					ćĄ«è”æ()
					if activeidfa(name)then
						up_hb(name,bid[name]['keyword'].."-æżæŽ»æć")
						up_wenfree(name,bid[name]['keyword'].."-æżæŽ»æć")
					end
				end			
--			end
		end
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
						up(name,bid[name]['keyword'].."-æżæŽ»æć")
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
	return app.localized_name(bid) or 'æȘćźèŁ'
end

apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}

function newidfa(name)
	local TIMEline = os.time()
	local OUTtime = rd(25,28)
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
			log("ćŻćšäžæŹĄ")
		end
		delay(2)
	end
	up(name,bid[name]['keyword'])
end

--æ„äżĄćčłć°
function _vCode_lx() --æ„äżĄ

--	local User = 'api-32182-rLPZxzn'
--	local Pass = 'yangmian121'
	local	User = 'api-18190-rKpL6bd'
	local	Pass = '135246'
	local PID = '14112'
--    local token,number = "a5c85b2e94093b9885a885a8c89451e36710242c",""
    local token,number = "8795f5b7a8709a639dc72cebac18834f83927ccd",""
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("è·ćtoken\n"..i.."æŹĄć±5æŹĄ")
                sys.msleep(1500)
				local lx_url = 'http://api.banma1024.net/api/do.php?action=loginIn&name='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				if RetStr then
					RetStr = string.split(RetStr,"|")
					if RetStr[1] == 1 or RetStr[1] == '1' then
						token = RetStr[2]
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
			local url___ = "http://api.banma1024.net/api/do.php?action=getPhone&sid="..PID.."&token="..token.."&vno=0"
			log(url___)
			RetStr = get(url___)
			if RetStr ~= "" and  RetStr ~= nil then
				log(RetStr)
				RetStr = string.split(RetStr,"|")
			end
			delay(3)
			if RetStr[1] == 1 or RetStr[1]== '1' then
				number = RetStr[2]
				log(number)
				local phone_title = (string.sub(number,1,3))
--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://api.banma1024.net/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
						get(lx_url);
						log("æé»->"..number)
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
				RetStr = get("http://api.banma1024.net/api/do.php?action=getMessage&sid="..PID.."&token="..token.."&phone="..number)
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
				toast(tostring(RetStr).."\n"..i.."æŹĄć±25æŹĄ")
            end
            return false
        end),
        addBlack=(function()
			local lx_url =	'http://api.banma1024.net/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
			log("æé»"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
var = {}
--var.appbid = "com.wondertek.hecmccmobile";
var.appbid = "cn.miao";



function inputword(v)
	key.send_text(v,200)
end





dxcode = _vCode_lx()
--dxcode.login()
tips = {}
tips_æç„éäș = {{{208, 999, 0x987de6},{457, 989, 0x987de6},{120, 455, 0xa0c3fd},{125, 288, 0x918ef0},}, 85, 31, 100, 575, 1065}
ç»ćœçéą = {{{ 86, 154, 0xc9c9c9},{ 86, 155, 0x323232},{ 89, 186, 0xbfbfbf},{273, 154, 0xc4c4c4},{280, 167, 0x9d9d9d},{263, 188, 0x909090},}, 85, 73, 129, 293, 200}
ç»ćœçéą_èŻ·èŸć„ææșć· = {{{ 90, 335, 0xe2e2e5},{ 88, 311, 0xf1f1f2},{153, 310, 0xefeff1},{255, 311, 0xececee},{252, 336, 0xe5e5e8},}, 85, 79, 301, 268, 343}
ç»ćœçéą_è·ćéȘèŻç  = {{{498, 451, 0x535353},{448, 444, 0xcfcfcf},{450, 461, 0xc0c0c0},{556, 443, 0xdedede},{556, 462, 0xc2c2c2},}, 85, 442, 437, 566, 469}
ç»ćœçéą_éźçćźæ = {{{572, 655, 0x007aff},{574, 666, 0x007aff},{609, 656, 0x007aff},}, 85, 548, 635, 628, 681}
ç»ćœçéą_ćææĄæŹŸ = {{{113, 764, 0xffffff},{106, 766, 0xfefefe},{121, 759, 0x9d9d9d},{106, 773, 0x9e9e9e},}, 85, 100, 748, 129, 781}
ç»ćœçéą_ç»ćœæéź = {{{298, 670, 0xffffff},{157, 662, 0x987de6},{534, 708, 0x987de6},{346, 682, 0xffffff},{494, 669, 0x987de6},}, 85, 71, 633, 552, 728}
ćŒćŻć„ćș·äčæ = {{{415, 720, 0xfffecf},{474, 740, 0xf2dc92},{546, 733, 0xeed280},{588, 735, 0xe8c366},}, 85, 391, 710, 599, 753}
tipsæ·ć€ ={{{460, 554, 0xeec346},{254, 565, 0x6fa47b},{290, 515, 0xf1eddc},{335, 768, 0xf1a9ae},{480, 689, 0x705457},}, 85, 118, 407, 510, 812}
tipsæ„éŁ ={{{191, 425, 0xecf0cf},{339, 461, 0xf5f3cc},{290, 748, 0xf9c94d},{467, 664, 0x51dea8},}, 85, 101, 330, 514, 797}
tipsè¶ćŒ ={{{194, 697, 0x5119cd},{231, 749, 0xff00a5},{184, 787, 0x3c03c9},{378, 734, 0xff29a7},{469, 701, 0x2511c4},}, 85, 141, 677, 511, 804}
tipsæŽæ°æç€șäžæŹĄćèŻŽ={{{130, 774, 0x007aff},{212, 791, 0x007aff},{206, 790, 0xf9f9f9},{419, 782, 0x007aff},{263, 361, 0x000000},{262, 358, 0xf9f9f9},}, 85, 81, 312, 566, 821}
function reg1()
	local TIMEline = os.time()
	local OUTtime = 3*60
	local ææșć· = true
	local ç­äżĄ = false
	local æäș€ = false
--	var.password  = myRand(4,8,2)
	while os.time()- TIMEline < OUTtime do
		if active(var.appbid,4)then
			if d(tips_æç„éäș,'tips_æç„éäș',true) then
			elseif d(tipsæŽæ°æç€șäžæŹĄćèŻŽ,'tipsæŽæ°æç€șäžæŹĄćèŻŽ',true) then
			elseif d(ç»ćœçéą,'ç»ćœçéą') then
				if d(ç»ćœçéą_èŻ·èŸć„ææșć·,'ç»ćœçéą_èŻ·èŸć„ææșć·') then
					if ææșć· then
						var.phone = dxcode.getPhone()
						if var.phone then
							if #var.phone == 11 then
								click(101, 323)
								inputword(var.phone)
								ææșć· = false
								ç­äżĄ = true
							end
						end
					end
				elseif ç­äżĄ then
					if d(ç»ćœçéą_è·ćéȘèŻç ,'ç»ćœçéą_è·ćéȘèŻç ',true) then
					else	
						var.sms = dxcode.getMessage()
						if #var.sms == 4 then
							click(98, 465)
							inputword(var.sms)
	--						up('ćȘćè§éą','çčć»æłšć')
							ç­äżĄ = false
							æäș€ = true
						end	
					end	
				elseif æäș€ then
					if d(ç»ćœçéą_éźçćźæ,'ç»ćœçéą_éźçćźæ',true) then
					elseif d(ç»ćœçéą_ćææĄæŹŸ,'ç»ćœçéą_ćææĄæŹŸ',true) then
					elseif d(ç»ćœçéą_ç»ćœæéź,'ç»ćœçéą_ç»ćœæéź',true) then

					end
				end
			elseif d(ćŒćŻć„ćș·äčæ,'ćŒćŻć„ćș·äčæ') or d(tipsæ·ć€,'tipsæ·ć€') or d(tipsæ„éŁ,'tipsæ„éŁ') or d(tipsè¶ćŒ,'tipsè¶ćŒ') then
				up_hb('ćŠć„ćș·',other,'æäș€æłšć')
				up_wenfree('ćŠć„ćș·',other,'æäș€æłšć')
				delay(5)
				return true
			end
		end	
		delay(1)
	end
end


äžȘäșșäž­ćżçéą = {{{572, 1077, 0x987de6},{572, 1067, 0xffffff},{562, 1067, 0x4d4d4d},{298, 1069, 0x987de6},{337, 1099, 0x987de6},}, 85, 272, 1047, 618, 1133}
èżćçź­ć€Ž = {{{31, 70, 0x333333},{43, 57, 0xcbcbcb},{43, 82, 0x7a7a7a},{33, 70, 0xf7f7f7},{34, 75, 0xcfcfcf},}, 85, 24, 49, 52, 89}
äž»çéąçčæç = {{{576, 1092, 0x9e9e9e},{576, 1086, 0x9e9e9e},{561, 1120, 0x9a9a9a},{580, 1075, 0xffffff},{582, 1101, 0xffffff},}, 85, 547, 1051, 606, 1131}
ææŻćžć„ = {{{109, 653, 0x387957},{214, 648, 0x3c7a59},{408, 643, 0xf4bf5f},{510, 653, 0xf8c061},{473, 660, 0x844b46},}, 85, 64, 607, 532, 692}
éć„œäș = {{{350, 1008, 0xffffff},{184,  994, 0xccb8fe},{505, 1026, 0xab9cff},{498,  993, 0xab9cff},}, 85, 111, 974, 535, 1044}
ç«ćłéąć = {{{326, 782, 0xff3018},{225, 762, 0xffe523},{422, 793, 0xffc010},{409, 739, 0xff2a21},}, 85, 170, 732, 471, 830}
äŒéèźĄć = {{{113, 156, 0x314a7a},{ 89, 156, 0x2e3868},{ 73, 147, 0x494b8a},{127, 155, 0x15083a},{ 82, 125, 0x78eef8},}, 85, 54, 103, 154, 234}
ć ć„èźĄć = {{{339, 1092, 0xffffff},{298, 1101, 0xfdfcff},{296, 1101, 0xc0b1ff},{  9, 1064, 0xd4c3ff},{625, 1065, 0xd4c1fe},{626, 1116, 0xbbacff},}, 85, 248, 1079, 395, 1113}
ć ć„èźĄć1 = {{{339, 1095, 0xffffff},{337, 1096, 0xc4b2ff},{ 11, 1063, 0xd5c4ff},{632, 1064, 0xd4c1ff},{621, 1121, 0xb9aaff},}, 85, 2, 1064, 636, 1132}
æç„éäș = {{{311, 668, 0xffffff},{313, 668, 0xa59ac7},{270, 668, 0x978bbe},{325, 673, 0x9487bc},}, 85, 252, 653, 379, 689}
èźŸçœźćŻç çéą = {{{305, 488, 0xffffff},{327, 483, 0xffffff},{122, 468, 0xcccccc},{143, 511, 0xcccccc},{513, 473, 0xcccccc},{520, 518, 0xcccccc},}, 85, 85, 444, 559, 537}
tipsæ·ć€ ={{{460, 554, 0xeec346},{254, 565, 0x6fa47b},{290, 515, 0xf1eddc},{335, 768, 0xf1a9ae},{480, 689, 0x705457},}, 85, 118, 407, 510, 812}
tipsæ„éŁ ={{{191, 425, 0xecf0cf},{339, 461, 0xf5f3cc},{290, 748, 0xf9c94d},{467, 664, 0x51dea8},}, 85, 101, 330, 514, 797}
tipsè¶ćŒ ={{{194, 697, 0x5119cd},{231, 749, 0xff00a5},{184, 787, 0x3c03c9},{378, 734, 0xff29a7},{469, 701, 0x2511c4},}, 85, 141, 677, 511, 804}
ç«ćłć ć„ = {{{337, 608, 0xffffff},{274, 599, 0xffffff},{137, 579, 0xd0bdff},{512, 632, 0xa693ff},{235, 366, 0x1f1047},{214, 366, 0x81d9fa},}, 85, 45, 206, 563, 666}
function ćĄ«è”æ()
	local TIMEline = os.time()
	local OUTtime = 4*60
	var.password  = myRand(4,8,2)
	while os.time()- TIMEline < OUTtime do
		if active(var.appbid,4)then
			if d(ææŻćžć„,'ææŻćžć„',true) then
			elseif d(éć„œäș,'éć„œäș',true) then
				click(158, 599)
			elseif d(ç«ćłéąć,'ç«ćłéąć',true) then
			elseif d(äŒéèźĄć,'äŒéèźĄć') then
				click(270, 435)
			elseif d(ć ć„èźĄć,'ć ć„èźĄć',true) or d(ć ć„èźĄć1,'ć ć„èźĄć1',true) then
			elseif d(æç„éäș,'æç„éäș',true) then
			elseif d(äž»çéąçčæç,'äž»çéąçčæç',true) then
			elseif d(ç«ćłć ć„,'ç«ćłć ć„',true) then
			elseif d(ćŒćŻć„ćș·äčæ,'ćŒćŻć„ćș·äčæ') then
				click(301, 448)
				delay(5)
			elseif d(äžȘäșșäž­ćżçéą,'äžȘäșșäž­ćżçéą') then
				click(590, 78)
				delay(2)
				click(249, 199)
			elseif d(èźŸçœźćŻç çéą,'èźŸçœźćŻç çéą') then
				click(118, 324)
				inputword(var.password)
				delay(2)
				click(253, 497)
				up_hb('ćŠć„ćș·',other,'ćźæŽæłšć')
				up_wenfree('ćŠć„ćș·',other,'ćźæŽæłšć')
				delay(3)
				return true
			elseif d(tipsæ·ć€,'tipsæ·ć€') or d(tipsæ„éŁ,'tipsæ„éŁ') or d(tipsè¶ćŒ,'tipsè¶ćŒ') then
				click(321, 929)
			elseif d(èżćçź­ć€Ž,'èżćçź­ć€Ž',true) then
			else
				
			end	
		end
		delay(1)
	end
end


--æèŽ§æäž­ćź
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
		
		if taskData.data == "æ°ćąææș" or taskData.data == "ææ ä»»ćĄ" then
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
		if true or checkip()then
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
			if v.json == "ćè°" then
				callback_key = true
			end
			activeapi(work)
		end
		vpnx()
		delay(2)
	end
end


















