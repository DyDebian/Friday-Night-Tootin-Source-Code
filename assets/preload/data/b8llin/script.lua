local defaultNotePos = {};
local shakearrow = false;
local shakearrow2 = false;
local ii=0.5;

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
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0)))
        end
    end
    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*ii)))
        end
    end
end

function onStepHit()
    if curStep == 320 then
        shakearrow = true;
        setCamZoom('cam',1.4);
        setHudZoom('cam',1.3);
    end
    if curStep == 448 then
        shakearrow = false;
        shakearrow2 = true;
        setCamZoom('cam',1.4);
        setHudZoom('cam',1.3);
    end
    if curStep == 576 then
        ii=0.2;
        setCamZoom('cam',1.4);
        setHudZoom('cam',1.3);
    end
    if curStep == 704 then
        ii=0;
        setCamZoom('cam',1.4);
        setHudZoom('cam',1.3);
    end
    if curStep == 830 then
        shakearrow2 = false;
        for i = 0,7 do
            noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
            noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        end
    end
end