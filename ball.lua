local GeneralVariables = require "general"

local ball = {}

function ball.load(p)
    player = p

    ball.speed = 500
    ball.direction = {x = 0, y = 0}
    ball.image = love.graphics.newImage("assets/sprites/ball.png")
    if player.number == 1 then
        ball.x = player.x - ball.image:getWidth() * GeneralVariables.pixelScale
    else
        ball.x = player.x + player.image:getWidth() * GeneralVariables.pixelScale
    end
    ball.y = player.y + (player.image:getHeight() * GeneralVariables.pixelScale - ball.image:getHeight() * GeneralVariables.pixelScale) / 2

    ball.isMoving = false

    ball.collisionCounter = 0
end

function ball.update(dt, wallBlipSound)
    if ball.isMoving then
        ball.x = ball.x + dt*ball.speed*ball.direction.x
        ball.y = ball.y + dt*ball.speed*ball.direction.y

        if ball.y < 0 then
            ball.y = 0
            ball.direction.y = -ball.direction.y
            wallBlipSound:play()
        elseif ball.y > GeneralVariables.mapHeight*GeneralVariables.tileHeight - ball.image:getHeight()*GeneralVariables.pixelScale then
            ball.y = GeneralVariables.mapHeight*GeneralVariables.tileHeight - ball.image:getHeight()*GeneralVariables.pixelScale
            ball.direction.y = -ball.direction.y
            wallBlipSound:play()
        end
    else
        ball.y = player.y + (player.image:getHeight() * GeneralVariables.pixelScale - ball.image:getHeight() * GeneralVariables.pixelScale) / 2
    end
end

function ball.draw()
    love.graphics.draw(ball.image, ball.x, ball.y, nil, GeneralVariables.pixelScale)
end

function ball.isColliding(p)
    return ball.x + ball.image:getWidth()*GeneralVariables.pixelScale > p.x and ball.x < p.x + p.image:getWidth()*GeneralVariables.pixelScale and
        ball.y + ball.image:getHeight()*GeneralVariables.pixelScale > p.y and ball.y < p.y + p.image:getHeight()*GeneralVariables.pixelScale
end

function ball.checkWin()
    if ball.x < 0 then
        return 1
    elseif ball.x > GeneralVariables.mapWidth*GeneralVariables.tileWidth then
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

function ball.collide(p, s, padBlipSound, hitBlipSound)
    ball.collisionCounter = ball.collisionCounter + 1
    if ball.collisionCounter % 10 == 0 and ball.speed < 800 then
        ball.speed = ball.speed + 50
        print(ball.speed)
    end

    ball.x = p.x + p.image:getWidth() * GeneralVariables.pixelScale * s
    if ball.y < p.y then
        theta = -(math.random()*math.pi/4 + math.pi/12)
        multiplier = 1.3
        hitBlipSound:play()
    elseif ball.y + ball.image:getHeight() * GeneralVariables.pixelScale > p.y + p.image:getHeight() * GeneralVariables.pixelScale then
        theta = (math.random()*math.pi/4 + math.pi/12)
        multiplier = 1.3
        hitBlipSound:play()
    else
        theta = (math.random()*math.pi/4 - math.pi/8)
        multiplier = 1
        padBlipSound:play()
    end

    ball.direction.x = math.cos(theta) * s * multiplier
    ball.direction.y = math.sin(theta)
end

return ball