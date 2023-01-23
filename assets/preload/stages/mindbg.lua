function onCreatePost()
	makeLuaSprite("sky", "bgs/mindbg/sky", -1400, -1100)
	setScrollFactor("sky", 0.1, 0.1)
	addLuaSprite("sky", false)

	makeLuaSprite("bgcity", "bgs/mindbg/bgcity", -470, 400)
	setScrollFactor("bgcity", 0.25, 0.25)
	addLuaSprite("bgcity", false)
    setProperty("bgcity.velocity.x", 10)

    local width = 0;
    for i = -1, 3 do
        makeLuaSprite("bgbuild"..i, "bgs/mindbg/bgbuild", -650 + i * width, 150)
        width = getProperty('bgbuild'..i..'.width')
        setScrollFactor("bgbuild"..i, 0.3, 0.5)
        addLuaSprite("bgbuild"..i, false)
    end

	makeLuaSprite("thing", "bgs/mindbg/thing", -300, 200)
	setScrollFactor("thing", 0.8, 0.8)
    --addLuaSprite("thing", false)

	makeLuaSprite("fog", "bgs/mindbg/fog", -450, -500)
	setScrollFactor("fog", 0.7, 0.7)
	addLuaSprite("fog", false)

	makeLuaSprite("train", "bgs/mindbg/train", -550, 1040)
	setScrollFactor("train", 0.97, 0.97)
	addLuaSprite("train", false)

	makeAnimatedLuaSprite("rain", "bgs/mindbg/rain", -480, 240)
	addAnimationByPrefix("rain", "rain", "rain", 24, true)
	addLuaSprite("rain", true)
	setBlendMode("rain", "add")
	playAnim("rain", "rain", true)
	setProperty('rain.alpha', 0.1)
	setProperty('rain.flipX', true)
	setScrollFactor("rain", 1.2, 1.2)

	makeLuaSprite("overlay", "bgs/mindbg/overlay", -600, -200)
	setBlendMode("overlay", "add")
	addLuaSprite("overlay", true)

	addHaxeLibrary('FlxCamera', 'flixel')
    addHaxeLibrary('FlxMath', 'flixel.math')
	addHaxeLibrary('Math')
	runHaxeCode([[
		var camFG;
		camFG = new FlxCamera();
		camFG.bgColor = 0x00000000;
		for (camera in FlxG.cameras.list) {
			FlxG.cameras.remove(camera, false);
		}

		FlxG.cameras.add(game.camGame);
		FlxG.cameras.add(camFG, false);
		FlxG.cameras.add(game.camOther, false);
		FlxG.cameras.add(game.camHUD, false);

		game.dad.cameras = [camFG];
		game.boyfriend.cameras = [camFG];
		for (item in [
			"train", "fog", "rain", "overlay"
		]) {
			game.getLuaObject(item).cameras = [camFG];
		}



		setVar('camFG', camFG);
		setVar('DAD_POS_X', game.dad.x);
		setVar('DAD_POS_Y', game.dad.y);
		setVar('BF_POS_X', game.boyfriend.x);
		setVar('BF_POS_Y', game.boyfriend.y);
        setVar('bgBuildOffset', game.getLuaObject("bgbuild0").x);
	]])
end

function onUpdatePost(elapsed)
	runHaxeCode([[
		var camFG = getVar('camFG');
		camFG.x = game.camGame.x;
		camFG.y = game.camGame.y;
		camFG.zoom = game.camGame.zoom;
		camFG.target = game.camGame.target;
		camFG.y = Math.sin(Conductor.songPosition / 10);

        for (i in -1...2) {
            var bgBuild = game.getLuaObject("bgbuild" + i);
            var width = bgBuild.width + 1300;
            bgBuild.x = getVar('bgBuildOffset') + FlxMath.lerp(-width, 0, (Conductor.songPosition / 1000) % 1) + (i * width);
        }

	]])
end


