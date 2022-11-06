function onCreate()
    makeLuaSprite('black','BlackBg',-400,0);
    addLuaSprite('black',false);
    setProperty('black.scale.x',2);
    setProperty('black.scale.y',2);
    setProperty('black.alpha',0);
    setActorAlpha(0,'black');
end

function onStepHit()
    if curStep == 143 then
        doTweenAlpha('bgtween','black',0.7,0.6,'circIn');
    end
    if curStep == 208 then
        doTweenAlpha('bgtween','black',0,0.6,'circIn');
    end
    if curStep == 272 then
        doTweenZoom('camtween','camGame',1,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',1);
    end
    if curStep == 399 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
        doTweenAlpha('bgtween','black',0.7,0.6,'circIn');
    end
    if curStep == 463 then
        doTweenAlpha('bgtween','black',0,0.6,'circIn');
    end
    if curStep == 655 then
        doTweenZoom('camtween','camGame',1.1,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',1.1);
    end
    if curStep == 784 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
end