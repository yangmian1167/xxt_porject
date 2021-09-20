nLog = require('nLog')()
require('faker')
require('xxtsp')

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

url = 'https://sourl.cn/9dhxs4'
safari = 'com.apple.mobilesafari'

--appbid = 'com.owohonline.owohapp'
appbid = app.front_bid()
log(appbid)

function up()
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = "优健康"
	idfalist.idfa = idfa
	idfalist.ip = ip or get_ip() or '192.168.1.1'
--	idfalist.account = bid[name]['keyword'] or account
--	idfalist.password = password
--	idfalist.phone = phone
	idfalist.other = "点击完成"
	idfalist.device =json.encode(fakerdevice) 
	return post(url,idfalist)
end
--XXTfakerNewPhone(appbid)
立即购买 = {{{403, 735, 0xee833f},{318, 733, 0xffe7b9},{118, 707, 0xe6817d},{495, 758, 0xf07836},{562, 679, 0x32acac},{540, 800, 0x34b1b0},}, 85, 35, 590, 604, 838}
完成界面 = {{{528, 657, 0x007aff},{412, 730, 0x8b3a00},{351, 456, 0x94550f},}, 85, 303, 390, 595, 756}
--[[]]
function main()
	vpnx()
	delay(3)
	if vpn() then
		delay(3)
		if XXTfakerNewPhone(safari)then
			idfa = XXTfakerGetinfo(safari)['IDFA']
			delay(3)
			openUrl(url)
			local timeline = os.time()
			local outtime = math.random(60,80)
			while os.time() - timeline < outtime do
				if d(立即购买,"立即购买",true) then
				elseif d(完成界面,"完成界面",true) then
					up()
					return true
				else	
					moveTo(350, 783,350, 426)
				end
				delay(1)
			end	
		end
	end
end

for i= 1,40 do
	main()
end
--]]
--openUrl(url)













