
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

atexit(function() 
		sys.toast('脚本结束了！')
		vpnx()
		local appbids = app.front_bid()
		if appbids ~= "com.apple.springboard" then
			app.quit(appbids)
			--closeX(appbids)
		end
		sys.msleep(500)
	end)


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
	return post(url,idfalist)
end

function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	log( post(url,postArr) )
end

function checkidfa(name)
	local url = "http://idfaapi.wenfree.cn/"
	local postArr = {}
	postArr.service = "App.SharkIdfa.Distinct"
	postArr.channel_id = '4'
	postArr.task_id = bid[name]['appid']
	postArr.idfa = idfa
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.os_version = os_version or sys.version()
	postArr.device_type = model
	postArr.keyword = bid[name]['keyword']
	postArr.udid = udid

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
		if data.data.msg == '请求数据成功!' then
			log(" 排重成功: OK.",true)
			return true
		else
			log("idfa-排重失败",true)
		end
	end
end

function clickidfa(name,callbackkey)
	local url = "http://idfaapi.wenfree.cn/"
	local postArr = {}
	postArr.service = "App.SharkIdfa.Click"
	postArr.channel_id = '4'
	postArr.task_id = bid[name]['appid']
	postArr.idfa = idfa
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.os_version = os_version or sys.version()
	postArr.device_type = model
	postArr.keyword = bid[name]['keyword']
	postArr.udid = udid
	
	local index = 0
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
		if tonumber(data.data.code) == 0 or data.data.msg == '请求数据成功!' then
			log("点击成功: OK.",true)
			return true
		else
			log("idfa-点击失败",true)
		end
	end
end

function activeidfa(name,callbackkey)
	local url = "http://idfaapi.wenfree.cn/"
	local postArr = {}
	postArr.service = "App.SharkIdfa.Activate"
	postArr.channel_id = '4'
	postArr.task_id = bid[name]['appid']
	postArr.idfa = idfa
	postArr.ip = ip or get_ip() or rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)..'.'..rd(1,255)
	postArr.os_version = os_version or sys.version()
	postArr.device_type = model
	postArr.keyword = bid[name]['keyword']
	postArr.udid = udid
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
		if tonumber(data.data.code) == 0 or data.data.msg == '请求数据成功!' then
			log("上报成功: OK.",true)
			return true
		else
			log("idfa-上报失败",true)
		end
	end
end

function checkip()
	ip = get_ip() or false
	if ip then
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
end

function callbackapi(name)
	if XXTfakerNewPhone(bid[name]['appbid'])then
		idfa = XXTfakerGetinfo(bid[name]['appbid'])['IDFA']
		model = XXTfakerGetinfo(bid[name]["appbid"])['ProductType']
		os_version = XXTfakerGetinfo(bid[name]["appbid"])['ProductVersion']
		udid = XXTfakerGetinfo(bid[name]["appbid"])['UDID']
		if checkidfa(name)then
			if clickidfa(name)then
				delay(rd(2,3))
				newidfa(name)
				if activeidfa(name)then
					back_pass(task_id,"ok")
					up(name,bid[name]['keyword'])
				end
			end
		end

	end
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
	local OUTtime = rd(30,45)
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
	end
	up(name,bid[name]['keyword'])
end

function beewallidfa(name)
	if clickisok(name)then
		delay(rd(2,3))
		newidfa(name)
	end
	delay(1)
end

--bid.万博娱乐 = {	["appid"] =  "1434066842", ["appbid"] = "com.qq.FindWord", ["adid"]= '1032', ["keyword"]="万博娱乐" }
function main(v)
	if vpn() then
		if checkip()then
			work = v.work
			task_id = v.task_id
			bid={}
			bid[work]={}
			bid[work]['keyword']=v.keyword
			bid[work]['appbid']=v.appbid
			bid[work]['appid']=v.appid
			callbackapi(work)
		end
		vpnx()
		delay(2)
	end
end




















