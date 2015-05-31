local moduleName = ...
local M = {}

function M.render(client, req)
	client:send('HTTP/1.1 200 OK\nContent-Type: text/html; charset=utf-8\n\n<!DOCTYPE html>\n<html>\n<head>\n<meta charset="UTF-8">\n<meta name=viewport content="width=device-width, initial-scale=1.0, minimum-scale=0.5 maximum-scale=1.0">\n<title>Shiny Lights</title>\n<link rel="stylesheet" href="/s.css">\n</head>\n<body>\n<h1>Shiny Lights</h1>\n<h2>Wifi Configuration</h2>\n<form action="/" method="post">')
	client:send("<p>This device's wifi mac is: " .. stamac .. "</p>")
	for ssid, v in pairs(currentAPs) do
 		authmode, rssi, bssid, channel = string.match(v, "(%d),(-?%d+),(%x%x:%x%x:%x%x:%x%x:%x%x:%x%x),(%d+)")
		sssid = string.gsub(ssid, "\"", "&quot;")
		client:send(
			string.format(
				"<div><label><span class=\"%s\">%s</span><input type=\"radio\" name=\"ssid\" value=\"%s\">%s</label></div>",
				string.char(97 + tonumber(authmode)),
				(tonumber(authmode) < 1 and "d" or "e"),
				sssid,
				ssid
			) -- rssi no rssi.. wnat rssi (a, b, c are low med high)
		)
	end
	client:send('<input type="password" name="password" placeholder="Password"><br/><input type="submit" value="Save"></form></body></html>')
	return true
end
 
return M
