package stages;

import StageData.StageFile;

class Censored extends Stage {
    var img:BGSprite;
    var songName:String;
    public override function new(stageData:StageFile, songName:String) {
        Paths.setCurrentLevel('shared');
        this.songName = songName;
        super(stageData);
    }
    override function create() {
        img = new BGSprite('censors/${Paths.formatToSongPath(songName)}', 0, 0);
        img.screenCenter(XY);
        add(img);
        img.cameras = [PlayState.instance.camHUD];
    }
    override function update(elapsed:Float) {
        PlayState.instance.snapCamFollowToPos(0,0);
        super.update(elapsed);
    }
}