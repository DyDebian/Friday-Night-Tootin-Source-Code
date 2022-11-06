function onStepHit()
    if curStep == 128 or curStep == 640 then
        setCamZoom('cam',0.8);
    end
    if (curStep >= 271 and curStep <= 512 or curStep >= 768 and curStep <= 1024) and curStep % 4 == 0 then
        setCamZoom('hud', 1.05);
    end
    if curStep == 218 or curStep == 730 then
        doTweenZoom('camtween','camGame',1.2,3.9,'smootherstepinout');
    end
    if curStep == 256 or curStep == 768 then
        cancelTween('camtween');
    end
end