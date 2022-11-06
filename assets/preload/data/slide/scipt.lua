function onCreate()
    makeLuaSprite('white','WhiteBg',-400,0);
    addLuaSprite('white',true);
    setProperty('white.scale.x',2);
    setProperty('white.scale.y',2);
    setProperty('white.alpha',0);
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if curStep >= 640 then
        cameraShake('cam',0.01, 0.05);
    end
end

function onStepHit()
    if curStep == 128 or curStep == 384 or curStep == 1152 then
        doTweenZoom('camtween','camGame',0.9,1.3,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 256 or curStep == 640 or curStep == 1280 then
        doTweenZoom('camtween','camGame',0.7,1.3,'smootherstepinout');
        setProperty('defaultCamZoom',0.7);
    end
    if curStep == 1420 then
        doTweenAlpha('bgtween','white',1,1.35,'Linear');
    end
end