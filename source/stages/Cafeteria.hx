package stages;

import StageData.StageFile;

class Cafeteria extends Stage {
    var directory:String = 'bgs/2swag';

    var farBG:BGSprite;
    var bg:BGSprite;
    var people:Null<BGSprite>;
    var bf:Null<BGSprite>;
    var table:BGSprite;
    var overlay:Null<BGSprite>;

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    override function create() {
        farBG = new BGSprite('$directory/bgg', -200, -160, 0.9, 0.9);
        bg = new BGSprite('$directory/bg', -1300, -100, 0.97, 0.97);
        table = new BGSprite('$directory/table', 200, 810, 0.97, 0.97);
        if (!ClientPrefs.lowQuality) {
            people = new BGSprite('$directory/people', 220, 660, 0.97, 0.97, ['people'], true);
            bf = new BGSprite('$directory/bf', 770, 688, 0.95, 0.95, ['bf'], false);

            overlay = new BGSprite('$directory/overlay', -800, -300);
            overlay.blend = ADD;
        }

        add(farBG);
        add(bg);
        if (people != null) add(people);
        if (bf != null) add(bf);
        add(table);
        if (overlay != null) foregroundSprites.push(overlay);

        super.create();
    }
    override function beatHit(curBeat:Int) {
        if (bf != null && curBeat % 2 == 0) 
            bf.animation.play('bf', true);

        super.beatHit(curBeat);
    }
}