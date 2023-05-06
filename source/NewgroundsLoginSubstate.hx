import io.newgrounds.NGLite.LoginOutcome;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;

class NewgroundsLoginSubstate extends MusicBeatSubstate {
    public function new() {
        NGio.newgroundsLogin();
        super();
    }
    override function create() {
        var bg:FlxSprite = new FlxSprite().makeGraphic(1280, 720, 0xBB000000);
        bg.scale.set(0.9, 0.9);
        bg.updateHitbox();
        bg.screenCenter(XY);
        add(bg);

        var heading:FlxText = new FlxText(0, FlxG.height * 0.4, 0, "[CHECK YOUR BROWSER.]",12);
        heading.setFormat(Paths.font("Helvetica.ttf"), 55, 0xFFFFFFFF);
        heading.screenCenter(X);
        add(heading);
        super.create();
    }
    override function update(elapsed:Float) {

        super.update(elapsed);

        if (NGio.active) {
            close();
        }
    }
}