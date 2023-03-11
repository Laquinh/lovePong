local GeneralVariables = require 'general'

local pausedState = {}

local game = require 'game'

function pausedState.init()
    font = love.graphics.getFont()
    text = "Paused"
    textWidth = font:getWidth(text)
    textHeight = font:getHeight(text)/2

    pausedState.isInitialized = true
end

function pausedState.resume()
end

function pausedState.load()
    if pausedState.isInitialized then
        pausedState.resume()
    else
        pausedState.init()
    end
end

function pausedState.update(dt)
end

function pausedState.draw()
    if pausedState.screenshot ~= nil then
        love.graphics.setColor{1, 1, 1, 0.25}
        love.graphics.draw(pausedState.screenshot)
    end
    love.graphics.setColor{1, 1, 1, 1}
    love.graphics.print(text, GeneralVariables.mapWidth/2 - textWidth/2, GeneralVariables.mapHeight/2 - textHeight)
end

function pausedState.keypressed(key)
    if key == 'escape' then
        game.switchState(game.states.play)
    end
end

return pausedState