function love.conf(t)
    GeneralVariables = require 'general'

    t.window.width = GeneralVariables.mapWidth
    t.window.height = GeneralVariables.mapHeight
    t.window.title = "Love Pong"

    t.console = true
end