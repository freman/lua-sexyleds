local moduleName = ...
local M = {}

function M.render(src, client, req)
	if file.open(src, "r") then
		local content = "application/data"
        local ext = string.match(src, "(\.%w+)$")
		if ext == ".js" then
			content = "application/javascript"
		elseif ext == ".css" then
			content = "text/css"
		elseif ext == ".woff" then
			content = "application/font-woff"
		end

		client:send("HTTP/1.1 200 Ok\nContent-Type: " .. content .. "\n\n")

		s = file.read(1460)
		while s ~= nil do
			client:send(s)
			s = file.read(1460)
		end
	else
		client:send("HTTP/1.1 404 File Not Found\r\n\r\n")
	end
	return true
end

return M
