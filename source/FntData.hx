import flixel.FlxG;

class FntData
{
    public static function createFntData()
    {
        if(FlxG.save.data.week5beated == null)
            FlxG.save.data.week5beated = false;

        if (FlxG.save.data.Leschipsunloked == null)
			FlxG.save.data.Leschipsunloked = false;

		if (FlxG.save.data.Helltutorialunloked == null)
			FlxG.save.data.Helltutorialunloked = false;
        
        if(FlxG.save.data.Mewunloked == null)
			FlxG.save.data.Mewunloked = false;

		if(FlxG.save.data.Awaitedunloked == null)
			FlxG.save.data.Awaitedunloked = false;

        if(FlxG.save.data.Zooescapeunloked == null)
            FlxG.save.data.Zooescapeunloked = false;

        if(FlxG.save.data.Mewswitchunloked == null)
            FlxG.save.data.Mewswitchunloked = false;
    }
}