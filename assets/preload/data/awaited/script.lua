function onStepHit()
    if curStep == 384 or curStep == 448 or curStep == 576 or curStep == 1152 or curStep == 1216 or curStep == 1344 then
        setCamZoom('cam',0.5);
        setCamZoom('hud',0.8);
    end
end