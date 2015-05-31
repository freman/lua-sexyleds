print("Init lua starting...")
timeout = 30

checkCount = 0
function checkStatus()
	print("check")
	checkCount = checkCount + 1
	local s=wifi.sta.status()
	print("s" .. s)
	if (s==5) then
		print("Launch app")
		launchApp()
		return
	elseif (s==2 or s==3 or s==4 or checkCount >= timeout) then
		print("Setup is required")
		runSetup()
		return
	end
	print("None of the above")
end

function launchApp()
	tmr.stop(0)
	local task = 'task.lua'
	dofile(task)
end

function runSetup()
	tmr.stop(0)
	print("network not found, switching to AP mode")
	dofile('setup.lua')
end

wifi.setmode(wifi.STATION)
wifi.sta.autoconnect(1)

tmr.alarm(0, 2000, 0, function() tmr.alarm(0, 1000, 1, checkStatus) end)