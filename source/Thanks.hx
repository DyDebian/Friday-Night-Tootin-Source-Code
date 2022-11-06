package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class Thanks extends MusicBeatState
{
    override public function create()
    {
        FlxG.sound.playMusic(Paths.music('Thank_you_for_playing'), 1);

        var tks:FlxSprite = new FlxSprite().loadGraphic(Paths.image('thanks_for_playing'));
        tks.screenCenter();
        tks.alpha = 0;
        add(tks);

        var help:FlxSprite = new FlxSprite().loadGraphic(Paths.image('eyooo_panda_panda'));
        help.screenCenter();
        help.alpha = 0;
        add(help);

        FlxTween.tween(tks, {alpha: 1}, 10,{onComplete:function(tween:FlxTween)
        {
            new FlxTimer().start(6.5, function(tmr:FlxTimer)
            {
                FlxTween.tween(tks, {alpha: 0}, 10,{onComplete:function(tween:FlxTween)
                {
                    FlxTween.tween(help, {alpha: 1}, 10);
                }});
            });
        }});

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if(FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.sound.playMusic(Paths.music('Menu_' + ClientPrefs.menuSong), 1);
            FlxG.switchState(new StoryMenuState());
        }
    }
}