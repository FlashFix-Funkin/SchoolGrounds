package stages;

import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import StageData.StageFile;

class Hallway extends Stage {
    var directory:String = 'bgs/hall-pass';
    
    private final characters:Array<Dynamic> = [
        ['cassandra', 200], ['hanzo', 300], ['pierre', 300], ['spike', 150]
    ];
    var tween:Null<FlxTween> = null;
    var bgChars:Array<BGSprite> = [];
    var bgScroll:Array<BGSprite> = [];

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }

    var width:Float = 0;
    var initOffset:Float = 0;
    override function create() {
        for (i in 0...2) {
            var bg:BGSprite = new BGSprite('$directory/background', width * i, 0);
            bg.setGraphicSize(Std.int(bg.width * 0.85));
            bg.updateHitbox();
            width = bg.width;
            bgScroll.push(bg);
            add(bg);
        }
        initOffset = bgScroll[0].x;
        for (i => obj in characters) {
            var char:BGSprite = new BGSprite('$directory/Characters/${obj[0]}', 1700, obj[1]);
            char.ID = i;
            bgChars.push(char);
            add(char);
        }
        super.create();
        PlayState.instance.letterboxxing = true; //gotta force this one sorry;
    }
    override function update(elapsed:Float) {
        for (i => spr in bgScroll) {
            spr.x = FlxMath.lerp(0, -width, (Conductor.songPosition / 37500) % 1) + (i * width) - 1200;
        }
        for (spr in bgChars) {
            spr.y = FlxMath.lerp(spr.y, characters[spr.ID][1], CoolUtil.boundTo(elapsed * 5.6, 0, 1));
            if (spr.x <= -750) {
                bgChars.remove(spr);
                remove(spr);
                spr.kill();
            }
        }

        if (tween != null) tween.active = !PlayState.instance.paused;
        super.update(elapsed);
    }
    public override function beatHit(curBeat:Int) {
        if (curBeat % 2 == 0) {
            for (spr in bgChars) spr.y += 10;
        }
        if (FlxG.random.bool(0.013 * curBeat) && tween == null && bgChars.length > 0) {
            tween = FlxTween.tween(bgChars[0], {
                x: -750
            }, FlxG.random.float(8.5, 10), {onComplete: (twn:FlxTween) -> {tween = null;}});
        }
        super.beatHit(curBeat);
    }
}