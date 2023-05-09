package;

import flixel.group.FlxSpriteGroup;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	var paused:Bool = false;

	public static var psychEngineVersion:String = ''; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	public var camGame:FlxCamera;
	public var camNotif:FlxCamera;

	var menuItems:FlxTypedGroup<FlxText>;

	var SGlogo:FlxText;

	var picoColorSwap:ColorSwap = null;
	
	var optionShit:Array<String> = [
		'PICO CAMPAIGN.',
		'FREEPLAY.',
		'OPTIONS.',
		'LOCKER ROOM.',
		'COMICS.'
	];
	
	var NGbutton:FlxSprite;
	var magenta:FlxSprite;
	var debugKeys:Array<FlxKey>;

	var loginButton:FlxText; var loginButtonCol:UInt = 0xFFFFBA13;

	var profileInfo:FlxSpriteGroup;
	

	override function create()
	{
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
		FlxG.sound.music.fadeIn(1, 0, 0.7);

		FlxG.mouse.visible = true;
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camNotif = new FlxCamera();
		camNotif.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camNotif, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		picoColorSwap = new ColorSwap();

		var picoYellowBG:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('YellowPicoBG'));
		picoYellowBG.scrollFactor.set(-1);
		picoYellowBG.setGraphicSize(Std.int(picoYellowBG.width * 1.175));
		picoYellowBG.updateHitbox();
		picoYellowBG.screenCenter();
		picoYellowBG.antialiasing = ClientPrefs.globalAntialiasing;
		picoYellowBG.shader = picoColorSwap.shader;
		add(picoYellowBG);

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('paperMainBG'));
		bg.scrollFactor.set(-1);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.alpha = 0.5;
		add(bg);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(-1);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		

		SGlogo = new FlxText(50, 50, 0, "[Schoolgrounds.]",12);
		SGlogo.setFormat(Paths.font("Helvetica.ttf"), 80, FlxColor.WHITE);
		SGlogo.scrollFactor.set(0);
		add(SGlogo);

		loginButton = new FlxText(FlxG.width - 112, 12, 0, "Login?...",12);
		loginButton.setFormat(Paths.font("Helvetica.ttf"), 30, loginButtonCol, LEFT);
		loginButton.scrollFactor.set(0);
		loginButton.visible = !NGio.active;
		add(loginButton);

		if (NGio.active)
			updateProfileInfo();
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxText>();
		add(menuItems);

		var scale:Float = 1.05;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxText = new FlxText(50, (i * 100)  + offset + 150, 0, "" + optionShit[i], 12);
			menuItem.setFormat(Paths.font("Helvetica.ttf"), 50, FlxColor.WHITE);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.ID = i;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		NGbutton = new FlxSprite(-50).loadGraphic('assets/images/newgrounds_logo.png');
		var mds:Float = (optionShit.length - 4) * 0.135;
		if(optionShit.length < 6) mds = 0;
		NGbutton.scrollFactor.set(0, mds);
		NGbutton.setGraphicSize(Std.int(NGbutton.width * 1.175));
		NGbutton.updateHitbox();
		NGbutton.visible = true;
		NGbutton.scale.x = 0.6;
		NGbutton.scale.y = 0.6;
		NGbutton.antialiasing = ClientPrefs.globalAntialiasing;
		NGbutton.x = 900;
		NGbutton.y = 350;
		add(NGbutton);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		super.create();
	}
	
	var selectedSomethin:Bool = false;

	override function closeSubState() {
		paused = false;
		super.closeSubState();
		FlxG.sound.play(Paths.sound('scrollMenu'));
		if (NGio.active) {
			updateProfileInfo();	
			new Notification("Unlocked Rapman Song in Freeplay!", this);
			new Notification("Unlocked Newgrounds exclusive Costumes!", this);
		}
	}
		
	override function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(NGbutton))
		{		
			CoolUtil.browserLoad('https://www.newgrounds.com/portal/view/310349');
		}
		if (!NGio.active) loginButton.color = FlxG.mouse.overlaps(loginButton) ? FlxColor.WHITE : loginButtonCol;
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(loginButton) && !NGio.active) {
			paused = true;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			openSubState(new NewgroundsLoginSubstate());
		}
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!paused) {
			menuItems.forEach((spr:FlxSprite) -> {
				if (FlxG.mouse.overlaps(spr)) {
					curSelected = spr.ID; changeItem(0);
				}
			});
	
			if (!selectedSomethin)
			{
				if (controls.UI_UP_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
	
				if (controls.UI_DOWN_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
	
				if (controls.ACCEPT || (FlxG.mouse.justPressed && FlxG.mouse.overlaps(menuItems.members[curSelected])))
				{
					{
						selectedSomethin = true;
	
						menuItems.forEach(function(spr:FlxSprite)
						{
							if (curSelected != spr.ID) {
								FlxTween.tween(NGbutton, {alpha: 0}, 0.4, { ease: FlxEase.quadOut });
								FlxTween.tween(spr, {alpha: 0}, 0.4, {
									ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										spr.kill();
									}
								});
							}
							else
							{
								
									var daChoice:String = optionShit[curSelected];
	
									switch (daChoice)
									{
										case 'PICO CAMPAIGN.':
											MusicBeatState.switchState(new StoryMenuState());
											picoColorSwap.hue = 0.9;
											picoColorSwap.brightness = 0.25;
											picoColorSwap.saturation = 0.25;				
										case 'FREEPLAY.':
											MusicBeatState.switchState(new FreeplayState());
											picoColorSwap.hue = 0.6;	
											picoColorSwap.brightness = 0.25;
											picoColorSwap.saturation = 0.25;	
										#if MODS_ALLOWED
										case 'mods':
											MusicBeatState.switchState(new ModsMenuState());
										#end
										case 'awards':
											MusicBeatState.switchState(new AchievementsMenuState());
										case 'credits':
											MusicBeatState.switchState(new CreditsState());
										case 'OPTIONS.':
											LoadingState.loadAndSwitchState(new options.OptionsState());
											picoColorSwap.hue = 0.5;
											picoColorSwap.brightness = 0.25;
											picoColorSwap.saturation = 0.25;		
										case 'COSTUMES.':
											MusicBeatState.switchState(new FreeplayState());
										case 'COMICS.':
											MusicBeatState.switchState(new FreeplayState());
	
									}
							}
						});
					}
				}
				#if desktop
				else if (FlxG.keys.anyJustPressed(debugKeys))
				{
					selectedSomethin = true;
					MusicBeatState.switchState(new MasterEditorMenu());
				}
				#end
			}	
		}

		super.update(elapsed);

	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxText)
		{
			spr.updateHitbox();
			spr.setFormat(Paths.font("Helvetica.ttf"), 50, spr.ID == curSelected ? FlxColor.RED : FlxColor.WHITE);
		});
	}

	function updateProfileInfo() {
		loginButton.visible = !NGio.active;

		profileInfo = new FlxSpriteGroup(FlxG.width - 200, 12);
		add(profileInfo);

		var icon:FlxSprite = NGio.getUserIcon(120, 0);
		profileInfo.add(icon);

		var name:FlxText = new FlxText(0, 0, 0, NGio.sessionData.userData.name ?? "something went wrong..." 12);
		name.setFormat(Paths.font("Helvetica.ttf"), 30, FlxColor.WHITE, RIGHT);
		name.x = 120 - name.width - 12;
		profileInfo.add(name);

	}
}
