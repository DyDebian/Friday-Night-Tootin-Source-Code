package;

import flixel.input.gamepad.FlxGamepad;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxButtonPlus;
import flixel.ui.FlxBar;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.system.FlxSound;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import FreeplayState;
import WeekData;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class ListenToMusicState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
    var insts:FlxSound;
    var voices:FlxSound;
	var inst:Bool = true;
	var voice:Bool = true;
	var reloadvoice:Bool = false;
	var reloadinst:Bool = false;
    var curPlaying:String = '';
	var endedSong:Bool = false;
	var songPosBG:FlxSprite;
    var songPosBar:FlxBar;
    var songName:FlxText;
	var songPos:Float;
	var loopSong:Bool = false;
	var backed:Bool = false;
	var curThing:FlxSound;

	private var grpSongs:FlxTypedGroup<Alphabet>;

	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{
        Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
        WeekData.reloadWeekFiles(false);
		FlxG.mouse.visible = true;

        FlxG.sound.playMusic(Paths.music('Menu_' + ClientPrefs.menuSong), 0);

		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}
		WeekData.loadTheFirstEnabledMod();

		if(FlxG.save.data.Helltutorialunloked)
        {
            addSong("hell-tutorial",10,"gf",FlxColor.fromRGB(165, 0, 77));
        }
        if(FlxG.save.data.Leschipsunloked)
        {
            addSong("leis-chips",10,"mom-tootin",FlxColor.fromRGB(154, 106, 241));
        }
        if(FlxG.save.data.Mewunloked)
        {
            addSong("mew",10,"senpai-pixel",FlxColor.fromRGB(255, 170, 111));
        }
        if(FlxG.save.data.Awaitedunloked)
        {
            addSong("awaited",10,"evil-bf-tootin",FlxColor.fromRGB(162, 38, 66));
        }
		if(FlxG.save.data.Zooescapeunloked)
		{
			addSong("zoo-escape",10,"dad",FlxColor.fromRGB(215, 215, 215));
		}
		if(FlxG.save.data.Mewswitchunloked)
		{
			addSong("mew-simplyswitch-edition",10,"senpai-pixel",FlxColor.fromRGB(255, 170, 111));
		}

		 #if windows
         DiscordClient.changePresence("In The Music listening Menu", null);
		 #end

		var isDebug:Bool = false;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
        {
            var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
            songText.isMenuItem = true;
            songText.targetY = i;
            grpSongs.add(songText);

            if (songText.width > 980)
            {
                var textScale:Float = 980 / songText.width;
                songText.scale.x = textScale;
                for (letter in songText.lettersArray)
                {
                    letter.x *= textScale;
                    letter.offset.x *= textScale;
                }
            }
            Paths.currentModDirectory = songs[i].folder;
            var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
            icon.sprTracker = songText;

            iconArray.push(icon);
            add(icon);
        }
        WeekData.setDirectoryFromWeek();

        addUi();
		changeSelection();

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
    {
        songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
    }

    function weekIsLocked(name:String):Bool {
        var leWeek:WeekData = WeekData.weeksLoaded.get(name);
        return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
    }

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = FlxG.keys.justPressed.UP;
		var downP = FlxG.keys.justPressed.DOWN;
		var accepted = controls.ACCEPT;

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.DPAD_UP)
			{
				changeSelection(-1);
			}
			if (gamepad.justPressed.DPAD_DOWN)
			{
				changeSelection(1);
			}
		}

		if (upP || FlxG.keys.justPressed.W || FlxG.mouse.wheel == 1)
		{
			changeSelection(-1);
		}
		if (downP || FlxG.keys.justPressed.S || FlxG.mouse.wheel == -1)
		{
			changeSelection(1);
		}

		if (controls.BACK && !backed)
		{
			#if desktop
			FlxG.mouse.visible = false;
			backed = true;
			var video:FlxVideo = new FlxVideo(Paths.video('dontdelet'));
			video.finishCallback = function()
			{
				MusicBeatState.switchState(new MainMenuState());
			}
			add(video);
			#else
			MusicBeatState.switchState(new MainMenuState());
			#end
		}

		if (accepted)
		{
            //playSong();
			#if debug
			insts.time = insts.length - 5000;
			voices.time = insts.time;
			#end
		}
		if(reloadvoice && voices != null)
		{
			if(voice)
			{
				insts.pause();
				if(!voices.playing)
					voices.play();
				voices.pause();
				var curtimer = insts.time;
				voices.time = curtimer;
				if(inst)
					insts.resume();
				voices.resume();
				reloadvoice = false;
			}
			else
			{
				voices.pause();
				reloadvoice = false;
			}
		}
		if(reloadinst && insts != null)
		{
			if(inst)
			{
				if(!insts.playing)
					insts.play();
				insts.pause();
				voices.pause();
				var curtimer = voices.time;
				insts.time = curtimer;
				insts.resume();
				if(voice)
					voices.resume();
				reloadinst = false;
			}
			else
			{
				insts.pause();
				reloadinst = false;
			}
		}
		if(insts != null && insts.playing && inst)
		{
        	songPos = insts.time;
		}
		else if(voices != null && voices.playing  && !insts.playing && voice)
		{
			songPos = voices.time;
		}
		if(loopSong && endedSong)
		{
			destroySong();
			loadSong();
		}

		if(FlxG.mouse.overlaps(songPosBG) && FlxG.mouse.justPressed && (voices != null || insts != null))
		{
			var mousePosition:Float = (FlxG.mouse.x/FlxG.width/songPosBG.x)-(FlxG.mouse.x/songPosBG.width)+0.5569120156571 + 0.0146757467614513; //this is not the best way to get this value and probably the dumbest way but it works
			if(inst)
			{
				curThing = insts;
			}
			else if(!inst && voice)
			{
				curThing = voices;
			}
			#if debug
			trace(mousePosition);
			#end
			curThing.time = Math.abs(mousePosition)*curThing.length;
			if(inst)
			{
				voices.time = insts.time;
			}
		}

	}

	function changeSelection(change:Int = 0)
	{
		//FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		switch (songHighscore) {
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
        }

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

    function playSong()
    {
        if(curPlaying != songs[curSelected].songName)
        {
            destroySong();
        }
        if((insts != null || voices != null) && !(insts.playing || voices.playing) && !endedSong && curPlaying == songs[curSelected].songName)
        {
            if(inst)
            {
                insts.resume();
            }
            if(voice)
            {
                voices.resume();
            }
        }
        else if((insts != null || voices != null) && (insts.playing || voices.playing) && !endedSong && curPlaying == songs[curSelected].songName)
        {
            pauseSong();
        }
        else
        {
            loadSong();
        }   
    }

	function loadSong()
	{
		insts = FlxG.sound.load(Paths.inst(songs[curSelected].songName));
		voices = FlxG.sound.load(Paths.voices(songs[curSelected].songName));
		endedSong = false;
		curPlaying = songs[curSelected].songName;
		if(inst)
		{
			insts.play();
		}
		if(voice)
		{
			voices.play();
		}
		insts.onComplete = songCallBack;
		voices.onComplete = songCallBack;
		reloadBar();
		#if windows
		DiscordClient.changePresence("In The Music listening Menu" + "\nlistening:" + songs[curSelected].songName, "");
		#end
		#if debug
		trace("This really cool sound is playing");
		#end
	}

    function pauseSong()
    {
        if(inst)
            insts.pause();
        if(voice)
            voices.pause();
    }

	function songCallBack()
	{
		endedSong = true;
	}

	function prevSong()
	{
		destroySong();
		changeSelection(-1);
		loadSong();
	}

	function nextSong()
	{
		destroySong();
		changeSelection(1);
		loadSong();
	}

	function destroySong()
	{
		if(insts != null)
			insts.destroy();
		if(voices != null)
			voices.destroy();
	}

    function addUi()
    {

		songPosBG = new FlxSprite(0, 0).loadGraphic(Paths.image('healthBar'));
        songPosBG.y = FlxG.height * 0.9 + 45; 
        songPosBG.screenCenter(X);
        add(songPosBG);

        var check_inst_activ = new FlxUICheckBox(songPosBG.x + (songPosBG.width + 32), songPosBG.y - 32, null, null, "Instrumental", 100);
		check_inst_activ.checked = true;
		check_inst_activ.callback = function()
		{
			if(check_inst_activ.checked)
			{
				trace("Inst activated");
				inst = true;
				reloadinst = true;
			}
			else
			{
				trace("Inst deactivated");
				inst = false;
				reloadinst = true;
			}
		}

		add(check_inst_activ);
		var check_voice_activ = new FlxUICheckBox(songPosBG.x + (songPosBG.width + 32), songPosBG.y, null, null, "Voice", 32);
		check_voice_activ.checked = true;
		check_voice_activ.callback = function()
		{
			if(check_voice_activ.checked)
			{
				trace("Voice activated");
				voice = true;
				reloadvoice = true;
			}
			else
			{
				trace("Voice deactivated");
				voice = false;
				reloadvoice = true;
			}
		}

		var check_loop_activ = new FlxUICheckBox(songPosBG.x + (songPosBG.width + 100), songPosBG.y, null, null, "Loop", 32);
		check_loop_activ.checked = false;
		check_loop_activ.callback = function()
		{
			if(check_loop_activ.checked)
			{
				trace("Loop:On");
				loopSong = true;
			}
			else
			{
				trace("Loop:Off");
				loopSong = false;
			}
		}
		add(check_loop_activ);

        songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
            'null', 0, 100);
        songPosBar.numDivisions = 1000;
        songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
        add(songPosBar);

        songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - (curPlaying.length * 5),songPosBG.y,0,'null', 16);
        songName.y -= 3;
        songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        add(songName);

		add(check_voice_activ);
        var play_button:FlxButtonPlus = new FlxButtonPlus(songPosBG.x - 235,songPosBG.y,playSong,"Play",100,20);
        add(play_button);
        var pause_button:FlxButtonPlus = new FlxButtonPlus(songPosBG.x - 115,songPosBG.y,pauseSong,"Pause",100,20);
        add(pause_button);
		var prev_button:FlxButtonPlus = new FlxButtonPlus(songPosBG.x - 235,songPosBG.y - 30,prevSong,"Prev Song",100,20);
		add(prev_button);
		var next_button:FlxButtonPlus = new FlxButtonPlus(songPosBG.x - 115,songPosBG.y - 30,nextSong,"Next Song",100,20);
		add(next_button);
    }

	function reloadBar()
	{
		songPosBar.destroy();
		songName.destroy();

		songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
            'songPos', 0, insts.length - 1000);
        songPosBar.numDivisions = 1000;
        songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.YELLOW);
        add(songPosBar);

        songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - (curPlaying.length * 5),songPosBG.y,0,curPlaying, 16);
        songName.y -= 3;
        songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        add(songName);
	}
}