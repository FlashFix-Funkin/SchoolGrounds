package stages;

import StageData.StageFile;

class Classroom extends Stage {
    var directory:String = 'bgs/cass';

    var sky:BGSprite;
    var bgg:BGSprite;
    var bg:BGSprite;
    var desk:BGSprite;
    var overlay:Null<BGSprite>;

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    override function create() {
        sky = new BGSprite('$directory/sky', -1400, -170, 0.5, 0.5);
        bgg = new BGSprite('$directory/bgg',-1000, 100, 0.8, 0.8);
        bg = new BGSprite('$directory/bg', -700, -70, 0.97, 0.97);
        desk = new BGSprite('$directory/desk', -900, 1300, 1.2, 1.2);
        if (!ClientPrefs.lowQuality) {
            overlay = new BGSprite('$directory/overlay', -800, -200);
            overlay.blend = ADD;
        }

        add(sky);
        add(bgg);
        add(bg);
        foregroundSprites.push(desk);
        if (overlay != null) foregroundSprites.push(overlay);
        super.create();
    }
}