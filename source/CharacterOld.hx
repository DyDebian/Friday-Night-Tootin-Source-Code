package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;

using StringTools;

class CharacterOld extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var barColor:FlxColor;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			
			case 'pico_guitar':
				barColor = 0xFFB7D855;
				frames = Paths.getSparrowAtlas('characters/Pico_guitar', 'shared');
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if(isPlayer == true)
				{
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
				    animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singLEFTmiss', "picoRightMiss", 24, false);
				    animation.addByPrefix('singRIGHTmiss', "PicoLeftMiss", 24, false);
				}
				else
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singLEFTmiss', "PicoLeftMiss", 24, false);
					animation.addByPrefix('singRIGHTmiss', "picoRightMiss", 24, false);
				}
				animation.addByPrefix('singUPmiss', "pico Up Dog", 24, false);
				animation.addByPrefix('singDOWNmiss', "PicoDownMiss", 24, false);

				if(isPlayer == true)
				{
					addOffset('idle', -20, 0);
					addOffset("singUP", 3, 17);
					addOffset("singRIGHT", -21, -3);
					addOffset("singLEFT", 54, -15);
					addOffset("singDOWN", 53, -89);
					addOffset("singUPmiss", 0, 47);
					addOffset("singRIGHTmiss", -27, 67);
					addOffset("singLEFTmiss", 54, 66);
					addOffset("singDOWNmiss", 60, -62);
				}
				else
				{
					addOffset('idle', -10, 0);
					addOffset("singUP", -70, 16);
					addOffset("singRIGHT", 1, -3);
					addOffset("singLEFT", -93, -16);
					addOffset("singDOWN", -78, -89);
				}

				playAnim('idle');

				flipX = true;

			case 'bf_tootin':
				barColor = 0xFF31B0D1;
				var tex = Paths.getSparrowAtlas('characters/bf_tootin', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, true);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				if(isPlayer == false)
				{
					animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				    animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				}
				else
				{
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				}
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS0', 24, false);
				animation.addByPrefix('hey', 'BF HEY!!', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				if(isPlayer == false)
				{
					addOffset('idle', -5);
					addOffset("singUP", -2, 27);
					addOffset("singRIGHT", -42, -7);
					addOffset("singLEFT", 32, -7);
					addOffset("singDOWN", -40, -54);
				}
				else
				{
					addOffset('idle', -5);
					addOffset("singUP", -6, 28);
					addOffset("singRIGHT", -9, -6);
					addOffset("singLEFT", -3, -8);
					addOffset("singDOWN", -7, -51);
				}
				addOffset("singUPmiss", -5, 35);
				addOffset("singRIGHTmiss", 0, 5);
				addOffset("singLEFTmiss", 0, 5);
				addOffset("singDOWNmiss", -10, -40);
				addOffset("hey", -5, 4);
				addOffset('firstDeath', 66, 12);
				addOffset('deathLoop', 32, -8);
				addOffset('deathConfirm', 37, 52);
				addOffset('scared', -7, 0);

				playAnim('idle');

				flipX = true;

			
			case 'bf-pixel-tootin':
				barColor = 0xFF7BD6F6;
				frames = Paths.getSparrowAtlas('characters/bfPixel_tootin', 'shared');
				animation.addByPrefix('idle', 'BF IDLE', 24, true);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;

			case 'disco':
				barColor = 0xFF52248A;
				frames = Paths.getSparrowAtlas('characters/Disco', 'shared');

				animation.addByPrefix('idle', "Mom Idle", 24, true);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 7, 52);
				addOffset("singRIGHT", -12, 11);
				addOffset("singLEFT", 151, -23);
				addOffset("singDOWN", 33, -238);

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001 && animation.curAnim.finished)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair') && !animation.curAnim.name.startsWith('cheer'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
