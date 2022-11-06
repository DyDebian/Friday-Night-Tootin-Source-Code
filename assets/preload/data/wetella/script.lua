local defaultZoom = 0.7;

function onCreate()
    makeLuaSprite('black','BlackBg',-400,0);
    addLuaSprite('black',false);
    setProperty('black.scale.x',3);
    setProperty('black.scale.y',3);
    setProperty('black.alpha',0);
end

function onStepHit()
    if curStep == 448 or curStep == 960 then
        doTweenAlpha('bgtween','black',1,0.6,'circIn');
        doTweenZoom('camtween','camGame',1.2,1.8,'smootherstepinout');
        setProperty('defaultCamZoom',1.2);
    end
    if curStep == 503 or curStep == 1015 then
        doTweenZoom('camtween','camGame',defaultZoom - 0.4,7,'smootherstepinout');
        setProperty('defaultCamZoom',defaultZoom - 0.4);
    end
    if curStep == 572 or curStep == 1084 then
        cancelTween('camtween');
        setProperty('defaultCamZoom',defaultZoom);
    end
    if curStep == 576 or curStep == 1086 then
        doTweenAlpha('bgtween','black',0,0.6,'circIn');
    end
end