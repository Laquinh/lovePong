local GeneralVariables = require 'general'
local enums = require 'enums'

local player = {}

local ball

local function oppositePosition(position)
    if position == enums.Position.LEFT then
        return enums.Position.RIGHT
    else
        return enums.Position.LEFT
    end
end

function player.load(playerType, targetBall)
    player.type = playerType
    player.speed = 300
    player.width = 32
    player.height = 3*32

    if player.type == enums.PlayerType.ONE then
        player.position = GeneralVariables.defaultPosition[enums.PlayerType.ONE]
    else
        player.position = oppositePosition(GeneralVariables.defaultPosition[enums.PlayerType.ONE])
    end

    if player.type == enums.PlayerType.AI then
        assert(targetBall, "AI player needs a target ball")
        player.update = player.updateAI
        ball = targetBall
    else
        player.update = player.updateHuman
    end

    if player.position == enums.Position.LEFT then
        player.x = 0
    else
        player.x = GeneralVariables.mapWidth - player.width
    end
    
    player.y = (GeneralVariables.mapHeight - player.height) / 2

    if player.position == enums.Position.RIGHT then
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

if GeneralVariables.drawMode == enums.DrawMode.IMAGES then
    function player.draw()
        if player.position == enums.Position.LEFT then
            love.graphics.draw(player.image, player.x + player.width, player.y + player.height, nil, -GeneralVariables.pixelScale)
        else
            love.graphics.draw(player.image, player.x, player.y, nil, GeneralVariables.pixelScale)
        end
    end
elseif GeneralVariables.drawMode == enums.DrawMode.GEOMETRY then
    function player.draw()
        love.graphics.setColor(player.color)
        love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
    end
end

function player.updateHuman(dt)
    if love.keyboard.isDown(player.controls.up) and player.y > 0 then
        player.y = player.y - dt*player.speed
    elseif love.keyboard.isDown(player.controls.down) and player.y < GeneralVariables.mapHeight - player.height then
        player.y = player.y + dt*player.speed
    end
end

function player.updateAI(dt)
    if ball.y < player.y then
        player.y = player.y - dt*player.speed
    elseif ball.y > player.y + player.height then
        player.y = player.y + dt*player.speed
    end
end

return player