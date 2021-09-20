nLog = require('nLog')()
require('faker')
require('xxtsp')
require('lzdm')
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
bid={}
bid.app = 'com.baihe.online'

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

--[[]]

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



--]]--

screen.init(0)
var = {}
var.lun = 0


--lx.id = '12939'
--全局变量

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
	postdate.name = '百合婚恋'
	postdate.idfa = idfa 
	postdate.phone = phone
	postdate.password = password 
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other 
--	postdate.account = bid[work]['adid'] or ''

	log(post(url,postdate))
	-- body
end


--回馈注册结果
function up_res(res_)
token = get('http://st.jiuapi.cn/api/home/user/login?username=dytian&password=Qwe666')
token = json.decode(token)
token = token.message
log(get('http://st.jiuapi.cn/api/home/get/reslut?token='..token..'&phone='..phone..'&state='..res_))

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




imgUrl = "http://image.baidu.com/channel/listjson?pn=15000&rn=1&tag1=%E7%BE%8E%E5%A5%B3&tag2=%E5%85%A8%E9%83%A8&ftags=%E5%A4%B4%E5%83%8F&ie=utf8"


page={}

page.主菜单={{{578,1096,0x929292},{300,1079,0x9d9d9d},{179,1078,0x929292},{49,1086,0xff425a},}, 85, 22, 1050, 623, 1132}
page.主菜单_我的_资料={{{567,192,0xaaaaaa},{590,83,0x979797},{578,1096,0xff2983},{300,1080,0x9d9d9d},{43,1074,0x929292},}, 85, 0, 0, 0, 0}
page.编辑_编辑_我喜欢谁={{{544,825,0xff5e00},{544,605,0xff5e00},{530,330,0xff5e00},{597,70,0xffffff},{527,356,0xff5e00},}, 85, 445, 45, 629, 875}
page.编辑_编辑_我喜欢谁ios10={{{549,792,0xff5e00},{549,808,0xff5e00},{549,765,0xff5e00},{549,784,0xfff5ef},{530,284,0xff5e00},
					{531,319,0xff5e00},}, 85, 468, 222, 620, 840}
page.编辑资料界面={{{388,80,0x525252},{367,87,0x525252},{300,73,0x525252},{52,83,0xfc6e27},}, 85, 9, 53, 521, 115}
page.infolist={
	{607, 354, 0xd1d1d5},
	{608, 446, 0xcbcbd0},
	{608, 538, 0xcbcbd0},
	{608, 722, 0xcbcbd0},
	{607, 814, 0xd1d1d5},
	{607, 906, 0xd1d1d5},
}
page.滑动确定={{{601,662,0xfd6e27},{603,648,0xfd6e27},}, 85, 588, 493, 622, 877}
page.编辑资料_保存={{{599,89,0xfd6e27},{550,80,0xfd6e27},{367,79,0x525252},{52,83,0xfc6e27},}, 85, 23, 47, 626, 120}
page.编辑_更多资料界面={{{596,72,0xfc6127},{568,85,0xfc6127},{594,98,0xfc6127},{52,84,0xfc6e27},
					{38,82,0xffffff},}, 85, 18, 45, 636, 122}
page.编辑_基本资料={{{547,1074,0xff5e00},{547,1062,0xff5e00},{58,1078,0x333333},{58,1081,0xffffff},
					{58,1083,0x333333},{32,1082,0x333333},{59,1069,0x333333},{59,1096,0x333333},}, 85, 0, 0, 0, 0}



function clickM(x,y,m)
	local m = m or 1
	for i=1,m do
		click(x,y,0.5)
	end
end

