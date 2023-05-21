package stages;

import StageData.StageFile;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.util.FlxGradient;

class Blackboard extends Stage {
    var directory = 'bgs/tutorial';

    var bgGrad:FlxSprite;
    var bg:BGSprite;
    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }

    override function create() {
        bgGrad = FlxGradient.createGradientFlxSprite(1990, 1320, [0xFF3D8365, 0xFF244B4C]);
        bgGrad.x = -350;
        bgGrad.y = -350;
        add(bgGrad);

        bg = new BGSprite('$directory/bg', -298, -264, 0.97, 0.97);
        add(bg);

        super.create();
        gfGroup.alpha = 0;
    }
}