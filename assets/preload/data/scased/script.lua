local defaultNotePos = {};
local bigshakearrow = false;
local shakearrow = false;
local shakearrow2 = false;

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')


        table.insert(defaultNotePos, {x, y, angle})
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0)))
        end
    end
    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 64 * math.cos((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][3] + 10 * math.sin((currentBeat + i*0)))
        end
    end
    if bigshakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0.25) * math.pi + 5));
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 64 * math.cos((currentBeat + i*0.25) * math.pi + 5));
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][3] + 32 * math.cos((currentBeat + i*0.25) * math.pi + 5));
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if curStep >= 512 and curStep <= 526 then
        shakecam();
    elseif curStep >= 528 and curStep <= 536 then
        shakecam();
    elseif curStep >= 831 and curStep <= 839 then
        shakecam();
    end
    setProperty('health', getProperty('health') - 0.0085);
end

function onStepHit()
    if curStep == 512 then
        shakearrow = false;
        setProperty('gf.alpha',0);
        bigshakearrow = true
        setCamZoom('cam',1.4)
    end
    if curStep == 528 then
        setCamZoom('cam',1.4)
    end
    if curStep == 576 then
        doTweenAlpha("tween", 'gf', 1, 0.6, "linear");
        bigshakearrow = false
        resetStaticArrows(0.6);
    end
    if curStep == 831 then
        setProperty('gf.alpha',0);
        setCamZoom('cam',1.4)
    end
    if curStep == 911 then
        doTweenAlpha("tween", 'gf', 1, 0.6, "linear");
    end
    if curStep == 192 then
        setCamZoom('cam',1.4)
    end
    if curStep == 200 then
        setCamZoom('cam',1.4)
    end
    if curStep == 208 then
        setCamZoom('cam',1.4)
    end
    if curStep == 216 then
        setCamZoom('cam',1.4)
    end
    if curStep == 224 then
        setCamZoom('cam',1.4)
    end
    if curStep == 232 then
        setCamZoom('cam',1.4)
    end
    if curStep == 255 then
        shakearrow = true;
        setCamZoom('cam',1.4)
    end
    if curStep == 656 then
        shakearrow2 = true;
        setCamZoom('cam',1.4)
    end
    if curStep == 783 then
        shakearrow2 = false;
        resetStaticArrows(0.6);
    end
end

function shakecam()
    cameraShake('cam',0.02,0.2);
end

function resetStaticArrows(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], time, "linear");
    end
end