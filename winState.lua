local winState = {}

local buttons

local game = require 'game'
function winState.init()
    buttons =
    {
        restart = dofile 'button.lua',
        quit = dofile 'button.lua'
    }

    winState.font = love.graphics.newFont(GeneralVariables.fontPath, 50)
    winState.text = winState.winner.type .. " (" .. winState.winner.position .. ") won!"
    winState.textWidth = winState.font:getWidth(winState.text)
    winState.textHeight = winState.font:getHeight(winState.text)/2

    buttons.restart.load("Restart")
    buttons.quit.load("Quit")
    buttons.quit.y = buttons.restart.y + buttons.restart.height + 20

    buttons.restart.action = function()
        game.states.play.reset()
        game.switchState(game.states.play)
    end

    buttons.quit.action = function()
        love.event.quit()
    end

    winState.isInitialized = true
end

function winState.resume()
end

function winState.load()
    if winState.isInitialized then
        winState.resume()
    else
        winState.init()
    end
end

function winState.update(dt)
end

function winState.draw()
    love.graphics.setColor{1, 1, 1, 1}
    love.graphics.setFont(winState.font)
    love.graphics.print(winState.text, GeneralVariables.mapWidth/2 - winState.textWidth/2, GeneralVariables.mapHeight/2 - winState.textHeight - 100)

    for i, button in pairs(buttons) do
        buttons[i].draw()
    end
end

function winState.keypressed(key)
    if key == 'return' then
        buttons.restart.action()
    elseif key == 'escape' then
        buttons.quit.action()
    end
end

function winState.mousepressed(x, y, button)
    for i, button in pairs(buttons) do
        buttons[i].mousepressed(x, y, button)
    end
end

return winState