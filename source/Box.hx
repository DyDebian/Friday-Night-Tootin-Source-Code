package;

import flixel.FlxSprite;

class Box extends FlxSprite
{
    public function new(x:Float,y:Float)
    {
        super(x,y);

        frames = Paths.getSparrowAtlas('box');
        animation.addByPrefix('bump','stereo boom',24,false);
        animation.play('bump');
    }

    public function bump()
    {
        animation.play('bump',true);
    }
}