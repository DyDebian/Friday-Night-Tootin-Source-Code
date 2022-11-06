math.randomseed(os.time());
local defaultNotePos = {};
local shakecam = false;
local shakecamforce = 4;
local shakehud = false;
local shakehudforce = 8;
local forcehudchoose = {-8,8,4,-4,12};
local curchoose = 1;
local lastchoose = curchoose;
local shakearrow = false;
local shakearrow2 = false;
local repeatt = false;

function onSongStart()
    setProperty('camZooming',true);
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')

        alpha = getPropertyFromGroup('strumLineNotes', i, 'alpha')

        table.insert(defaultNotePos, {x, y, angle, alpha})
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if repeatt then
        if curchoose ~= lastchoose then
            shakehudforce = forcehudchoose[curchoose];
            lastchoose = curchoose;
            repeatt = false;
        else
            curchoose = math.random(table.getn(forcehudchoose));
            --debugPrint(curchoose);
        end
    end

    if shakecam then
        setPropertyFromClass('flixel.FlxG','camera.angle',shakecamforce*math.sin(currentBeat));
    end

    if shakehud then
        setProperty('camHUD.angle', shakehudforce - math.sin(currentBeat) * math.pi);
    end

    if shakearrow then
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.25)))
        end
    end

    if shakearrow2 then
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 15 * math.cos((currentBeat + i*1)))
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if curStep >= 511 and curStep <= 543 or curStep >= 640 and curStep <= 670 or curStep >= 868 and curStep <= 896 or curStep >= 915 and curStep <= 928 then
        repeatt = true;
    end
    cameraShake('cam',0.01, 0.05);
end

function onStepHit()
    if curStep == 1 then
        setCamZoom('hud',1.1);
    end
    if curStep == 161 then
        shakecam = true;
        setCamZoom('hud',1.05);
        setCamZoom('cam',0.95);
    end
    if curStep == 321 or curStep == 832 then
        shakearrow = true;
    end
    if curStep == 352 or curStep == 864 then
        shakearrow = false;
        shakearrow2 = true;
    end
    if curStep == 448 then
        shakehud = true;
        shakecamforce = 4;
    end
    if curStep == 416 then
        shakearrow2 = false;
        shakecamforce = 2;
        resetStaticArrows();
    end
    if curStep == 929 then
        shakearrow2 = false;
        shakecam = false;
        shakehud = false;
        resetStaticArrows();
        setPropertyFromClass('flixel.FlxG','camera.angle',0);
        setProperty('camHUD.angle',0);
    end
    if curStep == 672 then
        shakecam = false;
        setPropertyFromClass('flixel.FlxG','camera.angle',0);
    end
    if curStep == 736 then
        shakecam = true;
    end
end

function onBeatHit()
    if curBeat % 4 == 0 then
        --setCamZoom('hud',1.05);
        setCamZoom('cam',0.75);
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end