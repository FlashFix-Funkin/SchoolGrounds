package stages;

import StageData.StageFile;

class SwagCafeteria extends Stage {
    var bg:BGSprite;
    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('secrets');
        super(stageFile);

        PlayState.SONG.player1 = 'swag-pica';
        PlayState.SONG.player2 = 'swag-daniel';
    }
    override function create() {
        bg = new BGSprite('bgexport_swagger', -2400, -300, 0.95, 0.95);
        add(bg);
        super.create();
        gfGroup.alpha = 0;
    }
}