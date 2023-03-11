local SoundManager = require 'SoundManager'
local scoreboard = require 'scoreboard'
local enums = require 'enums'

local player1, player2, ball

function love.load()
    player1 = dofile 'player.lua'
    player2 = dofile 'player.lua'
    ball = dofile 'ball.lua'

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    player1.load(enums.PlayerType.ONE)
    ball.load(player1)
    player2.load(enums.PlayerType.AI, ball)

    scoreboard.load()
end

function love.update(dt)
    player1.update(dt)
    player2.update(dt)

    ball.update(dt)

    if ball.isMoving then
        if ball.isColliding(player1) then
            ball.collide(player1)
        elseif ball.isColliding(player2) then
            ball.collide(player2)
        end

        local scorer = ball.checkScorer()

        if scorer == player1.position then
            ball.load(player2)
            SoundManager.missBlip:play()
            scoreboard.update(player1.position)
        elseif scorer == player2.position then
            ball.load(player1)
            SoundManager.missBlip:play()
            scoreboard.update(player2.position)
        end

        if scoreboard.scores[player1.position] >= GeneralVariables.winningScore then
            win(player1)
        elseif scoreboard.scores[player2.position] >= GeneralVariables.winningScore then
            win(player2)
        end
    end
end

function love.draw()
    scoreboard.draw()

    player1.draw()
    player2.draw()
    ball.draw()
end

function love.keypressed(key)
    if key == 'space' and not ball.isMoving then
        ball.launch()
    end
end

function win(player)
    print('Player ' .. player.type .. ' wins!')
    love.timer.sleep(1)
    love.event.quit()
end