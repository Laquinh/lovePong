local playState = require 'playState'

local game = {}

function game.load()
    game.currentState = playState
    game.currentState.load()
end

function game.update(dt)
    game.currentState.update(dt)
end

function game.draw()
    game.currentState.draw()
end

function game.keypressed(key)
    game.currentState.keypressed(key)
end

return game