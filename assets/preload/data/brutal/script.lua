local defaultNotePos = {};
local camzoom = false;
local hudshake = false;
local onlyarrowhudshake = false;
local shakearrow = false;
local shakearrow2 = false;
local shakearrow3 = false;
local shakearrow4 = false;
local shakearrow5 = false;
local shakearrow6 = false;
local shakearrow7 = false;

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

    if camzoom == true then
        setCamZoom('cam',1.3);
        camzoom = false;
    end

    if hudshake then
        setProperty('camHUD.angle', 4 *math.sin(currentBeat));
        setProperty('camGame.angle',4 *math.sin(currentBeat));
    end

    if onlyarrowhudshake then
        setProperty('camHUD.angle', 6 *math.sin(currentBeat));
    end

    if shakearrow == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0) * math.pi))
           -- setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0)))
        end
    end

    if shakearrow2 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.15) * math.pi))
        end
    end

    if shakearrow3 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end

    if shakearrow4 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0)))
        end
    end

    if shakearrow5 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0) * math.pi))
        end
        if shakearrow6 == false then
            for i=0,7 do
                setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0) * math.pi))
            end
        end 
    end

    if shakearrow6 == true then
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end

    if shakearrow7 == true then
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end
end

function onStepHit()
    if curStep == 144 then
        --showOnlyStrums = true;
        --camzoom = true;
        shakearrow = true;
    end
    if curStep == 272 then
        shakearrow = false;
        shakearrow2 = true;
        --camzoom = true;
    end
    if curStep == 400 then
        shakearrow2 = false;
        shakearrow4 = true;
        --camzoom = true;
    end
    if curStep == 527 then
        shakearrow4 = false;
        shakearrow3 = true;
        hudshake = true;
        --camzoom = true;
    end
    if curStep == 655 then
        shakearrow3 = false;
        resetStaticArrows();
        hudshake = false;
        resetCam();
        showOnlyStrums = false;
    end
    if curStep == 848 then
        showOnlyStrums = true;
        shakearrow5 = true;
        --camzoom = true;
    end
    if curStep == 1120 then
        --camzoom = true;
        shakearrow6 = true;
        onlyarrowhudshake = true;
    end
    if curStep == 1175 then
        --camzoom = true;
        shakearrow6 = false;
        onlyarrowhudshake = false;
        resetCam();
    end
    if curStep == 1229 then
        --camzoom = true;
        shakearrow7 = true;
        onlyarrowhudshake = true;
    end
    if curStep == 1285 then
        shakearrow7 = false;
        shakearrow5 = false;
        onlyarrowhudshake = false;
        resetCam();
        --showOnlyStrums = false;
        resetStaticArrows();
    end
end

function resetCam()
    setProperty('camHUD.angle', 0);
    setProperty('camGame.angle',0);
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end