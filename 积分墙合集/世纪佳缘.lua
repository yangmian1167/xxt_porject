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
				RetStr = get("http://sms.wenfree.cn/public/?service=App.Sms.GetMessage".."&imei="..phone_imei.."&phonename="..phone_name)
				if RetStr then
					RetStr = json.decode(RetStr)
					log(RetStr)
					if RetStr.data.meg == success or RetStr.data.meg == 'success' then
						Msg = RetStr.data.sms
						if type(tonumber(Msg))== "number" then log(Msg); return Msg 
						else
							log(Msg)
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

function _Server_getnew()
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
--营业厅平台
function _vCode_yyt() --营业厅平台

	local	User = 'baihejiayuan867'
	local	Pass = '123456'
	local PID = '17'
    local token,number = "9B8173DA5D221A89A4D18B4B122C63A3",""	

    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://185.200.34.52:38790/api/login.aspx?user='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.code == 0  and RetStr.message == 'Success' then
						token = RetStr.data.token
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
			local url___ = "http://185.200.34.52:38790/api/get/mobile.aspx?token="..token.."&ProID="..PID
			log(url___)
			RetStr = get(url___)
			RetStr = json.decode(RetStr)
			log(RetStr)
			delay(3)
			if RetStr.code == 0 and RetStr.message == 'Success' then
				number = RetStr.data.mobile
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
				local url___ = "http://185.200.34.52:38790/api/get/sms.aspx?token="..token.."&mobile="..number.."&ProID="..PID.."&release=0"
				log(url___)
				RetStr = get(url___)
				if RetStr then
					RetStr = json.decode(RetStr)
					log(RetStr)
					if RetStr.code == 0 and RetStr.message == 'Success' then
						Msg = RetStr.Data.content
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
			local lx_url =	'http://dev.wanzhongma.com/open/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--dxcode = _vCode_yyt()	

function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = name
	idfalist.idfa = idfa or phone
	idfalist.ip = '192.168.1.1'
	idfalist.ip = ip or '192.168.1.1'
	idfalist.account = account or locals or get_local() or '未知'
	idfalist.password = password
	idfalist.phone = phone
	idfalist.other = other
	return post(url,idfalist)
end
function up_hb(other)
	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
	local postdate = {}
	postdate.service = 'Idfa.Idfa'
	postdate.name = '世纪佳缘'
	postdate.idfa = phone
--	postdate.phone = phone
	postdate.password = password
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other
--	postdate.account = bid[work]['adid']
	log(post(url,postdate))
	-- body
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
bid.app = 'com.jiayuan.jiayuaniphone'

page={}

--page_手机号登录注册 = {{{252,  956, 0xcf1278},{262,  956, 0xcf1278},{264,  970, 0xe36837},{460,  962, 0xc9b29d},{406, 1058, 0x4e97d5},}, 85, 140, 924, 548, 1110}
page_手机号登录注册 = {{{ 82, 171, 0xa1a2a3},{ 79, 201, 0xc4c5c5},{ 92, 216, 0xcecfcf},{463, 169, 0x4d4f50},{461, 217, 0xc0c1c1},{469, 193, 0x88898a},}, 85, 76, 161, 476, 226}
page_手机号登录注册_获取验证码 = {{{360, 632, 0xffffff},{254, 635, 0xffffff},{193, 611, 0xf95a76},{443, 661, 0xf83f83},{391, 623, 0xfff9fb},{390, 620, 0xf84182},}, 85, 83, 588, 557, 689}
page_填写资料1界面 = {{{305, 164, 0xb7b7b7},{317, 193, 0x676767},{345, 197, 0xc0c0c0},{309, 263, 0xaacdec},{393, 270, 0xc4dcf2},}, 85, 297, 139, 404, 286}

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
	local 国家地区 = true
	while os.time()-TimeLine < OutTime do
		if active(bid[work]['appbid'],10)then
			if d(page_手机号登录注册,'page_手机号登录注册') then
				if 国家地区 then
					if type(bid[work]['adid']) == 'string' and bid[work]['adid'] ~= '' then
						log('adid有字符串')
						click(154, 328)
						delay(2)
						click(126, 177)
						input(bid[work]['adid'])
						delay(1)
						click(116, 319)
						delay(2)
					end	
					国家地区 = false
				elseif 取号 then
					phone = dxcode.getPhone()
--					log(phone)
					number = phone
					if phone ~= nil or phone ~= '' then
						delay(2.8)
						if type(tonumber(phone)) == "number" then
							click(285, 335)
							phoneKey(phone)
							取号 = false
							短信 = true
						end
					end
				elseif 短信 then
					if d(page_手机号登录注册_获取验证码,'page_手机号登录注册_获取验证码',true) then
					else
						yzm = dxcode.getMessage()
