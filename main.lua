--Requires
local lsl = require "lsl"
local player = require "player"
local setup = require "setup"

--Loads
function love.load()

	player.load()

	lsl.scroll.setup({zoomToMouse = false, tilemap = "Images/tilemap.png", tileSize = 10, mapLength = 10, mapHeight = 10, maxZoom = 10, cameraSpeed = 5, zoomSpeed = 0.1})
	lsl.physics.setup({friction =  0.001, zero = 0.01,drawHitboxes = false})

	lsl.load()
	setup.load()

	--lsl.audio.newTrack(1,"Sounds/music.mp3")
	--lsl.audio.volume(1,0.2)
	--lsl.audio.play(1)

end

--Updates
function love.update(dt)

	if lsl.ui.getPage() == "inGame" or lsl.ui.getPage() == "gameMenu1" then
		player.update(dt)
	end

	lsl.update(dt)
	setup.update(dt)

end

--Drawing
function love.draw()

	if lsl.ui.getPage() == "inGame" or lsl.ui.getPage() == "gameMenu1" then
		player.draw()
	end

	lsl.draw()

end

--
--NOTE TO ANYONE USING THIS LIBRARY: main.lua is un-needed as none of the functions are stored here. Only use this file for experimentations with the library. Although you must require lsl