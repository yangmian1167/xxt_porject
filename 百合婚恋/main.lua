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





--------------------------握草平台--------------------------------------

--熊猫平台
function _vCode_xm() --熊猫平台

	local	User = 'zhangvsqaz'
	local	Pass = '199412'
	local PID = '5677'
    local token,number = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNDIxODAyMDQ2NDIxNzcwMjQiLCJyb2xlX2lkIjoxLCJkZXZpY2VfaWQiOjAsInVzZXJuYW1lIjoiemhhbmd2c3FheiIsImV4cCI6MTYzNTE1NDE2OSwiaXNzIjoicGFuZGEifQ.5R4cEIJNQqoO75HkJuY7ek2T8IUFAfDGtm7wCl4GdX8",""	

    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://api.8088km.com/api/v1/signin?username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if  RetStr.msg == '操作成功' then
						token = RetStr.data
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
			local url___ = "http://api.8088km.com/api/v1/GetPhone?token="..token.."&item="..PID
			log(url___)
			RetStr = get(url___)
			RetStr = json.decode(RetStr)
			log(RetStr)
			delay(3)
			if RetStr.msg == success or RetStr.msg== '操作成功' then
				number = RetStr.data
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
				RetStr = get("http://api.8088km.com/api/v1/GetMsg?token="..token.."&item="..PID.."&phone="..number)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.msg == 获取到了短信 or RetStr.msg == '操作成功' then 
						Msg = RetStr.data.yzm
--						local i,j = string.find(Msg,"%d+")
--						Msg = string.sub(Msg,i,j)
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
dxcode = _vCode_xm()

