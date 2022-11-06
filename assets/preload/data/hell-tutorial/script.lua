math.randomseed(os.time());
local defaultNotePos = {};
local shakearrow = true;
local shakearrowdad = false;
local shakearrowbf = false;

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
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.25)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25)))
        end
    end
    if shakearrowbf then
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + 0.5 * math.sin((currentBeat + i*0.25)))
            setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y') + 0.5 * math.cos((currentBeat + i*0.25)))
        end
    end
    if shakearrowdad then
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.25)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25)))
        end
    end
end

function onStepHit()
    if curStep == 416 then
        shakearrowbf = false;
        shakearrowdad = false;
        endNote();
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if curStep >= 200 and curStep <= 206 or curStep >= 265 and curStep <= 269 or curStep >= 281 and curStep <= 285 or curStep >= 330 and curStep <= 333 or curStep >= 217 and curStep <= 222 then
        if shakearrow == true then
            shakearrow = false;
        end
        shakearrowbf = false;
        setProperty('camHUD.angle',rangeRandom(-10,10));
        cameraShake('hud',0.02,0.2);
        randomNote();
        shakearrowbf = true;
        if shakearrowdad == false then
            shakearrowdad = true;
        end
    end
end

function rangeRandom(min, max)
    return math.random(min,max);
end

function randomNote()
    for i = 4,7 do 
        setPropertyFromGroup('strumLineNotes', i, 'x', 
        defaultNotePos[i + 1][1] + math.floor(math.random(-100,100)))

        if downscroll == true then 
            ymin = 30;
            ymax = -80;
        else 
            ymin = -30
            ymax = 80;
        end

        setPropertyFromGroup('strumLineNotes', i, 'y', 
        defaultNotePos[i + 1][2] + math.floor(math.random(ymin,ymax)))

        setPropertyFromGroup('strumLineNotes', i, 'angle', 
        defaultNotePos[i + 1][3] + math.floor(math.random(-360,360)))
    end
end

function endNote()
    noteTweenX('notetween0x', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') - 100, 3, 'Linear')
    noteTweenX('notetween1x', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') - 50, 6, 'Linear')
    noteTweenX('notetween2x', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') + 50, 3, 'Linear')
    noteTweenX('notetween3x', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') + 100, 3, 'Linear')
    noteTweenX('notetween4x', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') - 100, 3, 'Linear')
    noteTweenX('notetween5x', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') - 50, 6, 'Linear')
    noteTweenX('notetween6x', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') + 50, 3, 'Linear')
    noteTweenX('notetween7x', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') + 100, 3, 'Linear')
    noteTweenY('notetween0y', 0, getPropertyFromGroup('strumLineNotes', 0, 'y') + 300, 3, 'Linear')
    noteTweenY('notetween1y', 1, getPropertyFromGroup('strumLineNotes', 1, 'y') + 325, 6, 'Linear')
    noteTweenY('notetween2y', 2, getPropertyFromGroup('strumLineNotes', 2, 'y') + 483, 3, 'Linear')
    noteTweenY('notetween3y', 3, getPropertyFromGroup('strumLineNotes', 3, 'y') + 602, 3, 'Linear')
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