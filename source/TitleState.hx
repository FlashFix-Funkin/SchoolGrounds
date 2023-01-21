package;

import openfl.display.Sprite;
#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.utils.Assets as OpenFlAssets;
#if (MODS_ALLOWED && sys)
import sys.FileSystem;
import sys.io.File;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
import flixel.addons.display.FlxRuntimeShader;
#end
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;
typedef TitleData =
{
	titlex:Float,
	titley:Float,
	startx:Float,
	starty:Float,
	gfx:Float,
	gfy:Float,
	backgroundSprite:String,
}
class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var initialized:Bool = false;

	var iconGroup:FlxTypedGroup<HealthIcon> = new FlxTypedGroup();
	var excludeIconsAlpha:Array<Int> = [];
	var excludeIcons:Array<Int> = [];
	#if sys
	var bloomShader:FlxRuntimeShader = new FlxRuntimeShader(File.getContent(Paths.shaderFragment('bloom')));
	var rbShader:FlxRuntimeShader = new FlxRuntimeShader(File.getContent(Paths.shaderFragment('chromaticAberration')));
	#end
	var iconList:Array<String> = ['bf', 'dad', 'spooky', 'pico', 'mom', 'gf', 'parents', 'senpai-pixel', 'spirit-pixel', 'monster'];
	var iconList2:Array<String> = ['gf', 'parents', 'senpai-pixel', 'spirit-pixel', 'monster'];

	var iconGrid:FlxSprite;

	var grpNotes:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();

	var roseVHS:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	var logo:FlxSprite;
	
	var titleTextColors:Array<FlxColor> = [0xFF33FFFF, 0xFF3333CC];
	var titleTextAlphas:Array<Float> = [1, .64];
	var curWacky:Array<String> = [];
	var wackyImage:FlxSprite;
	var mustUpdate:Bool = false;
	var titleJSON:TitleData;
	var allowCamBeat:Bool = false;

	#if sys
	var shaderTween:FlxTween;
	#end
	var camZoomTween:FlxTween;

	public static var updateVersion:String = '';

	override public function create():Void
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		WeekData.loadTheFirstEnabledMod();

		//trace(path, FileSystem.exists(path));

		/*#if (polymod && !html5)
		if (sys.FileSystem.exists('mods/')) {
			var folders:Array<String> = [];
			for (file in sys.FileSystem.readDirectory('mods/')) {
				var path = haxe.io.Path.join(['mods/', file]);
				if (sys.FileSystem.isDirectory(path)) {
					folders.push(file);
				}
			}
			if(folders.length > 0) {
				polymod.Polymod.init({modRoot: "mods", dirs: folders});
			}
		}
		#end*/

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		swagShader = new ColorSwap();
		super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');

		ClientPrefs.loadPrefs();

		#if CHECK_FOR_UPDATES
		if(ClientPrefs.checkForUpdates && !closedState) {
			trace('checking for update');
			var http = new haxe.Http("https://raw.githubusercontent.com/ShadowMario/FNF-PsychEngine/main/gitVersion.txt");

			http.onData = function (data:String)
			{
				updateVersion = data.split('\n')[0].trim();
				var curVersion:String = MainMenuState.psychEngineVersion.trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if(updateVersion != curVersion) {
					trace('versions arent matching!');
					mustUpdate = true;
				}
			}

			http.onError = function (error) {
				trace('error: $error');
			}

			http.request();
		}
		#end

		Highscore.load();

		// IGNORE THIS!!!
		titleJSON = Json.parse(Paths.getTextFromFile('images/gfDanceTitle.json'));

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
				//trace('LOADED FULLSCREEN SETTING!!');
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			if (!DiscordClient.isInitialized)
			{
				DiscordClient.initialize();
				Application.current.onExit.add (function (exitCode) {
					DiscordClient.shutdown();
				});
			}
			#end

			if (initialized)
				startIntro();
			else
			{
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					startIntro();
				});
			}
		}
		#end
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;

	function startIntro()
	{
		if (!initialized)
		{
			/*var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;*/

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('klaskiMenu'));
			// FlxG.sound.list.add(music);
			// music.play();

			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('klaskiMenu'), 0);
			}
		}

		FlxG.autoPause = false; // putted on startIntro cause it prevents crash

		Conductor.changeBPM(158);
		persistentUpdate = true;

		if (ClientPrefs.shaders)
		{
			#if sys
			var arrayFilter:Array<BitmapFilter> = [];
			arrayFilter.push(new ShaderFilter(bloomShader));
			arrayFilter.push(new ShaderFilter(rbShader));
			FlxG.camera.setFilters(arrayFilter);
			bloomShader.setFloat('blurSize', 1.0 / 800.0);
			rbShader.setFloat('rOffset', -0.001);
			rbShader.setFloat('bOffset', 0.001);
			#end
		}

		var bg:FlxSprite = new FlxSprite();

		if (titleJSON.backgroundSprite != null && titleJSON.backgroundSprite.length > 0 && titleJSON.backgroundSprite != "none"){
			bg.loadGraphic(Paths.image(titleJSON.backgroundSprite));
		}else{
			bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		}

		// bg.antialiasing = ClientPrefs.globalAntialiasing;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		logoBl = new FlxSprite(titleJSON.titlex, titleJSON.titley);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');

		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		swagShader = new ColorSwap();
		gfDance = new FlxSprite(titleJSON.gfx, titleJSON.gfy);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.antialiasing = ClientPrefs.globalAntialiasing;
		add(gfDance);
		gfDance.shader = swagShader.shader;
		add(logoBl);
		logoBl.shader = swagShader.shader;

		titleText = new FlxSprite(titleJSON.startx, titleJSON.starty);
		#if (desktop && MODS_ALLOWED)
		var path = "mods/" + Paths.currentModDirectory + "/images/titleEnter.png";
		//trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path)){
			path = "mods/images/titleEnter.png";
		}
		//trace(path, FileSystem.exists(path));
		if (!FileSystem.exists(path)){
			path = "assets/images/titleEnter.png";
		}
		//trace(path, FileSystem.exists(path));
		titleText.frames = FlxAtlasFrames.fromSparrow(BitmapData.fromFile(path),File.getContent(StringTools.replace(path,".png",".xml")));
		#else

		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		#end
		var animFrames:Array<FlxFrame> = [];
		@:privateAccess {
			titleText.animation.findByPrefix(animFrames, "ENTER IDLE");
			titleText.animation.findByPrefix(animFrames, "ENTER FREEZE");
		}
		
		if (animFrames.length > 0) {
			newTitle = true;
			
			titleText.animation.addByPrefix('idle', "ENTER IDLE", 24);
			titleText.animation.addByPrefix('press', ClientPrefs.flashing ? "ENTER PRESSED" : "ENTER FREEZE", 24);
		}
		else {
			newTitle = false;
			
			titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
			titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		}
		
		titleText.antialiasing = ClientPrefs.globalAntialiasing;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		logo = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = ClientPrefs.globalAntialiasing;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		roseVHS = new FlxSprite(FlxG.width, FlxG.height);
		roseVHS.frames = Paths.getSparrowAtlas('roseVHS');
		roseVHS.animation.addByPrefix('static', 'mask', 40, true);
		roseVHS.animation.play('static');
		roseVHS.setGraphicSize(Std.int(roseVHS.width * 1.2));
		roseVHS.updateHitbox();
		roseVHS.screenCenter(XY);
		credGroup.add(roseVHS);

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, 0).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 2));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(XY);
		ngSpr.antialiasing = ClientPrefs.globalAntialiasing;

		#if sys
		for (i in 0...iconList.length)
		{
			iconList[i] = iconList[i].substring(5, iconList[i].length - 4);
		}
		#end

		addIcons();

		iconGrid = new FlxSprite(FlxG.width * 0.6 - 400, FlxG.height / 2 - 200, Paths.image('introIconGrid'));
		iconGrid.visible = false;
		add(iconGrid);

		for (i in 0...4)
		{
			var note:FlxSprite = new FlxSprite(FlxG.width * 0.3 + (i * 130), 0);
			note.frames = Paths.getSparrowAtlas('NOTE_IntroAssets');
			var animations:Array<String> = ['arrowLEFT', 'arrowDOWN', 'arrowUP', 'arrowRIGHT'];
			var animationsConfirm:Array<String> = ['left confirm', 'down confirm', 'up confirm', 'right confirm'];
			note.animation.addByPrefix('idle', animations[i]);
			note.animation.addByPrefix('confirm', animationsConfirm[i], 24, false);
			note.animation.play('idle');
			note.antialiasing = ClientPrefs.globalAntialiasing;
			note.visible = false;
			note.screenCenter(Y);
			note.setGraphicSize(Std.int(note.width * 0.8));
			note.updateHitbox();
			note.ID = i;
			grpNotes.add(note);
			add(note);
		}

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}


	function addIcons(secondSection:Bool = false) {
		for (i in 0...5)
		{
			var icon:HealthIcon = new HealthIcon(!secondSection ? iconList[i] : iconList2[i], false);
			icon.screenCenter(Y);
			icon.x = FlxG.width * 0.24 + (i * 140);
			icon.ID = i;
			icon.alpha = 0;
			iconGroup.add(icon);
			add(icon);
		}
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;
	private static var playJingle:Bool = false;
	
	var newTitle:Bool = false;
	var titleTimer:Float = 0;

	#if sys var amountBloom:Float = 0.1; #end

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (ClientPrefs.shaders)
		{
			#if sys
			bloomShader.setFloat('intensity', amountBloom);
			#end
		}

		FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 7.2), 0, 1));

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}
		
		if (newTitle) {
			titleTimer += CoolUtil.boundTo(elapsed, 0, 1);
			if (titleTimer > 2) titleTimer -= 2;
		}

		if (initialized && !transitioning && skippedIntro)
		{
			if (newTitle && !pressedEnter)
			{
				var timer:Float = titleTimer;
				if (timer >= 1)
					timer = (-timer) + 2;
				
				timer = FlxEase.quadInOut(timer);
				
				titleText.color = FlxColor.interpolate(titleTextColors[0], titleTextColors[1], timer);
				titleText.alpha = FlxMath.lerp(titleTextAlphas[0], titleTextAlphas[1], timer);
			}
			
			if(pressedEnter)
			{
				titleText.color = FlxColor.WHITE;
				titleText.alpha = 1;
				allowCamBeat = false;
				
				if(titleText != null) titleText.animation.play('press');

				FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 0.4);
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
				FlxG.camera.zoom += 0.068;

				transitioning = true;
				// FlxG.sound.music.stop();

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if (mustUpdate) {
						MusicBeatState.switchState(new OutdatedState());
					} else {
						MusicBeatState.switchState(new MainMenuState());
					}
					closedState = true;
				});
				// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
			}
		}

		if (initialized && pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			if(controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if(controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>, ?offset:Float = 0)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true);
			money.screenCenter(X);
			money.y += (i * 60) + 200 + offset;
			if(credGroup != null && textGroup != null) {
				credGroup.add(money);
				textGroup.add(money);
			}
		}
	}

	function addMoreText(text:String, ?offsetY:Float = 0, ?offsetX:Float = 0)
	{
		if(textGroup != null && credGroup != null) {
			var coolText:Alphabet = new Alphabet(0, 0, text, true);
			coolText.screenCenter(X);
			coolText.x += offsetX;
			coolText.y += (textGroup.length * 60) + 200 + offsetY;
			credGroup.add(coolText);
			textGroup.add(coolText);
		}
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	function removeLastCoolText()
	{
		credGroup.remove(textGroup.members[textGroup.length - 1], true);
		textGroup.remove(textGroup.members[textGroup.length - 1], true);
	}

	function skipTime() {
		FlxG.sound.music.pause();
		FlxG.sound.music.time = 12140;
		Conductor.songPosition = 12140;
		FlxG.sound.music.play();
	}

	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if(allowCamBeat)
		{
			FlxG.camera.zoom += 0.035;
		}

		if(logoBl != null)
			logoBl.animation.play('bump', true);

		if(gfDance != null) {
			danceLeft = !danceLeft;
			if (danceLeft)
				gfDance.animation.play('danceRight');
			else
				gfDance.animation.play('danceLeft');
		}

		if(!closedState) {
			sickBeats++;
			/*
			switch (sickBeats)
			{
				case 1:
					//FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.music('klaskiMenu'), 0);
					FlxG.sound.music.fadeIn(1.2, 0, 0.7);
				case 2:
					#if PSYCH_WATERMARKS
					createCoolText(['Psych Engine by'], 15);
					#else
					createCoolText(['ninjamuffin99', 'phantomArcade', 'kawaisprite', 'evilsk8er']);
					#end
				// credTextShit.visible = true;
				case 4:
					#if PSYCH_WATERMARKS
					addMoreText('Shadow Mario', 15);
					addMoreText('RiverOaken', 15);
					addMoreText('shubs', 15);
					#else
					addMoreText('present');
					#end
				// credTextShit.text += '\npresent...';
				// credTextShit.addText();
				case 5:
					deleteCoolText();
				// credTextShit.visible = false;
				// credTextShit.text = 'In association \nwith';
				// credTextShit.screenCenter();
				case 6:
					#if PSYCH_WATERMARKS
					createCoolText(['Not associated', 'with'], -40);
					#else
					createCoolText(['In association', 'with'], -40);
					#end
				case 8:
					addMoreText('newgrounds', -40);
					ngSpr.visible = true;
				// credTextShit.text += '\nNewgrounds';
				case 9:
					deleteCoolText();
					ngSpr.visible = false;
				// credTextShit.visible = false;

				// credTextShit.text = 'Shoutouts Tom Fulp';
				// credTextShit.screenCenter();
				case 10:
					createCoolText([curWacky[0]]);
				// credTextShit.visible = true;
				case 12:
					addMoreText(curWacky[1]);
				// credTextShit.text += '\nlmao';
				case 13:
					deleteCoolText();
				// credTextShit.visible = false;
				// credTextShit.text = "Friday";
				// credTextShit.screenCenter();
				case 14:
					addMoreText('Friday');
				// credTextShit.visible = true;
				case 15:
					addMoreText('Night');
				// credTextShit.text += '\nNight';
				case 16:
					addMoreText('Funkin'); // credTextShit.text += '\nFunkin';

				case 17:
					skipIntro();
			}
			*/
		}
	}
	
	var sickFastBeats:Float = 0;
	override function stepHit()
	{
		super.stepHit();

		if (!closedState && !skippedIntro)
		{
			sickFastBeats += 0.25;
			switch (sickFastBeats)
			{
				case 1:
					FlxG.sound.playMusic(Paths.music('klaskiMenu'), 0);
					FlxG.sound.music.fadeIn(1.2, 0, 0.7);
					createCoolText(['Ninjamuffin99'], 15);
				case 1.5:
					addMoreText('PhantomArcade', 15);
				case 2:
					addMoreText('KawaiSprite', 15);
				case 2.5:
					addMoreText('EvilSk8r', 15);
				case 3:
					#if sys
					if (ClientPrefs.shaders)
					{
						amountBloom = 8.0;
						shaderTween = FlxTween.tween(this, {amountBloom: 0.1}, 0.4, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
						{
							shaderTween = null;
						}});
					}
					#end
				case 5:
					removeLastCoolText();
				case 5.5:
					removeLastCoolText();
				case 6:
					removeLastCoolText();
				case 6.5:
					deleteCoolText();
				case 9:
					createCoolText(['PRESENT'], 15);
				case 9.5:
					addMoreText('IN', 15, -328);
				case 10:
					removeLastCoolText();
					addMoreText('IN COLLABORATION', 15);
				case 10.5:
					addMoreText('WITH', 15);
				case 11:
					#if sys
					if (ClientPrefs.shaders)
					{
						amountBloom = 8.0;
						shaderTween = FlxTween.tween(this, {amountBloom: 0.1}, 0.4, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
						{
							shaderTween = null;
						}});
					}
					#end
				case 13:
					removeLastCoolText();
				case 13.5:
					removeLastCoolText();
					addMoreText('IN', 15, -328);
				case 14:
					removeLastCoolText();
				case 14.5:
					deleteCoolText();
				case 16:
					ngSpr.visible = true;
				case 16.25:
					ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.6));
					ngSpr.updateHitbox();
					ngSpr.screenCenter(XY);
				case 17:
					ngSpr.visible = false;
					iconGroup.members[0].alpha = 1;
				case 17.5:
					iconGroup.members[1].alpha = 1;
				case 18:
					iconGroup.members[2].alpha = 1;
				case 18.5:
					iconGroup.members[3].alpha = 1;
				case 19:
					iconGroup.members[4].alpha = 1;
					#if sys
					if (ClientPrefs.shaders)
					{
						amountBloom = 8.0;
						shaderTween = FlxTween.tween(this, {amountBloom: 0.1}, 0.4, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
						{
							shaderTween = null;
						}});
					}
					#end
				case 21:
					for (i in 0...5)
					{
						iconGroup.members[i].alpha = 0;
					}
					var randomInt:Int = FlxG.random.int(0, 4, excludeIconsAlpha);
					iconGroup.members[randomInt].alpha = 1;
					excludeIconsAlpha.insert(excludeIconsAlpha.length + 1, randomInt);
				case 21.5:
					for (i in 0...5)
					{
						iconGroup.members[i].alpha = 0;
					}
					var randomInt:Int = FlxG.random.int(0, 4, excludeIconsAlpha);
					iconGroup.members[randomInt].alpha = 1;
					excludeIconsAlpha = [];
				case 22:
					for (i in 0...5)
					{
						iconGroup.members[i].alpha = 0;
					}
					iconGrid.visible = true;
				case 22.5:
					iconGrid.x += 200;
					iconGrid.y += 200;
				case 23:
					iconGrid.destroy();
					iconGroup.destroy();
					iconGroup = new FlxTypedGroup();
				case 25:
					addIcons(true);
					iconGroup.members[0].alpha = 1;
				case 25.5:
					iconGroup.members[1].alpha = 1;
				case 26:
					iconGroup.members[2].alpha = 1;
				case 26.5:
					iconGroup.members[3].alpha = 1;
				case 27:
					iconGroup.members[4].alpha = 1;
					for (i in 0...4)
					{
						iconGroup.members[i].alpha = 0;
					}
					#if sys
					if (ClientPrefs.shaders)
					{
						amountBloom = 8.0;
						shaderTween = FlxTween.tween(this, {amountBloom: 0.1}, 0.4, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
						{
							amountBloom = 0.1;
							shaderTween = null;
						}});
					}
					#end
				case 27.25:
					iconGroup.members[4].alpha = 0;
				case 27.5:
					iconGroup.members[4].alpha = 1;
				case 27.75:
					iconGroup.members[4].alpha = 0;
				case 28:
					iconGroup.members[4].alpha = 1;
				case 28.25:
					iconGroup.members[4].alpha = 0;
				case 28.5:
					iconGroup.members[4].alpha = 1;
				case 28.75:
					iconGroup.members[4].alpha = 0;
				case 29:
					grpNotes.members[0].visible = true;
				case 29.5:
					grpNotes.members[1].visible = true;
				case 30:
					grpNotes.members[2].visible = true;
				case 30.5:
					grpNotes.members[3].visible = true;
				case 31:
					grpNotes.forEachAlive(function (leNote:FlxSprite)
					{
						leNote.animation.play('confirm');
						leNote.centerOffsets();
						leNote.centerOrigin();
					});
					camZoomTween = FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.4, {ease: FlxEase.cubeOut, onComplete: function(tween:FlxTween){
						camZoomTween = FlxTween.tween(FlxG.camera, {zoom: 2.2}, 0.4, {ease: FlxEase.quintIn, onComplete: function(tween:FlxTween){
							camZoomTween = null;
						}});
					}});
					#if sys
					if (ClientPrefs.shaders)
					{
						shaderTween = FlxTween.tween(this, {amountBloom: 16.0}, 1, {onComplete: function(twn:FlxTween)
						{
							shaderTween = null;
						}});
					}
					#end
				case 33:
					for (i in 0...4)
					{
						grpNotes.members[i].visible = false;
					}
					skipIntro();
			}
		}
	}

	public static var hasBeenOnThisStage:Bool = false;
	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);
			remove(credGroup);
			remove(iconGroup);
			remove(grpNotes);
			if (camZoomTween != null) camZoomTween.cancel();
			#if sys
			if (shaderTween != null && ClientPrefs.shaders){
				shaderTween.cancel();
				amountBloom = 0.1;
			}
			#end
			FlxG.camera.flash(FlxColor.WHITE, 0.8);
			allowCamBeat = true;
			if (FlxG.sound.music.time < 12140 && FlxG.sound.music != null && !hasBeenOnThisStage)
			{
				skipTime();
				hasBeenOnThisStage = true;
			}
			
			skippedIntro = true;
		}
	}
}
