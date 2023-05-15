package stages;

import flixel.FlxBasic;
import StageData.StageFile;
import flixel.group.FlxGroup.FlxTypedGroup;

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

        create();
    }

    function create() {}
    override function update(elapsed:Float) { 
        super.update(elapsed); 
    }
    public function stepHit(curStep:Int) {}
    public function beatHit(curBeat:Int) {}
}