--Requires
local lsl = require "lsl"
local player = require "player"

--Loads
function love.load()

	lsl.scroll.setup({zoomToMouse = false, tilemap = "Images/tilemap.png", tileSize = 10, mapLength = 10, mapHeight = 10, maxZoom = 10, cameraSpeed = 5, zoomSpeed = 0.1})
	lsl.physics.setup({friction =  0.001, zero = 0.01,drawHitboxes = false})

	lsl.load()

	lsl.scroll.setTile(1,5,lsl.scroll.createTiledata({customImage = "Images/testCustomTile.png",minFilter = "linear",maxFilter = "linear", anstropy = 10}))

	lsl.ui.addButton(170,180,220,60,255,255,255,"Play",0,0,0,"run")
	lsl.ui.addButton(170,290,220,60,255,255,255,"Options",0,0,0,1)
	lsl.ui.addButton(170,510,220,60,255,255,255,"Exit",0,0,0,"exit")

	lsl.ui.addButton(170,180,240,60,255,255,255,"Volume:100",0,0,1,1)
	lsl.ui.addButton(170,290,240,60,255,255,255,"Fullscreen",0,0,1,"fullscreen")
	lsl.ui.addButton(170,400,220,60,255,255,255,"Back",0,0,1,0)

	lsl.ui.addButton(love.graphics.getWidth()/2-160,love.graphics.getHeight()/2-230,220,60,255,255,255,"Resume",5,0,"gameMenu1","run")
	lsl.ui.addButton(love.graphics.getWidth()/2-190,love.graphics.getHeight()/2-30,280,60,255,255,255,"Back to menu",5,0,"gameMenu1",0)
	lsl.ui.addButton(love.graphics.getWidth()/2-160,love.graphics.getHeight()/2+170,220,60,255,255,255,"Exit",2,0,"gameMenu1","exit")

	lsl.ui.setMenuBackground({page = {0,1,2},image = "Images/backgroundPicture.png"})

	--lsl.audio.newTrack(1,"Sounds/music.mp3")
	--lsl.audio.volume(1,0.2)
	--lsl.audio.play(1)

end

--Updates
function love.update()

	lsl.update()
	lsl.ui.inGameMenu("escape","gameMenu1")
	x,y = lsl.scroll.mouseCoordsToExactMap(love.mouse.getX(),love.mouse.getY())

	lsl.ui.replaceButton(love.graphics.getWidth()/2-160,love.graphics.getHeight()/2-230,220,60,255,255,255,"Resume",5,0,"gameMenu1","run",8)
	lsl.ui.replaceButton(love.graphics.getWidth()/2-190,love.graphics.getHeight()/2-30,280,60,255,255,255,"Back to menu",5,0,"gameMenu1",0,9)
	lsl.ui.replaceButton(love.graphics.getWidth()/2-160,love.graphics.getHeight()/2+170,220,60,255,255,255,"Exit",2,0,"gameMenu1","exit",10)

end

--Drawing
function love.draw()

	lsl.draw()

	--if

end

--
--NOTE TO ANYONE USING THIS LIBRARY: main.lua is un-needed as none of the functions are stored here. Only use this file for experimentations with the library. Although you must require lsl