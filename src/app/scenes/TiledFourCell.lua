--
-- Author: Your Name
-- Date: 2015-06-30 16:50:26
--
local TiledFourCell = class("TiledFourCell", function()
	return {}
end)

function TiledFourCell:ctor()
	self.leftTop = 0
	self.leftDown = 0
	self.rightTop = 0
	self.rightDown = 0 
end

function TiledFourCell:onExit()
end

function TiledFourCell:setLeftTop(num)
	self.leftTop = num
end

function TiledFourCell:setLeftDown(num)
	self.leftDown = num
end

function TiledFourCell:setRightTop(num)
	self.rightTop = num
end

function TiledFourCell:setRightDown(num)
	self.rightDown = num
end


function TiledFourCell:getTotalNum()
	self.totalNum = self.leftTop + self.leftDown + self.rightTop + self.rightDown 
	return self.totalNum
end

return TiledFourCell