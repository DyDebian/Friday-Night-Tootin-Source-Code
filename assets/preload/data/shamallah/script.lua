function onStepHit()
    if curStep == 192 or curStep == 832 then
        doZoomTweened(0.8);
    end
    if curStep == 320 then
        doZoomTweened(0.7);
    end
    if curStep == 448 or curStep == 1088 then
        doZoomTweened(0.86);
    end
    if curStep == 704 or curStep == 1343 then
        doZoomTweened(0.7);
    end
end

function doZoomTweened(toGo)
    doTweenZoom('camtween','camGame',toGo,0.6,'smootherstepinout');
    setProperty('defaultCamZoom',toGo);
end
