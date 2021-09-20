-- 此处为nLog功能实现操作
nLog = require('nLog')()
require('xxtsp')
require('faker')
local curl = require('lcurl')
local e = curl.easy()
require('lzdm')


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


function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = name
	idfalist.idfa = idfa
	idfalist.ip = ip or get_ip() or '192.168.1.1'
	idfalist.account = '' or account
	idfalist.password = password
	idfalist.phone = phone
	idfalist.other = other
	return post(url,idfalist)
end



function getCrad()
    local url = 'http://rok.honghongdesign.cn/public/';
    local postarr={}
	info = {}
    postarr['s']='RokId.Id'
    local carddata = post(url,postarr)
    local carddata = json.decode(carddata)
    if(carddata) then
        info.cradid = carddata.data.id
        info.cardname = carddata.data.name
        info.cardnumber = carddata.data.number
    end
end



--[[]]
function _vCode_sf() --顺丰

	local	User = 'wenfree'
	local	Pass = 'AaDd112211'
	local PID = '10'
    local token,number = "75044e220f7e11eb81a2008cfa0433f8",""	
    return {
	    login=(function() 
            local RetStr
			for i=1,5,1 do
				sys.toast("获取token\n"..i.."次共5次")
                sys.msleep(1500)
				local lx_url = 'http://103.91.211.167/api/login?userName='..User..'&password='..Pass
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
--				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token.. "&operator=exclude4"
				local url___ = "http://103.91.211.167/api/getPhone?sid="..PID.."&token="..token
				log(url___)
				RetStr = get(url___)
				if RetStr ~= "" and  RetStr ~= nil then
					log(RetStr)
					RetStr = string.split(RetStr,"|")
				end
				delay(3)
				if RetStr[1] == 0 or RetStr[1]== '0' then
					number = RetStr[2]
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
				Msg = get("http://103.91.211.167/api/getMessage?sid="..PID.."&token="..token.."&phone="..number)
				log(Msg);
				if Msg then
					local arr = string.split(Msg,"|") 
					if arr[1] == '0' then 
						Msg = arr[2]
						Msg = string.split(Msg,":") 
						Msg = Msg[2]
						local i,j = string.find(Msg,"%d+")
						Msg = string.sub(Msg,i,j)
					end
					if type(tonumber(Msg))== "number" then log(Msg); return Msg end
				end
				toast(tostring(Msg).."\n"..i.."次共25次")
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

dxcode = _vCode_sf()

优秀的司机= {{{100, 273, 0xeac7ae},{188, 442, 0xe2ebf2},{ 70, 475, 0x0c1234},{458, 398, 0xf6f7fb},}, 85, 42, 196, 525, 507}
我要加入= {{{340, 970, 0xffffff},{ 47, 948, 0xff8533},{544, 981, 0xff8533},{563, 944, 0xff8533},}, 85, 9, 910, 626, 1118}
访问位置不允许= {{{224, 651, 0x007aff},{150, 648, 0x007aff},{124, 627, 0xf9f9f9},{464, 650, 0x007aff},{492, 623, 0xf9f9f9},}, 85, 89, 599, 506, 689}


注册界面 = {{{580, 993, 0xffcead},{ 52, 947, 0xffcead},{589, 944, 0xffcead},{ 48, 991, 0xffcead},}, 85, 8, 871, 630, 1122}
注册界面_获取验证码 = {{{559, 851, 0xffffff},{464, 841, 0xff8533},{605, 872, 0xff8533},}, 85, 433, 805, 621, 903}
完成按钮 = {{{612, 587, 0x007aff},{569, 575, 0x007aff},{567, 597, 0x007aff},}, 85, 550, 556, 629, 607}
报名成功 = {{{298, 262, 0x3ad152},{318, 293, 0xffffff},{344, 307, 0x3ed250},{303, 675, 0xfca659},{408, 812, 0x06c15f},}, 85, 39, 172, 590, 849}
function reg()
	getCrad()
	local 城市选择 = true
	local 司机地址 = false
	local cardkey = false
	local 取号 = false
	local 验证码 = false
	local 短信 = false
	local 提交 = false
	local TIMEline = os.time()
	local OUTtime = math.random(180,200)
	while os.time()- TIMEline < OUTtime do
		if d(注册界面,'注册界面') then
			if 城市选择 then
				delay(10)
--				click(602, 189)
--				juli = 100
--				juli = juli * math.random(1,7)
--				click(92, (355+juli))
				城市选择 = false
				司机地址 = true
			elseif 司机地址 then
--				click(97, 294)
--				if d(我要加入,'我要加入',true) then 
					司机地址 = false
					cardkey = true
--				end	
			elseif cardkey then
				click(81, 396)
				sys.input_text(info.cardnumber)
				delay(2)
				click(80, 423)
				sys.input_text(info.cardname)
				cardkey = false
				取号 = true
			elseif 取号 then
				phone = dxcode.getPhone()
--					log(phone)
				number = phone
				if phone ~= nil or phone ~= '' then
					if type(tonumber(phone)) == "number" then
						delay(1)
						click(116, 634)
						input(phone)
						取号 = false
						验证码 = true
					end
				end
			elseif 验证码 then
				screen.image(372, 672, 579, 741):save_to_png_file("/private/var/mobile/yzm.jpg")
				orcYZM()
				click(85, 735)
				app.input_text(yzm_jg)
				验证码 = false
				短信 = true
			elseif 短信 then
				if d(注册界面_获取验证码,'注册界面_获取验证码',true) then
				else	
					yzm = dxcode.getMessage()
							log(yzm)
					if yzm ~= nil or yzm ~= '' then
						click(98, 846)
						delay(1)
						input(yzm)			
						短信 = false
						提交 = true
					end
				end	
			end
		elseif 提交 and d(报名成功,'报名成功') then
			up('T3出行','注册成功')
			return true
		elseif d(完成按钮,'完成按钮',true) then
		elseif d(访问位置不允许,'访问位置不允许',true) then
		elseif d(我要加入,'我要加入',true) then
		elseif d(优秀的司机,'优秀的司机',true) then
			moveTo(367, 798,346, 209)
		end
	end
	delay(1)
end

url = 'https://static.t3go.cn/t3-wechat-active/driver.html?type=2&channelCode=lkttup&adCode=nanjinglingkai&adid=__AID__&creativeid=__CID__&creativetype=__CTYPE__&clickid=__CLICKID__#/home?type=2&channelCode=lkttup&adCode=nanjinglingkai'

function main()
	vpnx()
	delay(3)
	if vpn() then
		if XXTfakerNewPhone('com.apple.mobilesafari') then
			idfa = XXTfakerGetinfo('com.apple.mobilesafari')['IDFA']
			model = XXTfakerGetinfo('com.apple.mobilesafari')['ProductType']
			os_version = XXTfakerGetinfo('com.apple.mobilesafari')['ProductVersion']
			udid = XXTfakerGetinfo('com.apple.mobilesafari')['UDID']
			openUrl(url)
			reg()
		end
	end	
end

--[[]]

while (true) do
	local ret,errMessage = pcall(main)
	if ret then
	else
		log(errMessage)
--		sys.alert(errMessage, 3)
		delay(5)
	end
end


--]]






