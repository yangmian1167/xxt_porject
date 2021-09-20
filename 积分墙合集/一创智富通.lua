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

function _vCode_lxy() --流星云
			
	local User = 'api-t4TRnuxO'
	local Pass = 'yangmian121'
	local PID = '18173'
    local token,number = "A2F8A6CA8FE8E7BF4B3D3D8EFA0004C6FC9401FB93385B",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://www.liuxing985.com:81/sms/api/login?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.code == 0 or RetStr.code == "0" then
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
				local url___1 = "http://www.liuxing985.com:81/sms/api/getPhone?token="..token.."&sid="..PID..'&ascription=1'
				local url___2 = "http://www.liuxing985.com:81/sms/api/getPhone?token="..token.."&sid="..PID..'&ascription=2'
				math_ = math.random(1,10)
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
					if  RetStr.code == 0 or RetStr.code == "0" then
						number = RetStr.phone
						log(number)
					end
					local phone_title = (string.sub(number,1,3))
	--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
	--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
	--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
					local blackPhone = {}
					for k,v in ipairs(blackPhone) do
						if phone_title == v then
							local lx_url =	'http://www.liuxing985.com:81/sms/api/addBlacklist?token='..token..'&phone='..number..'&sid='..PID
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
				local url___ = "http://www.liuxing985.com:81/sms/api/getMessage?token="..token.."&sid="..PID.."&phone="..number
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					RetStr = json.decode(RetStr)
					if  RetStr.code == 0 or RetStr.code == "0" then
						Msg = RetStr.sms
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
			local lx_url =	'http://www.liuxing985.com:81/sms/api/addBlacklist?token='..token..'&phone='..number..'&sid='..PID
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
function _vCode_df() --德芙
			
	local User = '18129871167'
--	local User = 'yangmian1167'
	local Pass = 'yangmian121'
	local PID = '19358'
    local token,number = "lnWu1pFiMO5tWnADWXHkEBiouG/39X6ZcSc66G38+U2iG0JYdtxufnKGt0tCmcTS0eVDJoseiHOz2n7Idhlz5ImWCKgAsMcDnjOb7AJpQb+YfbMii/L4CFRK27WfPEfC5m0FKTzy2cSfNu7QCBXssGkGdTXiQMkToq9DlP1Ka8I=",""	
--    local token,number = "kKNLL3RlJjvcTrOXPqWnGeBEFXUko0ew9nmJEcXpz+iVH3u68Cq5xV8Ov4bolGXmxgin0Hj5DCGIO+snjlAdMhH7wrggqXBHLhGpc4wUhZMisj/4AHPQseKAyBxo7mxjne3sBOb56pAHkVeFDW8JTmS8i3ORD+RAuavB0jmha08=",""	
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
				math_ = math.random(1,10)
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
function _vCode_yhc() --萤火虫
			
	local User = 'yangmian1167'
	local Pass = 'yangmian121'
	local PID = '17552'
    local token,number = "425f16bc397147116e3cfef5e34b1031",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://www.yhcgx.com:81/login?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.msg == 'success' then
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
				local url___1 = "http://www.yhcgx.com:81/getphone?token="..token.."&id="..PID.."&catname=1"
				local url___2 = "http://www.yhcgx.com:81/getphone?token="..token.."&id="..PID.."&catname=2"
				math_ = math.random(1,10)
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
					if  RetStr.msg == 'success' then
						number = RetStr.phone
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
				local url___ = "http://www.yhcgx.com:81/getmessage?token="..token.."&id="..PID.."&phone="..number
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					RetStr = json.decode(RetStr)
					if  RetStr.code == '0' then
						Msg = RetStr.msg
						local i,j = string.find(Msg,"%d+")
						Msg = string.sub(Msg,i,j)
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
function _vCode_xfx() --小飞象
			
	local User = 'yangmian1167'
	local Pass = 'yangmian121'
	local PID = '17552'
    local token,number = "425f16bc397147116e3cfef5e34b1031",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://www.yhcgx.com:81/login?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.msg == 'success' then
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
				local url___1 = "http://www.yhcgx.com:81/getphone?token="..token.."&id="..PID.."&catname=1"
				local url___2 = "http://www.yhcgx.com:81/getphone?token="..token.."&id="..PID.."&catname=2"
				math_ = math.random(1,10)
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
					if  RetStr.msg == 'success' then
						number = RetStr.phone
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
				local url___ = "http://www.yhcgx.com:81/getmessage?token="..token.."&id="..PID.."&phone="..number
				log(url___)
				RetStr = get(url___)	
				log(RetStr)
				if RetStr then
					RetStr = json.decode(RetStr)
					if  RetStr.code == '0' then
						Msg = RetStr.msg
						local i,j = string.find(Msg,"%d+")
						Msg = string.sub(Msg,i,j)
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
--dxcode = _vCode_lxy()
--dxcode = _vCode_yhc()

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
	local url = 'http://wenfree.cn/api/Public/idfa/?service=Ip.Checkphone&name=一创智富通&phone='..phone
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
function checkphone()
--	ip = get_ip() or "192.168.1.1"
--	log(ip)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=Ip.Checkphone&name=一创智富通&phone='..phone
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
function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	log( post(url,postArr) )
end

