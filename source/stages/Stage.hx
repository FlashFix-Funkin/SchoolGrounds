package stages;

import FunkinLua.ModchartSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxBasic;
import StageData.StageFile;
import flixel.group.FlxGroup.FlxTypedGroup;

using Lambda;
class Stage extends FlxTypedGroup<FlxBasic> {
    public final DEFAULT_CAM_ZOOM:Float;
    public final IS_PIXEL_STAGE:Bool;

    public final BOYFRIEND:Array<Dynamic>;
    public final GIRLFRIEND:Array<Dynamic>;
    public final OPPONENT:Array<Dynamic>;

    public final HIDE_GIRLFRIEND:Bool;

    public final CAMERA_BOYFRIEND:Array<Float>;
    public final CAMERA_GIRLFRIEND:Array<Float>;
    public final CAMERA_OPPONENT:Array<Float>;
    public final CAMERA_SPEED:Float;

    public final LETTERBOXXING:Bool;

    public var foregroundSprites:Array<BGSprite> = [];
    public var infrontOfGirlfriendSprites:Array<BGSprite> = [];

    public var introSequence:Null<()->Void>;

    private var boyfriendGroup(get, never):FlxSpriteGroup;
    private var dadGroup(get, never):FlxSpriteGroup;
    private var gfGroup(get, never):FlxSpriteGroup;

    
    private var _dummy:FlxBasic;

    private function get_boyfriendGroup() {
        return PlayState.instance.boyfriendGroup ?? new FlxSpriteGroup(BOYFRIEND[0], BOYFRIEND[1]);
    }
    private function get_dadGroup() {
        return PlayState.instance.dadGroup ?? new FlxSpriteGroup(OPPONENT[0], OPPONENT[1]);
    }
    private function get_gfGroup() {
        return PlayState.instance.gfGroup ?? new FlxSpriteGroup(GIRLFRIEND[0], GIRLFRIEND[1]);
    }

    public function new(stageFile:StageFile) {
        super();

        this.DEFAULT_CAM_ZOOM = stageFile.defaultZoom;
        this.IS_PIXEL_STAGE = stageFile.isPixelStage;

        this.BOYFRIEND = stageFile.boyfriend;
        this.GIRLFRIEND = stageFile.girlfriend;
        this.OPPONENT = stageFile.opponent;
        this.HIDE_GIRLFRIEND = stageFile.hide_girlfriend;

        this.CAMERA_BOYFRIEND = stageFile.camera_boyfriend ?? [0, 0];
        this.CAMERA_GIRLFRIEND = stageFile.camera_girlfriend ?? [0, 0];
        this.CAMERA_OPPONENT = stageFile.camera_opponent ?? [0, 0];
        this.CAMERA_SPEED = stageFile.camera_speed ?? 1.0;

        this.LETTERBOXXING = stageFile.letterboxxing ?? ClientPrefs.letterboxxing;
        
        _dummy = new FlxBasic();
        create();
    }

    /**
     * Generates the stage objects after all initilizaiton has been completed. Anything called after `super.create()` will be placed in the foreground.
     */
    function create() {
        // Decided to move this here because i can lol
        add(gfGroup);
        infrontOfGirlfriendSprites.iter((spr:BGSprite) -> {
            add(spr);
        });
        add(dadGroup);
        add(boyfriendGroup);
        add(_dummy);
        foregroundSprites.iter((spr:BGSprite) -> {
            add(spr);
        });
    }
    override function update(elapsed:Float) { 
        super.update(elapsed); 
    }
    public function stepHit(curStep:Int) {}
    public function beatHit(curBeat:Int) {}
    public function sectionHit(curSection:Int, ?mustHitSection:Bool) {}
    
    public function addModchartSprite(sprite:ModchartSprite, foreground:Bool) {
        var position:Int;
        if (foreground)
            position = members.indexOf(_dummy)+1;
        else {
            position = members.indexOf(gfGroup);
            if (members.indexOf(boyfriendGroup) < position)
                position = members.indexOf(boyfriendGroup);
            else if (members.indexOf(dadGroup) < position)
                position = members.indexOf(dadGroup);
        }
        insert(position, sprite);
    }
}