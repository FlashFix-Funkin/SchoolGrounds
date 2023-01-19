local zoom = false;
local gohard = false;

local default = nil;

function onUpdate()
	
	if curStep >= 896 and curStep <= 1152 and not gohard and not ending then
		gohard = true;
		default = getProperty("camGame.zoom");
		doTweenZoom("gofuckingoffTween", "camGame", default * 1.25, 19.2, "circIn");
	end
end

function onTweenCompleted(name)
	if name == "gofuckingoffTween" then
		doTweenZoom("gofuckingoffTween2", "camGame", default, 1, "circOut");
	end
end