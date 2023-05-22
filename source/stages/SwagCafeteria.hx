package stages;

import StageData.StageFile;

class SwagCafeteria extends Stage {
    var bg:BGSprite;
    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('secrets');
        stageFile.defaultZoom = 1.3;
        stageFile.letterboxxing = false;
        super(stageFile);

        PlayState.SONG.player1 = 'swag-pica';
        PlayState.SONG.player2 = 'swag-daniel';
    }
    override function create() {
        bg = new BGSprite('bgexport_swagger', -910, 70, 0.95, 0.95);
        bg.setGraphicSize(Std.int(bg.width * 0.55));
        bg.updateHitbox();
        add(bg);
        super.create();
        gfGroup.alpha = 0;

        PlayState.instance.showRating = false;
        PlayState.instance.showComboSpr = false;
        PlayState.instance.showComboNum = false;
    }
}