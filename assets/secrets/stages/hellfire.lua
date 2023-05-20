function onCreate()
	-- background shit
	makeAnimatedLuaSprite('stageback', 'hellfire', -600, -300)
	addAnimationByPrefix('stageback', 'idle', 'bg', 24, true)
	setGraphicSize('stageback', 2560, 1400)
	playAnim('stageback', 'idle', true)
	setScrollFactor('stageback', 0.9, 0.9)

	addLuaSprite('stageback', false)
	setProperty('boyfriendGroup.visible', false)
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end