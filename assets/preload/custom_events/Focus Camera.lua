local hardFocus = false;
local focusChar = 'boyfriend';

function onEvent(eventName, value1,value2)
	if eventName == 'Focus Camera' then
		if tostring(value1) == 'BF' then
			cameraSetTarget('boyfriend');
			focusChar = 'boyfriend';
			
		elseif tostring(value1) == 'Opponent' then
			cameraSetTarget('dad');
			focusChar = 'dad';
			
		elseif tostring(value1) == 'GF' then
			cameraSetTarget('gf');
			focusChar = 'gf';
		end
		
		if tostring(value2) == 'True' or tostring(value2) == 'true' then
			hardFocus = true;
		end
		
		if tostring(value2) == '' or tostring(value2) == nil then
			hardFocus = false;
		end
	end
end

function onSectionHit()
	if hardFocus then 
		cameraSetTarget(focusChar)
	end
end