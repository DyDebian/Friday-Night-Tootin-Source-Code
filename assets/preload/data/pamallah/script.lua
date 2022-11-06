local default = 0;

function onSongStart()
    default = getProperty('defaultCamZoom')
end

function onStepHit()
    if curStep >= 320 and curStep <= 832 and curStep % 4 == 0 then
        setCamZoom('hud', 1.05);
    end
    if curStep == 577 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 832 then
        setProperty('defaultCamZoom',default);
    end
end