--						log(yzm)
						if yzm ~= nil or yzm ~= '' then
							click(180, 429)
							delay(2.8)
							phoneKey(yzm)			
							短信 = false
							提交 = true
--						else
--							return false
						end
					end	

				end	
			elseif d(page_上传头像跳过,'page_上传头像跳过',true) then
			elseif d(page_上传头像跳过1,'page_上传头像跳过1',true) then
			elseif d(page_主界面,'page_主界面') or d(page_主界面2,'page_主界面2')or d(page_主界面3,'page_主界面3') then
				up_hb('注册过拉黑')
				return false
			elseif 提交 and  d(page_填写资料1界面,'page_填写资料1界面') then
				up_hb('提交注册')
				return true
			end
		end
		delay(0.5)
	end
end	

page_填写资料1界面_生日未选择 ={{{442, 664, 0xf5f5f5},{527, 681, 0xefefef},{525, 661, 0xf8f8f8},{453, 687, 0xdddddd},{470, 686, 0xe5e5e5},{395, 186, 0x878787},}, 85, 435, 653, 539, 693}
page_填写资料1界面_地区未选择 ={{{442, 756, 0xf5f5f5},{440, 764, 0xdfdfdf},{439, 776, 0xf5f5f5},{525, 753, 0xf8f8f8},{519, 779, 0xe5e5e5},}, 85, 431, 748, 534, 784}
page_填写资料1界面_请输入昵称 ={{{183, 442, 0xf4f4f4},{181, 449, 0xf5f5f5},{185, 466, 0xeeeeee},{319, 440, 0xebebeb},{329, 444, 0xf4f4f4},{322, 466, 0xdcdcdc},}, 85, 179, 436, 337, 476}
page_完成 ={{{557, 647, 0xc2e3ff},{547, 650, 0x8dcbff},{602, 668, 0xc8e6ff},{599, 673, 0xa9d8ff},}, 85, 542, 639, 607, 679}
page_完成_生日 ={{{294, 645, 0xe8e8e8},{288, 658, 0xa1a1a1},{289, 670, 0xdddddd},{346, 646, 0xdadada},{346, 673, 0xd5d5d5},}, 85, 282, 638, 356, 678}
page_完成_所在地区 ={{{258, 647, 0xbebebe},{281, 645, 0x848484},{255, 672, 0xd4d4d4},{381, 646, 0x8b8b8b},{382, 670, 0xd3d3d3},}, 85, 248, 639, 390, 679}
page_完成_身高 ={{{300, 644, 0xe8e8e8},{336, 644, 0xe3e3e3},{290, 673, 0xd7d7d7},{308, 674, 0xcacaca},{323, 674, 0xebebeb},{347, 673, 0xb6b6b6},}, 85, 286, 636, 356, 678}
page_完成_学历 ={{{293, 645, 0x868686},{301, 644, 0xc8c8c8},{311, 644, 0xe0e0e0},{297, 673, 0xb5b5b5},{344, 673, 0xaaaaaa},}, 85, 282, 635, 357, 678}
page_完成_月薪 ={{{294, 646, 0xc7c7c7},{291, 672, 0xb1b1b1},{329, 644, 0xe7e7e7},{342, 644, 0xf3f3f3},{346, 674, 0xe7e7e7},}, 85, 289, 638, 355, 679}
page_完成_婚史 ={{{292, 644, 0xe6e6e6},{288, 672, 0xc6c6c6},{314, 645, 0x808080},{337, 645, 0xa5a5a5},{350, 671, 0xeaeaea},}, 85, 285, 639, 356, 681}

page_填写资料1界面_下一步 ={{{539, 82, 0x979797},{538, 84, 0x333333},{495, 69, 0x989898},{596, 86, 0x898989},}, 85, 488, 50, 607, 112}

page_填写资料2界面 ={{{305, 162, 0xc7c7c7},{307, 193, 0x000000},{343, 201, 0xa4a4a4},{367, 149, 0xbcbcbc},{338, 186, 0x878787},}, 85, 293, 138, 374, 209}
page_填写资料2界面_未选择 ={{{442, 447, 0xd9d9d9},{439, 466, 0xf5f5f5},{471, 443, 0xf4f4f4},{525, 444, 0xe8e8e8},{519, 469, 0xe5e5e5},{527, 464, 0xefefef},}, 85, 434, 438, 541, 760}
page_填写资料2界面_完成注册 ={{{305, 938, 0xffffff},{263, 935, 0xffffff},{121, 903, 0xf96a6f},{503, 973, 0xf83b85},{503, 913, 0xf83b85},}, 85, 59, 884, 563, 994}

