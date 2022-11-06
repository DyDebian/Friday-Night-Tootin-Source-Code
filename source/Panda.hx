package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class Panda extends FlxSprite
{
    public function new(pandaType:Int)
    {
        super();

        switch(pandaType)
        {
            case 0:
                frames = Paths.getSparrowAtlas('pandaBg/panda_sit');
                animation.addByPrefix('idle','pandasit',30,false);
            case 1:
                frames = Paths.getSparrowAtlas('pandaBg/panda_hat');
                animation.addByPrefix('idle','pandtender',30,false);
            case 2:
                frames = Paths.getSparrowAtlas('pandaBg/panda_happy');
                animation.addByPrefix('idle','panda',24,false);
            case 3:
                frames = Paths.getSparrowAtlas('panda_shock');
		        animation.addByPrefix('shock','Panda panda impressed',15,false);
            case 4:
                loadGraphic(Paths.image('PandaHeaven/Angel_Panda_1'));
            case 5:
                loadGraphic(Paths.image('PandaHeaven/Angel_Panda_2'));
            case 6:
                loadGraphic(Paths.image('PandaHeaven/Angel_Panda_3'));
        }
        antialiasing = true;
    }

    public function dance()
    {
        animation.play('idle',true);
    }

    public function float()
    {
        FlxTween.tween(this, {y: y+8}, 0.6, {ease: FlxEase.smoothStepInOut, type: FlxTweenType.PINGPONG});
    } 
}