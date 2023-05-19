package stages;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.group.FlxSpriteGroup;
import StageData.StageFile;

using Lambda;

class Train extends Stage {
    var directory:String = 'bgs/mindbg';

    var sky:BGSprite;
    var bgCity:BGSprite;
    var closerBuildings:Array<BGSprite> = [];
    var thing:BGSprite; // why it's named this i will never know.
    var fog:BGSprite;
    var train:BGSprite;
    var rain:BGSprite;
    var overlay:BGSprite;

    var shakeSprs:FlxSpriteGroup;
    
    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    
    var buildingOffset:Float = 0;
    override function create() {
        shakeSprs = new FlxSpriteGroup();

        sky = new BGSprite('$directory/sky', -1400, -1100, 0.1, 0.1);

        bgCity = new BGSprite('$directory/bgcity', -470, 400, 0.25, 0.25);
        bgCity.velocity.x = 10;

        var width:Float = 0;
        for (i in -1...2) {
            var bgBuild = new BGSprite('$directory/bgbuild', -650 + i * width, 150, 0.3, 0.5);
            bgBuild.ID = i;
            width = bgBuild.width;
            closerBuildings.push(bgBuild);
        }
        buildingOffset = closerBuildings[0].x;

        fog = new BGSprite('$directory/fog', -450, -500, 0.7, 0.7);

        train = new BGSprite('$directory/train', -550, 1040, 0.97, 0.97);

        rain = new BGSprite('$directory/rain', -480, 240, 1.2, 1.2, ['rain'], true);
        rain.blend = ADD;
        rain.alpha = 0.1;
        rain.flipX = true;
        foregroundSprites.push(rain);

        overlay = new BGSprite('$directory/overlay', -600, -200);
        overlay.blend = ADD;
        foregroundSprites.push(overlay);

        add(sky);
        add(bgCity);
        add(fog);
        closerBuildings.iter((spr:BGSprite) -> {
            add(spr);
        });
        
        super.create();
        remove(dadGroup);
        remove(boyfriendGroup);
        add(shakeSprs);
        shakeSprs.add(train);
        shakeSprs.add(dadGroup);
        shakeSprs.add(boyfriendGroup);
    }
    override function update(elapsed:Float) {
        for (spr in closerBuildings) {
            var w = spr.width + 1300;
            spr.x = buildingOffset + FlxMath.lerp(-w, 0, (Conductor.songPosition / 1000) % 1) + (spr.ID * w);
        }
        shakeSprs.y = Math.sin(Conductor.songPosition / 10);
        super.update(elapsed);

    }
}