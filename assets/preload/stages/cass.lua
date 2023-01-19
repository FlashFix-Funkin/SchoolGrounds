local directory = "bgs/cass"

function onCreatePost()
	makeLuaSprite("sky", directory.."sky", -1400, -170)
	setScrollFactor("sky", 0.5, 0.5)
	addLuaSprite("sky", false)

	makeLuaSprite("bgg", directory.."bgg", -1000, 100)
	setScrollFactor("bgg", 0.8, 0.8)
	addLuaSprite("bgg", false)

	makeLuaSprite("bg", directory.."bg", -700, -70)
	setScrollFactor("bg", 0.97, 0.97)
	addLuaSprite("bg", false)

	makeLuaSprite("desk", directory.."desk", -900, 1300)
	setScrollFactor("desk", 1.2, 1.2)
	addLuaSprite("desk", true)

	makeLuaSprite("overlay", directory.."overlay", -800, -200)
	setBlendMode("overlay", "add")
	addLuaSprite("overlay", true)

end
