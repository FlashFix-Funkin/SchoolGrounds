
function onCountdownStarted()
    for i = 0,3 do
        local p = getPropertyFromGroup('opponentStrums',i,'x')
        setPropertyFromGroup('opponentStrums',i,'x',getPropertyFromGroup('playerStrums',i,'x'))
        setPropertyFromGroup('playerStrums',i,'x',p)
    end
end

function onUpdatePost()
    P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') *        getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)
    P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
    setProperty('iconP1.x',P1Mult - 110)
    setProperty('iconP1.origin.x',240)
    setProperty('iconP1.flipX',true)
    setProperty('iconP2.x',P2Mult + 110)
    setProperty('iconP2.origin.x',-100)
    setProperty('iconP2.flipX',true)
    setProperty('healthBar.flipX',true)
end

function onSectionHit()
	if mustHitSection then
    	doTweenAlpha('fgBars', 'fgBars', 1, 0.2, linear)
	else
        doTweenAlpha('fgBars', 'fgBars', 0.4, 0.2, linear)
	end
end


function onBeatHit()
    if curBeat == 118 then
        playSound ('train_passes', 1, 'trainSound');
	elseif curBeat == 132 then
		doTweenX('train', 'train', 3000, 0.25, linear);
	end
end

