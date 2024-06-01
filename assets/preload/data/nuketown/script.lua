local defaultNotePos = {};
local defaultZoom = 0.72;
local Xforce = 25;
local Yforce = 5;
local minYforce = 5;
local maxYforce = 35;
local goMinY = false;
local goMaxY = false;
local arrow_wave = true;
local wavespeedIn = 0.05;
local wavespeedOut = 0.02;

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
--[[
    if curStep >= 0 and curStep < 12 or curStep >= 18 and curStep < 28 or curStep >= 34 and curStep < 44 or curStep >= 50 and curStep < 56 or curStep >= 320 and curStep < 332 or curStep >= 338 and curStep < 348 or curStep >= 354 and curStep < 364 or curStep >= 369 and curStep < 376 or curStep >= 384 and curStep < 397 or curStep >= 402 and curStep < 412 or curStep >= 417 and curStep < 428 or curStep >= 434 and curStep < 444 or curStep >= 450 and curStep < 461 or curStep >= 466 and curStep < 476 or curStep >= 482 and curStep < 492 or curStep >= 498 and curStep < 508 or curStep >= 514 and curStep < 524 or curStep >= 530 and curStep < 540 or curStep >= 546 and curStep < 556 or curStep >= 562 and curStep < 572 or curStep >= 578 and curStep < 588 or curStep >= 594 and curStep < 605 or curStep >= 610 and curStep < 620 or curStep >= 626 and curStep < 636 or curStep >= 640 and curStep < 652 or curStep >= 658 and curStep < 668 or curStep >= 674 and curStep < 684 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + Xforce * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + Yforce * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end
    if curStep >= 12 and curStep < 18 or curStep >= 28 and curStep < 34 or curStep >= 44 and curStep < 50 or curStep >= 652 and curStep < 658 or curStep >= 668 and curStep < 674 or curStep >= 684 and curStep < 691 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 25 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 25 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end
    if curStep >= 332 and curStep < 338 or curStep >= 348 and curStep < 354 or curStep >= 364 and curStep < 369 or curStep >= 397 and curStep < 402 or curStep >= 412 and curStep < 417 or curStep >= 428 and curStep < 434 or curStep >= 444 and curStep < 450 or curStep >= 461 and curStep < 466 or curStep >= 476 and curStep < 482 or curStep >= 492 and curStep < 498 or curStep >= 508 and curStep < 514 or curStep >= 524 and curStep < 530 or curStep >= 540 and curStep < 546 or curStep >= 556 and curStep < 562 or curStep >= 572 and curStep < 578 or curStep >= 588 and curStep < 594 or curStep >= 605 and curStep < 610 or curStep >= 620 and curStep < 626 or curStep >= 636 and curStep < 640 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 25 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 35 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end
    --]]
    if arrow_wave then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + Xforce * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + Yforce * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end

    if goMinY then
        Yforce = lerp(Yforce,minYforce,wavespeedOut);
    end

    if goMaxY then
        Yforce = lerp(Yforce,maxYforce,wavespeedIn);
    end
end

