package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class BackgroundDevs extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = Paths.getSparrowAtlas('weeb/fnt_developers');
        setGraphicSize(Std.int(width * PlayState.daPixelZoom));
        animation.addByPrefix('idle','devpeople happy',24,false);
        animation.play('idle');
    }

    public function dance()
    {
        animation.play('idle',true);
    }
}