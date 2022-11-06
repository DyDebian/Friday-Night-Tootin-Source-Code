package;

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
	public static var psychEngineVersion:String = '0.5.2h/Fnt Custom Build'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'jukebox',
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	var blackline:FlxSprite;
	var logo:FlxSprite;
	var nightbg:FlxSprite;
	var maincharacters:FlxTypedGroup<FlxSprite>;
	var chars:Array<String> = ['bf_tootin', 'pico_guitar', 'disco', 'bf-pixel-tootin'];
	var chars_x:Array<Int> = [390,295,325,550];//330,235,255,490
	var chars_y:Array<Int> = [-165,-185,-260,-35];
	var chars_anim:Array<String> = ['hey', 'singRIGHT','singUP','singLEFT'];
	var curmaincharacter:String;
	var tweenChar:FlxTween;

	override function create()
	{
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.3));
		bg.updateHitbox();
		bg.screenCenter();
		bg.y -= 50;
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		nightbg = new FlxSprite(-356,-1000).loadGraphic(Paths.image('MenuNightBg'));//-525,-865
		nightbg.setGraphicSize(Std.int(nightbg.width * 0.5));//0.6
		nightbg.antialiasing = true;
		nightbg.y -= 50;
		add(nightbg);
    
		logo = new FlxSprite(185,-800).loadGraphic(Paths.image('logoBumpinLoading'));//-525
		logo.setGraphicSize(Std.int(logo.width * 0.5));
		logo.antialiasing = true;
		logo.x += 85;
		add(logo);
	
		blackline = new FlxSprite(-575,-802).loadGraphic(Paths.image('Menublackline'));//-785
		blackline.setGraphicSize(Std.int(logo.width * 1.1));
		blackline.antialiasing = true;
		blackline.y -= 50;
		blackline.x += 125;
		add(blackline);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.3));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.y -= 50;
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (-50 +  i * 140) + offset);//140
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x += 15;
			menuItem.y -= 35;
			if(i == 2)
			{
				menuItem.y -= 25;
			}
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.8));
			menuItem.updateHitbox();
		}

		FlxTween.tween(logo, {y:-540}, 1, {ease: FlxEase.smoothStepOut});

		FlxG.camera.follow(camFollowPos, null, 1);
		FlxG.camera.zoom -= 0.20;//0.12

		maincharacters = new FlxTypedGroup<FlxSprite>();
		add(maincharacters);

		var versionShit:FlxText = new FlxText(-120, FlxG.height + 45, 0, "Psych Engine v" + psychEngineVersion, 250);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.scale.x = 1.2;
		versionShit.scale.y = 1.2;
		add(versionShit);
		var versionShit:FlxText = new FlxText(-130, FlxG.height + 62, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 250);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.scale.x = 1.2;
		versionShit.scale.y = 1.2;
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		loadChars();
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		/*
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		*/
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	/* Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	*/
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

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

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				for(i in 0...maincharacters.length)
				{
					if(curmaincharacter == chars[i])
					{
						maincharacters.members[i].animation.play(chars_anim[i],true);
					}
				}
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
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
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'jukebox':
										#if desktop
										var video:MP4HandlerOld = new MP4HandlerOld();
										video.playMP4(Paths.video('dontdelet'), new ListenToMusicState(), false, false, true);
										#else
										MusicBeatState.switchState(new ListenToMusicState());
										#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if (desktop && debug)
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

	/*	menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	*/
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				//camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
		changeChar();
	}

	function loadChars()
	{
		for(i in 0...chars.length)
		{
			var char:CharacterOld = new CharacterOld(chars_x[i],chars_y[i],chars[i]);
			if(i == 0)
			{
				char.scale.x = 1.1;
				char.scale.y = 1.1;
				char.flipX = false;
			}
			else if(i == 2)
			{
				char.flipX = true;
			}
			else
			{
				char.flipX = false;
			}
			maincharacters.add(char);
		}
	}

	function changeChar()
	{
		if(tweenChar != null)
		{
			tweenChar.cancel();
			tweenChar = null;
		}
		for(i in 0...maincharacters.length)
		{
			maincharacters.members[i].x = chars_x[i];
			maincharacters.members[i].alpha = 0;
		}

		var toTween:Int = 0;
		curmaincharacter = chars[0];
		switch(curSelected)
		{
			case 0:
				toTween = 0;
			case 1:
				toTween = 2;
				curmaincharacter = chars[2];
			case 2:
				toTween = 1;
				curmaincharacter = chars[1];
			case 3:
				toTween = 3;
				curmaincharacter = chars[3];
		}
		maincharacters.members[toTween].x += 25;
		tweenChar = FlxTween.tween(maincharacters.members[toTween], {x:maincharacters.members[toTween].x - 25, alpha:1}, 0.25, {ease: FlxEase.quadOut});
	}
}