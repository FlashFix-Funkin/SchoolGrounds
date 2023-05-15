package stages;

import StageData.StageFile;

class Warehouse extends Stage {
    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
}