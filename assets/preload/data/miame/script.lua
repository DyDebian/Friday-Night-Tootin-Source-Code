local defaultZoom = 0.72;
local doAplha = true;

function onCreate()
    makeLuaSprite('blackFade', 'BlackBg',0,0);
    setProperty('blackFade.scale.x',3);
    setProperty('blackFade.scale.y',3);
    screenCenter('blackFade');
    addLuaSprite('blackFade',true);

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

    setProperty('defaultCamZoom',0.9);
end

function onUpdate()
    if doAplha then
        setProperty('blackFade.alpha',lerp(getProperty('blackFade.alpha'),1,0.03))
    end
end

function onStepHit()
    if curStep == 32 then
        doAplha = false;
        doTweenAlpha('blackTween','blackFade',0,0.5,'smootherstepinout');
        setZoomCam(defaultZoom,0.5,'smootherstepinout');
    end
    if curStep == 288 or curStep == 816 then
        setZoomCam(0.82,1,'smootherstepinout');
        ligthOn();
        cameraFlash('cam', 'FFFFFF',1);
    end
    if curStep == 544 or curStep == 1056 then
        setZoomCam(defaultZoom,1,'smootherstepinout');
        ligthOff();
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if curStep >= 0 and curStep < 31 then
        setProperty('blackFade.alpha',0.4)
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

function lerp(a,b,c)
    return a + c * (b-a);
end

function setZoomCam(zoom,duration,tween)
    doTweenZoom('ZoomTween','camGame',zoom,duration,tween)
end

function onTweenCompleted(tag)
    if (curStep >= 32 and curStep < 48) or (curStep >= 544 and curStep < 544+16) or (curStep >= 1056 and curStep < 1056+16) then
        setProperty('defaultCamZoom',defaultZoom);
    elseif (curStep >= 288 and curStep < 288+16) or (curStep >= 816 and curStep < 816+16) then
        setProperty('defaultCamZoom',0.82);
    end
end