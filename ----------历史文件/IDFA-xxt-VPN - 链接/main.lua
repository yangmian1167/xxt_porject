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

bid={}
--bid.大码微拍 = "com.xmfg.dmwp"
--bid.开天斩龙 = "com.kai.tian.ktzl"
--bid.赚钱啦 = "sz.parttimejob"
--bid.四方坦克大战 = "com.sfgame.sftkdz"
--bid.融360 = "com.rong360.victor"
--bid.全日空海淘 = "acd.mall.apps.20170619"
--bid.无忧行 = "com.cmi.jegotrip"
--bid.独角秀 = "com.mydeershow.www"
bid.驾考宝典 = "cn.mucang.ios.jiakaobaodianhuoche"


screen.init(0)
var = {}
var.lun = 0
--全局变量

function up(name,other)
	local url =  'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = name
	idfalist.idfa = idfa
	idfalist.ip = '192.168.1.1'
	idfalist.ip = get_ip() or '192.168.1.1'
	idfalist.account = account
	idfalist.password = password
	idfalist.phone = phone
	idfalist.other = other
	return post(url,idfalist)
end


function rd(n,k)
	return math.random(n,k)
end

function appname(bid)
	return app.localized_name(bid) or '未安装'
end


apparr={}
apparr.right={{{462,666,0x007aff},{225,666,0x007aff},}, 85, 54, 394, 590, 809}

web={}
web.open={{{526,632,0x007aff},{396,622,0x3897ff},{393,623,0xffffff},},85}
web.点击下载={{{335, 952, 0x814d40},{130, 938, 0xffdf20},{525, 972, 0xffc20f},{537, 893, 0x052ee2},}, 85, 60, 847, 575, 1032}
--融360
--urls = "http://m.rong360.com/app/osdown/?ios=https://itunes.apple.com/cn/app/id1026689855?mt=8&android=https://campaign.rong360.com/applanding/rongapp/landing_22.html?&weixin=&from=zckj_xgxyk_ceshi01"
--全日空海淘
--urls = "https://at.umeng.com/C09j0j"
--urls = "http://suo.im/5HFQe5"
urls = "https://ecam.spdb.com.cn/ecam/page/294229974916050265/68002f?cl_md=&cl_sh=18222&cl_sr=T10&cl_orgid=166&channelCode=T10"
--urls = "https://share-m.kakamobi.com/activity.kakamobi.com/jiakaobaodian-jiaoliantuiguang/down.html?jxpid=v3_59260679&cityCode=&proxyName=%25E6%259D%25A8%25E5%25BA%25B7&jxrid=59260679"
function open(urls)
	openUrl(urls)
	delay(3)
	local timeline = os.time()
	local outtimes = 60
	while os.time()-timeline < outtimes do
--		if d(web.open,"web.open",true,1)then
			delay(math.random(14,15))
			return true
--		elseif d(web.点击下载,'web.点击下载',true) then
--		end
--		delay(1)
	end
	log("open time ",true)
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

function ends()
	
	for _,bid in ipairs(app.bundles()) do
		app.quit(bid)
	end
	vpnx()
	sys.msleep(2000)
	
end

function back_pass(task_id,success)
	local url = 'http://wenfree.cn/api/Public/tjj/?service=Tjj.backpass'
	local postArr = {}
	postArr.task_id = task_id
	postArr.success = success
	log( post(url,postArr) )
end
--bid_ = 'com.kebida.dushu'
bid_ = 'com.baoli.phdj'
function newidfa(keys,times)
	for i= 1,times do
		if false or vpn()then
			XXTfakerNewPhone('com.apple.mobilesafari')
			delay(1)
			if XXTfakerNewPhone(bid_)then
				idfa = XXTfakerGetinfo(bid_)['IDFA']
				if open(urls) then
					local TIMEline = os.time()
					local OUTtime = rd(45,50)
					while os.time()- TIMEline < OUTtime do
						if active(bid_,4)then
							if d(apparr.right,"apparr.right",true)then
							else
								moveTo(600,300,100,100,30,50)
								delay(1)
								click(321, 978)
								delay(1)
								click(462, 666)
								delay(1)
							end
						end
					end
					up(appname(bid_),'初次上传')
--					back_pass(task_id,"ok")
				end
			end	
		end
		vpnx()
		delay(3)
		log("关闭VPN-------->>>>>>>")
	end
end
--open(urls)
--newidfa(work,1)
vpn()
XXTfakerNewPhone('com.apple.mobilesafari')
XXTfakerNewPhone(bid_)
open(urls)
--[[
while true do
	log("vpn-key")

	-----------------------------------
--			local TaskDate = ( get_task() )
--			if TaskDate then
--				for i,v in ipairs(TaskDate) do
--					work = v.work
					work = '驾考宝典'
--					task_id = v.task_id
--					if bid[work] ~= nil then
						newidfa(work,1)
--					end
--				end
--			end
	------------------------------------
	ends()
end
--]]

	





















