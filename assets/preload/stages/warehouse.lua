function onCreatePost()
	-- background shit
	makeLuaSprite('BACKGROUND', 'HanzouStage/BACKGROUND', -400, -300);
	setScrollFactor('BACKGROUND', 1.1, 1.1);

	makeLuaSprite('FOREGROUND', 'HanzouStage/FOREGROUND', -1000, -325);

	makeLuaSprite('rubble', 'HanzouStage/front rubble', -450, 650);

	makeLuaSprite('lamp', 'HanzouStage/lamp', 900, -200);

	makeLuaSprite('lamplight', 'HanzouStage/LAMPLIGHT OVERLAY OVERLAY OVERLAY', -25, -100);
	setProperty('lamplight.alpha', 0.1)
	setBlendMode('lamplight', 'add')

	setProperty('gf.alpha', 0)

	addLuaSprite('BACKGROUND', false);
	addLuaSprite('FOREGROUND', false);
	addLuaSprite('lamplight', true);
	addLuaSprite('lamp', true);
	addLuaSprite('rubble', true);


	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end