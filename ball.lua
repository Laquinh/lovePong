local GeneralVariables = require "general"
local enums = require "enums"
local SoundManager = require "SoundManager"

local ball = {}

function ball.load(player)
    ball.player = player

    ball.speed = 500
    ball.direction = {x = 0, y = 0}

    ball.width = 24
    ball.height = 24
    ball.radius = 12

    if player.number == 1 then
        ball.x = player.x - ball.width
    else
        ball.x = player.x + player.width
    end

    ball.y = player.y + (player.height - ball.height) / 2

    ball.isMoving = false

    ball.collisionCounter = 0

    if GeneralVariables.drawMode == enums.DrawMode.IMAGES then
        ball.image = love.graphics.newImage("assets/sprites/ball.png")
        assert(ball.image:getWidth()*GeneralVariables.pixelScale == ball.width and ball.image:getHeight()*GeneralVariables.pixelScale == ball.height, "Ball image dimensions (" .. ball.image:getWidth() .. ", " .. ball.image:getHeight() .. ") don't match ball dimensions (" .. ball.width .. ", " .. ball.height .. ")")
    end
end

function ball.update(dt)
    if ball.isMoving then
        ball.x = ball.x + dt*ball.speed*ball.direction.x
        ball.y = ball.y + dt*ball.speed*ball.direction.y

        if ball.y < 0 then
            ball.y = 0
            ball.direction.y = -ball.direction.y
            SoundManager.wallBlipSound:play()
        elseif ball.y > GeneralVariables.mapHeight - ball.height then
            ball.y = GeneralVariables.mapHeight - ball.height
            ball.direction.y = -ball.direction.y
            SoundManager.wallBlipSound:play()
        end
    else
        ball.y = ball.player.y + (ball.player.height - ball.height) / 2
    end
end

if GeneralVariables.drawMode == enums.DrawMode.IMAGES then
    function ball.draw()
        love.graphics.draw(ball.image, ball.x, ball.y, nil, GeneralVariables.pixelScale)
    end
elseif GeneralVariables.drawMode == enums.DrawMode.GEOMETRY then
    function ball.draw()
        love.graphics.circle("fill", ball.x + ball.radius, ball.y + ball.radius, ball.radius)
    end
end

function ball.isColliding(player)
    return ball.x + ball.width > player.x and ball.x < player.x + player.width and
        ball.y + ball.height > player.y and ball.y < player.y + player.height
end

function ball.checkWinner()
    if ball.x < 0 then
        return 1
    elseif ball.x > GeneralVariables.mapWidth then
        return 2
    else
        return 0
    end
end

function sign(x)
    if x < 0 then
        return -1
    elseif x > 0 then
        return 1
    else
        return 0
    end
end

function ball.collide(player, directionSign)
    ball.collisionCounter = ball.collisionCounter + 1
    if ball.collisionCounter % 10 == 0 and ball.speed < 800 then
        ball.speed = ball.speed + 50
        print(ball.speed)
    end

    ball.x = player.x + player.width * directionSign

    local theta, multiplier

    if ball.y < player.y then
        theta = -(math.random()*math.pi/4 + math.pi/12)
        multiplier = 1.3
        SoundManager.hitBlipSound:play()
    elseif ball.y + ball.height > player.y + player.height then
        theta = (math.random()*math.pi/4 + math.pi/12)
        multiplier = 1.3
        SoundManager.hitBlipSound:play()
    else
        theta = (math.random()*math.pi/4 - math.pi/8)
        multiplier = 1
        SoundManager.padBlipSound:play()
    end

    ball.direction.x = math.cos(theta) * directionSign * multiplier
    ball.direction.y = math.sin(theta)
end

return ball