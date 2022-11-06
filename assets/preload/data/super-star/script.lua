function onStepHit()
    if curStep == 128 or curStep == 512 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 252 or curStep == 528 then
        setProperty('defaultCamZoom',0.7);
    end
end

function onBeatHit()
    if curBeat >= 64 and curBeat < 127 or curBeat >= 192 and curBeat < 255 or curBeat >= 132 and curBeat < 160 then
        if not(curBeat >= 132 and curBeat < 160) then
            setCamZoom('cam', 0.75);
        end
        setCamZoom('hud', 1.05);
    end
end