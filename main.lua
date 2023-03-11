local SoundManager = require 'SoundManager'
local scoreboard = require 'scoreboard'
local enums = require 'enums'
local game = require 'game'

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')

    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end

function love.keypressed(key)
    game.keypressed(key)
end