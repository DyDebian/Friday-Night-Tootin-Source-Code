local defaultNotePos = {};
local shakearrow = false;

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
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 12 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 12 * math.cos((currentBeat + i*0.25)))
        end
    end
end

function onStepHit()
    if curStep == 384 then
        shakearrow = true;
    end
    if curStep == 640 then
        shakearrow = false;
        resetStaticArrows();
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
    end
end