page_上传头像跳过 ={{{546,  76, 0xffffff},{549,  77, 0x363839},{406, 456, 0xd8d8d8},{345, 461, 0xffffff},{254, 287, 0x4a95d5},{192, 181, 0x000000},}, 85, 27, 51, 601, 496}
page_上传头像跳过1 ={{{547,  97, 0x66686c},{533,  87, 0x66686c},{588, 111, 0x6b6d71},{583,  85, 0xbabbbd},{588,  90, 0xc0c1c3},}, 85, 521, 68, 596, 128}
page_主界面 ={{{69, 1080, 0xff2181},{48, 1067, 0xff566d},{67, 1118, 0xe52553},{74, 1130, 0xe73862},{74, 1125, 0xffffff},}, 85, 33, 1046, 94, 1133}
page_主界面2 ={{{74, 1078, 0xff1a83},{62, 1069, 0xff2b7e},{58, 1066, 0xffffff},{54, 1066, 0xff4176},{68, 1116, 0xe42351},{72, 1116, 0xffffff},}, 85, 37, 1048, 91, 1132}
page_主界面3 ={{{71, 1077, 0xff1f82},{50, 1074, 0xff4f71},{58, 1064, 0xffffff},{58, 1058, 0xffffff},{52, 1062, 0xff4973},}, 85, 36, 1050, 89, 1100}
function fix()
	local TimeLine = os.time()
	local OutTime = 60*5
	local 比例男 = math.random(1,100)
	local	  xingbie = ''
	local 完成注册key = false
	local 生日key = true
	local 地区key = true
	while os.time()-TimeLine < OutTime do
		if active(bid[work]['appbid'],10)then
			if d(page_主界面,'page_主界面') or d(page_主界面2,'page_主界面2')or d(page_主界面3,'page_主界面3') then
				if 完成注册key then
					up_hb('完整注册')
					return true
--				else
--					up_hb('注册过拉黑')
--					return true
				end
			elseif d(page_填写资料1界面,'page_填写资料1界面') then
				if d(page_填写资料1界面_下一步,'page_填写资料1界面_下一步') then
					if 比例男 <= 50 then
						xingbie = '男'
						click(135, 571)
						click(135, 571)
					else
						xingbie = '女'
						click(451, 555)
						click(451, 555)
					end	
					d(page_填写资料1界面_下一步,'page_填写资料1界面_下一步',true)
				elseif 生日key and d(page_填写资料1界面_生日未选择,'page_填写资料1界面_生日未选择',true) then
					生日key = false
				elseif 地区key and d(page_填写资料1界面_地区未选择,'page_填写资料1界面_地区未选择',true) then
					地区key =false
				elseif d(page_填写资料1界面_请输入昵称,'page_填写资料1界面_请输入昵称') then
					click(475, 457)
				else
					if 比例男 <= 50 then
						xingbie = '男'
						click(135, 571)
					else
						xingbie = '女'
						click(451, 555)
					end	
				end	
			elseif d(page_填写资料2界面,'page_填写资料2界面') then
				if d(page_填写资料2界面_未选择,'page_填写资料2界面_未选择',true) then
				elseif d(page_填写资料2界面_完成注册,'page_填写资料2界面_完成注册',true) then
					完成注册key = true
				end	
			elseif d(page_完成,'page_完成') then
				if d(page_完成_生日,'page_完成_生日') then
					local 随机1 = math.random(3,5) 
					local 随机2 = math.random(1,3) 
					local 随机3 = math.random(1,3) 
					for i = 1 , 随机1 do
						moveTo(164, 803,172, 1040)
					end	
					for i = 1 , 随机2 do
						moveTo(318, 806,308, 1040)
					end	
					for i = 1 , 随机3 do
						moveTo(464, 804,456, 1041)
					end	
					d(page_完成,'page_完成',true)
				elseif d(page_完成_所在地区,'page_完成_所在地区') then
					if bid[work]['adid'] == '香港' then
						for i = 1 , 33 do
							click(185, 986)
						end
						click(489, 988)
					elseif bid[work]['adid'] == '越南' then
						for i = 1 , 37 do
							click(185, 986)
						end
						for i = 1 , 31 do
							click(489, 988)	
						end	
					else
						--指定城市
						随机地区 = math.random(1,8)
						if 随机地区 == 1 then
							log('河北张家口市')
							for i = 1 , 3 do
								click(185, 986)
							end
							for i = 1 , 7 do
								click(489, 988)
							end
						elseif 随机地区 == 2 then
							log('河北承德市')
							for i = 1 , 3 do
								click(185, 986)
							end
							for i = 1 , 8 do
								click(489, 988)
							end
						elseif 随机地区 == 3 then
							log('山西省运城市')
							for i = 1 , 4 do
								click(185, 986)
							end
							for i = 1 , 8 do
								click(489, 988)
							end
						elseif 随机地区 == 4 then
							log('内蒙古乌兰察布市')
							for i = 1 , 5 do
								click(185, 986)
							end
							for i = 1 , 9 do
								click(489, 988)
							end
						elseif 随机地区 == 5 then
							log('山东省宾州')
							for i = 1 , 15 do
								click(185, 986)
							end
							for i = 1 , 16 do
								click(489, 988)
							end					
						elseif 随机地区 == 6 then
							log('安徽省亳州市')
							for i = 1 , 12 do
								click(185, 986)
							end
							for i = 1 , 14 do
								click(489, 988)
							end						
						elseif 随机地区 == 7 then
							log('河北沧州市')
							for i = 1 , 3 do
								click(185, 986)
							end
							for i = 1 , 9 do
								click(489, 988)
							end						
						elseif 随机地区 == 8 then
							log('贵州铜仁市')
							for i = 1 , 24 do
								click(185, 986)
							end
							for i = 1 , 5 do
								click(489, 988)
							end		
						end
						---原始随机
