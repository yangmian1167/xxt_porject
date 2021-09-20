-- 此处为nLog功能实现操作
nLog = require('nLog')()



--	local zmRan = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
--	function p_idfa(n)
--		function idfa()
--			function zm(n)
--				local zm_ = ""
--				zm_ = zmRan[math.random(1,#zmRan)]
--				if n == 1 then
--					return zm_
--				else
--					return zm_ .. zm(n-1)
--				end
--			end
--			return zm(8).."-"..zm(4).."-4"..zm(3).."-"..zm(4).."-"..zm(12)
--		end
--		--实际需求量
--		if n == 1 then
----			print(idfa())
--			return idfa()
--		else
--			for i=1,n do
--				nLog(idfa())
--			end
--		end
--	end
		
--	jieguo = p_idfa(7800)	

		
		
phonelist = {		
{"一创智富通","A11B9EB7-771B-4747-0721-7307CAEFBF02","17056450811"},


}		
		
function post(url,tables)
	local server = url
	local post_data = ''
	local index = 0
	for k,v in pairs(tables)do
		index = index + 1
		if index == #tables then
			post_data = post_data..k..'='..v
		else
			post_data = post_data..k..'='..v..'&'
		end
	end
	
	local safari = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3)'
	local code, res_headers, body = http.post(server, 15, {
		["User-Agent"] = safari, -- 模拟 safari
	}, post_data)
	if code == 200 then
		nLog(body)
		return body
	end
end
function up(name,idfa,phone)
	local url = 'http://wenfree.cn/api/Public/idfa/?service=idfa.idfa'
	local idfalist ={}
	idfalist.phonename = phonename or device.name()
	idfalist.phoneimei = phoneimei or sys.mgcopyanswer("SerialNumber")
	idfalist.phoneos = phoneos or sys.version()
	idfalist.name = '一创智富通'
	idfalist.idfa = idfa or phone
--	idfalist.ip = '192.168.1.1'
--	idfalist.ip = ip or '192.168.1.1'
--	idfalist.account = account or locals or get_local() or '未知'
--	idfalist.password = password
	idfalist.phone = phone
--	idfalist.other = other
	return post(url,idfalist)
end		

--for k , v in ipairs(phonelist) do
--	up(v[1],v[2],v[3])

--end	
		
		
		oenUlr("https://at.umtrack.com/zqyKvi   A0005")
		
		
		
		
		
		
		
		
		
		
		
		
		
		