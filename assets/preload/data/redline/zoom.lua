local zoom = false;
local add = 0.05

local default = nil;

function onUpdate()

	if not mustHitSection and not zoom then
		zoom = not zoom;
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + add);
	elseif mustHitSection and zoom and not ending then
		zoom = not zoom;
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - add);
	end
	
	if (curStep > 528 and curStep < 592) or (curStep > 656 and curStep < 720) then
		add = 0.1
	elseif (curStep > 592 and curStep < 656) or (curStep > 720 and curStep < 784) then
		add = 0.05
	end
end