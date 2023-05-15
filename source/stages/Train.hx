package stages;

import StageData.StageFile;

class Train extends Stage {
    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
}