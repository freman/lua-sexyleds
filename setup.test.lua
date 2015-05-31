local moduleName = ...
local M = {}

function M.render(client, req)
	local status = wifi.sta.status()
	local ip = ""

	if status == 5 then
		ip = wifi.sta.getip()
	end

	client:send("HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n")
	client:send("{\"status\": " .. status .. ", \"ip\": \"" .. ip .. "\"}")
    client:close()
	return true
end
 
return M
