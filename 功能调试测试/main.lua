-- 此处为nLog功能实现操作
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

--atexit(function() 
--		sys.toast('脚本结束了！')
--		vpnx()
--		local appbids = app.front_bid()
--		if appbids ~= "com.apple.springboard" then
--			app.quit(appbids)
--			--closeX(appbids)
--		end
--		sys.msleep(500)
--	end)


-- 登apple ID


--app.open_url("prefs:root=STORE")
--app.open_url("prefs:root=General")


--[[
登录 = {{
	{443, 474, 0x007aff},
	{199, 481, 0x007aff},
	{174, 471, 0xf8f8f8},
}, 85, 137, 442, 498, 501}

click(116, 335)
input('a@gemehouse.com')
delay(2)
click(124, 384)
input('Whoami@1314')
delay(2)


d(登录,'登录',true)
滑动key = 1
while true do
	
	if 滑动key == 1 then
		moveTo(120, 619,482, 622)
		滑动key = 滑动key + 1
	elseif 滑动key == 2 then
		moveTo(120, 619,502, 622)
		滑动key = 滑动key + 1
	elseif 	滑动key == 3 then
		moveTo(120, 619,525, 622)	
		滑动key = 滑动key + 1
		if 滑动key >= 3 then
			滑动key = 1
		end	
	end
	delay(2)			
end				

--]]--




--vpnx()
--delay(3)
--XXTfakerNewPhone(app.front_bid())
--XXTfakerNewPhone("com.apple.mobilesafari")
--		idfa = XXTfakerGetinfo("com.apple.mobilesafari")['IDFA']
--		model = XXTfakerGetinfo("com.apple.mobilesafari")['ProductType']
--		os_version = XXTfakerGetinfo("com.apple.mobilesafari")['ProductVersion']
--		udid = XXTfakerGetinfo("com.apple.mobilesafari")['UDID']
--		log(idfa)
--		log(model)
--		log(udid)
--vpn()

--url = 'http://www.1n.cn/mobile.php/?s=Game/open_game/pid/2202/game_id/638.html'

--openUrl(url)



--log(app.front_bid())

--[[
function up(name,other)
	local url = 'http://idfa888.com/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = name
	idfalist.idfa = idfa or '1235'
	idfalist.ip = get_ip() or '192.168.1.1'
	idfalist.account = account
	idfalist.password = password
	idfalist.phone = phone
	idfalist.other = other
	return post(url,idfalist)
end


--while true do
--moveTo(331, 941,242, 309)
--delay(5)
--click(567, 774)
--delay(3)
--moveTo(609, 914,118, 914)
--moveTo(609, 914,118, 914)
--delay(2)
--click(270, 932)
--idfa = pasteboard.read()
--log(idfa)
--up('抖音链接','上传成功')
--end

--]]



--get
--function get(url,times)
--	local url = url
--	local times = times or 9
--	local code, res_headers, body = http.get(url, times, {
--		["User-Agent"] = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0)"; -- 模拟 IE8 的请求
--		["Cookie"] = ""; -- 顺带 Cookie 提交
--	})
--	if code == 200 then -- 如果返回的状态码是 HTTP_OK
--		return body -- 输出百度首页的网页 HTML 内容
--	end
--end
--function get(url)
--	local url = url
--	local code, res_headers, body = http.get(url, 5,{})
--	if code ==200 then -- 如果返回的状态码是 HTTP_OK
--		return body -- 输出内容
--	end
--end


--log(get("http://ymapi.wenfree.cn/?s=App.Bhapione.Get&name=锦江酒店&idfa=06A1687F-BA31-4DCF-9F22-43C6ABA2F4A6"))





--function up_hb(other)
--	local url = 'http://hb.wenfree.cn/api/Public/idfa/'
--	local postdate = {}
--	postdate.service = 'Idfa.Idfa'
--	postdate.name = "ceshi0000001"
--	postdate.idfa = "ceshi0000001"
--	postdate.phone = "ceshi0000001"
--	postdate.phoneimei = "99999999999999"
----	postdate.password = password
--	postdate.ip = ip or get_ip() or '192.168.1.1'
--	postdate.other = other
--	postdate.account = "ceshi0000001"
--	log(post(url,postdate))
--	-- body
--end


--up_hb("ceshi0000002")
--XXTfakerNewPhone(app.front_bid())
--page = {}
--page.滑动验证码界面_点1={{{249, 383, 0x161523},{249, 387, 0x222127},{249, 449, 0x292d30},{249, 452, 0x313538},}, 85, 188, 332, 508, 607}
--page.滑动验证码界面_点2={{{322, 403, 0x393939},{322, 408, 0x444444},{322, 468, 0x4b4b49},{322, 464, 0x474745},}, 85, 188, 332, 508, 607}
--page.滑动验证码界面_点3={{{290, 374, 0x28291b},{290, 378, 0x2b2c21},{290, 436, 0x2e2c1d},{290, 433, 0x2f2d1d},}, 85, 188, 332, 508, 607}

--page.点击验证码={{{543, 488, 0xf95415},{475, 492, 0xfc9d78},}, 85, 414, 464, 576, 508}
--page.滑块={{{150, 670, 0x66d200},{136, 675, 0x66d200},}, 85, 114, 649, 542, 705}
--page.请正确拼合图像={{{106, 576, 0xde715b},{324, 599, 0xde715b},}, 85, 94, 568, 332, 610}
--while true do

--	if d(page.滑块,"page.滑块") then
--		if d(page.请正确拼合图像,"page.请正确拼合图像") then
--			delay(3)
--			click(174, 781)
--			delay(3)
--		elseif d(page.滑动验证码界面_点1,"page.滑动验证码界面_点1") or d(page.滑动验证码界面_点2,"page.滑动验证码界面_点2")or d(page.滑动验证码界面_点3,"page.滑动验证码界面_点3")  then
--			moveTo(102, 675,x,675,20)
--		else
--			click(174, 781)
--			delay(5)
--		end
--	elseif d(page.点击验证码,"page.点击验证码",true) then
--	end
--	delay(1)
--end

openUrl("https://www.wuhegmptv.cn/a6Am9R364o2HAIsr")
--log(app.front_bid())