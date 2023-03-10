local SoundManager = {}

SoundManager.padBlip = love.audio.newSource('assets/sounds/blip.wav', 'static')

SoundManager.wallBlip = love.audio.newSource('assets/sounds/blip.wav', 'static')
SoundManager.wallBlip:setVolume(0.3)
SoundManager.wallBlip:setPitch(1.5)

SoundManager.hitBlip = love.audio.newSource('assets/sounds/blip.wav', 'static')
SoundManager.hitBlip:setPitch(2)

SoundManager.missBlip = love.audio.newSource('assets/sounds/blip.wav', 'static')
SoundManager.missBlip:setPitch(0.7)

return SoundManager