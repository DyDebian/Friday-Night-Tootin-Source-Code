local bf_x=0;

function onCreate()
    setProperty('camZooming',true);
    setProperty('skipArrowStartTween',true);

    setProperty('iconP1.alpha', 0);
    setProperty('iconP2.alpha', 0);
    setProperty('healthBar.alpha', 0);
    setProperty('scoreTxt.alpha', 0);

    setProperty('bfcurFollowX', 0);

    makeLuaSprite('black', 'BlackBg',0,0);
    setProperty('black.scale.x',3);
    setProperty('black.scale.y',3);
    screenCenter('black');
    addLuaSprite('black',false);

    makeLuaSprite('ligth', 'spotlight',0,0);
    setProperty('ligth.y', getProperty('ligth.y') - 112);
    setProperty('ligth.alpha',0);
    addLuaSprite('ligth',true);

    makeLuaSprite('sax', 'sax2',0,0);
    setProperty('sax.visible',false);
    addLuaSprite('sax',true);

    bf_x=getCharacterX('boyfriend');
    setProperty('boyfriend.x', getProperty('boyfriend.x') - 200);
    setProperty('boyfriend.alpha',0);
    setProperty('sax.x', getProperty('boyfriend.x') - 25);
    setProperty('sax.y', getProperty('boyfriend.y') + 80);
    setProperty('ligth.x', getProperty('ligth.x') + 500);
    setProperty('dad.alpha',0);

    addCharacterToList('bf_tootin','bf');
end

function onSongStart()
    ligthOn();
    for i=4,7 do
        if middlescroll == false then
            setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') - 320);
        end
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 1);
    end
end

function onStepHit()
    if curStep == 37 then
        doSax();
    end
    if curStep == 43 then
        cancelTween('scaleTween');
        cancelTween('angleTween');
        removeLuaSprite('sax',true);
        triggerEvent('Change Character', 'bf', 'bf_tootin');
        setProperty('boyfriend.x',bf_x);
        setProperty('boyfriend.x', getProperty('boyfriend.x') - 160);
    end
    if curStep == 44 then
        objectPlayAnimation('boyfriend','hey',true);
    end
    if curStep == 104 then
        cameraFlash('hud','FFFFFF',1);
        doTweenAlpha('alphaBlack', 'black', 0.5,1);
    end
    if curStep == 360 then
        doZoomTweened(1.1,0.6);
        doTweenAlpha('alphaBlack', 'black', 0,1);
        doTweenAlpha('ligthTween', 'ligth', 0,1);
    end
    if curStep == 486 then
        doZoomTweened(0.9,0.6);
        doTweenAlpha('alphaBlack', 'black', 1,1);
        doTweenAlpha('alphaBf', 'boyfriend', 0,1);
    end
    if curStep >= 232 and curStep <= 486 and curStep % 4 == 0 then
        setCamZoom('hud',1.1);
    end
end

function ligthOn()
    setProperty('ligth.alpha',0.3);
    setProperty('boyfriend.alpha',1);
end

function doSax()
    setProperty('sax.visible',true);
    setProperty('sax.scale.x',4);
    setProperty('sax.scale.y',4);
    doTweenScale('scaleTween', 'sax', 1, 0.6, 'quadIn');
    doTweenAngle('angleTween', 'sax', 720, 0.6, 'cubeIn');
end

function doZoomTweened(toGo, time)
    doTweenZoom('camtween','camGame',toGo,time,'smootherstepinout');
    setProperty('defaultCamZoom',toGo);
end