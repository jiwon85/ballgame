-- Abstract: HelloPhysics project
--
-- Demonstrates creating phyiscs bodies
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
--	Supports Graphics 2.0
---------------------------------------------------------------------------------------

--Ball Object & methods
Ball =  {img = "", value = 0, imgRef = nil}

function Ball:display(x, y)
	self.imgRef = display.newImage(self.img, x, y)
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

local redBall = Ball
redBall.img = "red.png"
redBall.value = 0
redBall:display(180, -50)

local redBall2 = Ball
redBall2.img = "red.png"
redBall2.value = 0
redBall2:display(170, -50)

physics.addBody( redBall.imgRef, "dynamic", { density=.8, friction=0.1, bounce=0.8, radius = 27} )
physics.addBody( redBall2.imgRef, "dynamic", { density=.8, friction=0.1, bounce=0.8, radius = 27} )

-- redBall.imgRef:setLinearVelocity(90, 150)

local function tapListener( event )
    local object = event.target
    display.remove(object)
    ballCount=ballCount-1
    if ballCount == 0 then
        local myText = display.newText( "game over", 100, 200, native.systemFontBold, 20 )
	    myText:setFillColor( 1, 0, 0.5 )
    end

end

redBall.imgRef:addEventListener( "tap", tapListener )
redBall2.imgRef:addEventListener( "tap", tapListener )

--TODO
--make balls into their own objects
--place them into an array (by color maybe?)
--randomize x coordiate placement and linear velocity
--figure out precedence of color and how to detect




