package;

import flixel.FlxG;
import haxe.io.Bytes;
import openfl.display.BitmapData;
import flixel.FlxSprite;
import io.newgrounds.components.MedalComponent;
import io.newgrounds.utils.MedalList.ExternalMedalList;
import io.newgrounds.utils.MedalList.ExternalMedal;
import io.newgrounds.NGLite.LoginOutcome;
import io.newgrounds.NG;

class NGio {
    public static var active:Bool = false;
    public static var username:Null<String>;
    public static var isSupporter:Bool = false;

    public static function newgroundsLogin( ?onComplete:( outcome : LoginOutcome ) -> Void ):Void {
        NG.create();
        NG.core.requestLogin((cb : LoginOutcome) -> {
            switch (cb) {
                case SUCCESS:
                    NGio.username = NG.core.user.name;
                    NGio.isSupporter = NG.core.user.supporter;
                default:
                    // ... thing fucking fucked

            }
            active = cb == SUCCESS;
            if (onComplete != null)
                onComplete(cb);
            // ...
        });
    }

    public static function getUserIcon(x:Float, y:Float):FlxSprite {
        var icon:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.urlImage(NG.core.user.icons.large));
        return icon;
    }
}