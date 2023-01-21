package ui;

import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.group.FlxGroup;

class HealthBar extends FlxTypedGroup<Dynamic> {

    private final defaults:Map<String, Dynamic> = [
        "BG_OFFSET" => 4,
        "BG_Y_MULT" => [0.11, 0.9],
        "HEALTH_CLAMP" => [0, 2]
    ];

    private var backgroundImage:AttachedSprite;
    private var healthBar:FlxBar;
    private var iconArray:Array<HealthIcon>;

    private var hasCustomColors:Bool = false;

    public override function new(downScroll:Bool = false, ?customColors:Bool = false, ?hideHUD:Bool = false) {
        this.hasCustomColors = customColors;

        // "PlayState.healthBarBG"
        backgroundImage = new AttachedSprite('healthBar');
        backgroundImage.y = FlxG.height * defaults["BG_Y_MULT"][downScroll ? 1 : 0];
        backgroundImage.screenCenter(X);
        backgroundImage.scrollFactor.set();
        backgroundImage.visible = !ClientPrefs.hideHud;
        backgroundImage.xAdd = backgroundImage.yAdd = -defaults["BG_OFFSET"];
        add(backgroundImage);

        // "PlayState.healthBar"
        var b = backgroundImage;
        healthBar = new FlxBar(
            b.x + defaults["BG_OFFSET"], // x
            b.y + defaults["BG_OFFSET"], // y
            RIGHT_TO_LEFT, // Fill Direction
            Std.int(b.width - (2 * defaults["BG_OFFSET"])), // Width
            Std.int(b.height - (2 * defaults["BG_OFFSET"])), // Height
            PlayState, "health", // Parent Field
            defaults["HEALTH_CLAMP"][0],  // Min
            defaults["HEALTH_CLAMP"][1] // Max
        );
        healthBar.scrollFactor.set();
        healthBar.visible = !ClientPrefs.hideHud;
        healthBar.alpha = ClientPrefs.healthBarAlpha;
        add(healthBar);

        b.sprTracker = healthBar;

        super();
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
    }
}