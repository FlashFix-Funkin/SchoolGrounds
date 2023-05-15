package stages;

import flixel.FlxG;
import flixel.system.FlxSound;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween;
import flixel.FlxBasic;
import flixel.FlxSprite;
import StageData.StageFile;

class Station extends Stage {
    var directory:String = 'bgs/redline';

    var backColorSpr:FlxSprite;
    var train:BGSprite;
    var backBars:BGSprite;
    var groundBack:BGSprite;
    var groundFront:BGSprite;
    var pillars:BGSprite;
    var fgBars:BGSprite;
    var nebulaZorua:BGSprite;
    var signLeft:BGSprite;
    var signRight1:BGSprite;
    var signRight2:BGSprite;
    var lightsUpper:BGSprite;
    var lightMiddle:BGSprite;
    var lightLeft:BGSprite;
    var lightRight:BGSprite;
    var gradient:BGSprite;

    final globalScale:Float = 0.87;
    final POS_X:Float = -550;
    final POS_Y:Float = -310;

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    override function create() {
        backColorSpr = new FlxSprite(POS_X, POS_Y).makeGraphic(2800, 1575, 0xFF1e2025);

        train = new BGSprite('$directory/train_back', -4000, 400);
        train.scale.set(globalScale, globalScale);
        train.updateHitbox();
        
        backBars = new BGSprite('$directory/backBars', POS_X, POS_Y);
        backBars.scale.set(globalScale, globalScale);
        backBars.updateHitbox();
        
        groundBack = new BGSprite('$directory/groundBack', POS_X, POS_Y);
        groundBack.scale.set(globalScale, globalScale);
        groundBack.updateHitbox();
        
        groundFront = new BGSprite('$directory/groundFront', POS_X, POS_Y);
        groundFront.scale.set(globalScale, globalScale);
        groundFront.updateHitbox();

        pillars = new BGSprite('$directory/pillarsFront', POS_X, POS_Y);
        pillars.scale.set(globalScale, globalScale);
        pillars.updateHitbox();
        
        fgBars = new BGSprite('$directory/redLine', POS_X, POS_Y);
        fgBars.scale.set(globalScale, globalScale);
        fgBars.updateHitbox();
        
        nebulaZorua = new BGSprite('$directory/trashCan', POS_X, POS_Y);
        nebulaZorua.scale.set(globalScale, globalScale);
        nebulaZorua.updateHitbox();
        
        signLeft = new BGSprite('$directory/signLeft1', POS_X, POS_Y);
        signLeft.scale.set(globalScale, globalScale);
        signLeft.updateHitbox();
        
        signRight1 = new BGSprite('$directory/signRight1', POS_X, POS_Y);
        signRight1.scale.set(globalScale, globalScale);
        signRight1.updateHitbox();
        
        signRight2 = new BGSprite('$directory/signRight2', POS_X, POS_Y);
        signRight2.scale.set(globalScale, globalScale);
        signRight2.updateHitbox();

        lightsUpper = new BGSprite('$directory/lightsUpper', POS_X, POS_Y);
        lightsUpper.scale.set(globalScale, globalScale);
        lightsUpper.updateHitbox();
        
        lightMiddle = new BGSprite('$directory/lightMiddle', POS_X, POS_Y);
        lightMiddle.scale.set(globalScale, globalScale);
        lightMiddle.updateHitbox();
        
        lightLeft = new BGSprite('$directory/lightLeft', POS_X, POS_Y);
        lightLeft.scale.set(globalScale, globalScale);
        lightLeft.updateHitbox();
        
        lightRight = new BGSprite('$directory/lightRight', POS_X, POS_Y);
        lightRight.scale.set(globalScale, globalScale);
        lightRight.updateHitbox();
        
        gradient = new BGSprite('$directory/gradient', POS_X, POS_Y);
        gradient.scale.set(globalScale, globalScale);
        gradient.updateHitbox();
        
        lightMiddle.blend = BlendMode.ADD;
        lightMiddle.alpha = 0.1;
        lightLeft.blend = BlendMode.ADD;
        lightLeft.alpha = 0.1;
        lightRight.blend = BlendMode.ADD;
        lightRight.alpha = 0.1;
        //gradient.blend = BlendMode.DARKEN;
        gradient.alpha = 0.5;

        add(backColorSpr);
        add(backBars);
        add(groundBack);
        add(train);
        add(groundFront);
        add(pillars);
        add(signLeft);
        add(signRight1);
        add(signRight2);
        add(lightsUpper);
        trace('tesing 1 2 3');
        foregroundSprites = [lightMiddle, lightLeft, lightRight, nebulaZorua, fgBars, gradient];

        super.create();
    }

    override function beatHit(curBeat:Int) {
        if (curBeat == 118) {
            FlxG.sound.play(Paths.sound('trainSound', 'shared'));
        }
        else if (curBeat == 132)
            FlxTween.tween(train, {x: 3000}, 0.25, {
                onComplete: (twn:FlxTween) -> {
                    remove(train);
                    train.kill();
                }
            });
        super.beatHit(curBeat);
    }
}