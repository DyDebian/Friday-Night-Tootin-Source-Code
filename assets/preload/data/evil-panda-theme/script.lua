local defaultNotePos = {};
local defaultZoom = 0.7;
local beat = false;
local shakearrow = false;
local shakearrow2 = false;
local hudmoveAngle = false;
local shakehud = false;
local DobleStaticNoteState = 0;
local DSNValue = 32;
local alphaNotes = true;

function onCreate()
    setProperty('skipArrowStartTween',true);
    makeLuaSprite('black','BlackBg',-400,0);
    makeLuaSprite('blackToTweenDad','BlackBg',-400,0);
    addLuaSprite('black',false);
    addLuaSprite('blackToTweenDad',true);
    setProperty('black.scale.x',2);
    setProperty('black.scale.y',2);
    setProperty('blackToTweenDad.scale.x',2);
    setProperty('blackToTweenDad.scale.y',2);
    setProperty('boyfriend.alpha',0);
    setProperty('gf.alpha',0);
    setProperty('iconP1.alpha', 0);
    setProperty('iconP2.alpha', 0);
    setProperty('healthBar.alpha', 0);
    setProperty('scoreTxt.alpha', 0);
end

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')


        table.insert(defaultNotePos, {x, y})
    end
end

function onUpdate(elapsed)
    if alphaNotes then
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 0);
        end
    end

    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if beat then --505 570
        if curStep < 1216 then
            --[[
            if curStep < 512 then
                setCamZoom('cam',0.98);
                setCamZoom('hud',1.07);
            elseif curStep < 700 then
                setCamZoom('cam',1.08);
                setCamZoom('hud',1.07);
            elseif (curStep >= 960 and curStep < 992) or (curStep >= 1024 and curStep < 1056) then
                setCamZoom('cam',1.08);
                setCamZoom('hud',1.07);
            --]]
            --else
            setCamZoom('cam',0.78);
            setCamZoom('hud',1.07);
            --end
        else
            setCamZoom('cam',0.79);
            setCamZoom('hud',0.90);--0.85
        end
        beat = false;
    end

    if hudmoveAngle then
        setProperty('camHUD.angle', 4 * math.sin(currentBeat));
    end

    if shakehud then
		setProperty('camHUD.x', 8 * math.sin((currentBeat * 15 + 0.25) * math.pi));
        setProperty('camHUD.y', 8 * math.cos((currentBeat * 15 + 0.25) * math.pi));
	end

    if shakearrow then
        for i=0,7 do
            --setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0) * math.pi))
        end
    end

    if shakearrow2 then
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0) * math.pi))
        end
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.15) * math.pi))
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    cameraShake('cam',0.01, 0.05);
end

function onStepHit()
    if curStep == 188 then
        alphaNotes = false;
        doTweenAlpha('blackTween','blackToTweenDad',0,2,'Linear');
        doTweenAlpha("tweeniconP2", 'iconP2', 1, 2, "linear");
        doTweenAlpha("tweenhealthBar", 'healthBar', 1, 2, "linear");
        doTweenAlpha("tweenscoreTxt", 'scoreTxt', 1, 2, "linear");
        if middlescroll == false then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        elseif middlescroll == true and showCpuMiddleScroll == true then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.6, "linear");
            end
        end
    end
    if curStep == 320 then
        setCamZoom('cam',1.2);
    end
    if curStep == 384 then
        setCamZoom('cam',1.2);
        --doTweenAlpha('bgtween','black',0.8,1,'Linear');
        doTweenAlpha('gftween','gf',1,1,'Linear'); --0.8
    end
    if curStep == 440 then
        for i = 4,7 do
            if middlescroll == false then
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 500);
            else
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 875);
            end
        end
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 1);
			noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
            noteTweenAngle("movementAngle " .. i, i, 360, 0.6, "linear");
		end
    end
    if curStep == 445 then
        doTweenAlpha('bftween','boyfriend',1,1,'Linear');
        doTweenAlpha("tweeniconP2", 'iconP1', 1, 1, "linear");
    end
    if curStep == 448 then
        doTweenAlpha('bgtween','black',0.8,1,'Linear');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 512 then
        setProperty('defaultCamZoom',1.0);
    end
    if curStep == 704 then
        doTweenZoom('camtween','camGame',defaultZoom,0.4,'sineinout');
        setProperty('defaultCamZoom',defaultZoom);
        doTweenAlpha('bgtween','black',0,1,'Linear');
        --doTweenAlpha('gftween','gf',1,1,'Linear');
    end
    if ((curStep >= 704 and curStep <= 1088 or curStep >= 1216 and curStep <= 1472) and curStep % 4 == 0) then
        beat = true;
    end
    if ((curStep >= 505 and curStep <= 512 or curStep >= 570 and curStep <= 576 or curStep >= 634 and curStep <= 640) and curStep % 1 == 0) then
        beat = true;
    end
    if curStep == 1216 then
        doTweenZoom('camtween','camGame',defaultZoom,0.4,'sineinout');
        setProperty('defaultCamZoom',defaultZoom);
        setCamZoom('cam',0.9);
        shakearrow = true;
        hudmoveAngle = true;
    end
    if curStep == 1344 then
        shakearrow = false;
        shakearrow2 = true;
    end
    if curStep == 960 or curStep == 1024 or curStep == 1088 or curStep == 1152 or curStep == 1200 or curStep == 1176 then
        setProperty('defaultCamZoom',1.0);
        setProperty('camHUD.angle', -5);
        shakehud = true;
    end
    if curStep == 976 or curStep == 1040 or curStep == 1104 or curStep == 1164 or curStep == 1168 or curStep == 1184 then
        setProperty('camHUD.angle', 5);
    end
    if curStep == 1166 or curStep == 1196 then
        setProperty('camHUD.angle', -10);
    end
    if curStep == 1208 then
        setProperty('camHUD.angle', 20);
    end
    if curStep == 992 or curStep == 1056 or curStep == 1120 or curStep == 1216 then
        setProperty('defaultCamZoom',defaultZoom);
        setProperty('camHUD.angle', 0);
        shakehud = false;
        setProperty('camHUD.x', 0);
        setProperty('camHUD.y', 0);
    end
    if curStep == 1472 then
        shakearrow2 = false;
        hudmoveAngle = false;
        resetStaticArrows();
        cameraShake('hud',0.15, 1);
        setProperty('blackToTweenDad.alpha',1);
        setProperty('iconP1.alpha', 0);
        setProperty('camHUD.angle', 0);
    end
    if curStep >= 832 and curStep <= 958 and curStep % 4 == 0 then
        DobleStaticNotes();
    end
    if curStep == 959 then
        resetStaticArrows();
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        --noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
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