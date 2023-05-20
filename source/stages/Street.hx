package stages;

import flixel.FlxG;
import flixel.system.FlxSound;
import openfl.display.BlendMode;
import flixel.tweens.FlxTween;
import flixel.FlxBasic;
import flixel.FlxSprite;
import StageData.StageFile;

class Street extends Stage {

    var directory:String = 'bgs/whippy';

    var road:BGSprite;
    var buildings:BGSprite;
    var buildingsfar:BGSprite;
    var picoschool:BGSprite;
    var buildingswayfaaar:BGSprite;
    var sky:BGSprite;

    public override function new(stageFile:StageFile) {
        Paths.setCurrentLevel('shared');
        super(stageFile);
    }
    override function create(){

        road = new BGSprite('$directory/FG', -810, -200);
        road.scale.set(1.1, 1.1);
        road.updateHitbox();

        buildings = new BGSprite('$directory/BG1', -630, -220, 0.8, 0.8);
        buildings.updateHitbox();

        buildingsfar = new BGSprite('$directory/BG2', -150, 285, 0.6, 0.6);
        buildingsfar.updateHitbox();

        picoschool = new BGSprite('$directory/BGschool', 350, 170, 0.5, 0.5);
        picoschool.scale.set(0.8, 0.8);
        picoschool.updateHitbox();

        buildingswayfaaar = new BGSprite('$directory/BG3', -300, 170, 0.3, 0.3);
        buildingswayfaaar.scale.set(1.1, 1.1);
        buildingswayfaaar.updateHitbox();

        sky = new BGSprite('$directory/SKY',-270,-250,0.1,0.1);
        sky.updateHitbox();

        add(sky);
        add(buildingswayfaaar);
        add(picoschool);
        add(buildingsfar);
        add(buildings);
        add(road);
        
        super.create();
        
        gfGroup.alpha = 0;
    }
}
