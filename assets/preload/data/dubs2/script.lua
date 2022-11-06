local anglething = 1;

function onSongStart()
    setProperty('camZooming',true);
end

function onStepHit()
    if curStep == 532 or curStep == 564 or curStep == 596 or curStep == 628 then
        doZoomTweened(0.8,0.4);
    end
    if curStep == 536 or curStep == 568 or curStep == 600 or curStep == 632 then
        doZoomTweened(0.9,0.4);
    end
    if curStep == 540 or curStep == 572 or curStep == 604 or curStep == 636 then
        doZoomTweened(1,0.4);
    end
    if curStep == 544 or curStep == 576 or curStep == 608 or curStep == 640 then
        doZoomTweened(0.7,0.6);
    end
    if curStep == 56 or curStep == 120 then
        doZoomTweened(0.9,0.6);
    end
    if curStep == 64 or curStep == 128 then
        doZoomTweened(0.7,0.6);
    end
    if curStep == 256 then
        doZoomTweened(0.8,0.6);
    end
    if curStep == 504 then
        doZoomTweened(0.7,0.6);
    end
end

function doZoomTweened(toGo, time)
    doTweenZoom('camtween','camGame',toGo,time,'smootherstepinout');
    setProperty('defaultCamZoom',toGo);
end

function onBeatHit()
    if curBeat >= 133 and curBeat < 188 or curBeat >= 192 and curBeat < 255 then
        anglething = anglething * -1;
        setProperty('camHUD.angle',anglething*3)
        setProperty('camGame.angle',anglething*3)
        doTweenAngle('turn', 'camHUD', anglething, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -anglething*8, crochet*0.001, 'linear')
        doTweenAngle('tt', 'camGame', anglething, stepCrochet*0.002, 'circOut')
        doTweenX('ttrn', 'camGame', -anglething*8, crochet*0.001, 'linear')
    else
        resetCam();
    end
end

function resetCam()
    setProperty('camHUD.angle',0);
    setProperty('camGame.angle',0);
    setProperty('camHUD.x',0);
    setProperty('camGame.x',0);
end

function doZoomTweened(toGo, time)
    doTweenZoom('camtween','camGame',toGo,time,'smootherstepinout');
    setProperty('defaultCamZoom',toGo);
end