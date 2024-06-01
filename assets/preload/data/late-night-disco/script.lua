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
    if curStep == 68 or curStep == 131 then
        setZoomCam(1.0,6.5);
    end
    if curStep == 349 then
        setZoomCam(1,1,'smootherstepinout');
    end
    if curStep == 365 or curStep == 862 then
        setZoomCam(1,0.88,'smootherstepinout');
    end
    if curStep == 878 then
        setZoomCam(1,0.78,'smootherstepinout');
    end
    if curStep == 702 then
        ligthOn();
        setZoomCam(0.82,0.6,'smoothstepin');
    end
    if curStep == 735 or curStep == 799 then
        setZoomCam(0.65,2.5,'smootherstepinout');
    end
    if curStep == 959 then
        setZoomCam(defaultZoom,0.8,'smootherstepinout');
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
    if curStep >= 702 and curStep <= 710 then
        setProperty('defaultCamZoom',0.82)
    elseif curStep >= 959 then
        setProperty('defaultCamZoom',defaultZoom);
    end
end