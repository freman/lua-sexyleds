local moduleName = ...
local M = {}

function M.parse(req)
	local t = {}
    local post = ""
    t["method"], t["uri"], t["version"], post = string.match(req, "(%u+)%s+(/[%w%p]*)%s+HTTP/(%d.%d)(.*)")
    if post ~= nil and t["method"] == "POST" then
            post = string.match(post, ".*\r?\n\r?\n(.+)")
            post = string.gsub(post, "^%s*(.-)%s*$", "%1")
            for k, v in string.gmatch(post, "([^&]+)=([^&]+)") do
                    t["_" .. k] = v
            end
    end

	if t["method"] == nil then t["method"] = "GET" end
	if t["uri"] == nil then t["uri"] = "/404" end
	if t["version"] == nill then t["version"] = "1.1" end
	
	return t
end

return M
