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

using DateTools;

class NGio {
    public static var sessionData:NewgroundsSessionData;
    public static var active:Bool = false;

    public static function newgroundsLogin( ?onComplete:( outcome : LoginOutcome ) -> Void ):Void {
	    NG.create();
        NG.core.requestLogin((cb : LoginOutcome) -> {
            switch (cb) {
                case SUCCESS:
                    NGio.sessionData = {
                        sessionDate: Date.now(),
                        sessionID: NG.core.sessionId,
                        userData: {
                            name: NG.core.user.name,
                            isSupporter: NG.core.user.supporter
                        }
                    };
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

typedef NewgroundsSessionData = {
    sessionDate : Date,
    sessionID : String,
    userData : { name : String, isSupporter : Bool }
}