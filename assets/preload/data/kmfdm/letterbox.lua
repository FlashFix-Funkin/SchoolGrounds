function onCreate()
	setProperty("gf.alpha", 0);
end

function createLetterboxing()

	makeLuaSprite('bartop','',0,-1000)
    makeGraphic('bartop',1900,1000,'000000')
    addLuaSprite('bartop',true)

    makeLuaSprite('barbot','',0,725)
    makeGraphic('barbot',1900,1000,'000000')
    addLuaSprite('barbot',true)

    setScrollFactor('bartop',0,0)
    setScrollFactor('barbot',0,0)
    setObjectCamera('bartop','hud')
    setObjectCamera('barbot','hud')

	setObjectOrder('bartop', getObjectOrder('bartop') - 12)
	setObjectOrder('barbot', getObjectOrder('barbot') - 12)

end
function onStepHit()
    if curStep == 68 then
        doTweenY('bartopY', 'bartop', -900, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 625, 0.35, 'circOut')
    end

    if curStep == 992 then
        doTweenY('bartopY', 'bartop', -850, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 550, 0.35, 'circOut')
    end


    if curStep == 1120 then
        doTweenY('bartopY', 'bartop', -900, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 625, 0.35, 'circOut')
    end



end

function onCreate()
    createLetterboxing()
end

local zoom = false;
local gohard = false;

local default = nil;

function onUpdate()

	if not mustHitSection and not zoom then
		zoom = not zoom;
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.05);
	elseif mustHitSection and zoom and not ending then
		zoom = not zoom;
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.05);
	end
	
	if curStep >= 992 and curStep <= 1120 and not gohard and not ending then
		gohard = true;
		default = getProperty("camGame.zoom");
		doTweenZoom("gofuckingoffTween", "camGame", default * 1.75, 12.4, "circIn");
	end
	
	if curStep >= 1376 and gohard then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.1);
		gohard = false;
	end
end

function onTweenCompleted(name)
	if name == "gofuckingoffTween" then
		doTweenZoom("gofuckingoffTween2", "camGame", default, 1, "circOut");
	end
end