--[[
function makeinfo()
	local TimeLine = os.time()
	local OutTime = 60*3
	local sexhight = false
	local makeinfo_ = false
	
	while os.time()-TimeLine < OutTime do
		if active(bid.app,5)then
			if d(page.主菜单,"page.主菜单",true)then
			elseif d(page.主菜单_我的_资料,"page.主菜单_我的_资料",true)then
			elseif makeinfo_ and (d(page.编辑_编辑_我喜欢谁,"page.编辑_编辑_我喜欢谁",false)or d(page.编辑_编辑_我喜欢谁ios10,"page.编辑_编辑_我喜欢谁ios10",false))then
--				up("婚恋网",'信息完成'..sexk)
				up("百合回访",sexk.."修改资料")
				sys.alert("注册完成,即将退出",3)
				closeX(appbids)
				return true
			elseif d(page.编辑_编辑_我喜欢谁,"page.编辑_编辑_我喜欢谁",false) or d(page.编辑_编辑_我喜欢谁ios10,"page.编辑_编辑_我喜欢谁ios10",false) then
					if sexhight then
						moveTo(300,700,300,400,5,20)
						moveTo(300,700,300,400,5,20)
					else
						if d(page.编辑_编辑_我喜欢谁,"page.编辑_编辑_我喜欢谁",true)then
						elseif d(page.编辑_编辑_我喜欢谁ios10,"page.编辑_编辑_我喜欢谁ios10",true)then
						end
					end
			elseif d(page.编辑资料界面,"page.编辑资料界面",false)then
					for i,v in ipairs(page.infolist)do
						click(v[1],v[2])
						if i == 1 then
							clickM(168, 809,rd(6,9))
						elseif i == 2 then
							clickM(171, 1035,rd(1,2))					
						elseif i == 3 then
							clickM(171, 1035,rd(1,2))
							clickM(468, 1037,rd(1,3))
						elseif i == 4 then
							local choice = {
								{585,  831, 0xffeade},
								{585,  916, 0xffffff},
								{585, 1003, 0xffffff},
							}
							click(choice[1][1],choice[rd(1,#choice)][2])
						elseif i == 5 then
							local choice = {
								{583,  628, 0xff5e00},
								{584,  717, 0xffffff},
								{590,  811, 0xffffff},
								{589,  892, 0xffffff},
								{585,  979, 0xffffff},
								{590, 1068, 0xffffff},
							}						
							click(choice[1][1],choice[rd(1,#choice)][2])
						elseif i == 6 then
							local choice = {
								{583,  742, 0xff5e00},
								{588,  828, 0xffffff},
								{588,  919, 0xffffff},
								{586, 1001, 0xffffff},
								{587, 1093, 0xffffff},
							}
							click(choice[1][1],choice[rd(1,#choice)][2])
						end
						d(page.滑动确定,"page.滑动确定",true)
					end
					if d(page.编辑资料_保存,"page.编辑资料_保存",true)then
						delay(5)
						makeinfo_ = true
					end

			elseif d(page.编辑_更多资料界面,"page.编辑_更多资料界面") then
				if d(page.编辑_基本资料,"page.编辑_基本资料",true)then
				else
					moveTo(300,700,300,400,5,20)
				end
			else
				if d(page.本地相册,"page.本地相册",true,3)then
					
				end
			end
		end
		delay(0.5)
	end
end


--]]



page.基本资料界面={{{380,76,0x000000},{370,72,0xffffff},{368,72,0x000000},{42,83,0x888888},},85}
	page.基本资料界面_请输入={{{444,285,0xc7c7cd},{457,285,0xc7c7cd},{495,285,0xff8432},{501,285,0xffffff},}, 85, 367, 255, 519, 319}
	page.基本资料界面_性别女={ {{541,361,0xe2e2e2},{540,351,0xfbfbfb},{537,343,0xe2e2e2},{536,382,0xe2e2e2},}, 85, 496, 322, 581, 407}
		page.基本资料界面_性别女_选框={{{586,664,0xffffff},{585,644,0xebebeb},{564,665,0xe6e6e6},{607,665,0xe6e6e6},}, 85, 554, 634, 622, 969}
	page.基本资料界面_完成={{{306,1042,0xffffff},{309,1022,0xff645a},{86,1041,0xff7948},{530,1043,0xff4e6b},}, 85, 17, 968, 621, 1125}
page.昵称={{{46,77,0xfd6e27},{306,77,0x525252},{308,72,0xffffff},},85}
	page.昵称完成={{{569,85,0xfd884d},{551,73,0xfd6e27},{545,67,0xffffff},}, 85, 526, 61, 614, 109}
page.我知道了={{{383,840,0xff5962},{369,317,0xffa251},{356,775,0x008eff},},85}
page.本地相册={{{367,860,0xfd6e27},{396,767,0xfd6e27},{569,154,0xffffff},},85}			--3x
page.照片={{{328,78,0x000000},{331,81,0xf9f9f9},{552,80,0x007aff},},85}
page.照片ios10={{{214,210,0x000000},{105,543,0x8e8e93},{309,70,0x000000},{563,77,0x208bff},}, 85,  11, 12, 630, 571}
page.照片_详情={{{21,83,0x007aff},{309,79,0xf9f9f9},{313,79,0x3a3a3a},{552,86,0x007aff},},85}
page.照片_详情ios10={{{23,83,0x007aff},{60,184,0x000000},{313,86,0x3a3a3a},{567,82,0x1e8aff},}, 85, 5, 7, 630, 460}
page.照片_注册成功={{{569,1097,0x43fe85},{62,1086,0xe83c2d},},85}
page.照片_地址未显示={{{596,404,0xc7c7cc},{568,407,0xd9d9d9},{523,404,0xffffff},{530,404,0xd9d9d9},}, 85, 450, 341, 625, 465}
page.照片_地址_确定={{{602,661,0xfd6e27},{581,667,0xfd6e27},}, 85, 535, 626, 628, 697}

page.完善信息_完成注册={{{314,1033,0xffffff},{319,1033,0xff635b},{319,1009,0xff635c},{319,1067,0xff625b},}, 85, 224, 986, 411, 1094}
page.上传头像={{{441,756,0xfd6e27},{356,860,0xfd6e27},{335,345,0xff8000},{568,154,0xffffff},},85}
page.完成注册={{
	{340, 931, 0xfe605c},
	{ 97, 920, 0xfe7b48},
	{ 93, 951, 0xff7c47},
	{531, 940, 0xff4b6f},
}, 85, 66, 763, 579, 1133}

page.弹出选择确定={{{587, 577, 0xf9ba9b},{546, 568, 0xfb864b},{602, 591, 0xfb9b6c},{599, 590, 0xf7f7f7},}, 85, 535, 558, 613, 600}
page.注册完成界面={{{78, 1082, 0xff78a4},{75, 1086, 0xffffff},{71, 1089, 0xff2d7d},{46, 1118, 0xffccd6},{77, 1109, 0xffffff},}, 85, 29, 1050, 106, 1130}

page.完善信息_点本地相册={{
	{338, 812, 0x007aff},
	{330, 811, 0x2c91fe},
	{296, 813, 0x007aff},
	{254, 816, 0xf9f9f9},
}, 85, 218, 748, 436, 861}

page.完善信息_相机胶卷界面={{
	{310,  82, 0xffffff},
	{281,  87, 0xffffff},
	{223,  49, 0x424242},
	{417, 111, 0x424242},
	{414,  68, 0x424242},
}, 85, 196, 43, 435, 123}
page.上传头像点完成={{
	{602, 1091, 0x53b311},
	{553, 1069, 0x171717},
	{585, 1106, 0x191c17},
}, 85, 542, 1061, 621, 1113}



apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}
apparr.right_agree={{
		{475, 964, 0x49b849},
		{478, 968, 0xffffff},
		}, 85, 323, 602, 624, 1132}

tips={}
tips.协议更新提示={{{336, 729, 0x1986ff},{302, 730, 0x037aff},{222, 591, 0x097eff},{244, 437, 0x000000},{361, 438, 0x000000},}, 85, 133, 403, 515, 766}

function sjclick(min,max,x,y)
	local sjkey = rd(min,max)
	if sjkey == 0 then
		return true
	end
	for i=1,sjkey do
		click(x,y,0.5)
	end
end


page.完善信息_开始找对象={{{319, 1086, 0xffffff},{102, 1078, 0xff754a},{562, 1113, 0xff4e6d},{584, 1041, 0xffffff},}, 85, 35, 1025, 616, 1133}
function fix()
	local TimeLine = os.time()
	local OutTime = 60*3
	local 性别key = true
	local 生日key = true
	local 地区key = true
	local 身高key = true
	local 月收入key = true
	local 学历key = true
	local 婚姻状况key = true
	local 提交key = false
	local 注册完成key = false
	while os.time()-TimeLine < OutTime do
		if active(bid[work]['appbid'],5) then
			if d(tips.协议更新提示,"tips.协议更新提示",true)then
			elseif d(apparr.right,"apparr.right",true)then
			elseif d(apparr.right_agree,"right_agree",true)then
			elseif d(page.完善信息_相机胶卷界面,"page.完善信息_相机胶卷界面") then
				x = 120*(math.random(0,4))
				y = 160*(math.random(0,5))
				click(77+x, 217+y)
			elseif d(page.完善信息_点本地相册,'page.完善信息_点本地相册',true) then
			elseif d(page.上传头像点完成,'page.上传头像点完成',true) then
				头像key = false
			elseif d(page.完善信息,"page.完善信息") then
				if 性别key then
					local math_ = math.random(1,10)
					if math_ > 5 then
						click(290, 357)
					elseif math_ <= 5 then
						click(488, 366)
					end
					性别key = false
				elseif 生日key then
					delay(2)
					click(385, 474)
					for i = 1,math.random(1,8) do
						click(169, 947)
					end
					for i = 1,math.random(1,8) do
						click(323, 947)
					end
					for i = 1,math.random(1,8) do
						click(452, 947)
					end
					生日key = false
				elseif 地区key then	
					随机地区 = math.random(1,8)
					click(383, 578)
					delay(2)
					if 随机地区 == 1 then
						log('河北张家口市')
						click(37, 818)
						for i = 1 , 6 do
							click(568, 958)
						end
					elseif 随机地区 == 2 then
						log('河北承德市')
						click(37, 818)
						for i = 1 , 7 do
							click(568, 958)
						end
					elseif 随机地区 == 3 then
						log('内蒙古乌兰察布市')
						click(38, 909)
						for i = 1 , 8 do
							click(568, 958)
						end
					elseif 随机地区 == 4 then
						log('山西省运城市')
						click(197, 901)
						for i = 1 , 7 do
							click(568, 958)
						end
					elseif 随机地区 == 5 then
						log('山东省宾州')
						click(197, 901)
						click(353, 961)
						click(353, 961)
						for i = 1 , 15 do
							click(568, 958)
						end						
					elseif 随机地区 == 6 then
						log('安徽省亳州市')
						click(42, 666)
						for i = 1 , 14 do
							click(568, 958)
						end						
					elseif 随机地区 == 7 then
						log('河北沧州市')
						click(37, 818)
						for i = 1 , 8 do
							click(568, 958)
						end						
					elseif 随机地区 == 8 then
						log('贵州省铜仁市')
						click(203, 747)
						for i = 1 , 2 do
							click(356, 959)
						end							
						for i = 1 , 5 do
							click(584, 958)
						end	
					end	
					地区key = false
				elseif 身高key then	
					click(360, 687)
					delay(2)
					click(60+(math.random(0,4)*110), 685+(math.random(0,4)*100)) 
					身高key = false
				elseif 月收入key then	
					local math_ = math.random(0,10)
					if math_ > 5 then
						click(238, 787)
					elseif math_ <= 5 then
						click(387, 783)
					elseif math_ == 0 then
						click(576, 788)
					end
					月收入key = false
				elseif 学历key then	
					local math_ = math.random(0,10)
					if math_ > 5 then
						click(245, 895)
					elseif math_ <= 5 then
						click(388, 895)
					elseif math_ == 0 then
						click(566, 895)
					end
					学历key = false
				elseif 婚姻状况key then
					click(252, 1003)
					婚姻状况key = false
					提交key = true
				elseif 提交key then
					if d(page.完善信息_开始找对象,"page.完善信息_开始找对象",true) then
--						up("婚恋网",'填完信息'..sexk)
--						up("百合回访",'填完信息'..sexk)
						注册完成key = true
					else
						moveTo(151, 812,189, 593)
					end
				end
			elseif  d(page.注册完成界面,"page.注册完成界面") then
				if	注册完成key then
					up_hb('完整注册')
					return true
				else
					up_hb('注册过拉黑')
--					dxcode.addBlack()
					return false
				end	
			else
				d(page.弹出选择确定,"page.弹出选择确定",true)
				
			end	
		end
		delay(0.5)
	end
end

function rd_click(min,max,x,y)
	local key = rd(min,max)
	if key == 0 then
		return false
	else
		for i=1,key do
			click(x,y,0.5)
		end
	end
end



page.allow={{{477,665,0x007aff},{187,668,0x007aff},}, 85, 71, 440, 580, 702}
page.allow_local={{{360,594,0x007aff},{347,684,0x007aff},{359,777,0x007aff},}, 85, 324, 565, 373, 797}

page.tip_bad={{{154,635,0x007aff},{164,662,0x007aff},{502,646,0x007aff},}, 85, 111, 613, 533, 681}

page.regUI={{{480, 144, 0xff5f5e},{467, 141, 0xff6b54},{467, 125, 0xffffff},{476, 104, 0xff5f5e},{457, 104, 0xff5f5e},}, 85, 418, 66, 519, 161}
	page.regUI_up={{{171, 140, 0xff5d60},{165, 140, 0xff6a54},{143, 105, 0xff5f5e},{192, 100, 0xff5f5e},}, 85, 101, 75, 232, 154}
	page.regUI_login={{{326, 329, 0xc7c7cd},{274, 316, 0xdbdbdf},{281, 342, 0xcacad0},{360, 315, 0xeaeaed},{357, 342, 0xdcdce0},}, 85, 263, 303, 370, 352}
page.regUI_next={{{330, 588, 0xffffff},{144, 556, 0xff6939},{148, 623, 0xff6939},{529, 560, 0xfe336b},}, 85, 101, 522, 540, 652}
page.regUI_next1={{{162, 555, 0xff663a},{166, 613, 0xff653c},{490, 552, 0xff3866},{491, 621, 0xff3864},}, 85, 123, 498, 524, 668}
page.regUI_move={{{ 94, 797, 0x7e7e7e},{ 96, 785, 0xffffff},{106, 785, 0x939393},{139, 785, 0x7e7e7e},{150, 799, 0xffffff},{157, 812, 0xbcbcbc},}, 85, 74, 767, 241, 821}
	page.regUI_send={ {{498,344,0xff5d5f},{413,338,0xff7b46},{558,344,0xff4871},{484,321,0xff635b},}, 85, 391, 197, 577, 387}
	page.regUI_yzm={{{238, 68, 0x9a9a9a},{234, 93, 0xc5c5c5},{240, 99, 0xb0b0b0},{401, 69, 0xc2c2c2},{401, 97, 0x969696},}, 85, 228, 55, 411, 108}
	page.regUI_reg={ {{255,736,0xff6a55},{318,703,0xff635b},{338,766,0xff615d},}, 85, 178, 698, 497, 774}
page.完善信息={{{382, 99, 0x959595},{253, 96, 0x8d8d8d},{253, 71, 0xa1a1a1},{382, 68, 0x484848},}, 85, 245, 58, 393, 105}
page.账号异常={{{440, 675, 0x666666},{206, 668, 0x666666},{197, 600, 0x662719},{461, 599, 0x661726},}, 85, 157, 564, 481, 707}
page.取消上传={{{174, 655, 0x007aff},{435, 663, 0xff3b30},}, 60, 124, 611, 504, 687}
page.已注册联合登录={{{375, 236, 0xff927e},{317, 249, 0xfe866d},{286, 252, 0xffcfd4},{233, 213, 0xffb28c},{340, 129, 0xffbb8e},{372, 113, 0xfffcfc},}, 85, 177, 78, 458, 321}
page.已注册联合登录1={{{334, 196, 0xfefdfd},{276, 168, 0xff5760},{372, 201, 0xff3b84},{191, 360, 0x555555},{131, 366, 0xff9072},{535, 366, 0xff9073},}, 85, 37, 67, 574, 753}
page.基本信息界面={{{259, 68, 0x686868},{253, 86, 0x787878},{254, 98, 0xe8e8e8},{381, 70, 0x6b6b6b},{384, 97, 0x979797},}, 85, 243, 60, 394, 108}


page.注册界面={{{293, 127, 0xdd007c},{295, 182, 0xec6c1f},{318, 158, 0xffffff},{340, 130, 0xdd007c},{375, 169, 0xffffff},}, 85, 229, 74, 422, 233}
page.登录界面={{{194, 127, 0xff5f5e},{157, 124, 0xff7271},{ 96, 113, 0xffffff},{241, 146, 0xffffff},{244, 126, 0xffffff},}, 85, 83, 106, 257, 155}
page.立即注册={{{361, 758, 0xffffff},{211, 732, 0xff6141},{436, 770, 0xff3e5f},}, 85, 175, 701, 464, 817}
page.账号异常={{{444, 681, 0x661926},{450, 643, 0x661926},{203, 635, 0x662619},{195, 683, 0x662719},{220, 662, 0xffffff},{188, 649, 0xffffff},}, 85, 158, 597, 505, 709}
page.基本信息界面_男女={{{160, 510, 0x74a5fd},{262, 564, 0x62b1fc},{379, 510, 0xff925d},{545, 575, 0xff655e},}, 85, 62, 470, 592, 609}


page.滑动验证码界面={{{122, 675, 0x5fbb08},{115, 675, 0xf9f9f9},{137, 675, 0x66d200},{142, 677, 0xf9f9f9},{149, 679, 0x66d200},}, 85, 110, 650, 553, 699}
page.滑动验证码界面_点1={{{321, 448, 0x022903},}, 85, 186, 331, 552, 615}
page.滑动验证码界面_点2={{{376, 462, 0x00411f},}, 85, 186, 331, 552, 615}
page.滑动验证码界面_点3={{{225, 389, 0x003b12},}, 85, 186, 331, 552, 615}
page.滑动验证码界面_滑动失败={{{111, 597, 0xde715b},{528, 601, 0xde715b},{526, 575, 0xde715b},}, 85, 101, 571, 543, 609}

page.英文数字验证码界面={{{272, 434, 0xdfdfdf},{262, 460, 0x787878},{378, 436, 0xb7b7b7},{378, 458, 0xe0e0e0},}, 85, 256, 423, 385, 467}
page.英文数字验证码界面_确定={{{229, 530, 0xff724d},{427, 561, 0xff516a},}, 85, 148, 483, 499, 610}
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
	local 打码key = true
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
			if d(page.完善信息,"page.完善信息") then
				up_hb('点击提交')
				return true
			elseif  d(page.注册完成界面,"page.注册完成界面") then
					up_hb('注册过拉黑')
					return false
			elseif d(page.账号异常,"page.账号异常")then
--				dxcode.addBlack()
				return false				
			elseif d(page.已注册联合登录,"page.已注册联合登录") or d(page.已注册联合登录1,"page.已注册联合登录1")  then
				up_hb('注册过拉黑')
--				dxcode.addBlack()
				return false
			elseif d(page.登录界面,"page.登录界面")then
				click(390, 141)
			elseif d(page.regUI_move,"page.regUI_move")then
--			elseif d(page.regUI_move,"page.regUI_move",true)then
--				if movekey == 1 then
--					moveTo(116, 706,341, 686)
--					movekey = movekey + 1
--				elseif movekey == 2 then
--					moveTo(116, 706,255, 687)
--					movekey = movekey + 1
--				elseif movekey == 3 then
--					moveTo(116, 706,300, 683)
--					movekey = 1
--				end	
			elseif d(page.注册界面,"page.注册界面") then
				if 国家地区 then
					if type(bid[work]['adid']) == 'string' and bid[work]['adid'] ~= '' then
						log('adid有字符串')
						click(323, 287)
						delay(2)
						click(108, 190)
						input(bid[work]['adid'])
						delay(1)
						click(113, 200)
						delay(2)
					end	
					国家地区 = false
				elseif d(page.账号异常,"page.账号异常") then
--					dxcode.addBlack()
					return false
				elseif d(page.立即注册,"page.立即注册",true) then
				elseif 取号 then
					if d(page.注册界面,"page.注册界面")then
						delay(1)
--						if yzm.get.phone()then
--						if GET_Phone() then
						phone = dxcode.getPhone()
						log(phone)
						number = phone
						if phone then
							delay(2.8)
							if type(tonumber(phone)) == "number" then
								click(303, 530)
								phoneKey(phone)
								d(page.注册界面,"page.注册界面",true)
								取号 = false
								短信 = true
							end
						end
					end
				end	
			elseif d(page.regUI_yzm,"regUI_yzm")then
				if 短信 then		
--					elseif yzm.get.sms()then
--					if GET_message(phone)then
					yzm = dxcode.getMessage()
					log(yzm)
					if yzm then
						delay(2.8)
						input(yzm)			
						短信 = false
						提交 = true
					else
						return false
					end	
				else
					if 发验证码次数 < 3 and d(page.regUI_send,"page.regUI_send",true)then
						发验证码次数 = 发验证码次数 + 1
					elseif 发验证码次数 >= 3 then
						return false
					end
					取短信次数 = 取短信次数 + 1
					if 取短信次数 > 25 then
						return false
					end
					delay(3)
				end
			elseif d(page.基本信息界面,"page.基本信息界面")then
--				dxcode.addBlack()
				click(524, 288)
				click(190, 296)
				input(password)
				click(536, 181)				
				if sex > sex_key then
						sexk = '女'
						click(454, 520)
				else
					sexk = '男'
					click(187, 528)
				end
			
			elseif d(page.滑动验证码界面,"page.滑动验证码界面") then
				if d(page.滑动验证码界面_滑动失败,"page.滑动验证码界面_滑动失败") then
					delay(2)
					click(170, 779)
				elseif d(page.滑动验证码界面_点1,"page.滑动验证码界面_点1") or d(page.滑动验证码界面_点2,"page.滑动验证码界面_点2") or d(page.滑动验证码界面_点3,"page.滑动验证码界面_点3") then
					moveTo(92, 675,x,675,20)
				end
			elseif d(page.英文数字验证码界面_确定,"page.英文数字验证码界面_确定",true) then
			elseif d(page.英文数字验证码界面,"page.英文数字验证码界面") then	
				if 打码key then
					screen.image(347, 508, 494, 581):save_to_png_file(imgfile)
					orcYZM()
					click(123, 560)
					sys.input_text(yzm_jg)
					delay(2)
					打码key = false
				else
					return false
				end	
			else
				if d(page.allow,"page.allow",true)then
				elseif d(page.allow_local,"page.allow_local",true)then
				end
			end	
		end
		delay(0.5)
	end
end



function newidfa()
	local TIMEline = os.time()
	local OUTtime = rd(25,30)
	while os.time()- TIMEline < OUTtime do
		if active(bid[work]['appbid'],10)  then
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
	return true
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



--[[]]
function main(v)
	work = v.work
	task_id = v.task_id
	bid={}
	bid[work]={}
	bid[work]['adid'] =  v.adid 
	if bid[work]['adid'] then
	else
		bid[work]['adid'] = ''
	end
	bid[work]['appbid']=v.appbid 
	vpnx()
	delay(3)
	if false or vpn() then
		ip,locals = get_local()
		if ip ~= "192.168.1.1" and ip~= nil then
			if true or checkip()then
				if false or XXTfakerNewPhone(bid[work]['appbid'])then
					idfa = XXTfakerGetinfo(bid[work]['appbid'])['IDFA']
					delay(1)
--					dxcode.login()
--					dxcode.GetPhone()
					if reg()then
						if fix()then
--							up_res(1) -- 回馈结果成功
							back_pass(task_id,"ok")
							if newidfa() then
								
							end
						else
--							up_res(2) -- 回馈结果失败
						end	
					else
--						up_res(2) -- 回馈结果失败
					end
				end
	
			end
		end
	end
	app.quit(bid[work]['appbid'])
	delay(2)
end

--]]




















