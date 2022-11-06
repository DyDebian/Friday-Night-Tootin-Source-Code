local defaultNotePos = {};
local DobleStaticNoteState = 0;
local LeftStaticNotePunchState = 0;
local DSNValue = 32;
local shakearrow = false;
local shakearrow2 = false;
local shakearrow3 = false;
local movearrow = false;
local hudshake = false;
local shakeforce = 4;
local hudmoveX = false;
local hudmoveY = false;
local xforce = 12;
local yforce = 12;
local pulseStaticNotesdad = false;
local pulseStaticNotesbf = false;
local noteScaledad = 0.99;
local noteScalebf = 0.99;
local dsongSpeed = 0;
local noteSpeedSin = false;

function onCreate()
    makeLuaSprite('black','BlackBg',-400,0);
    addLuaSprite('black',false);
    setProperty('black.scale.x',2);
    setProperty('black.scale.y',2);
    setProperty('black.alpha',0);
    makeLuaSprite('black_2','BlackBg',-400,0);
    addLuaSprite('black_2',true);
    setProperty('black_2.scale.x',2);
    setProperty('black_2.scale.y',2);
end

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        scale_x = getPropertyFromGroup('strumLineNotes', i, 'scale.x');

        scale_y = getPropertyFromGroup('strumLineNotes', i, 'scale.y');

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle');

        table.insert(defaultNotePos, {x, y, scale_x, scale_y, angle});
    end
    dsongSpeed = getProperty('songSpeed');
    doTweenAlpha('bgtween','black_2',0,15);
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if beat then
        setCamZoom('cam',1);
        beat = false;
    end

    if hudshake then
        setProperty('camHUD.angle', shakeforce * math.sin(currentBeat));
    end

    if hudmoveX then
        setProperty('camHUD.x', xforce * math.sin(currentBeat) * math.pi);
    end

    if hudmoveY then
        setProperty('camHUD.y', yforce * math.cos(currentBeat) * math.pi);
    end

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)));
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0)));
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][5] + 12 * math.cos((currentBeat + i*0)));
        end
    end

    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 20 * math.sin((currentBeat + i*0.25)));
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 20 * math.cos((currentBeat + i*1)));
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][5] + 12 * math.cos((currentBeat + i*1)));
        end
    end

    if shakearrow3 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 18 * math.sin((currentBeat + i*0)) * math.pi);
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 10 * math.cos((currentBeat + i*1)) * math.pi);
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][5] + 32 * math.cos((currentBeat + i*0)));
        end
    end

    if movearrow == true then
        if middlescroll == false then
            for i=0,3 do
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 300 * math.sin((currentBeat + i*0)) + 350)
                setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0) * math.pi))
                setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][5] + 32 * math.cos((currentBeat + i*0)));
            end
        end
        if middlescroll == true then
            for i=4,7 do
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] - 300 * math.sin((currentBeat + i*0)) - 100)
            end
        elseif middlescroll == false then
            for i=4,7 do
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] - 300 * math.sin((currentBeat + i*0)) - 275)
            end
        end
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][5] - 32 * math.cos((currentBeat + i*0)));
        end
    end

    if pulseStaticNotesdad == true and curStep % 4 == 0 then
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', defaultNotePos[i + 1][3]);
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', defaultNotePos[i + 1][4]);
        end
        noteScaledad = 0;
    end
    if pulseStaticNotesbf == true and curStep % 4 == 0 then
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', defaultNotePos[i + 1][3]);
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', defaultNotePos[i + 1][4]);
        end
        noteScalebf = 0;
    end
    if noteScaledad < 0.20 then
        noteScaledad = noteScaledad - elapsed*0.5;
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', defaultNotePos[i + 1][3] + noteScaledad);
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', defaultNotePos[i + 1][4] + noteScaledad);
        end
    end
    if noteScalebf < 0.20 then
        noteScalebf = noteScalebf - elapsed*0.5;
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', defaultNotePos[i + 1][3] + noteScalebf);
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', defaultNotePos[i + 1][4] + noteScalebf);
        end
    end

    if noteSpeedSin then
        setProperty('songSpeed', getProperty('songSpeed') + 0.015 * math.sin(currentBeat));
    end

    if getProperty('skipped') == true then
        cancelTween('bgtween');
        setProperty('black_2.alpha',0);
        setProperty('skipped',false);
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if curStep >= 2111 then
        cameraShake('cam',0.01, 0.05);
    end
end

