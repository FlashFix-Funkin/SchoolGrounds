local offset = 15

function onBeatHit()
	if curBeat % 2 == 0 then
		doTweenY("bfWalk", 'boyfriend', getProperty("boyfriend.y") + offset, 0.01, 'circOut')
		doTweenY("opponentWalk", 'dad', getProperty("dad.y") + offset, 0.01, 'circOut')
	end
end

function onTweenCompleted(name)
	if name == "bfWalk" then
		doTweenY("bfWalkEnd", 'boyfriend', getProperty("boyfriend.y") - offset, 0.5, 'circOut')
		doTweenY("opponentWalkEnd", 'dad', getProperty("dad.y") - offset, 0.5, 'circOut')
	end
end