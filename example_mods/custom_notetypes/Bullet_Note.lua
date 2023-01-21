local inter = 0.025;
local hit = false;

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet_Note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Bullet_Note'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Bullet_Note' then
		if difficulty == 2 then
			playSound('hankshoot', 0.5);
		end
		
		playAnim('dad', 'shot', true);
		playAnim('boyfriend', 'Dodge', false);
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
		cameraShake('camGame', 0.01, 0.2);
		
		doTweenY('bartopY', 'bartop', -890, 0.15, 'circInOut') 
		doTweenY('barbotY', 'barbot', 615, 0.15, 'circInOut') 
		
		if curStep > 94 then
			setProperty("camera.zoom",getProperty("camera.zoom") + inter);
		else
			setProperty("camera.zoom",getProperty("camera.zoom") + inter * 0.5);
		end
    end
end


function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Bullet_Note' and difficulty == 2 then
		setProperty('health', -1);
	elseif noteType == 'Bullet_Note' and difficulty == 1 then
		setProperty('health', getProperty('health')-0.8);
	end
end