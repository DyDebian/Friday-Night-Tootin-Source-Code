function onCreate()
    makeLuaSprite('black','BlackBg',-400,0);
    addLuaSprite('black',true);
    setProperty('black.scale.x',3);
    setProperty('black.scale.y',3);
    setObjectCamera('black','hud');
end

function onStepHit()
    if curStep == 44 or curStep == 940 then
        doTweenAlpha('bgtween','black',0,6.5,'linear');
    end
    if curStep == 896 then
        cameraFlash('hud', '9A6AF1',1);
        setProperty('black.alpha',1);
    end
end

function onBeatHit()
    if curBeat >= 32 and curBeat < 63 or curBeat >= 64 and curBeat < 127 or curBeat >= 160 and curBeat < 224 then
        if not(curBeat >= 32 and curBeat < 63) then
            setCamZoom('cam',0.75);
        end
        setCamZoom('hud',1.05)
    end
end