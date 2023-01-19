local directory = "bgs/hall-pass/"

local counter = 0
local timer = 40

function makeBackground(x,y)
    makeLuaSprite('backgroundLoop'..counter, directory..'background', x, y);
    scaleObject('backgroundLoop'..counter, 0.85, 0.85);
    addLuaSprite('backgroundLoop'..counter, false);
    
    doTweenX('backgroundLoop'..counter, 'backgroundLoop'..counter, -5090, timer, 'linear')
end

function onCreate()
    makeBackground(-50,0)
end

function onTweenCompleted(name)
    if name == 'backgroundLoop'..counter then
        doTweenX('backgroundLoop'..counter.."final", 'backgroundLoop'..counter, -7090, timer * ((6590 / 5090) - 1), 'linear')
        counter = counter + 1
        makeBackground(getProperty('backgroundLoop'..(counter-1)..'.width')/4, 0)
    end
    if name == 'backgroundLoop'..(counter-1)..'final' then
        removeLuaSprite('backgroundLoop'..counter-1)
    end
end