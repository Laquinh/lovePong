local GeneralVariables = require 'general'
local enums = require 'enums'

local player = {}

function player.load(number)
    player.number = number
    player.speed = 300
    player.width = 32
    player.height = 3*32
    if player.number == 1 then
        player.x = GeneralVariables.mapWidth - player.width
    else
        player.x = 0
    end
    player.y = (GeneralVariables.mapHeight - player.height) / 2

    if player.number == 1 then
        player.controls = {up = 'up', down = 'down'}
    else
        player.controls = {up = 'w', down = 's'}
    end
    
    if GeneralVariables.drawMode == enums.DrawMode.IMAGES then
        player.image = love.graphics.newImage('assets/sprites/pad.png')
        assert(player.image:getWidth()*GeneralVariables.pixelScale == player.width and player.image:getHeight()*GeneralVariables.pixelScale == player.height, "Player image dimensions don't match player dimensions")
    end

    player.color = {1, 1, 1, 1}
end

function player.update(dt)
    if love.keyboard.isDown(player.controls.up) and player.y > 0 then
        player.y = player.y - dt*player.speed
    elseif love.keyboard.isDown(player.controls.down) and player.y < GeneralVariables.mapHeight - player.height then
        player.y = player.y + dt*player.speed
    end
end

if GeneralVariables.drawMode == enums.DrawMode.IMAGES then
    function player.draw()
        if player.number == 2 then
            love.graphics.draw(player.image, player.x + player.width, player.y + player.height, nil, -GeneralVariables.pixelScale)
        else
            love.graphics.draw(player.image, player.x, player.y, nil, GeneralVariables.pixelScale)
        end
    end
elseif GeneralVariables.drawMode == enums.DrawMode.GEOMETRY then
    function player.draw()
        love.graphics.setColor(player.color)
        if player.number == 2 then
            love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
        else
            love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
        end
    end
end

return player