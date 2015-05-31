apmac, cnt = string.gsub(wifi.ap.getmac(), "-", "")
stamac = wifi.sta.getmac()
cfg={}
cfg.ssid="LEDS:" .. apmac
cfg.pwd="shinylights"
wifi.setmode(wifi.STATIONAP)
wifi.ap.config(cfg)

currentAPs = {}

function listAPs_callback(t)
  if(t==nil) then
    return
  end
  currentAPs = t
end

function listAPs()
  print("Getting aps")
  wifi.sta.getap(listAPs_callback)
end
tmr.alarm(0, 15000, 1, listAPs)
listAPs()

srv=net.createServer(net.TCP)
srv:listen(80, function(conn)
	conn:on("receive", function(client, payload)
		local req = dofile("http.lua").parse(payload)
		local sent = dofile("setup.router.lua").route(client, req)
		if sent == false then
            print("yeh bad news bear")
			client:send("HTTP/1.1 400 Bad Request\r\n\r\n")
        end
	end)

	conn:on("sent", function(client)
        print("Closing connection")
        client:close()
	end)
end)