--握草平台
function _vCode_wc() --握草平台

	local	User = 'zhangvsqaz'
	local	Pass = '199412'
	local PID = '1770'
    local token,number = "f354ce87a8b3ce06fcd7056ae46240e9754e913a",""	

    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://www.wocaopt.net/sms/api.php?a=login&user='..User..'&pass='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.msg == OK or RetStr.msg == 'OK' then
						token = RetStr.data
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
			local url___ = "http://www.wocaopt.net/sms/api.php?a=getPhone&sid="..PID.."&token="..token
			log(url___)
			RetStr = get(url___)
			RetStr = json.decode(RetStr)
			log(RetStr)
			delay(3)
			if RetStr.msg == success or RetStr.msg== 'success' then
				number = RetStr.iphone
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
				RetStr = get("http://www.wocaopt.net/sms/api.php?a=getMessage&sid="..PID.."&token="..token.."&phone="..number)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.msg == 获取到了短信 or RetStr.msg == '获取到了短信' then 
						Msg = RetStr.yzm
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
--dxcode = _vCode_wc()	
--有信平台
function _vCode_yx() --有信

	local	User = 'zhangvsqaz1go'
	local	Pass = '199412'
	local PID = '21549'
    local token,number = "4b885afa6d87b114098187518b25d196",""	

    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://api.cafebay.cn/api/do.php?action=loginIn&name='..User..'&password='..Pass
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
			local url___ = "http://api.cafebay.cn/api/do.php?action=getPhone&sid="..PID.."&token="..token
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
				local blackPhone = {'144','141','142','143','144','145','146','147','199','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
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
				RetStr = get("http://api.cafebay.cn/api/do.php?action=getMessage&sid="..PID.."&token="..token.."&phone="..number)
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
			local lx_url =	'http://api.cafebay.cn/api/do.php?action=addBlacklist&sid='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--dxcode = _vCode_yx()	
--马大帅平台
function _vCode_ma() --马大帅平台

	local	User = 'zhangvsqaz'
	local	Pass = '135246'
	local PID = '20206'
    local token,number = "a8e7f1b50254cbb57f210491c6f484ad7cbd604d",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://61.160.195.26:81/logon/username='..User..'&password='..Pass
				log(lx_url)
                RetStr = get(lx_url)
				local curl = require('lcurl')
				local e = curl.easy()
                RetStr = e:unescape(RetStr)
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
			local url___ = "http://61.160.195.26:81/Getnumber/id="..PID.."&token="..token
			log(url___)
			RetStr = get(url___)
			local curl = require('lcurl')
			local e = curl.easy()
			RetStr = e:unescape(RetStr)
			if RetStr ~= "" and  RetStr ~= nil then
				log(RetStr)
				RetStr = string.split(RetStr,"|")
			end
			delay(3)
			if RetStr[1] == 1 or RetStr[1]== '1' then
				number = RetStr[2]
				log(number)
				local phone_title = (string.sub(number,1,3))
--				local blackPhone = {'144','141','142','143','144','145','146','147','199','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://61.160.195.26:81/Addblacklist/id='..PID..'&phone='..number..'&token='..token
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
				RetStr = get("http://61.160.195.26:81/Getsms/id="..PID.."&token="..token.."&phone="..number)
				log(RetStr);
				local curl = require('lcurl')
				local e = curl.easy()
                RetStr = e:unescape(RetStr)
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
			local lx_url =	'http://61.160.195.26:81/Addblacklist/id='..PID..'&phone='..number..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--dxcode = _vCode_ma()	



--月亮平台
function _vCode_yl() --月亮平台

	local	User = '51135893913'
	local	Pass = '199412'
	local PID = '1257'
    local token,number = "ad83d006f68c32e237a955f8d90f9ed1_10216",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://47.56.243.107:9000/yhapi.ashx?act=login&ApiName='..User..'&PassWord='..Pass
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
			local url___ = "http://47.56.243.107:9000/yhapi.ashx?act=getPhone&iid="..PID.."&token="..token.."&did="..User
			log(url___)
			RetStr = get(url___)
			if RetStr ~= "" and  RetStr ~= nil then
				log(RetStr)
				RetStr = string.split(RetStr,"|")
			end
			delay(3)
			if RetStr[1] == 1 or RetStr[1]== '1' then
				number = RetStr[5]
				number_pid = RetStr[2]
				log(number)
				log(number_pid)
				local phone_title = (string.sub(number,1,3))
				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://47.56.243.107:9000/yhapi.ashx?act=addBlack&reason='..User..'&pid='..number_pid..'&token='..token
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
				RetStr = get("http://47.56.243.107:9000/yhapi.ashx?act=getPhoneCode&pid="..number_pid.."&token="..token)
				log(RetStr);
				if RetStr then
					local arr = string.split(RetStr,"|") 
					if arr[1] == '1' then 
						Msg = arr[3]
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
			local lx_url =	'http://47.56.243.107:9000/yhapi.ashx?act=addBlack&reason='..User..'&pid='..number_pid..'&token='..token
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--dxcode = _vCode_yl()


function _vCode_wzy() --万众云

	local	User = 'api-GbzRcm'
	local	Pass = '199555'
	local PID = '10394'
    local token,number = "074a7678aa5611ea92c100163e0007a2",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://dev.wanzhongma.com/open/api/login?userName='..User..'&password='..Pass..'&json=2'
				log(lx_url)
                RetStr = get(lx_url)
				if RetStr then
					RetStr = string.split(RetStr,"|")
					if RetStr[1] == 0 or RetStr[1] == '0' then
						token = RetStr[3]
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
			local url___ = "http://dev.wanzhongma.com/open/api/getPhone?sid="..PID.."&token="..token..'&json=2'
			log(url___)
			RetStr = get(url___)
			if RetStr ~= "" and  RetStr ~= nil then
				log(RetStr)
				RetStr = string.split(RetStr,"|")
			end
			delay(3)
			if RetStr[1] == 0 or RetStr[1]== '0' then
				number = RetStr[3]
				log(number)
				local phone_title = (string.sub(number,1,3))
--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://dev.wanzhongma.com/open/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..'&json=2'
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
				RetStr = get("http://dev.wanzhongma.com/open/api/getMessage?sid="..PID.."&token="..token.."&phone="..number..'&json=2')
				log(RetStr);
				if RetStr then
					local arr = string.split(RetStr,"|") 
					if arr[1] == '0' then 
						Msg = arr[3]
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
			local lx_url =	'http://dev.wanzhongma.com/open/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..'&json=2'
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--dxcode = _vCode_wzy()

function _vCode_lh() --蓝狐

	local	User = 'api-1pj8gnHT'
	local	Pass = 'wq000000'
	local PID = '353'
    local token,number = "A1F1A9C385F7F5A01B763A80BA545F94",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http//www.huli667.com/sms/api/login?username='..User..'&password='..Pass
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
			local url___ = "http://www.huli667.com/sms/api/getPhone?sid="..PID.."&token="..token
			log(url___)
			RetStr = get(url___)
			RetStr = json.decode(RetStr)
			log(RetStr)
			delay(3)
			if RetStr.msg == success or RetStr.msg== 'success' then
				number = RetStr.phone
				log(number)
				local phone_title = (string.sub(number,1,3))
--				local blackPhone = {'144','141','142','143','144','145','146','147','199','161','162','165','167','170','171'}
--				local blackPhone = {"130","131","132","145","155","156","166","171","175","176","185","186","134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
--				local blackPhone = {"134","135","136","137","138","139","147","150","151","152","157","158","159","178","182","183","184","187","188","198"}
				local blackPhone = {}
				for k,v in ipairs(blackPhone) do
					if phone_title == v then
						local lx_url =	'http://www.huli667.com/sms/api/Addblack/?iid='..PID..'&phone='..number..'&token='..token
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
				RetStr = get("http://www.huli667.com/sms/api/getMessage?sid="..PID.."&token="..token.."&phone="..number)
				RetStr = json.decode(RetStr)
				log(RetStr)
				if RetStr then
					if RetStr.msg == success or RetStr.msg== 'success' then
						Msg = RetStr.sms
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
			local lx_url =	'http//www.huli667.com/sms/api/addBlacklist?sid='..PID..'&phone='..number..'&token='..'&json=2'
			log("拉黑"..number..'\n'..lx_url);
            return get(lx_url);
        end),
    }
end
--dxcode = _vCode_lh()

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
	postdate.idfa = phone
--	postdate.phone = phone
	postdate.password = password
	postdate.ip = ip or get_ip() or '192.168.1.1'
	postdate.other = other
	postdate.account = account
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

page.弹出选择确定={{
	{589, 580, 0x666666},
	{570, 582, 0x666666},
	{548, 582, 0x666666},
	{551, 582, 0xf7f7f7},
}, 85, 539, 557, 610, 601}
page.注册完成界面={{
	{312, 892, 0xfff9f5},
	{159, 876, 0xff6e1d},
	{164, 909, 0xff6e1d},
	{477, 875, 0xff6e1d},
}, 85, 129, 839, 508, 951}

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

function fix()
	local TimeLine = os.time()
	local OutTime = 60*3
	local 头像key = false
	local 生日key = true
	local 地区key = true
	local 身高key = true
	local 月收入key = true
	local 学历key = true
	local 婚姻状况key = true
	local 提交key = false
	local 注册完成key = false
	while os.time()-TimeLine < OutTime do
		if active(bid.app,5) then
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
				if 头像key then
						delay(2)
						click(350, 273)
						delay(2)
						click(327, 814)
				elseif 生日key then
					delay(2)
					click(547, 436)
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
							diqux = math.random(0,2)
							diquy = math.random(0,5)
						if diqux==0 and diquy==1 then
							diqux = math.random(0,2)
							diquy = math.random(0,5)
						else	
							click(545, 538)
							delay(2)
							click(37+(diqux*80), 667+(diquy*80))
							for i = 1,math.random(1,8) do
								click(594, 958)
							end
							地区key = false
						end	
				elseif 身高key then	
					click(550, 645)
					delay(2)
					click(60+(math.random(0,4)*110), 685+(math.random(0,4)*100)) 
					身高key = false
				elseif 月收入key then	
					for i = 1,math.random(1,5) do
						click(471, 767)
					end
					月收入key = false
				elseif 学历key then	
					for i = 1,math.random(1,5) do
						click(441, 877)
					end
					学历key = false
				elseif 婚姻状况key then
					click(301, 984)
					婚姻状况key = false
					提交key = true
				elseif 提交key then
					if d(page.完成注册,"page.完成注册",true) then
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
page.完善信息={{{265, 68, 0x9c9c9c},{253, 79, 0xa2a2a2},{253, 98, 0x909090},{381, 70, 0x6b6b6b},{384, 97, 0x979797},}, 85, 248, 63, 391, 105}
page.账号异常={{{440, 675, 0x666666},{206, 668, 0x666666},{197, 600, 0x662719},{461, 599, 0x661726},}, 85, 157, 564, 481, 707}
page.取消上传={{{174, 655, 0x007aff},{435, 663, 0xff3b30},}, 60, 124, 611, 504, 687}
page.已注册联合登录={{{375, 236, 0xff927e},{317, 249, 0xfe866d},{286, 252, 0xffcfd4},{233, 213, 0xffb28c},{340, 129, 0xffbb8e},{372, 113, 0xfffcfc},}, 85, 177, 78, 458, 321}
page.已注册联合登录1={{{334, 196, 0xfefdfd},{276, 168, 0xff5760},{372, 201, 0xff3b84},{191, 360, 0x555555},{131, 366, 0xff9072},{535, 366, 0xff9073},}, 85, 37, 67, 574, 753}
page.基本信息界面={{{259, 68, 0x686868},{253, 86, 0x787878},{254, 98, 0xe8e8e8},{381, 70, 0x6b6b6b},{384, 97, 0x979797},}, 85, 243, 60, 394, 108}


page.注册界面={{{475, 130, 0xff6b6b},{470, 120, 0xffffff},{333,  96, 0xffffff},{571, 163, 0xffffff},{574, 105, 0xffffff},}, 85, 315, 76, 600, 181}
page.登录界面={{{194, 127, 0xff5f5e},{157, 124, 0xff7271},{ 96, 113, 0xffffff},{241, 146, 0xffffff},{244, 126, 0xffffff},}, 85, 83, 106, 257, 155}
page.立即注册={{{342, 654, 0xffffff},{339, 651, 0xff4e51},{209, 617, 0xff6040},{425, 676, 0xff425b},{443, 633, 0xff3d5f},}, 85, 160, 578, 505, 710}
page.账号异常={{{444, 681, 0x661926},{450, 643, 0x661926},{203, 635, 0x662619},{195, 683, 0x662719},{220, 662, 0xffffff},{188, 649, 0xffffff},}, 85, 158, 597, 505, 709}
page.基本信息界面_男女={{{160, 510, 0x74a5fd},{262, 564, 0x62b1fc},{379, 510, 0xff925d},{545, 575, 0xff655e},}, 85, 62, 470, 592, 609}


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
		if active(bid.app,10)then
			if d(page.完善信息,"page.完善信息") then
				up_hb('点击提交')
				return true
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
				delay(2)
				if d(page.账号异常,"page.账号异常") then
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
						if phone ~= nil or phone ~= '' then
							delay(2.8)
							if type(tonumber(phone)) == "number" then
								click(293, 402)
								phoneKey(phone)
--								click(26, 282)
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
					if yzm ~= nil or yzm ~= '' then
						delay(2.8)
						input(yzm)			
						短信 = false
						提交 = true
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
			elseif d(page.基本信息界面,"基本信息界面")then
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
			else
				
				if d(page.allow,"page.allow",true)then
				elseif d(page.allow_local,"page.allow_local",true)then
				end
			end
		end
		delay(0.5)
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
		local c, h, b = http.get("https://wenfree.cn/api/app.php?s=App.IP.GetInfo", 30)
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



--[[
function main(v)
	task_id = v.task_id
	vpnx()
	delay(3)
	if false or vpn() then
		ip,locals = get_local()
		if ip ~= "192.168.1.1" and ip~= nil then
			if true or checkip()then
				if false or XXTfakerNewPhone(bid.app)then
					idfa = XXTfakerGetinfo(bid.app)['IDFA']
					delay(1)
--					dxcode.login()
--					dxcode.GetPhone()
					if reg()then
						if fix()then
						--	makeinfo()
						back_pass(task_id,"ok")
						end
--					else
						--yzm.get.cancelRecv()
					end
				end
	
			end
		end
	end
	app.quit(bid.app)
	delay(2)
end

--]]






				osList = {
					"12.3",	"12.3",	"12.3","12.3","12.3","12.3","12.3",
					"12.3.1","12.3.1","12.3.1",
					"12.3","12.3",
					"12.2","12.1.4",
				}

function main()
--	task_id = v.task_id
--	dxcode.login()
	vpnx()
	delay(3)
	if false or vpn() then
--		ip,locals = get_local()
--		if ip ~= "192.168.1.1" and ip~= nil then
--			if true or checkip()then
				if false or XXTfakerNewPhone(bid.app)then
					idfa = XXTfakerGetinfo(bid.app)['IDFA']
					delay(1)
--					dxcode.login()
--					dxcode.GetPhone()
					if reg()then
						if fix()then
						--	makeinfo()
--						back_pass(task_id,"ok")
						end
--					else
						--yzm.get.cancelRecv()
					end
				end
	
--			end
--		end
	end
	app.quit(bid.app)
	delay(2)
end




while (true) do
	local ret,errMessage = pcall(main)
	if ret then
	else
		log(errMessage)
--		sys.alert(errMessage, 3)
		delay(5)
	end
end














