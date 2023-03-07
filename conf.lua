function love.conf(t)
    GeneralVariables = require "general"

    t.window.width = GeneralVariables.tileWidth * GeneralVariables.mapWidth
    t.window.height = GeneralVariables.tileHeight * GeneralVariables.mapHeight
    t.window.title = "Love Pong"

    t.console = true
end