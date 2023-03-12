local GeneralVariables = require 'general'

local pausedState = {}

local game = require 'game'

local buttons

function pausedState.init()
    buttons = 
    {
        resume = dofile 'button.lua',
        quit = dofile 'button.lua'
    }

    pausedState.font = love.graphics.newFont(GeneralVariables.fontPath, 50)
    pausedState.text = "Paused"
    pausedState.textWidth = pausedState.font:getWidth(pausedState.text)
    pausedState.textHeight = pausedState.font:getHeight(pausedState.text)/2

    buttons.resume.load("Resume")
    buttons.quit.load("Quit")
    buttons.quit.y = buttons.resume.y + buttons.resume.height + 20

    buttons.resume.action = function()
        game.switchState(game.states.play)
    end

    buttons.quit.action = function()
        love.event.quit()
    end

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
    love.graphics.setFont(pausedState.font)
    love.graphics.print(pausedState.text, GeneralVariables.mapWidth/2 - pausedState.textWidth/2, GeneralVariables.mapHeight/2 - pausedState.textHeight - 100)

    for i, button in pairs(buttons) do
        buttons[i].draw()
    end
end

function pausedState.keypressed(key)
    if key == 'escape' then
        buttons.resume.action()
    end
end

function pausedState.mousepressed(x, y, mouseButton)
    for i, button in pairs(buttons) do
        buttons[i].mousepressed(x, y, mouseButton)
    end
end

return pausedState