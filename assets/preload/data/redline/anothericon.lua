local loosing = false
function IconFilterShit(sprite)
	P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
    if downscroll then
        makeLuaSprite('rIcon', 'bgs/redline/Icons/'..sprite, P2Mult, getProperty("iconP2.y"))
    else
        makeLuaSprite('rIcon', 'bgs/redline/Icons/'..sprite, P2Mult, getProperty("iconP2.y"))
    end
	setProperty('rIcon.origin.x', -10)
    setObjectCamera('rIcon', 'camHud')
    scaleObject('rIcon', 0.95, 0.95)
    addLuaSprite('rIcon', true)
end

function onBeatHit()
	setProperty('rIcon.scale.x', 1.15)
	setProperty('rIcon.scale.y', 1.15)
	doTweenX('iconHitX', 'rIcon.scale', 0.95, 0.35, 'circOut')
	doTweenY('iconHitY', 'rIcon.scale', 0.95, 0.35, 'circOut')
end

function onUpdatePost(elapsed)
    P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
	setProperty('rIcon.x', P2Mult)
	setProperty('rIcon.origin.x', -10)
	setProperty('rIcon.y', getProperty("iconP2.y"))

	if getProperty('healthBar.percent') > 80 and loosing == false then
		debugPrint('hi')
		removeLuaSprite('rIcon')
		IconFilterShit('roc-lose')
		loosing = true
	elseif getProperty('healthBar.percent') <= 80  and loosing == true then
		removeLuaSprite('rIcon')
		IconFilterShit('roc-default')
		loosing = false
	end
end

function onCreate()
	IconFilterShit('roc-default')
end