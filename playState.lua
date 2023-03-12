local enums = require 'enums'
local GeneralVariables = require 'general'
local SoundManager = require 'SoundManager'
local scoreboard = require 'scoreboard'

local playState = {}

local player1, player2, ball
local game = require 'game'

function playState.init()
    player1 = dofile 'player.lua'
    player2 = dofile 'player.lua'
    ball = dofile 'ball.lua'

    player1.load(enums.PlayerType.ONE)
    ball.load(player1)
    player2.load(enums.PlayerType.AI, ball)

    scoreboard.load()

    playState.isInitialized = true
end

function playState.resume()
end

function playState.load()
    if playState.isInitialized then
        playState.resume()
    else
        playState.init()
    end
end

function playState.update(dt)
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
            playState.win(player1)
        elseif scoreboard.scores[player2.position] >= GeneralVariables.winningScore then
            playState.win(player2)
        end
    end
end

function playState.draw()
    player1.draw()
    player2.draw()
    ball.draw()
    scoreboard.draw()
end

function playState.keypressed(key)
    if key == 'space' and not ball.isMoving then
        ball.launch()
    elseif key == 'return' or key == 'escape' then
        love.graphics.captureScreenshot(
            function(screenshot)
                game.states.paused.screenshot = love.graphics.newImage(screenshot)
                game.switchState(game.states.paused)
            end
        )
    end
end

function playState.mousepressed(x, y, button)
end

function playState.win(player)
    game.states.win.winner = player
    game.switchState(game.states.win)
end

function playState.reset()
    playState.isInitialized = false
end

return playState