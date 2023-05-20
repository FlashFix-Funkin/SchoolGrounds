package stages;

import flixel.FlxG;
import flixel.system.FlxSound;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween;
import flixel.FlxBasic;
import flixel.FlxSprite;
import StageData.StageFile;

class Warehouse extends Stage {

    var directory:String = 'bgs/HanzouStage';

    var BACKGROUND:BGSprite;
    var FOREGROUND:BGSprite;
    var rubble:BGSprite;
    var lamp:BGSprite;
    var lampoverlay:BGSprite;

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    override function create(){

        BACKGROUND = new BGSprite('$directory/BACKGROUND', -400, -300, 1.25, 1.25);
        BACKGROUND.updateHitbox();

        FOREGROUND = new BGSprite('$directory/FOREGROUND', -1000,-325);
        FOREGROUND.updateHitbox();

        rubble = new BGSprite('$directory/rubble', -450,550,0.75,0.75);
        rubble.updateHitbox();

        lamp = new BGSprite('$directory/lamp',900,-200);
        lamp.updateHitbox();

        lampoverlay = new BGSprite('$directory/lampoverlay',-25,-100);
        lampoverlay.blend = BlendMode.ADD;
        lampoverlay.alpha = 0.1;
        lampoverlay.updateHitbox();


        add(BACKGROUND);
        add(FOREGROUND);
        foregroundSprites = [rubble, lampoverlay, lamp];

        super.create();

        gfGroup.alpha = 0;
    }
}
