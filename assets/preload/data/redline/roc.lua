--Xtra Opponent Script 3.0
--Script made by: JasonTheOne111
--[[
How to Install Script:  
    Download Psych Engine, Open "mods" folder, put this script in either "mods/scripts" or "mods/data/songName/"
]]
--Base character stuff
local path = "characters/roc" --Add path to spritesheet and xml, good: characters/name, bad: mods/images/characters
local defaultPosition = {1550, 550}
--local defx = 0 --X position of the character
--local defy = 0 --Y position of the character
local singDuration = 0.4 --Insert how long you want the character to sing. Default: 0.4 (seconds)
local opponentScale = 1 --Scale of the opponent, default: 1
local animationFPS = 24 --Add the framerate (fps) of all the animation ex: 25, default: 24 fps
local overlapping = true --True for this opponent to go Over the base characters, False for it to go under the base characters
local looping = false --True for all animations to loop, False for all animations to play once
local hasMissAnimations = false --If the character has miss animations, set this to true
local flipx = false --If the character's X is flipped, set this value to true
local flipy = false --If the character's Y is flipped, set this value to true
local opponentAngle = 0 --Put the angle/rotation of the opponent here, leave as 0 for default
local opponentAlpha = 1 --Put the transparency of the new opponent (1 being fully visible, 0 being invisible)
--Names
local opponentName = "roc" --Add the name of your character here (optional unless more that one xtra opponent)
local idleName = "idle" --Add the name of the idle position in the xml file
local leftName = "left" --Add the name of the left position in the xml file
local downName = "down" --Add the name of the down position in the xml file
local upName = "up" --Add the name of the up position in the xml file
local rightName = "right" --Add the name of the right position in the xml file

local leftMissName = "Add Left Miss Name In Xml Here" --Add the name of the left miss position in the xml file
local downMissName = "Add Down Miss Name In Xml Here" --Add the name of the down miss position in the xml file
local upMissName = "Add Up Miss Name In Xml Here" --Add the name of the up miss position in the xml file
local rightMissName = "Add Right Miss Name In Xml Here" --Add the name of the right miss position in the xml file
local noteTypeName = "No Animation" --Add the name of the custom notetype that you want to use to make the new opponent sing, leave blank for normal note
--Offsets, All defaults are 0
--First Value is "X", Second Value is "Y".
local idleOffsets = {0, -10}
local leftOffsets = {-16, -10}
local downOffsets = {-9, 18}
local upOffsets = {8, -27}
local rightOffsets = {24, -3}

local leftMissOffsets = {0, 0}
local downMissOffsets = {0, 0}
local upMissOffsets = {0, 0}
local rightMissOffsets = {0, 0}
--Don't touch anything after this point



function onCreate()
    --When the song starts loading??? I don't fucking know
    makeCharacter()
end

function onCountdownTick(tick)
    if tick % 2 == 0 then
        playAnim('roc', 'idle', true) 
    end
end

























































































































function makeCharacter()
    --This code could technically go under "function onCreate()" but nah
    animSprite(opponentName, 'idle', idleName, path, defaultPosition[1], defaultPosition[2], 24, looping, overlapping, opponentScale, flipx)
    addAnimationByPrefix(opponentName, '0', leftName .. '0', animationFPS, looping)
    addAnimationByPrefix(opponentName, '1', downName .. '0', animationFPS, looping)
    addAnimationByPrefix(opponentName, '2', upName .. '0', animationFPS, looping)
    addAnimationByPrefix(opponentName, '3', rightName .. '0', animationFPS, looping)
    addOffset(opponentName, 'idle', -idleOffsets[1], -idleOffsets[2])
    addOffset(opponentName, '0', -leftOffsets[1], -leftOffsets[2])
    addOffset(opponentName, '1', -downOffsets[1], -downOffsets[2])
    addOffset(opponentName, '2', -upOffsets[1], -upOffsets[2])
    addOffset(opponentName, '3', -rightOffsets[1], -rightOffsets[2])
    if hasMissAnimations then
        addAnimationByPrefix(opponentName, '0miss', leftMissName .. '0', animationFPS, looping)
        addAnimationByPrefix(opponentName, '1miss', downMissName .. '0', animationFPS, looping)
        addAnimationByPrefix(opponentName, '2miss', upMissName .. '0', animationFPS, looping)
        addAnimationByPrefix(opponentName, '3miss', rightMissName .. '0', animationFPS, looping)
        addOffset(opponentName, '0miss', leftMissOffsets[1], leftMissOffsets[2])
        addOffset(opponentName, '1miss', downMissOffsets[1], downMissOffsets[2])
        addOffset(opponentName, '2miss', upMissOffsets[1], upMissOffsets[2])
        addOffset(opponentName, '3miss', rightMissOffsets[1], rightMissOffsets[2])
    end
end
function animSprite(tag, anim, animxml, path, pos1, pos2, fps, loop, over, scale, flipxs)
    --I was too lazy to type all this shit out more than once, so i made it a function
    makeAnimatedLuaSprite(tag, path, pos1, pos2)
    addAnimationByPrefix(tag, anim, animxml, fps, loop)
    addLuaSprite(tag, over)
    scaleObject(tag,scale,scale)
    setProperty(tag .. '.x', defaultPosition[1]+idleOffsets[1])
    setProperty(tag .. '.y', defaultPosition[2]+idleOffsets[2])
    setProperty(tag .. '.flipX', flipxs)
    setProperty(tag .. '.flipY', flipy)
    setProperty(tag .. '.angle', opponentAngle)
    setProperty(tag .. '.alpha', opponentAlpha)
end
function onBeatHit()
    --If you know what this function does, then great. If not, thats a you problem
    if curBeat %2 == 0 then
        if looping == false then
            if getProperty(opponentName .. '.animation.curAnim.name') == "idle" then
                playAnim(opponentName , 'idle')
            end
        end
    end
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
    --Used when the opponent hits a note, duh
    -- left = 0, down = 1, up = 2, right = 3
    if noteType == noteTypeName then
        playAnim(opponentName, direction, not isSustainNote)
        runTimer('idle'.. opponentName .. direction, singDuration)
    end
end

function onTimerCompleted(tag)
    --This is the thing that is called when you use "runTimer('fuckoff', timerTime)"
    if tag == "idle" .. opponentName .."0" then
        if getProperty(opponentName .. '.animation.curAnim.name') == "0" or getProperty(opponentName .. '.animation.curAnim.name') == "0miss" then
            playAnim(opponentName , 'idle')
        end
    end
    if tag == "idle" .. opponentName .."1" then
        if getProperty(opponentName .. '.animation.curAnim.name') == "1" or getProperty(opponentName .. '.animation.curAnim.name') == "1miss" then
            playAnim(opponentName , 'idle')
        end
    end
    if tag == "idle" .. opponentName .."2" then
        if getProperty(opponentName .. '.animation.curAnim.name') == "2" or getProperty(opponentName .. '.animation.curAnim.name') == "2miss" then
            playAnim(opponentName , 'idle')
        end
    end
    if tag == "idle" .. opponentName .."3" then
        if getProperty(opponentName .. '.animation.curAnim.name') == "3" or getProperty(opponentName .. '.animation.curAnim.name') == "3miss" then
            playAnim(opponentName , 'idle')
        end
    end
end
