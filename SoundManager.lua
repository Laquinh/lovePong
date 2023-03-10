local SoundManager = {}

SoundManager.padBlipSound = love.audio.newSource('assets/sounds/blip.wav', 'static')

SoundManager.wallBlipSound = love.audio.newSource('assets/sounds/blip.wav', 'static')
SoundManager.wallBlipSound:setVolume(0.3)
SoundManager.wallBlipSound:setPitch(1.5)

SoundManager.hitBlipSound = love.audio.newSource('assets/sounds/blip.wav', 'static')
SoundManager.hitBlipSound:setPitch(2)

SoundManager.missBlipSound = love.audio.newSource('assets/sounds/blip.wav', 'static')
SoundManager.missBlipSound:setPitch(0.7)

return SoundManager