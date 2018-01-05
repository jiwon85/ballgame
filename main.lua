
--Ball Object & methods
Ball =  {img = "", imgRef = nil}

function Ball:display(x, y)
	self.imgRef = display.newImage(self.img, x, y)
	self.imgRef.value = 1
end


local function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--Background set up
local physics = require( "physics" )
physics.start()

local sky = display.newImage( "bkg_clouds.png", 160, 195 )

local ground = display.newImage( "ground.png", 160, 445 )



local ballCount = 2;

--change walls to be invisible later

local leftWall = display.newRect (1, display.contentHeight/2, 1, display.contentHeight)

local rightWall = display.newRect (display.contentWidth-1, display.contentHeight/2, 1, display.contentHeight)

physics.addBody( leftWall, "static", {friction=0.2, bounce=0.3})
physics.addBody( rightWall, "static", {friction=0.2, bounce=0.3})

physics.addBody( ground, "static", { friction=0.5, bounce=0.3 } )

--local crate = display.newImage( "crate.png", 180, -50 )
--crate.rotation = 5

local redBall = deepCopy(Ball)
redBall.img = "red.png"
redBall:display(180, -50)

local redBall2 = deepCopy(Ball)
redBall2.img = "red.png"
redBall2:display(170, -50)

physics.addBody( redBall.imgRef, "dynamic", { density=.8, friction=0.1, bounce=0.8, radius = 27} )
physics.addBody( redBall2.imgRef, "dynamic", { density=.8, friction=0.1, bounce=0.8, radius = 27} )

-- redBall.imgRef:setLinearVelocity(90, 150)

local function tapListener( event )
    local object = event.target
    display.remove(object)
    object.value = object.value - 1
    if object.value == 0 then
    	ballCount=ballCount-1
    end
    if ballCount == 0 then
        local myText = display.newText( "game over", 100, 200, native.systemFontBold, 20 )
	    myText:setFillColor( 1, 0, 0.5 )
    end

end

local function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

redBall.imgRef:addEventListener( "tap", tapListener )
redBall2.imgRef:addEventListener( "tap", tapListener )

--TODO
--make balls into their own objects
--place them into an array (by color maybe?)
--randomize x coordiate placement and linear velocity
--figure out precedence of color and how to detect




