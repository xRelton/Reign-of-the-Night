local player = {}

local lsl = require "lsl"

function player.load()

	playerX, playerY = 0, 0
	playerScreenX, playerScreenY = 0, 0

end

function player.draw()

	love.graphics.rectangle("fill", playerScreenX, playerScreenY, 10, 10)

end

function player.update(dt)

	if love.keyboard.isDown("w") then playerY = playerY - 1000*dt end
	if love.keyboard.isDown("a") then playerX = playerX - 1000*dt end
	if love.keyboard.isDown("s") then playerY = playerY + 1000*dt end
	if love.keyboard.isDown("d") then playerX = playerX + 1000*dt end

	playerScreenX = playerX
	playerScreenY = playerY

end

return player