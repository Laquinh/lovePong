local GeneralVariables = require 'general'

local scoreboard = {}

function scoreboard.load()
    scoreboard.scores = {0, 0}
    
    scoreboard.offset = 50

    scoreboard.color = {1, 1, 1, 0.75}
    scoreboard.font = love.graphics.newFont("assets/fonts/Pixeboy-z8XGD.ttf", 136)
    love.graphics.setFont(scoreboard.font)

    scoreboard.scoreWidth = {scoreboard.font:getWidth(scoreboard.scores[1]..""), scoreboard.font:getWidth(scoreboard.scores[2].."")}

    print(scoreboard.scoreWidth[1], scoreboard.scoreWidth[2])
end

function scoreboard.update(index)
    scoreboard.scores[index] = scoreboard.scores[index] + 1

    scoreboard.scoreWidth = {scoreboard.font:getWidth(scoreboard.scores[1]..""), scoreboard.font:getWidth(scoreboard.scores[2].."")}
end

function scoreboard.draw()
    love.graphics.setColor(scoreboard.color)

    love.graphics.print(scoreboard.scores[1], GeneralVariables.mapWidth/2 + scoreboard.offset, 10)
    love.graphics.print(scoreboard.scores[2], GeneralVariables.mapWidth/2 - scoreboard.offset - scoreboard.scoreWidth[2], 10)
end

return scoreboard