package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

class CoolLight extends FlxSprite //No Psych Blammed Lights
{
    var tween:FlxTween;
    var noteShader:ColorSwap;

    public function new()
    {
        super();

        loadGraphic(Paths.image('light'));
        noteShader = new ColorSwap();
        shader = noteShader.shader;
        alpha = 0;
    }

    public function lightBump(color:FlxColor, intensity:Float = 1, isNote:Bool = false, noteData:Int = 0)
    {
        if(ClientPrefs.flashing)
        {
            if(tween != null)
            {
                tween.cancel();
                tween = null;
            }
            this.color = color;
            if(isNote)
            {
                noteShader.hue = ClientPrefs.arrowHSV[noteData % 4][0] / 360;
                noteShader.saturation = ClientPrefs.arrowHSV[noteData % 4][1] / 100;
                noteShader.brightness = ClientPrefs.arrowHSV[noteData % 4][2] / 100;
            }
            else
            {
                noteShader.hue = 0;
                noteShader.saturation = 0;
                noteShader.brightness = 0;
            }
            alpha = intensity;
            tween = FlxTween.tween(this,{alpha: 0}, 0.6);
        }
    }
}