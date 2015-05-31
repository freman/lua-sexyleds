local moduleName = ...
local M = {}

function M.render(client, req)
	local target_ssid = req["_ssid"]
	local target_password = req["_password"]

	client:send('HTTP/1.1 200 OK\nContent-Type: text/html; charset=utf-8\n\n<!DOCTYPE html>\n<html>\n<head>\n<meta charset="UTF-8">\n<meta name=viewport content="width=device-width, initial-scale=1.0, minimum-scale=0.5 maximum-scale=1.0">\n<title>Shiny Lights</title>\n<link rel="stylesheet" href="/s.css">\n</head>\n<body>\n<h1>Shiny Lights</h1>\n<h2>Wifi Configuration Saved</h2>')
	client:send('<p>Hang out for a tick while I try connecting</p><div>Radio Status: <span id="radio">thinking</span></div><div>Current IP: <span id="ip">not sure</span></div><div id="ok" style="display: none">Everything is awsome, simply reboot me and I will come back up on your wifi connection</div><div id="fail" style="display: none">Something went wrong, want to hit the back button and try again?</div>')
	client:send('<script type="text/javascript" src="/j.js"></script></body></html>')
	
	wifi.sta.config(target_ssid, target_password)
	wifi.sta.connect()

	return true
end
 
return M
