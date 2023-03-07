local GeneralVariables = require "general"

local player = {}

function player.load()
    player.speed = 300
    player.image = love.graphics.newImage("assets/sprites/pad.png")
    player.x = (GeneralVariables.mapWidth - GeneralVariables.pixelScale) * GeneralVariables.tileWidth
    player.y = (GeneralVariables.mapHeight * GeneralVariables.tileHeight - player.image:getHeight() * GeneralVariables.pixelScale) / 2
    player.number = 1
    player.controls = {up = "up", down = "down"}
end

function player.update(dt)
    if love.keyboard.isDown(player.controls.up) and player.y > 0 then
        player.y = player.y - dt*player.speed
    elseif love.keyboard.isDown(player.controls.down) and player.y < GeneralVariables.mapHeight*GeneralVariables.tileHeight - player.image:getHeight()*GeneralVariables.pixelScale then
        player.y = player.y + dt*player.speed
    end
end

function player.draw()
    if player.number == 2 then
        love.graphics.draw(player.image, player.x + player.image:getWidth() * GeneralVariables.pixelScale, player.y + player.image:getHeight() * GeneralVariables.pixelScale, nil, -GeneralVariables.pixelScale)
    else
        love.graphics.draw(player.image, player.x, player.y, nil, GeneralVariables.pixelScale)
    end
end

return player