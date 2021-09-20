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


XXTfakerNewPhone(app.front_bid())
--log(app.front_bid())