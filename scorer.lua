local GeneralVariables = require 'general'

local scorer = {}

function scorer.load()
    scorer.scores = {0, 0}
    
    scorer.offset = 50

    scorer.color = {1, 1, 1, 0.75}
    scorer.font = love.graphics.newFont("assets/fonts/Pixeboy-z8XGD.ttf", 136)
    love.graphics.setFont(scorer.font)

    scorer.scoreWidth = {scorer.font:getWidth(scorer.scores[1]..""), scorer.font:getWidth(scorer.scores[2].."")}

    print(scorer.scoreWidth[1], scorer.scoreWidth[2])
end

function scorer.update(index)
    scorer.scores[index] = scorer.scores[index] + 1

    scorer.scoreWidth = {scorer.font:getWidth(scorer.scores[1]..""), scorer.font:getWidth(scorer.scores[2].."")}
end

function scorer.draw()
    love.graphics.setColor(scorer.color)

    love.graphics.print(scorer.scores[1], GeneralVariables.mapWidth/2 + scorer.offset, 10)
    love.graphics.print(scorer.scores[2], GeneralVariables.mapWidth/2 - scorer.offset - scorer.scoreWidth[2], 10)
end

return scorer