bid={}
bid.app = 'com.fcsc.tztiphone'

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
tips_确定 = {{{341, 894, 0xdcd1d2},{289, 889, 0xdadada},{203, 864, 0xf24957},{427, 913, 0xf24957},}, 85, 185, 833, 461, 935}
tips_确定1 = {{{337, 931, 0xdadada},{227, 906, 0xc20000},{397, 952, 0xc20000},{395, 968, 0xf7eded},}, 85, 193, 882, 446, 977}
tips_同意并继续 = {{{504, 914, 0xed3e26},{456, 915, 0xffffff},{377, 912, 0xf48475},{174, 918, 0x898989},{178, 919, 0xffffff},}, 85, 69, 855, 566, 961}
tips_跳过 = {{{556, 77, 0xf3f3f3},{532, 77, 0xfcfcfc},{524, 67, 0xffffff},{570, 72, 0xcccccc},}, 85, 484, 44, 601, 106}
tips_网络超时 = {{{336, 640, 0xdadada},{277, 635, 0xf24957},{382, 646, 0xf24957},{414, 622, 0xf24957},}, 85, 180, 586, 465, 690}
tips_系统提示确定= {{{384, 806, 0xf24957},{258, 788, 0xf24957},{399, 776, 0xf24957},{336, 791, 0xdadada},}, 85, 193, 748, 448, 834}
tips_输入股票取消= {{{604,  88, 0xffffff},{611,  88, 0x3b3a3e},{556,  61, 0x3b3a3e},{572,  73, 0xffffff},{617, 110, 0x3b3a3e},}, 85, 546, 40, 634, 123}
tips_系统提示确定= {{{337, 897, 0xdadada},{308, 898, 0xdadada},{220, 867, 0xc20000},{413, 907, 0xc20000},{451, 890, 0xf7eeed},}, 85, 177, 842, 463, 935}

首页 = {{{73, 1070, 0xed3e26},{65, 1080, 0xffffff},{68, 1090, 0xed3e26},{52, 1099, 0xffffff},}, 85, 28, 1043, 90, 1130}
行情 = {{{192, 1073, 0xcda76e},{177, 1072, 0xcda76e},{175, 1110, 0xd0ad78},{206, 1114, 0xfcf9f5},{211, 1088, 0xcda76e},}, 85, 162, 1061, 228, 1127}
点我的 = {{{577, 1074, 0x999999},{572, 1082, 0xdcdcdc},{586, 1113, 0xdfdfdf},{593, 1113, 0x999999},}, 85, 539, 1052, 628, 1128}
我的 = {{{579, 1072, 0xffffff},{574, 1078, 0xfad0cb},{571, 1061, 0xed3e26},{591, 1076, 0xed3e26},}, 85, 541, 1047, 612, 1126}
我的_登录注册 = {{{303, 222, 0xffffff},{104, 218, 0xd0bfab},{ 88, 218, 0xefdcc4},{ 93, 251, 0x008a70},{164, 188, 0x4d526c},}, 85, 28, 157, 366, 283}
手机号码验证界面2 = {{{436,  69, 0xffffff},{436,  68, 0xd1d2d4},{205,  70, 0xfcfcfc},{211, 100, 0x52565d},{438, 101, 0x696c73},}, 85, 191, 49, 457, 119}
手机号码验证界面 = {{{428,  83, 0xffffff},{308,  83, 0xffffff},{308,  82, 0xffffff},{205,  62, 0x3b3a3e},{449, 105, 0x3b3a3e},}, 85, 193, 55, 455, 112}
手机号码验证界面_获取验证码 = {{{546, 286, 0xffffff},{430, 267, 0xc1975b},{599, 303, 0xc1975b},}, 85, 401, 245, 623, 327}
手机号码验证界面_下一步 = {{{318, 439, 0xffffff},{ 52, 416, 0xc1975b},{546, 454, 0xc1975b},{577, 387, 0xf1f1f1},}, 85, 11, 376, 638, 499}
注册成功登陆账户 = {{{456, 633, 0x2287d6},{437, 633, 0x2287d6},{195, 628, 0xe5e5e5},{199, 628, 0xffffff},{406, 637, 0xffffff},}, 85, 12, 452, 631, 576}
注册成功登陆账户2 = {{{460, 636, 0x2287d6},{413, 634, 0x2287d6},{202, 639, 0x999999},{202, 635, 0xffffff},{242, 416, 0x9e9e9e},{241, 415, 0xffffff},}, 85, 132, 368, 541, 668}
注册成功登陆账户3 = {{{483, 631, 0x2287d6},{402, 633, 0xc1def4},{180, 635, 0x999999},{164, 624, 0xbcbcbc},}, 85, 134, 608, 517, 655}
已注册过_个人信息界面 = {{{354, 649, 0xffffff},{276, 648, 0xffffff},{ 94, 637, 0xff6138},{555, 679, 0xff6138},{553, 608, 0xf5f5f5},}, 85, 29, 595, 621, 710}

