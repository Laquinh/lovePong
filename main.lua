
function love.load()
    player1 = dofile 'player.lua'
    player2 = dofile 'player.lua'
    ball = dofile 'ball.lua'

    math.randomseed(os.time())

    love.graphics.setDefaultFilter("nearest", "nearest")

    player1.load()
    player2.load()
    player2.x = 0
    player2.number = 2
    player2.controls = {up = "w", down = "s"}
    ball.load(player1)

    padBlipSound = love.audio.newSource("assets/sounds/blip.wav", "static")
    wallBlipSound = love.audio.newSource("assets/sounds/blip.wav", "static")
    wallBlipSound:setVolume(0.3)
    wallBlipSound:setPitch(1.5)
    hitBlipSound = love.audio.newSource("assets/sounds/blip.wav", "static")
    hitBlipSound:setPitch(2)
    missBlipSound = love.audio.newSource("assets/sounds/blip.wav", "static")
    missBlipSound:setPitch(0.7)
end

function love.update(dt)
    player1.update(dt)
    player2.update(dt)

    ball.update(dt, wallBlipSound)

    if ball.isMoving then
        if ball.isColliding(player1) then
            ball.collide(player1, -1, padBlipSound, hitBlipSound)
        elseif ball.isColliding(player2) then
            ball.collide(player2, 1, padBlipSound, hitBlipSound)
        end

        win = ball.checkWin()

        if win == 1 then
            print("Player 1 wins!")
            ball.load(player2)
            missBlipSound:play()
        elseif win == 2 then
            print("Player 2 wins!")
            ball.load(player1)
            missBlipSound:play()
        end
    end
end

function love.draw()
    player1.draw()
    player2.draw()
    ball.draw()
end

function love.keypressed(key)
    if key == 'space' then
        ball.isMoving = true
        theta = math.random()*math.pi/6 - math.pi/12
        ball.direction.x = -math.cos(theta)
        ball.direction.y = math.sin(theta)
        print(theta, ball.direction.x, ball.direction.y)
        print(ball.isMoving)
        padBlipSound:play()
    end
end