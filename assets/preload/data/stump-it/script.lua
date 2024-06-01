local defaultZoom = 0.72;

function onCreate()
    makeLuaSprite('black', 'BlackBg',0,0);
    setProperty('black.scale.x',3);
    setProperty('black.scale.y',3);
    screenCenter('black');
    setProperty('black.alpha',0)
    addLuaSprite('black',false);

    makeLuaSprite('ligth', 'spotlight',0,0);
    setProperty('ligth.x', getProperty('ligth.x') + 375);
    setProperty('ligth.y', getProperty('ligth.y') - 125);
    setProperty('ligth.scale.x',3.5);
    setProperty('ligth.scale.y',1.2);
    setProperty('ligth.alpha',0);
    addLuaSprite('ligth',true);
end

function onStepHit()
    if curStep == 127 then
        setZoomCam(0.82,1,'smootherstepinout');
    end
    if curStep == 255 or curStep == 895 then
        setZoomCam(defaultZoom,1,'smootherstepinout');
        ligthOn();
    end
    if curStep == 511 then
        setZoomCam(0.88,1,'smootherstepinout');
        ligthOff()
    end
    if curStep == 563 or curStep == 692 then
        setZoomCam(0.6,1.42,'smootherstepinout');
    end
    if curStep == 628 or curStep == 756 then
        setZoomCam(0.6,1.32,'smootherstepinout');
    end
    if curStep == 1151 then
        ligthOff();
    end
end

function ligthOn()
    doTweenAlpha('blackTween','black',0.8,0.3,'cubeinout');
    doTweenAlpha('ligthTween','ligth',0.3,0.3,'cubeinout');
end

function ligthOff()
    doTweenAlpha('blackTween','black',0,0.3,'cubeinout');
    doTweenAlpha('ligthTween','ligth',0,0.3,'cubeinout');
end

function setZoomCam(zoom,duration,tween)
    doTweenZoom('ZoomTween','camGame',zoom,duration,tween)
end

function onTweenCompleted(tag)
    if curStep >= 127 and curStep <= 143 then
        setProperty('defaultCamZoom',0.82)
    elseif curStep >= 255 and curStep <= 271 then
        setProperty('defaultCamZoom',defaultZoom)
    elseif curStep >= 511 and curStep <= 527 then
        setProperty('defaultCamZoom',0.88)
    elseif curStep >= 895 then
        setProperty('defaultCamZoom',defaultZoom)
    end
end