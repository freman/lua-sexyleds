DATA=3
CLOCK=4
DELAY=10

gpio.mode(DATA, gpio.OUTPUT, gpio.PULLUP)
gpio.mode(CLOCK, gpio.OUTPUT, gpio.PULLUP)

red = 0
green = 0
blue = 0

function clk()
local noop = 0
	gpio.write(CLOCK, gpio.LOW)
	gpio.write(CLOCK, gpio.HIGH)
end

function sendByte(b)
	for i=7,0,-1 do
		if (bit.isset(b, i)) then
			gpio.write(DATA, gpio.HIGH);
		else
			gpio.write(DATA, gpio.LOW);
		end
		clk();
	end
end

function sendColor(red, green, blue)
    -- Start by sending a byte with the format "1 1 /B7 /B6 /G7 /G6 /R7 /R6"
    prefix = 192
	if (bit.isset(blue, 7)) then prefix = prefix + 32 end
	if (bit.isset(blue, 6)) then prefix = prefix + 16 end
	if (bit.isset(green, 7)) then prefix = prefix + 8 end
	if (bit.isset(green, 6)) then prefix = prefix + 4 end
	if (bit.isset(red, 7)) then prefix = prefix + 2 end
	if (bit.isset(red, 6)) then prefix = prefix + 1 end

--print("prefix: " .. prefix)
    sendByte(prefix);
        
    -- Now must send the 3 colors
    sendByte(blue);
    sendByte(green);
    sendByte(red);
end

function setColorRGB(r, g, b)
	sendByte(0)
	sendByte(0)
	sendByte(0)
	sendByte(0)

	red = r
	green = g
	blue = b
	sendColor(red, green, blue)

	sendByte(0)
	sendByte(0)
	sendByte(0)
	sendByte(0)
end

srv=net.createServer(net.TCP)
srv:listen(48879, function(conn)
	conn:on("receive", function(client, payload)
		if string.match(payload, "off") then
			-- everything off
		elseif string.match(payload, "on") then
			-- everything on
		end

		brightness = string.match(payload, "b%d+")
		if brightness ~= nil then
			brightness = tonumber(brightness)
			if brightness >= 0 and brightness <= 255 then
				-- calculate new brightness
			end
		end
			
		r, g, b = string.match(payload, "(%d+),(%d+),(%d+)")
		if r ~= nil and g ~= nil and b ~= nil then
			setColorRGB(r,g,b)
		end
		
		client:send("k")
	end)

	conn:on("sent", function(client)
        print("Closing connection")
        client:close()
	end)
end)
