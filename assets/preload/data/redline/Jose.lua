function onCreate()
	makeAnimatedLuaSprite('jose', 'bgs/redline/Jose/jose2', 480,160)
	addAnimationByPrefix('jose', 'idle', 'idle', 24, false)
	
	scaleObject('jose', 1,1)
	setObjectOrder('jose', getObjectOrder('gfGroup')+1)
	
	addLuaSprite('jose',true)
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('jose', 'idle', true)
	end
end

function onCountdownTick(counter)
	if counter % 2 == 0 then
		objectPlayAnimation('jose', 'idle');
	end
end