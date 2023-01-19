local directory = "bgs/redline/"

local xtimer = 0;
local fps = 60
local trainTime = 23 * fps;

function Train()
	makeLuaSprite('train', directory..'train', 2000, 75);
	scaleObject('train', 1.5, 1.5);
	setScrollFactor('train', 1, 1);
	setProperty('train.antialiasing', true);
	setObjectOrder('train', 1);
	addLuaSprite('train', false);
	
	makeLuaSprite('train2', directory..'train', 2000 + (getProperty('train.width') / 2), 75);
	scaleObject('train2', 1.5, 1.5);
	setScrollFactor('train2', 1, 1);
	setProperty('train2.antialiasing', true);
	setObjectOrder('train2', 1);
	addLuaSprite('train2', false);
	
	makeLuaSprite('train3', directory..'train', 2000 + (getProperty('train.width')), 75);
	scaleObject('train3', 1.5, 1.5);
	setScrollFactor('train3', 1, 1);
	setProperty('train3.antialiasing', true);
	setObjectOrder('train3', 1);
	addLuaSprite('train3', false);
	
	doTweenX('train', 'train', -10000, 1, 'linear');
	doTweenX('train2', 'train2', -10000 + (getProperty('train.width') / 2), 1, 'linear');
	doTweenX('train3', 'train3', -10000 + (getProperty('train.width')), 1, 'linear');
end

function onUpdate()
	
	xtimer = xtimer + 1 
	if xtimer >= trainTime then
		xtimer = 0
		playSound('train_passes', 1);
		runTimer('trainTimer', 4.5);
	end
	
end

function onTimerCompleted(name)
	if name == "trainTimer" then
		Train();
	end
end

function onTweenCompleted(name)
	if name == "train" then
		removeLuaSprite('train');
	end
	if name == "train2" then
		removeLuaSprite('train2');
	end
	if name == "train3" then
		removeLuaSprite('train3');
	end
end

function onCreate()
	makeLuaSprite('back_thing', directory..'back_thing', -959, -408);
	scaleObject('back_thing', 1, 1);
	setScrollFactor('back_thing', 0.8, 0.8);
	setProperty('back_thing.antialiasing', true);
	setObjectOrder('back_thing', 0);
	addLuaSprite('back_thing', false);

	makeLuaSprite('front_piece', directory..'front_piece', -790, -426);
	scaleObject('front_piece', 1, 1);
	setScrollFactor('front_piece', 1, 1);
	setProperty('front_piece.antialiasing', true);
	setObjectOrder('front_piece', 2);
	addLuaSprite('front_piece', false);

	setScrollFactor('gfGroup', 1, 1);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 3);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 4);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 5);

	makeLuaSprite('lightred', directory..'lightred', -233, -403);
	scaleObject('lightred', 1, 1);
	setScrollFactor('lightred', 1.15, 1.15);
	setProperty('lightred.antialiasing', true);
	setObjectOrder('lightred', 6);
	addLuaSprite('lightred', true);

	makeLuaSprite('bags', directory..'bags', -968, 473);
	scaleObject('bags', 1, 1);
	setScrollFactor('bags', 1.35, 1.35);
	setProperty('bags.antialiasing', true);
	setObjectOrder('bags', 7);
	addLuaSprite('bags', true);
end