function onStepHit()
    if curStep == 256 then
        doZoomTweened(0.8)
    end
    if curStep == 384 then
        setProperty('defaultCamZoom',0.7);
    end
    if curStep == 640 then
        doZoomTweened(0.88)
    end
    if curStep == 928 then
        setProperty('defaultCamZoom',0.7);
    end
    if (curStep >= 384 and curStep < 640 or curStep >= 944 and curStep < 1184) and curStep % 4 == 0 then
        setCamZoom('cam',0.65);
        setCamZoom('hud', 1.05);
    end
end

function doZoomTweened(toGo)
    doTweenZoom('camtween','camGame',toGo,0.6,'smootherstepinout');
    setProperty('defaultCamZoom',toGo);
end