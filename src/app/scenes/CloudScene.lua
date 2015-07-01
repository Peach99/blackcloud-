--
-- Author: Your Name
-- Date: 2015-06-30 16:05:52
--
local TiledFourCell = import("app.scenes.TiledFourCell")

local CloudScene = class("CloudScene", function()
	return display.newScene()
end)

function CloudScene:onEnter()
	self.colorLayer = display.newColorLayer(cc.c4b(255,255,255,255))
	self:addChild(self.colorLayer)

	self.tiledMap = cc.TMXTiledMap:create("blackCloud.tmx")
	self:addChild(self.tiledMap)
	self:setTouchEnabled(true)
    -- self:setTouchSwallowEnabled(true)
    self.colorLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
        if event.name == "began" then
            if self:onTouchBegan(cc.p(event.x,event.y)) then
                return true
            end
            return false
        elseif event.name == "moved" then
            self:onTouchMoved(cc.p(event.x,event.y))
        elseif event.name == "ended" then
            self:onTouchEnded(cc.p(event.x,event.y))
        end
    end)

	   -- 瓦片地图使用4X4的图片，每张小图片对应的数值如下：
	   --  0 4 8 12
	   --  1 5 9 13
	   --  2 6 10 14
	   --  3 7 11 15
 
	   --  以上数值为瓦片格子的数据值。
 
	   --  瓦片图素从1开始计数，如下：
	   --  1 2 3 4
	   --  5 6 7 8
	   --  9 10 11 12
	   --  13 14 15 16
	   --  比如数据值4，对应的瓦片图素是2；数据值10，对应的瓦片图素是11。
	    
	self.gids = {}   
	self.gids[0] = "1"
	self.gids[1] = "5"
	self.gids[2] = "9"
	self.gids[3] = "13"
	self.gids[4] = "2"
	self.gids[5] = "6"
	self.gids[6] = "10"
	self.gids[7] = "14"
	self.gids[8] = "3"
	self.gids[9] = "7"
	self.gids[10] = "11"
	self.gids[11] = "15"
	self.gids[12] = "4"
	self.gids[13] = "8"
	self.gids[14] = "12"
	self.gids[15] = "16"

	self.Cells = {}

end

function CloudScene:onExit()
end

function CloudScene:onTouchBegan(pos)
	-- print("onTouchBegan")
	local mapSize = self.tiledMap:getMapSize()
	local tiledSize = self.tiledMap:getTileSize()

	local col = math.floor(pos.x/tiledSize.width)
	local row = math.floor(mapSize.height - pos.y/tiledSize.height)
	
	local layer = self.tiledMap:getLayer("cloudLayer")
	self:changeCloudTiled4(layer, cc.p(col, row))
	self:changeCloudTiled8(layer, cc.p(col+1, row))
	self:changeCloudTiled1(layer, cc.p(col, row+1))
	self:changeCloudTiled2(layer, cc.p(col+1, row+1))

	-- print("···" .. col .. " " .. row)

	return true
end	

function CloudScene:onTouchMoved(pos)
	print("onTouchMoved")
	local mapSize = self.tiledMap:getMapSize()
	local tiledSize = self.tiledMap:getTileSize()

	local col = math.floor(pos.x/tiledSize.width)
	local row = math.floor(mapSize.height - pos.y/tiledSize.height)

	print("···" .. col .. " " .. row)
end	

function CloudScene:onTouchEnded(pos)
	-- print("onTouchEnded")
end	

function CloudScene:getCellByPos(pos)
	local key = "x="..pos.x.."y="..pos.y
	local cell = self.Cells[key]

	print(key)

	if cell == nil then
		cell = TiledFourCell.new()
		-- cell:retain()
		self.Cells[key] = cell
		print("CloudScene:getCellByPos(pos)")
	end

	return cell
end

function CloudScene:setGidByTotalNum(layer, cell, pos)
	local totalNum = cell:getTotalNum()
	layer:setTileGID(self.gids[totalNum], pos)
	-- print("setGidByTotalNum"..totalNum)
end

function CloudScene:changeCloudTiled4(layer, pos)
	local cell = self:getCellByPos(pos)
	cell:setRightDown(4)
	self:setGidByTotalNum(layer, cell, pos)
end

function CloudScene:changeCloudTiled8(layer, pos)
	local cell = self:getCellByPos(pos)
	cell:setLeftDown(8)
	self:setGidByTotalNum(layer, cell, pos)
end

function CloudScene:changeCloudTiled1(layer, pos)
	local cell = self:getCellByPos(pos)
	cell:setRightTop(1)
	self:setGidByTotalNum(layer, cell, pos)
end

function CloudScene:changeCloudTiled2(layer, pos)
	local cell = self:getCellByPos(pos)
	cell:setLeftTop(2)
	self:setGidByTotalNum(layer, cell, pos)
end

return CloudScene