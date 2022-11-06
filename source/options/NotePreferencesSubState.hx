package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class NotePreferencesSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Note Preferences';
		rpcTitle = 'Note Preferences Settings Menu'; //for Discord Rich Presence

        var option:Option = new Option('NoteSkin:',
			"What NoteSkin do you want?",
			'noteSkin',
			'string',
			'Arrow',
            ['Arrow', 'Circle']);
		addOption(option);

        var option:Option = new Option('Notes Colors',
			'Change Notes Colors',
			'',
			'');
		addOption(option);
        option.onChange = goColor;

        super();
    }

    function goColor()
    {
        openSubState(new options.NotesSubState());
    }
}