function onStepHit()
    if curStep >= 1023 and curStep < 1149 and curStep % 4 == 0 then
        DobleStaticNotes();
    end
    if curStep == 1151 then
        resetStaticArrows();
    end
    if curStep >= 1279 and curStep < 1404 and curStep % 2 == 0 then
        LeftStaticNotePunch();
    end
    if curStep == 1279 then
        noteSpeedSin = true;
    end
    if curStep == 1407 then
        noteSpeedSin = false;
        resetStaticArrows();
        setProperty('songSpeed', dsongSpeed);
    end
    if curStep == 1915 then
        doTweenAlpha('bgtween','black',1,0.6,'circIn');
        doTweenAlpha('bgtween2','black_2',1,0.6,'circIn');
        doTweenAlpha('gftween','gf',0,0.6,'circIn');
    end
    if curStep == 2111 then
        doTweenAlpha('bgtween2','black_2',0,2,'circIn');
    end
    if curStep == 2623 then
        beat = true;
        pulseStaticNotesbf = true;
        pulseStaticNotesdad = true;
        shakearrow = true;
        hudshake = true;
        hudmoveX = true;
    end
    if curStep == 2879 then
        beat = true;
        shakearrow = false;
        shakearrow2 = true;
        hudshake = false;
        hudmoveX = false;
        hudmoveY = true;
        resetHud();
    end
    if curStep == 3135 then
        shakearrow2 = false;
        hudmoveY = false;
        resetHud();
        resetStaticArrows();
    end
    if curStep == 3647 then
        beat = true;
        shakearrow3 = true;
        hudmoveX = true;
        hudmoveY = true;
        xforce = 15;
        yforce = 15;
    end
    if curStep == 3903 then
        beat = true;
        shakearrow3 = false;
        shakearrow = true;
        hudshake = true;
    end
    if curStep == 4031 then
        beat = true;
        shakearrow = false;
        movearrow = true;
    end
    if curStep == 4160 then
        hudmoveX = false;
        hudmoveY = false;
        hudshake = false;
        movearrow = false;
        pulseStaticNotesdad = false;
        pulseStaticNotesbf = false;
        noteScaledad = 0.20;
        noteScalebf = 0.20;
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', defaultNotePos[i + 1][3]);
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', defaultNotePos[i + 1][4]);
        end
        resetHud();
        resetStaticArrows();
        doTweenAlpha('bgTween','black_2',1,1);
        doTweenAlpha("tweeniconP2", 'iconP2', 0, 1, "linear");
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
    end
end

function DobleStaticNotes()
    if DobleStaticNoteState == 0 then
        for i=4,5 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') + DSNValue, 0.1);
        end
        for i=6,7 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') - DSNValue, 0.1);
        end
        DobleStaticNoteState = 1;
    elseif DobleStaticNoteState == 1 then
        for i=4,5 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') - DSNValue, 0.1);
        end
        for i=6,7 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') + DSNValue, 0.1);
        end
        DobleStaticNoteState = 2;
    elseif DobleStaticNoteState == 2 then
        for i=4,5 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') - DSNValue, 0.1);
        end
        for i=6,7 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') + DSNValue, 0.1);
        end
        DobleStaticNoteState = 3;
    elseif DobleStaticNoteState == 3 then
        for i=4,5 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') + DSNValue, 0.1);
        end
        for i=6,7 do
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') - DSNValue, 0.1);
        end
        DobleStaticNoteState = 0;
    end
end

function LeftStaticNotePunch()
    if LeftStaticNotePunchState == 0 then
        noteTweenX("MovementX1", 4, getPropertyFromGroup('strumLineNotes', 4, 'x') - DSNValue, 0.1);
        LeftStaticNotePunchState = 1;
    elseif LeftStaticNotePunchState == 1 then
        noteTweenX("MovementX2", 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + DSNValue, 0.1);
        LeftStaticNotePunchState = 2;
    elseif LeftStaticNotePunchState == 2 then
        noteTweenX("MovementX3", 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + DSNValue, 0.1);
        noteTweenX("MovementX4", 6, getPropertyFromGroup('strumLineNotes', 6, 'x') + DSNValue, 0.1);
        noteTweenX("MovementX5", 7, getPropertyFromGroup('strumLineNotes', 7, 'x') + DSNValue, 0.1);
        LeftStaticNotePunchState = 3;
    elseif LeftStaticNotePunchState == 3 then
        noteTweenX("MovementX6", 7, getPropertyFromGroup('strumLineNotes', 7, 'x') + DSNValue, 0.1);
        LeftStaticNotePunchState = 4;
    elseif LeftStaticNotePunchState == 4 then
        noteTweenX("MovementX7", 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - DSNValue, 0.1);
        LeftStaticNotePunchState = 5;
    elseif LeftStaticNotePunchState == 5 then
        noteTweenX("MovementX8", 5, getPropertyFromGroup('strumLineNotes', 5, 'x') - DSNValue, 0.1);
        noteTweenX("MovementX9", 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - DSNValue, 0.1);
        LeftStaticNotePunchState = 6;
    elseif LeftStaticNotePunchState == 6 then
        noteTweenX("MovementX10", 4, getPropertyFromGroup('strumLineNotes', 4, 'x') - DSNValue, 0.1);
        LeftStaticNotePunchState = 7;
    elseif LeftStaticNotePunchState == 7 then
        noteTweenX("MovementX11", 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + DSNValue, 0.1);
        LeftStaticNotePunchState = 8;
    elseif LeftStaticNotePunchState == 8 then
        noteTweenX("MovementX12", 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + DSNValue, 0.1);
        noteTweenX("MovementX13", 6, getPropertyFromGroup('strumLineNotes', 6, 'x') + DSNValue, 0.1);
        LeftStaticNotePunchState = 9;
    elseif LeftStaticNotePunchState == 9 then
        noteTweenX("MovementX14", 7, getPropertyFromGroup('strumLineNotes', 7, 'x') + DSNValue, 0.1);
        LeftStaticNotePunchState = 10;
    elseif LeftStaticNotePunchState == 10 then
        noteTweenX("MovementX15", 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - DSNValue, 0.1);
        LeftStaticNotePunchState = 11;
    elseif LeftStaticNotePunchState == 11 then
        noteTweenX("MovementX16", 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - DSNValue, 0.1);
        noteTweenX("MovementX17", 5, getPropertyFromGroup('strumLineNotes', 5, 'x') - DSNValue, 0.1);
        noteTweenX("MovementX18", 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - DSNValue, 0.1);
        LeftStaticNotePunchState = 0;
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        noteTweenAngle("angleTween" .. i, i,  defaultNotePos[i + 1][5], 0.6, "linear");
    end
end

function resetHud()
    setProperty('camHUD.angle', 0);
    setProperty('camHUD.x', 0);
    setProperty('camHUD.y', 0);
end