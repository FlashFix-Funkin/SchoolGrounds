import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Notification extends FlxObject {
    private static var _notifCount:Int = 0;

    var blackBar:FlxSprite;
    var notifText:FlxText;

    public function new(message:String, state:MusicBeatState) {
        blackBar = new FlxSprite(0, 30 * (_notifCount - 1) ).makeGraphic(FlxG.width, 30, 0x99000000);
        state.add(blackBar);

        notifText = new FlxText(0, -33, 0, message, 12);
        notifText.setFormat(Paths.font('Helvetica.ttf'), 24, FlxColor.WHITE);
        state.add(notifText);

        var twnOptn:TweenOptions = {
            ease: FlxEase.circOut,
            onComplete: (_:FlxTween) -> {
                new FlxTimer().start(3.0, (_)-> {
                    FlxTween.tween(
                        blackBar, { alpha : 0 }, 0.77, {
                            onComplete: (_:FlxTween) -> {
                                state.remove(blackBar);
                                blackBar.destroy();
                                _notifCount--;
                            }
                        }
                    );
                    FlxTween.tween(
                        notifText, { alpha: 0 }, 0.77, {
                            onComplete: (_:FlxTween) -> {
                                state.remove(notifText);
                                notifText.destroy();
                            }
                        }
                    );
                });
            }
        }

        FlxTween.tween( blackBar, { y: 30 * _notifCount }, 0.55, twnOptn );
        FlxTween.tween( notifText, { y: 30 * _notifCount }, 0.55, {});
        super();
        _notifCount++;
    }

    override function update(elapsed:Float) {
        notifText.y = blackBar.y + 2;
        super.update(elapsed);
    }
}