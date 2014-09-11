-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


-- Make a bead factory
-- Make beads on a stack
--	each bead must have a range
-- 	beads move the beads above and below









-- ******************************************************
--[[ This is where I started 

local box = display.newRect( 0, 0, 60, 40 )
box.x = 100
box.y = 60

box.minY = 60
box.maxY = 120



local function resolvePosition() 
	local currentY = box.y
	local range = box.maxY - box.minY
	local midY = box.minY + (range / 2)
	if box.y > midY then 
		box.y = box.maxY
	else
		box.y = box.minY
	end 
end 


-- This function handles touch events on the object
local function on_touch( event )

	-- Get the target object
	local target = event.target

	-- Check the phase of the event. Here the drag begins

	if event.phase == "began" then -- When the event begins
		local parent = target.parent -- get the parent object
		parent:insert( target ) -- move the drag object to the top

		-- The dragging object needs to keep focus
		display.getCurrentStage():setFocus( target )
		target.isFocus = true -- Mark this object as having focus
		-- Get the offset from center of the object to the location
		-- of the event
		target.offsetY = event.y - target.y
		-- This phase handles moving the object
	elseif target.isFocus and event.phase == "moved" then
		target.y = event.y - target.offsetY -- using the offsets
		
		if box.y < box.minY then 
			box.y = box.minY
		elseif box.y > box.maxY then 
			box.y = box.maxY
		end

		-- This phase ends the drag
	elseif event.phase == "ended" or event.phase == "cancelled" then
		display.getCurrentStage():setFocus( nil ) -- reset focus
		target.isFocus = false -- mark this object as no longer having focus
		resolvePosition()
	end

end

-- Add this event listener for touch events to the dragging object

box:addEventListener( "touch", on_touch )

--]]

--******************************************************************










-- ****************************************************************

-- The second step was to improve the system to make a factory. 
-- The factory method will allow me to make as many beads as I need. 

--[[
local function makeBead( x, y, range )
	
	-- make a bead
	local bead = display.newRect( x, y, 60, 40 )
	bead.minY = y
	bead.maxY = y + range
	bead.range = range
	
	-- resolve the position after a drag
	function bead:resolvePosition()
		local currentY = self.y
		local range = self.maxY - self.minY
		local midY = self.minY + (self.range / 2)
		if self.y > midY then 
			self.y = self.maxY
		else
			self.y = self.minY
		end 
	end 
	
	-- Drag a bead, This function handles touch events on the object
	function onTouch( event )
		-- Get the target object
		local target = event.target
		-- Check the phase of the event. Here the drag begins

		if event.phase == "began" then -- When the event begins
			local parent = target.parent -- get the parent object
			parent:insert( target ) -- move the drag object to the top

			-- The dragging object needs to keep focus
			display.getCurrentStage():setFocus( target )
			target.isFocus = true -- Mark this object as having focus
			-- Get the offset from center of the object to the location
			-- of the event
			target.offsetY = event.y - target.y
			-- This phase handles moving the object
		elseif target.isFocus and event.phase == "moved" then
			target.y = event.y - target.offsetY -- using the offsets
		
			if target.y < target.minY then 
				target.y = target.minY
			elseif target.y > target.maxY then 
				target.y = target.maxY
			end

			-- This phase ends the drag
		elseif event.phase == "ended" or event.phase == "cancelled" then
			display.getCurrentStage():setFocus( nil ) -- reset focus
			target.isFocus = false -- mark this object as no longer having focus
			target:resolvePosition()
		end
	end
	
	bead:addEventListener( "touch", onTouch )

	return bead
end 

-- Make a bead makeBead( x, y, range )
local bead_1 = makeBead( 100, 100, 120 )
local bead_2 = makeBead( 200, 100, 120 )
local bead_3 = makeBead( 300, 100, 120 )
local bead_4 = makeBead( 400, 100, 120 )

--]]

-- ****************************************************************




