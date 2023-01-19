local curCharacters_OnScreen = {} -- Will host all characters and allow for proper and easy communication between all individual sprites on screen
local curCharacters_InDirectory = { -- Will host all characters in the Characters directory
	"pierre";
	"cassandra";
	"spike";
	"hanzo";
}
local curCharacter_YOffsets = {
	300;
	200;
	150;
	300;
}


local directory = "weeks/hall-pass/Characters/"

local prev_CharacterAdded;

local relative_x = 0 -- Counter
local x_timer_Min = 1 -- Minimum time for a character to spawn
local x_timer_Max = 25 -- Maximum time for a character to spawn

math.randomseed(os.time())
local rand_interval = math.random(x_timer_Min*60, x_timer_Max*60)

function onCreate() -- Precache everything in Directory and Set Up CurCharacter_Counter
	for i = 1,#curCharacters_InDirectory do
		precacheImage(directory..curCharacters_InDirectory[i])
	end
end

function Create(array)
	local pseudo = {}
	for i = 1,#array do 
		table.insert(pseudo, curCharacters_InDirectory[i])
	end
	
	if #pseudo <= 0 then return "null" end

	local rand = math.random(1,#pseudo)
	debugPrint(curCharacters_OnScreen)

	for i,v in pairs(curCharacters_OnScreen) do
		if v == pseudo[rand] or pseudo[rand] == prev_CharacterAdded then
			table.remove(pseudo, rand)
			return Create(pseudo);
		end
	end
	
	return pseudo[rand]
end

function onUpdate() -- Callback for Random Interval for if and when a character should be created on screen
	relative_x = relative_x + 1
	if (relative_x >= x_timer_Min*60 and relative_x <= x_timer_Max*60) then
		if relative_x == rand_interval then
			rand_interval = math.random(x_timer_Min*60, x_timer_Max*60)
		
			relative_x = 0	
			local Available_Sprite = Create(curCharacters_InDirectory)
			
			if Available_Sprite ~= "null" then
				local offset = nil;
				for i,v in pairs(curCharacters_InDirectory) do
					if v == Available_Sprite then offset = curCharacter_YOffsets[i] end
				end
			
				for i,v in pairs(curCharacters_OnScreen) do
					if v == Available_Sprite then return end
				end
				
				prev_CharacterAdded = Available_Sprite
			
				table.insert(curCharacters_OnScreen, Available_Sprite)
				makeLuaSprite(Available_Sprite, directory..Available_Sprite, 1700, offset)
				
				addLuaSprite(Available_Sprite, false)
				doTweenX(Available_Sprite.."X_Move", Available_Sprite, -750, math.random(10,13), "linear")
			end
		end
	end
end

function onBeatHit() -- Callback for the Walking Effect on all individual sprites on screen
	if curBeat % 2 == 0 then
		for i,v in ipairs(curCharacters_OnScreen) do
			doTweenY(v.."walk", v, getProperty(v..".y") + 10, 0.01, "circOut")
		end
	end
end

function onTweenCompleted(name) -- Callback for Walking Effect and Deletion of a character on screen
	for i,v in ipairs(curCharacters_OnScreen) do
		if name == v.."X_Move" then
			table.remove(curCharacters_OnScreen, i)
			removeLuaSprite(v)
		end
		if name == v.."walk" then
			doTweenY(v.."walkEnd", v, getProperty(v..".y") - 10, 0.5, "circOut")
		end
	end
end