--						local 随机4 = math.random(1,10) 
--						local 随机5 = math.random(1,10) 
--						for i = 1 , 随机4 do
--							click(185, 986)
--						end
--						for i = 1 , 随机5 do
--							click(489, 988)
--						end	
					end	
					d(page_完成,'page_完成',true)
				elseif d(page_完成_身高,'page_完成_身高') then
					if 比例男 <= 50 then
						for i = 1 ,math.random(4,8) do
							moveTo(342, 1083,342,  988)
							delay(1)
						end
					else
						for i = 1 ,math.random(3,4) do
							moveTo(342, 1083,342,  988)
							delay(1)
						end
					end
					d(page_完成,'page_完成',true)
				elseif d(page_完成_学历,'page_完成_学历') then
					for i = 1 , math.random(1,5) do
						click(342, 977)
					end	
					d(page_完成,'page_完成',true)
				elseif d(page_完成_月薪,'page_完成_月薪') then	
					for i = 1 , math.random(1,4) do
						click(339, 991)
					end	
					d(page_完成,'page_完成',true)
				elseif d(page_完成_婚史,'page_完成_婚史') then
					click(338, 980)
					d(page_完成,'page_完成',true)
				else
					d(page_完成,'page_完成',true)
				end	
			else
				if d(page_上传头像跳过,'page_上传头像跳过',true) then
				elseif d(page_上传头像跳过1,'page_上传头像跳过1',true) then
				end
			end	
			
		end
		delay(1)
	end
end

apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}
tips_设置取消={{{447, 649, 0x007aff},{203, 660, 0x007aff},{157, 638, 0x007aff},{484, 652, 0x007aff},}, 85, 136, 616, 501, 673}
function newidfa()
	local TIMEline = os.time()
	local OUTtime = rd(25,30)
	while os.time()- TIMEline < OUTtime do
		if active(bid[work]['appbid'],10)  then
			if d(apparr.right,"apparr.right",true)then
			elseif d(tips_设置取消,"tips_设置取消",true)then
			elseif d(page_主界面,'page_主界面') or d(page_主界面2,'page_主界面2')or d(page_主界面3,'page_主界面3') then	
				click(566, 100)
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
	return true
end





--[[]]
function main(v)
	work = v.work
	task_id = v.task_id
	bid={}
	bid[work]={}
	bid[work]['adid'] = v.adid or ''
	bid[work]['appbid']=v.appbid
	bid[work]['note']=v.note
	if bid[work]['note'] == "新" then
		dxcode = _Server_getnew()
	elseif bid[work]['note'] == "旧" then
		dxcode = _Server_get()
	end
	vpnx()
	delay(3)
	if false or vpn() then
		ip,locals = get_local()
		if ip ~= "192.168.1.1" and ip~= nil then
			if true or checkip()then
				if false or XXTfakerNewPhone(bid[work]['appbid'])then
					idfa = XXTfakerGetinfo(bid[work]['appbid'])['IDFA']
					delay(1)
					if reg()then
						if fix() then
							back_pass(task_id,"ok")
							if newidfa() then
								
							end
						end
--					else
						--yzm.get.cancelRecv()
					end
				end
	
			end
		end
	end
	app.quit(bid[work]['appbid'])
	delay(2)
end

--]]

















