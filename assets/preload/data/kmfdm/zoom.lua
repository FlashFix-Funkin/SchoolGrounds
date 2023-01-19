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