function onStepHit()
    if curStep == 56 then
        arrow_wave = false;
        goMinY = false;
        goMaxY = false;
        Yforce = 10;
        resetStaticArrows();
    end
    if curStep == 192 then
        setProperty('defaultCamZoom',0.82);
    end
    if curStep == 320 then
        setProperty('defaultCamZoom',defaultZoom);
        arrow_wave = true;
        Xforce = 30;
        minYforce = 10;
        maxYforce = 50;
    end
    if curStep == 375 then
        arrow_wave = false;
    end
    if curStep == 384 then
        arrow_wave = true;
        setCamZoom("cam",1.2);
    end
    if curStep == 640 then
        Xforce = 25;
        minYforce = 5;
        maxYforce = 35;
    end
    if curStep == 12 or curStep == 28 or curStep == 44 or curStep == 56 or curStep == 332 or curStep == 348 or curStep == 364 or curStep == 376 or curStep == 396 or curStep == 412 or curStep == 428 or curStep == 443 or curStep == 460 or curStep == 475 or curStep == 492 or curStep == 507 or curStep == 523 or curStep == 540 or curStep == 556 or curStep == 572 or curStep == 578 or curStep == 588 or curStep == 605 or curStep == 620 or curStep == 636 or curStep == 652 or curStep == 668 or curStep == 684 then
        goMinY = false;
        goMaxY = true;
    end
    if curStep == 18 or curStep == 34 or curStep == 50 or curStep == 320 or curStep == 338 or curStep == 354 or curStep == 369 or curStep == 384 or curStep == 402 or curStep == 417 or curStep == 434 or curStep == 449 or curStep == 465 or curStep == 482 or curStep == 498 or curStep == 513 or curStep == 530 or curStep == 546 or curStep == 562 or curStep == 578 or curStep == 594 or curStep == 610 or curStep == 626 or curStep == 640 or curStep == 658 or curStep == 674 then
        goMaxY = false;
        goMinY = true;
    end
    if curStep == 691 then
        arrow_wave = false;
        noteTweenX('notetween0x', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') - 100, 3, 'Linear')--3
        noteTweenX('notetween1x', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') - 50, 6, 'Linear')--6
        noteTweenX('notetween2x', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') + 50, 3, 'Linear')--3
        noteTweenX('notetween3x', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') + 100, 3, 'Linear')--3
        noteTweenX('notetween4x', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') - 100, 3, 'Linear')
        noteTweenX('notetween5x', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') - 50, 6, 'Linear')
        noteTweenX('notetween6x', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') + 50, 3, 'Linear')
        noteTweenX('notetween7x', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') + 100, 3, 'Linear')
        noteTweenY('notetween0y', 0, getPropertyFromGroup('strumLineNotes', 0, 'y') + 300, 3, 'Linear')--3
        noteTweenY('notetween1y', 1, getPropertyFromGroup('strumLineNotes', 1, 'y') + 325, 6, 'Linear')--6
        noteTweenY('notetween2y', 2, getPropertyFromGroup('strumLineNotes', 2, 'y') + 483, 3, 'Linear')--3
        noteTweenY('notetween3y', 3, getPropertyFromGroup('strumLineNotes', 3, 'y') + 602, 3, 'Linear')--3
        noteTweenY('notetween4y', 4, getPropertyFromGroup('strumLineNotes', 4, 'y') + 300, 3, 'Linear')
        noteTweenY('notetween5y', 5, getPropertyFromGroup('strumLineNotes', 5, 'y') + 325, 6, 'Linear')
        noteTweenY('notetween6y', 6, getPropertyFromGroup('strumLineNotes', 6, 'y') + 483, 3, 'Linear')
        noteTweenY('notetween7y', 7, getPropertyFromGroup('strumLineNotes', 7, 'y') + 602, 3, 'Linear')
        noteTweenAngle('notetweem0angle', 0, getPropertyFromGroup('strumLineNotes', 0, 'angle') - 60, 3, 'Linear')
        noteTweenAngle('notetweem1angle', 2, getPropertyFromGroup('strumLineNotes', 2, 'angle') + 30, 3, 'Linear')
        noteTweenAngle('notetweem2angle', 3, getPropertyFromGroup('strumLineNotes', 3, 'angle') + 60, 3, 'Linear')
        noteTweenAngle('notetweem1angle', 4, getPropertyFromGroup('strumLineNotes', 4, 'angle') - 60, 3, 'Linear')
        noteTweenAngle('notetweem2angle', 6, getPropertyFromGroup('strumLineNotes', 6, 'angle') + 30, 3, 'Linear')
        noteTweenAngle('notetweem3angle', 7, getPropertyFromGroup('strumLineNotes', 7, 'angle') + 30, 3, 'Linear')
        for i=0,7 do
            noteTweenAlpha('notetweemalpha'..i, i, 0, 1.5, 'Linear')
        end	
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end

function lerp(a,b,c)
    return a + c * (b-a);
end