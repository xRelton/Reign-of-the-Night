local scroll = {}

function scroll.setup(args)

	hasBeenSetup = true

	zoomToMouse = false
	if args.zoomToMouse then zoomToMouse = args.zoomToMouse end

	if not(args.tilemap or args.mapLength or args.mapHeight or tileSize) then
		print("Missing arguements for scroll.setup()") 
	end

	tilemap, tileSize = love.graphics.newImage(args.tilemap), args.tileSize
	mapLength, mapHeight = args.mapLength, args.mapHeight

	minZoom,maxZoom,cameraSpeed,zoomSpeed = 0.2,1.5,0.1,0.1

	if args.minZoom then minZoom = args.minZoom end
	if args.maxZoom then maxZoom = args.maxZoom end
	if args.cameraSpeed then cameraSpeed = args.cameraSpeed end
	if args.zoomSpeed then zoomSpeed = args.zoomSpeed end

	minFilter,maxFilter,anstropy = "nearest", "nearest", 0

	if args.minFilter then minFilter = args.minFilter end
	if args.maxFilter then maxFilter = args.maxFilter end
	if args.anstropy then anstropy = args.anstropy end

	tilemap:setFilter(minFilter,maxFilter,anstropy)

end

function scroll.setTile(x,y,tiledata)

	if not(x<1 or x>mapLength) and not(y<1 or y>mapHeight) then
		map[x][y] = tiledata
	end

end	

function scroll.createTiledata(args)

	if args.x and args.y then 
		customImage,quad = false, love.graphics.newQuad(args.x,args.y,tileSize,tileSize,tilemap:getWidth(),tilemap:getHeight())
	end

	if args.customImage then
		minFilter,maxFilter,anstropy = "nearest", "nearest", 0
			if args.minFilter then minFilter = args.minFilter end
			if args.maxFilter then maxFilter = args.maxFilter end
			if args.anstropy then anstropy = args.anstropy end
		customImage,quad = love.graphics.newImage(args.customImage),false
		customImage:setFilter(minFilter,maxFilter,anstropy)
	end

	return {customImage,quad,{false,false}}

end

function scroll.mouseCoordsToMap(x,y)

	tileX = math.floor((x-(zoom*cameraX)-centreX)/(tileSize*zoom))
	tileY = math.floor((y-(zoom*cameraY)-centreY)/(tileSize*zoom))

	return tileX,tileY

end

function scroll.load()

	a = "test"
	lastSelected = {1,1}
	hoverColor = {0,0,0}

	if not(hasBeenSetup == true) then print("scroll.setup() must be called before lsl.load()") end

	mapLength,mapHeight = 10,10
	zoom = 1
	cameraX,cameraY = -50,-50 --start in middle of map
	zoomOffset = 0

	map = {}

	for x = 1,mapLength do
		map[x] = {}
		for y = 1,mapHeight do
			map[x][y] = createDefaultTiledata()
		end
	end

	centreX,centreY = 600,300

end

function scroll.mouseCoordsToExactMap(x,y) 

	tileX = (x-(zoom*cameraX)-centreX)/(tileSize*zoom)
	tileY = (y-(zoom*cameraY)-centreY)/(tileSize*zoom)

	return tileX,tileY

end

function scroll.draw()

	love.graphics.push()

	love.graphics.translate(centreX,centreY)
	love.graphics.scale(zoom)

	drawTiles()
	
end


function scroll.update()

	capZoom()

	if zoomToMouse == true then --WIP

		centreX = love.mouse.getX()
		centreY = love.mouse.getY()

	end

end

function scroll.mapCoordsToScreen(num,axis) --num is x position in tiles
	
	if axis == "x" then 
		camera = cameraX
	elseif axis == "y" then 
		camera = cameraY 
	else 
		print("Arguement 2 for applyScroll() must be \"x\" or \"y\"")
	end

	return num*tileSize+camera

end

function capZoom()

	if zoom>maxZoom then zoom = maxZoom end
	if zoom<minZoom then zoom = minZoom end

end

function mouseCoordsToExactMap(x,y) --MUCH LESS BROKEN

	tileX = (x-(zoom*cameraX)-centreX)/(tileSize*zoom)
	tileY = (y-(zoom*cameraY)-centreY)/(tileSize*zoom)

	return tileX,tileY

end

function drawScrollingObject(object)

	x,y = object[3][1], object[3][2]
	image,quad = object[6][1], object[6][2]
	scaling = object[7]

	if quad == false then
		love.graphics.draw(image,applyScroll(x,"x"),applyScroll(y,"y"),0,scaling,scaling)
	else
		love.graphics.draw(image,quad,applyScroll(x,"x"),applyScroll(y,"y"),0,1,1)
	end

end

function createDefaultTiledata()

	quad = love.graphics.newQuad(0,0,tileSize,tileSize,tilemap:getWidth(),tilemap:getHeight())

	return {false,quad,{false,false}} --customImage, quad

end

function love.wheelmoved(x, y)

	if inGame == true and menuPage == runPage then
	    if y > 0 then
	        zoom = zoom + zoomSpeed
	    elseif y < 0 then
	        zoom = zoom - zoomSpeed
	 	end
	end

end

function drawTiles()

	love.graphics.setBackgroundColor(255, 255, 255)

	for x=1,mapLength do
		for y=1, mapHeight do

			love.graphics.setColor(255,255,255)

			if map[x][y][1] == false then
				love.graphics.draw(tilemap,map[x][y][2],applyScroll(x,"x"),applyScroll(y,"y"),0,1,1)
			else
				customImage = map[x][y][1]
				scaling = tileSize/customImage:getWidth()
				love.graphics.draw(customImage,applyScroll(x,"x"),applyScroll(y,"y"),0,scaling,scaling)
			end
		end
	end

end

function applyScroll(num,axis) --num is x position in tiles
	
	if axis == "x" then 
		camera = cameraX
	elseif axis == "y" then 
		camera = cameraY 
	else 
		print("Arguement 2 for applyScroll() must be \"x\" or \"y\"")
	end

	return num*tileSize+camera

end

return scroll