编辑自选_完成 = {{{100, 77, 0xffffff},{ 90, 72, 0x8d8d8f},{ 61, 75, 0xffffff},{ 49, 97, 0xc2c1c3},{ 71, 97, 0x656468},}, 85, 38, 59, 115, 107}
网络故障_重新加载 = {{{343, 827, 0xffffff},{296, 819, 0xffffff},{259, 807, 0xffffff},{197, 795, 0xd64113},{480, 852, 0xd64113},{491, 787, 0xd64113},}, 85, 123, 758, 513, 876}

返回箭头 = {{{45,  83, 0xa8a8aa},{64,  66, 0xffffff},{65, 102, 0xd0d0d1},{64, 100, 0x525155},}, 85, 31, 43, 80, 116}
交易账号登录返回 = {{{ 47, 85, 0xffffff},{122, 87, 0x3a3a3a},{112, 61, 0xffffff},{156, 72, 0xa5a5a5},}, 85, 41, 56, 551, 112}
编辑自选点完成 = {{{86, 85, 0xffffff},{57, 76, 0xffffff},{91, 84, 0x9a9da1},{99, 83, 0x161b25},}, 85, 43, 61, 107, 105}
function reg()
	local TimeLine = os.time()
	local OutTime = 60*3

	local 取号 = true
	local 验证码 = false
	local 短信 = false
	local 提交 = true
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
			if d(手机号码验证界面,'手机号码验证界面') or d(手机号码验证界面2,'手机号码验证界面2') then
				
				if 取号 then
					phone = dxcode.getPhone()
--					log(phone)
					number = phone
					if phone ~= nil or phone ~= '' then
						if type(tonumber(phone)) == "number" then
							if checkphone() then
								delay(5)
								click(146, 197)
								input(phone)
								取号 = false
								短信 = true
							end
						end
					end
				elseif 短信 then
					if d(手机号码验证界面_获取验证码,'手机号码验证界面_获取验证码',true) then
					else
						yzm = dxcode.getMessage()
--						log(yzm)
						if yzm ~= nil or yzm ~= '' then
							click(168, 293)
							delay(1)
							input(yzm)			
							短信 = false
							提交 = true
--						else
--							return false
						end
					end	
				elseif d(手机号码验证界面_下一步,'手机号码验证界面_下一步',true)  then
				end	
			elseif 提交 and d(注册成功登陆账户,'注册成功登陆账户') or 提交 and d(注册成功登陆账户2,'注册成功登陆账户2') or 提交 and d(注册成功登陆账户3,'注册成功登陆账户3') then
				up('一创智富通','注册成功')
				dxcode.addBlack()
				delay(3)	
				return true
			elseif 提交 and d(已注册过_个人信息界面,'已注册过_个人信息界面')then
--				up('一创智富通','注册成功')
				dxcode.addBlack()
				delay(3)
				return false
			elseif d(tips_同意并继续,'tips_同意并继续') then
				click(104, 827)
				d(tips_同意并继续,'tips_同意并继续',true)
			elseif d(编辑自选点完成,'编辑自选点完成',true) then
--			elseif d(交易账号登录返回,'交易账号登录返回',true) then
			elseif d(tips_网络超时,'tips_网络超时',true) then
			elseif d(tips_跳过,'tips_跳过',true) then
			elseif d(tips_系统提示确定,'tips_系统提示确定',true) then
			elseif d(编辑自选_完成,'编辑自选_完成',true) then
			elseif d(tips_输入股票取消,'tips_输入股票取消',true) then
			elseif d(tips_确定,'tips_确定',true) then
			elseif d(tips_确定1,'tips_确定1',true) then
			elseif d(网络故障_重新加载,'网络故障_重新加载') then
				return false
			elseif d(点我的,'点我的',true) then
--			elseif d(首页,'首页') or d(行情,'行情') then
--				click(578, 1079)
			elseif d(我的,'我的')  then
				if d(我的_登录注册,'我的_登录注册') then
					delay(5)
					d(我的_登录注册,'我的_登录注册',true)
				end	
			elseif d(tips_系统提示确定,'tips_系统提示确定',true) then
			elseif d(返回箭头,'返回箭头',true) then
--			else
--				click(57, 1073)
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
					if open_url() then
						if reg()then
							back_pass(task_id,"ok")
	--					else
							--yzm.get.cancelRecv()
						end	
					end
				end
	
			end
		end
	end
--	app.quit(bid.app)
--	delay(2)
end

--]]

















