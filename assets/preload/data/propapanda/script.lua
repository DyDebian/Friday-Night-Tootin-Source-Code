local defaultNotePos = {};
local camzoombeat = false;
local hudshake = false;
local camshake = false;
local camshakebig = false;
local hudshakebig = false;
local hudXmovebig = false;
local shakearrow = false;
local shakearrow2 = false;
local shakearrow3 = false;
local shakearrow4 = false;
local movearrow = false;
local alphaNotes = false;
local alphaNotes2 = false;

function onCreate()
    makeLuaSprite('black','BlackBg',-400,0);
    addLuaSprite('black',false);
    setProperty('black.scale.x',2);
    setProperty('black.scale.y',2);
    setProperty('black.alpha',0);
    setActorAlpha(0,'black');
end

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        alpha = getPropertyFromGroup('strumLineNotes', i, 'alpha')


        table.insert(defaultNotePos, {x, y, alpha})
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if camzoombeat == true then
        setCamZoom("cam",0.8);
        camzoombeat = false;
    end

    if camshakebig == true then
        setProperty('camGame.angle', 4 *math.sin(currentBeat) * math.pi);
    end

    if hudshakebig == true then
        setProperty('camHUD.angle', 4 *math.sin(currentBeat) * math.pi);
    end

    if hudshake == true then
        setProperty('camHUD.angle', 4 *math.sin(currentBeat));
    end

    if camshake == true then 
        setProperty('camGame.angle', 4 *math.sin(currentBeat));
    end

    if hudXmovebig == true then
        setProperty('camHUD.x', 12 *math.sin(currentBeat) * math.pi);
    end

    if shakearrow == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 128 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0)))
        end
    end

    if shakearrow2 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0) * math.pi*1.5))
        end
    end

    if shakearrow3 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 0 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0) * math.pi))
        end
    end

    if shakearrow4 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end

    if movearrow == true then
        if middlescroll == false then
            for i=0,3 do
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 300 * math.sin((currentBeat + i*0)) + 350)
                setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0) * math.pi))
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
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0) * math.pi))
        end
    end

    if alphaNotes then
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', defaultNotePos[i + 1][3] + 1 * math.sin((currentBeat + i*0.25) * math.pi))
        end
    end
    if alphaNotes2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', defaultNotePos[i + 1][3] + 1 * math.sin((currentBeat + i*0.25) * math.pi))
        end
    end
end

function onStepHit()
    if curStep == 128 then
        hudshake = true;
        shakearrow3 = true;
        camzoombeat = true;
    end
    if curStep == 256 then
        shakearrow3 = false;
        hudshake = false;
        resetCam();
        camzoombeat = true;
        shakearrow = true;
    end
    if curStep == 260 or curStep == 292 or curStep == 324 or curStep == 356 then
        shakearrow = false;
        camzoombeat = true;
        shakearrow2 = true;
        hudXmovebig = true;
    end
    if curStep == 288 or curStep == 320 or curStep == 352 then
        camzoombeat = true;
        shakearrow2 = false;
        shakearrow = true;
        hudXmovebig = false;
        resetCam();
    end
    if curStep == 384 then
        camzoombeat = true;
        shakearrow2 = false;
        shakearrow3 = true;
    end
    if curStep == 448 then
        shakearrow3 = false;
        shakearrow4 = true;
        camzoombeat = true;
        camshakebig = true;
        hudshakebig = true;
    end
    if curStep == 512 then
        camshakebig = false;
        hudshakebig = false;
        hudXmovebig = false;
        shakearrow4 = false;
        resetCam();
        resetStaticArrows();
    end
    if curStep == 752 then
        doTweenAlpha('bgtween','black',1,2.6,'circIn');
        doTweenAlpha('dadtween','dad',0,2.6,'circIn');
        doTweenAlpha('gftween','gf',0,2.6,'circIn');
        doTweenAlpha('bftween','boyfriend',0,2.6,'circIn');
    end
    if curStep == 788 then
        alphaNotes = true;
        doTweenAlpha('dadtween','dad',1,5.6,'circIn');
        doTweenAlpha('bftween','boyfriend',1,5.6,'circIn');
    end
    if curStep == 1044 then
        shakearrow3 = true;
        camzoombeat = true;
        hudshake = true;
    end
    if curStep == 1172 then
        camshake = true;
        camzoombeat = true;
    end
    if curStep == 1236 then
        camzoombeat = true;
        shakearrow3 = false;
        alphaNotes = false;
        alphaNotes2 = true;
        movearrow = true;
    end
    if curStep == 1300 then
        movearrow = false;
        camshake = false;
        hudshake = false;
        alphaNotes2 = false;
        resetCam();
        resetStaticArrows();
        doTweenAlpha('bgtween','black',0,0.6,'circIn');
        doTweenAlpha('gftween','gf',1,0.6,'circIn');
    end
end

function resetCam()
    setProperty('camHUD.angle', 0);
    setProperty('camHUD.x',0);
    setProperty('camGame.angle',0);
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        --noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
        noteTweenAlpha("noteAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end