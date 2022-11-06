local defaultNotePos = {};
local beattime = 4;
local camzoombeat = false;
local shakearrow = false;
local arrowright = false;

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        table.insert(defaultNotePos, {x, y})
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
        end
    end

    if camzoombeat then
        setCamZoom('cam',0.75);
        setCamZoom('hud',1.05);
        camzoombeat = false;
    end
end

function onStepHit()
    if curStep == 352 then
        beattime = 2;
    end
    if curStep == 368 then
        beattime = 1;
    end
    if (curStep >= 128 and curStep <= 384 or curStep >= 1408 and curStep < 1664) and curStep % beattime == 0 then
        camzoombeat = true;
    end
    if curStep == 384 then
        shakearrow = true;
        camzoombeat = true;
    end
    if curStep == 640 then
        shakearrow = false;
        beattime = 4;
    end
    if curStep >= 640 and curStep <= 896 and curStep % beattime == 0 then
        camzoombeat = true;
        staticarrowbeat();
    end
    if curStep == 897 then
        resetStaticArrows()
    end
    if curStep == 384 or curStep == 416 or curStep == 448 or curStep == 480 or curStep == 512 or curStep == 544 or curStep == 576 or curStep == 608 then
        cameraFlash('cam','FFFFFF',2,true);
    end
    if curStep == 400 or curStep == 432 or curStep == 464 or curStep == 496 or curStep == 528 or curStep == 560 or curStep == 592 or curStep == 624 then
        cameraFlash('cam','008000',2,true);
    end
    if curStep == 1152 then
        cameraFlash('cam','B7D855',2);
    end
    if curStep == 1664 then
        doTweenZoom('camtween','camGame',1,1.2,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 1728 then
        doTweenZoom('camtween','camGame',0.7,0.8,'smootherstepinout');
        setProperty('defaultCamZoom',0.7);
    end
    if curStep == 1152 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 1407 then
        setProperty('defaultCamZoom',0.7);
    end
end

function staticarrowbeat()
    if arrowright == true then
        for i=0,7 do
            noteTweenX("movementX " .. i, i, getPropertyFromGroup('strumLineNotes', i, 'x') + 64, 0.2, "linear");
        end
        arrowright = false;
    elseif arrowright == false then
        for i=0,7 do
            noteTweenX("movementX " .. i, i, getPropertyFromGroup('strumLineNotes', i, 'x') - 64, 0.2, "linear");
        end
        arrowright = true;
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        --noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end