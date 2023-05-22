package stages;

import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import StageData.StageFile;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Classroom extends Stage {
    var directory:String = 'bgs/cass';

    var sky:BGSprite;
    var bgg:BGSprite;
    var bg:BGSprite;
    var blood:BGSprite;
    var teacher:BGSprite;
    var desk:BGSprite;
    var overlay:Null<BGSprite>;

    public var bell:BGSprite;

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    override function create() {
        sky = new BGSprite('$directory/sky', -1400, -170, 0.5, 0.5);
        bgg = new BGSprite('$directory/bgg',-1000, 100, 0.8, 0.8);
        bg = new BGSprite('$directory/bg', -700, -70, 0.97, 0.97);
        bell = new BGSprite('$directory/bell', 856, 188, 0.97, 0.97, ['idle', 'ringing'], true);
        blood = new BGSprite('$directory/blood', 1206, 555, 0.97, 0.97);
        blood.blend = MULTIPLY;
        teacher = new BGSprite('$directory/teacher', 1315, 676, 0.97, 0.97);
        desk = new BGSprite('$directory/desk', -900, 1300, 1.2, 1.2);
        if (!ClientPrefs.lowQuality) {
            overlay = new BGSprite('$directory/overlay', -800, -200);
            overlay.blend = ADD;
        }

        add(sky);
        add(bgg);
        add(bg);
        add(blood);
        add(teacher);
        add(bell);
        foregroundSprites.push(desk);
        if (overlay != null) foregroundSprites.push(overlay);

        comboPosition = new FlxObject(175, 350);

        super.create();
        PlayState.instance.letterboxxing = true; //gotta force this one sorry;
    }

    override function update(elapsed:Float) {
        switch (bell.animation.curAnim.name) {
            case 'ringing':
                bell.offset.x = 26;
            default:
                bell.offset.x = 0;
        }
        super.update(elapsed);
    }
}