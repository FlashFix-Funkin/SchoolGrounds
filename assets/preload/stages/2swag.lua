local directory = "bgs/2swag/"

function onCreatePost()
	makeLuaSprite("bgg", directory.."bgg", -200, -160)
	setScrollFactor("bgg", 0.9, 0.9)
	addLuaSprite("bgg", false)

	makeLuaSprite("bg", directory.."bg", -1300, -100)
	setScrollFactor("bg", 0.97, 0.97)
	addLuaSprite("bg", false)

		makeAnimatedLuaSprite("people", directory.."people", 220, 660)
	addAnimationByPrefix("people", "people", "people", 24, true)
	addLuaSprite("people", false)
	playAnim("people", "people", true)
	setScrollFactor("people", 0.97, 0.97)

			makeAnimatedLuaSprite("bf", directory.."bf", 770, 688)
		addAnimationByPrefix("bf", "bf", "bf", 24, false)
		setScrollFactor("bf", 0.95, 0.95)
		addLuaSprite("bf", false)

			makeLuaSprite("table", directory.."table", 200, 810)
	setScrollFactor("table", 0.97, 0.97)
	addLuaSprite("table", false)

	makeLuaSprite("overlay", directory.."overlay", -800, -300)
	setBlendMode("overlay", "add")
	addLuaSprite("overlay", true)

end

	function onBeatHit()
		if curBeat % 2 == 0 then
			playAnim("bf", "bf", true)
		end
	end