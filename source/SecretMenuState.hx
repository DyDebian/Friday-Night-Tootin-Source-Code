package;

import flixel.FlxG;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIInputText;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;

using StringTools;

class SecretMenuState extends MusicBeatState
{

    var code:String;
	var typing:FlxInputText;
    var secretaudio:FlxSound;
    var eventinit:Bool = false;

    override function create()
    {
        FlxG.mouse.visible = true;
        FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 1);

        var ui_code = new FlxUIInputText(0, 0, 105, code, 12);
        ui_code.screenCenter();
        typing = ui_code;
        add(ui_code);

        super.create();
    }
    override function update(elapsed:Float)
    {
        super.update(elapsed);

        code=typing.text;

        if(FlxG.keys.justPressed.ESCAPE && eventinit == false)
        {
            FlxG.mouse.visible = false;
            FlxG.sound.playMusic(Paths.music('Menu_' + ClientPrefs.menuSong), 1);
            FlxG.switchState(new FreeplayState());
        }
        if(FlxG.keys.justPressed.ENTER)
        {
            if(eventinit == false)
            {
                eventinit = true;
                secret();
            }
        }
    }
    function secret()
    {
        if(code.toLowerCase() == "mew")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/meow'));
            secretaudio.play();

            new FlxTimer().start(2.0, function(StartMew:FlxTimer)
            {
                var difficulty = 0;
                var songFormat = StringTools.replace('mew', " ", "-");
                var pop:String = Highscore.formatSong(songFormat, difficulty);

                PlayState.SONG = Song.loadFromJson(pop, 'mew/secret');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }
        else if(code.toLowerCase() == "hell")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/hell_laugh'));
            secretaudio.play();

            new FlxTimer().start(3.5, function(StartHellTutorial:FlxTimer)
            {
                var difficulty = 0;
                var songFormat = StringTools.replace('hell-tutorial', " ", "-");
                var pop:String = Highscore.formatSong(songFormat, difficulty);

                PlayState.SONG = Song.loadFromJson(pop, 'hell-tutorial/secret');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }
        else if(code.toLowerCase() == "leis chips")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/chips'));
            secretaudio.play();

            new FlxTimer().start(1.5, function(StartLeschips:FlxTimer)
            {
                var difficulty = 0;
                var songFormat = StringTools.replace('leis-chips', " ", "-");
                var pop:String = Highscore.formatSong(songFormat, difficulty);

                PlayState.SONG = Song.loadFromJson(pop, 'leis-chips/secret');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }
        else if(code.toLowerCase() == "awaited")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/me_waiting_for_the_song_to_arrive'));
            secretaudio.play();

            new FlxTimer().start(2.0, function(StartAwaited:FlxTimer)
            {
                var difficulty = 0;
                var songFormat = StringTools.replace('awaited', " ", "-");
                var pop:String = Highscore.formatSong(songFormat, difficulty);

                PlayState.SONG = Song.loadFromJson(pop, 'awaited/secret');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }
        else if(code.toLowerCase() == "zoo escape")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/goofy_ahh_sound'));
            secretaudio.play();

            new FlxTimer().start(2.0, function(StartZooEscape:FlxTimer)
            {
                var difficulty = 0;
                var songFormat = StringTools.replace('zoo-escape', " ", "-");
                var pop:String = Highscore.formatSong(songFormat, difficulty);

                PlayState.SONG = Song.loadFromJson(pop, 'zoo-escape/secret');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }
        else if(code.toLowerCase() == "bark")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/bark_bark'));
            secretaudio.play();

            new FlxTimer().start(1.5, function(StartMewSwitchRemix:FlxTimer)
            {
                var difficulty = 0;
                var songFormat = StringTools.replace('mew-simplyswitch-edition', " ", "-");
                var pop:String = Highscore.formatSong(songFormat, difficulty);

                PlayState.SONG = Song.loadFromJson(pop, 'mew-simplyswitch-edition/secret');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }
        else if(code.toLowerCase() == "panda")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            FlxG.mouse.visible = false;
            var video:FlxVideo = new FlxVideo(Paths.video('PANDA'));
            video.finishCallback = function()
            {
                amongus();
            }
            add(video);
        }
        else if(code.toLowerCase() == "fnt the movie")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            FlxG.mouse.visible = false;
            var video:FlxVideo = new FlxVideo(Paths.video('THE_ULTIMATE_TRAILER_FOR_FRIDAY_NIGHTY_TOOTY'));
            video.finishCallback = function()
            {
                amongus();
            }
            add(video);
        }
        else if(code.toLowerCase() == "gallery")
        {
            FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 0);
            FlxG.mouse.visible = false;
            MusicBeatState.switchState(new GalleryState());
        }
        else if(code.toLowerCase() == 'bruh')
        {
            secretaudio = FlxG.sound.load(Paths.sound('secretsongs/BRUH'));
            secretaudio.play();
            amongus();
        }
        else
        {
            eventinit = false;
        }
    }

    function amongus()
    {
        FlxG.sound.playMusic(Paths.music('secretmusic/secretmenu'), 1);
        eventinit = false;
        FlxG.mouse.visible = true;
    }
}