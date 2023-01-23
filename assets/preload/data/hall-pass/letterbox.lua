function createLetterboxing()

	makeLuaSprite('bartop','',0,-900)
    makeGraphic('bartop',1900,1000,'000000')
    addLuaSprite('bartop',true)

    makeLuaSprite('barbot','',0,625)
    makeGraphic('barbot',1900,1000,'000000')
    addLuaSprite('barbot',true)

    setScrollFactor('bartop',0,0)
    setScrollFactor('barbot',0,0)
    setObjectCamera('bartop','hud')
    setObjectCamera('barbot','hud')

	setObjectOrder('bartop', getObjectOrder('bartop') - 12)
	setObjectOrder('barbot', getObjectOrder('barbot') - 12)

end

function onCreate()
    createLetterboxing()
end