local GeneralVariables = require 'general'

local button = {}

function button.load(text)
    button.backgroundColor = {0.2, 0.2, 0.2, 0.8}
    button.textColor = {1, 1, 1, 1}

    button.font = love.graphics.newFont(GeneralVariables.fontPath, 32)
    button.text = text
    button.textWidth = button.font:getWidth(button.text)
    button.textHeight = button.font:getHeight(button.text)/2

    button.x = GeneralVariables.mapWidth/2 - button.textWidth/2 - 10
    button.y = GeneralVariables.mapHeight/2 - button.textHeight/2 - 10
    button.width = button.textWidth + 20
    button.height = button.textHeight + 20
end

function button.update(dt)
end

function button.draw()
    love.graphics.setColor(button.backgroundColor)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    love.graphics.setColor(button.textColor)
    love.graphics.setFont(button.font)
    love.graphics.print(button.text, button.x + button.width/2 - button.textWidth/2, button.y + button.height/2 - button.textHeight/2)
end

function button.mousepressed(x, y, mouseButton)
    if x >= button.x and x <= button.x + button.width and y >= button.y and y <= button.y + button.height then
        button.action()
    end
end

function button.action()
    print("Button '" .. button.text .. "' pressed!")
end

return button