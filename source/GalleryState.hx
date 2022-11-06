package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.system.FlxSound;

class GalleryState extends MusicBeatState
{
    var curSelected:Int = 0;
    var imageGroup:FlxTypedGroup<FlxSprite>;
    var arrowGroup:FlxTypedGroup<FlxSprite>;
    var image:FlxSprite;
    var desc:FlxText;
    var canPass:Bool = true;

    override public function create()
    {
        arrowGroup = new FlxTypedGroup<FlxSprite>();
        imageGroup = new FlxTypedGroup<FlxSprite>();

        add(imageGroup);
        add(arrowGroup);

        var descBox:FlxSprite = new FlxSprite(0,FlxG.height-64);
        descBox.makeGraphic(FlxG.width,32,FlxColor.GRAY);
        descBox.alpha = 0.6;
        add(descBox);

        desc = new FlxText(30,FlxG.height-64,0,"",32);
        desc.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
        add(desc);

        var left_arrow:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('gallery/arrow_gallery'));
        left_arrow.screenCenter(Y);
        arrowGroup.add(left_arrow);

        var right_arrow:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('gallery/arrow_gallery'));
        right_arrow.angle = 180;
        right_arrow.screenCenter(Y);
        right_arrow.x+=FlxG.width-right_arrow.width;
        arrowGroup.add(right_arrow);

        loadImage();
        changeSelected();
    }

    override public function update(elapsed:Float)
    {
        if((FlxG.keys.justPressed.LEFT || controls.NOTE_LEFT_P) && canPass)
        {
            changeSelected(-1);
        }

        if((FlxG.keys.justPressed.RIGHT || controls.NOTE_RIGHT_P) && canPass)
        {
            changeSelected(1);
        }

        if(FlxG.keys.justPressed.ESCAPE)
        {
            MusicBeatState.switchState(new SecretMenuState());
        }

    }

    function changeSelected(add:Int = 0)
    {
        canPass = false;

        var audio:FlxSound = FlxG.sound.load(Paths.sound('gallery_sound'));
        audio.play();

        curSelected+=add;

        if(curSelected > 11)
            curSelected = 0;
        if(curSelected < 0)
            curSelected = 11;

        var text:Array<String> = CoolUtil.coolTextFile(Paths.textFile('gallery/image_' + (curSelected+1),'preload'));
        desc.text = Std.string(text[0]);
        trace(text[0]);

        var dir=FlxG.width;
        if(add == -1)
            dir=-FlxG.width;

        var nextImage:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gallery/image_' + (curSelected+1)));
        switch(curSelected)
        {
            case 3:
                nextImage.setGraphicSize(Std.int(nextImage.width * 0.3));
            case 4:
                nextImage.setGraphicSize(Std.int(nextImage.width * 0.7));
            case 5:
                nextImage.setGraphicSize(Std.int(nextImage.width * 0.8));
            case 6:
                nextImage.frames = Paths.getSparrowAtlas('gallery/image_7');
                nextImage.setGraphicSize(Std.int(nextImage.width * 0.7));
                nextImage.animation.addByPrefix('idle','idle', 24, true);
                nextImage.animation.play('idle',true);
        }
        nextImage.screenCenter();
        nextImage.x+=dir;
        imageGroup.add(nextImage);

        FlxTween.tween(nextImage, {x: nextImage.x-dir}, 0.8);
        FlxTween.tween(image, {x: image.x-dir}, 0.8, {onComplete: function(tween:FlxTween)
        {
            loadImage();
            nextImage.destroy();
            canPass = true;
        }});
    }

    function loadImage()
    {
        if(image != null)
            image.destroy();

        image = new FlxSprite().loadGraphic(Paths.image('gallery/image_' + (curSelected+1)));
        switch(curSelected)
        {
            case 3:
                image.setGraphicSize(Std.int(image.width * 0.3));
            case 4:
                image.setGraphicSize(Std.int(image.width * 0.7));
            case 5:
                image.setGraphicSize(Std.int(image.width * 0.8));
            case 6:
                image.frames = Paths.getSparrowAtlas('gallery/image_7');
                image.setGraphicSize(Std.int(image.width * 0.7));
                image.animation.addByPrefix('idle','idle', 24, true);
                image.animation.play('idle',true);
        }
        image.screenCenter();
        imageGroup.add(image);
    }
}