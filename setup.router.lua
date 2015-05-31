local moduleName = ...
local M = {}

local route = {
	["GET:/"] = "setup.index.lua",
	["GET:/test"] = "setup.test.lua",
	["POST:/"] = "setup.save.lua",
	["GET:/s.css"] = "setup.css",
	["GET:/j.js"] = "setup.js",
    ["GET:/f.woff"] = "f.woff"
}

function M.route(client, req)
	local t = req["method"] .. ":" .. req["uri"]
	local r = route[t]
	print(t .. " >> " .. (r ~= nil and r or "404"))
	if r == nil then
		return
	false end
    local ext = string.match(r, "(\.%w+)$")
	if ext == ".lua" or ext == ".lc" then
		return dofile(r).render(client, req)
	end
	return dofile("render.lua").render(r, client, req)
end

return M
