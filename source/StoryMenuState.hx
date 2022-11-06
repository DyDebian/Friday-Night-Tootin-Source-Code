package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;
	var blackBG:FlxSprite;
	var blackBG_alt:FlxSprite;
	var animcomplet:Bool = false;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var bg_files:Array<String> = ['week1selectbg', 'week2selectbg', 'week3selectbg', 'week4selectbg', 'week5selectbg', 'week6selectbg', 'week7selectbg', 'week8selectbg', 'week666selectbg'];
	var enemy_files:Array<String> = ['Discoweek1', 'senpaiweek2', 'picoweek3', 'discoandpicoweek4', 'evilbfweek5', 'pandaweek6', 'momweek7', 'evilpandaweek8', 'PICO_DISCO_DUO'];
	var bfstyles:Array<String> = ['bf', 'bfpixel', 'bf_new_style'];
	var bg_group:FlxTypedGroup<FlxSprite>;
	var enemy_group:FlxTypedGroup<FlxSprite>;
	var bf_group:FlxTypedGroup<FlxSprite>;
	var weekselectors:FlxTypedGroup<MenuItem>;
	var weekTween:FlxTween;
	var bgTween:FlxTween;
	var enemyTween:FlxTween;
	var bfTween:FlxTween;
	var animTween:FlxTween;
	var coolLight:CoolLight;
	var nopress:Bool = false;
	var weekAnimComplet:Bool = false;

	var loadedWeeks:Array<WeekData> = [];

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		//var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);
		//bgSprite = new FlxSprite(0, 56);
		//bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		//grpWeekText = new FlxTypedGroup<MenuItem>();
		//add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		//add(blackBarThingie);

		//grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		//grpLocks = new FlxTypedGroup<FlxSprite>();
		//add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked)
			{
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				/*
				var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
				weekThing.y += ((weekThing.height + 20) * num);
				weekThing.targetY = num;
				grpWeekText.add(weekThing);

				weekThing.screenCenter(X);
				weekThing.antialiasing = ClientPrefs.globalAntialiasing;
				//weekThing.updateHitbox();

				// Needs an offset thingie
				if (isLocked)
				{
					var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
					lock.frames = ui_tex;
					lock.animation.addByPrefix('lock', 'lock');
					lock.animation.play('lock');
					lock.ID = i;
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					//grpLocks.add(lock);
				}
				num++;
			*/
			}
		}

		WeekData.setDirectoryFromWeek(loadedWeeks[0]);
	/*	var charArray:Array<String> = loadedWeeks[0].weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}
	*/
		difficultySelectors = new FlxGroup();
		weekselectors = new FlxTypedGroup<MenuItem>();

		blackBG = new FlxSprite(0,0).loadGraphic(Paths.image('storymenu/blackbar'));
		blackBG.setGraphicSize(Std.int(blackBG.width * 0.4));
		blackBG.screenCenter();
		blackBG.x -= 35;

		blackBG_alt = new FlxSprite(0,0).loadGraphic(Paths.image('storymenu/centerbar'));
		blackBG_alt.setGraphicSize(Std.int(blackBG.width * 0.4));
		blackBG_alt.screenCenter();
		blackBG_alt.visible = false;

		bg_group = new FlxTypedGroup<FlxSprite>();
		bf_group = new FlxTypedGroup<FlxSprite>();
		enemy_group = new FlxTypedGroup<FlxSprite>();

		leftArrow = new FlxSprite();
		leftArrow.screenCenter();
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		sprDifficulty = new FlxSprite();
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('hard');
		sprDifficulty.screenCenter();
		sprDifficulty.y += 250;
		sprDifficulty.x -= 35;

		rightArrow = new FlxSprite();
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');

		//add(bgYellow);
		//add(bgSprite);
		//add(grpWeekCharacters);
		add(bg_group);
		add(blackBG);
		add(enemy_group);
		add(bf_group);
		add(blackBG_alt);
		add(weekselectors);
		add(leftArrow);
		add(rightArrow);

		loadWeekSelection();

		leftArrow.x = weekselectors.members[0].x - weekselectors.members[0].width/4 + 15;
		leftArrow.y = weekselectors.members[0].y;
		rightArrow.x = weekselectors.members[0].x + weekselectors.members[0].width + 25;
		rightArrow.y = weekselectors.members[0].y;

	/*	var tracksSprite:FlxSprite = new FlxSprite(FlxG.width * 0.07, bgSprite.y + 425).loadGraphic(Paths.image('Menu_Tracks'));
		tracksSprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(tracksSprite);
	*/

		txtTracklist = new FlxText(0, 0, 0, "", 32);
		txtTracklist.screenCenter();
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		txtTracklist.x = weekselectors.members[0].x + weekselectors.members[0].width/4;
		txtTracklist.y = weekselectors.members[0].y + weekselectors.members[0].height;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		coolLight = new CoolLight();
		coolLight.screenCenter();
		add(coolLight);

		changeWeek();
		changeDifficulty();

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + lerpScore;

		// FlxG.watch.addQuick('font', scoreText.font);

		if (!movedBack && !selectedWeek)
		{
			var upP = controls.UI_LEFT_P;
			var downP = controls.UI_RIGHT_P;
			if (upP && !nopress)
			{
				changeWeek(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (downP && !nopress)
			{
				changeWeek(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.UI_RIGHT)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if (controls.UI_LEFT)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');
		/*
			if (controls.UI_RIGHT_P)
				changeDifficulty(1);
			else if (controls.UI_LEFT_P)
				changeDifficulty(-1);
			else if (upP || downP)
				changeDifficulty();
		*/

			if(FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}
		
		super.update(elapsed);

	/*	grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
			lock.visible = (lock.y > FlxG.height / 2);
		});
	*/
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				weekselectors.members[curWeek].startFlashing();
				stopspamming = true;
			}

			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				FreeplayState.destroyFreeplayVocals();
			});
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		//trace(Paths.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));
/*
		if(sprDifficulty.graphic != newImage)
		{
			sprDifficulty.loadGraphic(newImage);
			sprDifficulty.x = leftArrow.x + 60;
			sprDifficulty.x += (308 - sprDifficulty.width) / 3;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftArrow.y - 15;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastDifficultyName = diff;
*/

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		animcomplet = false;
		if(animTween != null)
		{
			animTween.cancel();
			animTween = null;
		}

		var bullShit:Int = 0;

	/*	var unlocked:Bool = !weekIsLocked(leWeek.fileName);
		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && unlocked)
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}
*/
		//bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			//bgSprite.visible = false;
		} else {
			//bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		//difficultySelectors.visible = unlocked;

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
		if(curWeek >= 5 && !weekAnimComplet)
		{
			weekAnimComplet = true;
			changeWeekSelectionAnimated();
		}
		else
		{
			if(curWeek == 7)
				coolLight.lightBump(FlxColor.RED,1,false);
			changeWeekSelection();
		}

	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
	/*	var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}
    */
		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.y = weekselectors.members[0].y + weekselectors.members[0].height;
		if(curWeek < 5)
		{
			txtTracklist.x -= FlxG.width * 0.27;
		}
		else
		{
			txtTracklist.y += 70;
		}

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	function loadWeekSelection()
	{
		//Load WeekText Files
		for(i in 0...loadedWeeks.length)
		{
			var weekNum:Int = i+1;
			var weekScale:Array<Float> = [0.55,0.38,0.55,0.08];//so I don't do a lot of if if if or switch case
			if(i == 8) 
				weekNum = 666;
			var week:MenuItem = new MenuItem(0,0,'week' + weekNum);
			week.screenCenter(Y);
			week.x += 125;
			week.y -= 15;
			if(i >= 5)
			{
				week.setGraphicSize(Std.int(week.width * weekScale[i - 5]));
				week.updateHitbox();
				week.screenCenter();
			}
			if(i == 8)
				week.x += 20;
				week.y -= 100;
			weekselectors.add(week);
		}

		//Load backgrounds
		for(i in 0...bg_files.length)
		{
			var bg:FlxSprite = null;
			if(i != 8)
			{
				bg = new FlxSprite().loadGraphic(Paths.image('storymenu/' + bg_files[i]));
				bg.setGraphicSize(Std.int(bg.width * 0.4));
				bg.screenCenter();
				if(i == 1)
				{
					bg.antialiasing = false;
				}
				else
				{
					bg.antialiasing = true;
				}
			}
			else if(i == 8)
			{
				bg = new FlxSprite(0,0);
				bg.frames = Paths.getSparrowAtlas('storymenu/' + bg_files[i]);
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				bg.animation.addByPrefix('play', 'week666selectbg gif',10,true);
				bg.animation.play('play');
				bg.screenCenter();
			}
			bg_group.add(bg);
		}

		//Load Enemys
		for(i in 0...enemy_files.length)
		{
			var enemy:FlxSprite = new FlxSprite().loadGraphic(Paths.image('storymenu/' + enemy_files[i]));
			if(i >= 5 && i != 8)
			{
				enemy.setGraphicSize(Std.int(enemy.width * 0.25));
			}
			else if(i == 8)
			{
				enemy.setGraphicSize(Std.int(enemy.width * 0.22));
			}
			else
			{
				enemy.setGraphicSize(Std.int(enemy.width * 0.3));
			}
			enemy.screenCenter();
			if(i == 1)
			{
				enemy.antialiasing = false;
			}
			else
			{
				enemy.antialiasing = true;
			}
			if(i >= 5)
			{
				enemy.x -= 400;
				enemy.y += 25;
			}
			enemy_group.add(enemy);
		}

		//Load bfStyles
		for(i in 0...bfstyles.length)
		{
			var bf:FlxSprite = new FlxSprite().loadGraphic(Paths.image('storymenu/' + bfstyles[i]));
			if(i == 2)
			{
				bf.setGraphicSize(Std.int(bf.width * 0.25));
			}
			else
			{
				bf.setGraphicSize(Std.int(bf.width * 0.3));
			}
			bf.screenCenter();
			if(i == 1)
			{
				bf.antialiasing = false;
			}
			else
			{
				bf.antialiasing = true;
			}
			if(i == 2)
			{
				bf.x += 400;
				bf.y += 25;
			}
			bf_group.add(bf);
		}
	}

	function updateArrow()
	{
		if(curWeek >= 5)
		{
			leftArrow.x = weekselectors.members[5].x - weekselectors.members[0].width/4 + 15 + 20;
			leftArrow.y = weekselectors.members[5].y + 25;
			rightArrow.x = weekselectors.members[5].x + weekselectors.members[0].width + 25 + 30;
			rightArrow.y = weekselectors.members[5].y + 25;
		}
		else
		{
			leftArrow.x = weekselectors.members[0].x - weekselectors.members[0].width/4 + 15;
			leftArrow.y = weekselectors.members[0].y;
			rightArrow.x = weekselectors.members[0].x + weekselectors.members[0].width + 25;
			rightArrow.y = weekselectors.members[0].y;
		}
	}

	function updateBar()
	{
		if(curWeek < 5)
		{
			blackBG.visible = true;
			blackBG_alt.visible = false;
		}
		else
		{
			blackBG_alt.visible = true;
			blackBG.visible = false;
		}
	}

	function changeWeekSelection()
	{
		if(weekTween != null) //to make sure that each tween will be null
		{
			weekTween.cancel();
			weekTween = null;
		}
		if(bgTween != null)
		{
			bgTween.cancel();
			bgTween = null;
		}
		if(enemyTween != null)
		{
			enemyTween.cancel();
			enemyTween = null;
		}
		if(bfTween != null)
		{
			bfTween.cancel();
			bfTween = null;
		}
		for(i in 0...weekselectors.length)
		{
			if(i >= 5)
			{
				weekselectors.members[i].screenCenter();
			}
			else
			{
				weekselectors.members[i].screenCenter(Y);
				weekselectors.members[i].x = 0;
				weekselectors.members[i].x += 125;
				weekselectors.members[i].y -= 15;
			}
			weekselectors.members[i].alpha = 0;
		}
		for(i in 0...bg_group.length)
		{
			bg_group.members[i].screenCenter();
			bg_group.members[i].alpha = 0;
		}
		for(i in 0...enemy_group.length)
		{
			enemy_group.members[i].screenCenter();
			enemy_group.members[i].alpha = 0;
			if(i >= 5)
			{
				enemy_group.members[i].x -= 400;
				enemy_group.members[i].y += 25;
			}
			
		}
		for(i in 0...bf_group.length)
		{
			bf_group.members[i].screenCenter();
			bf_group.members[i].alpha = 0;
			if(i == 2)
			{
				bf_group.members[i].x += 400;
				bf_group.members[i].y += 25;
			}
		}

		updateText();
		updateArrow();
		updateBar();

		weekselectors.members[curWeek].y -= 15;
		bg_group.members[curWeek].x -= 5;
		enemy_group.members[curWeek].x -= 25;
		var bfType:Int = 0;
		if(curWeek == 1)
		{
			bfType = 1;
		}
		else if(curWeek >= 5)
		{
			bfType = 2;
		}
		else
		{
			weekAnimComplet = false;
			bfType = 0;
		}
		bf_group.members[bfType].x += 25;

		weekTween = FlxTween.tween(weekselectors.members[curWeek], {y: weekselectors.members[curWeek].y + 15, alpha: 1}, 0.07);
		bgTween = FlxTween.tween(bg_group.members[curWeek], {x: bg_group.members[curWeek].x + 5, alpha: 1}, 0.10, {ease: FlxEase.smoothStepOut});//0.05
		enemyTween = FlxTween.tween(enemy_group.members[curWeek], {x: enemy_group.members[curWeek].x + 25, alpha: 1}, 0.25, {ease: FlxEase.quadOut, onComplete: function(thing:FlxTween)//0.15
		{
			animcomplet = true;
			if(curWeek == 4)
			{
				animTween = FlxTween.tween(enemy_group.members[curWeek], {y: enemy_group.members[curWeek].y+8}, 0.4, {ease: FlxEase.smoothStepInOut, type: FlxTweenType.PINGPONG});
			}
		}});
		bfTween = FlxTween.tween(bf_group.members[bfType], {x: bf_group.members[bfType].x - 25, alpha: 1}, 0.25, {ease: FlxEase.quadOut});
	}

	function changeWeekSelectionAnimated()
	{
		nopress = true;
		FlxG.camera.shake(0.01,10);
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			FlxG.camera.shake(0.01,0.01);
			if(ClientPrefs.flashing)
				FlxG.camera.flash(FlxColor.WHITE,1);
			nopress = false;
			changeWeekSelection();
		});
	}
}