-- ****************************************************************
--[[
-- Here I added some motion to the position resolving function. 

local function makeBead( x, y, range )
	
	-- make a bead
	local bead = display.newRect( x, y, 60, 40 )
	bead.minY = y
	bead.maxY = y + range
	bead.range = range
	
	-- resolve the position after a drag
	function bead:resolvePosition()
		local currentY = self.y
		local range = self.maxY - self.minY
		local midY = self.minY + (self.range / 2)
		
		-- Set the targetY to minY
		local targetY = bead.minY
		
		-- If the position is past the midY get the maxY
		if self.y > midY then 
			targetY = self.maxY
		end 
		
		-- Setup a transition to animate the bead to targetY
		transition.to( self, {y=targetY, time=100})
		
	end 
	
	-- Drag a bead, This function handles touch events on the object
	function onTouch( event )
		-- Get the target object
		local target = event.target
		-- Check the phase of the event. Here the drag begins

		if event.phase == "began" then -- When the event begins
			local parent = target.parent -- get the parent object
			parent:insert( target ) -- move the drag object to the top

			-- The dragging object needs to keep focus
			display.getCurrentStage():setFocus( target )
			target.isFocus = true -- Mark this object as having focus
			-- Get the offset from center of the object to the location
			-- of the event
			target.offsetY = event.y - target.y
			-- This phase handles moving the object
		elseif target.isFocus and event.phase == "moved" then
			target.y = event.y - target.offsetY -- using the offsets
		
			if target.y < target.minY then 
				target.y = target.minY
			elseif target.y > target.maxY then 
				target.y = target.maxY
			end

			-- This phase ends the drag
		elseif event.phase == "ended" or event.phase == "cancelled" then
			display.getCurrentStage():setFocus( nil ) -- reset focus
			target.isFocus = false -- mark this object as no longer having focus
			target:resolvePosition()
		end
	end
	
	bead:addEventListener( "touch", onTouch )

	return bead
end 

-- Make a bead makeBead( x, y, range )
local bead_1 = makeBead( 100, 100, 120 )
local bead_2 = makeBead( 200, 100, 120 )
local bead_3 = makeBead( 300, 100, 120 )
local bead_4 = makeBead( 400, 100, 120 )


--]]
-- ****************************************************************











-- ****************************************************************

-- Try and make a group of beads 

local function makeBead( x, y, range )
	-- make a bead
	local bead = display.newRect( x, y, 60, 40 )
	bead.minY = y
	bead.maxY = y + range
	bead.range = range
	
	-- resolve the position after a drag
	function bead:resolvePosition()
		local currentY = self.y
		local range = self.maxY - self.minY
		local midY = self.minY + (self.range / 2)
		
		-- Set the targetY to minY
		local targetY = bead.minY
		
		-- If the position is past the midY get the maxY
		if self.y > midY then 
			targetY = self.maxY
		end 
		
		-- Setup a transition to animate the bead to targetY
		transition.to( self, {y=targetY, time=100})
		
	end 
	
	-- Drag a bead, This function handles touch events on the object
	function onTouch( event )
		-- Get the target object
		local target = event.target
		-- Check the phase of the event. Here the drag begins

		if event.phase == "began" then -- When the event begins
			local parent = target.parent -- get the parent object
			parent:insert( target ) -- move the drag object to the top

			-- The dragging object needs to keep focus
			display.getCurrentStage():setFocus( target )
			target.isFocus = true -- Mark this object as having focus
			-- Get the offset from center of the object to the location
			-- of the event
			target.offsetY = event.y - target.y
			-- This phase handles moving the object
		elseif target.isFocus and event.phase == "moved" then
			target.y = event.y - target.offsetY -- using the offsets
		
			if target.y < target.minY then 
				target.y = target.minY
			elseif target.y > target.maxY then 
				target.y = target.maxY
			end

			-- This phase ends the drag
		elseif event.phase == "ended" or event.phase == "cancelled" then
			display.getCurrentStage():setFocus( nil ) -- reset focus
			target.isFocus = false -- mark this object as no longer having focus
			target:resolvePosition()
		end
	end
	
	bead:addEventListener( "touch", onTouch )

	return bead
end 



-- A function to make a bead group
local function makeBeadGroup( beadCount, x, y, range )
	-- Make a table to hold the beads
	local beadTable = {}

	-- A number of beads
	for i = 1, beadCount do 
		-- The y position of each bead will offset by the height of a bead
		local beadY = y + ((i-1) * 42)
		local bead = makeBead( x, beadY, range )
		
		beadTable[i] = bead
	end 
	
	-- Return beads table
	return beadTable
end 




-- makeBeadGroup( beadCount, x, y, range )
-- Make a group of 3
local beadGroup_1 = makeBeadGroup( 3, 285, 60, 60 )
-- * makeBeadGroup returns a table containing bead objects.
-- We may need to control the whole stack of beads. This table 
-- contains a reference to each of the beads in the group. 
-- ** At this point the beads will still overlap! 

-- make a group of 5
local beadGroup_2 = makeBeadGroup( 5, 185, 60, 60 )


-- ****************************************************************



