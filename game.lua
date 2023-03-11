local game = {}

function game.load()
    game.states =
    {
        play = require 'playState',
        paused = require 'pausedState'
    }

    game.switchState(game.states.play)
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

function game.switchState(state)
    game.currentState = state
    game.currentState.load()
end

return game