local defaultNotePos = {};
local alphaNotes = true;
local dad_x=0;
local bf_x=0;
local shakearrow=false;
local shakearrow2=false;
local shakearrow3 = false;
local hudmoveAngle=false;
local hudmove=false;
local anglething = 1;
local forcehudchoose = {-8,8,4,-4,12};
local curchoose = 1;
local lastchoose = curchoose;
local changeHudAngle = false;
local shakehud = false;

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
    addCharacterToList('evil_panda_side','dad');
    addCharacterToList('bf_tootin_side','bf');
end

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle');

        table.insert(defaultNotePos, {x, y, angle})
    end
    dad_x=getCharacterX('dad');
    bf_x=getCharacterX('boyfriend');
    changeSide(false);
end

function onUpdate(elapsed)
    if alphaNotes then
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 0);
        end
    end

    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if hudmoveAngle then
        setProperty('camHUD.angle', 4 * math.sin(currentBeat));
    end

    if hudmove then
        setProperty('camHUD.x', 12* math.sin(currentBeat) * math.pi);
        setProperty('camHUD.y', 12* math.cos(currentBeat) * math.pi);
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
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + 1.2 * math.sin((currentBeat + i*0) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y') + 0.6 * math.cos((currentBeat + i*0.45) * math.pi))
        end
    end
    if shakearrow3 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + 1.2 * math.sin((currentBeat + i*0) * math.pi))
            --setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y') + 0.6 * math.cos((currentBeat + i*0.45) * math.pi))
        end
    end

    if changeHudAngle then
        if curchoose ~= lastchoose then
            setProperty('camHUD.angle', forcehudchoose[curchoose]);
            lastchoose = curchoose;
            changeHudAngle = false;
        else
            curchoose = math.random(table.getn(forcehudchoose));
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    cameraShake('cam',0.01, 0.05);
end

function onStepHit()
    if curStep == 128 then
        setCamZoom('cam',1.2);
        alphaNotes = false;
        doTweenAlpha('blackTween','blackToTweenDad',0,2,'Linear');
        doTweenAlpha("tweeniconP2", 'iconP2', 1, 2, "linear");
        doTweenAlpha("tweenhealthBar", 'healthBar', 1, 2, "linear");
        doTweenAlpha("tweenscoreTxt", 'scoreTxt', 1, 2, "linear");
        --doTweenAlpha('bgtween','black',0.9,1,'Linear');
        --doTweenAlpha('gftween','gf',0.1,1,'Linear');
        if middlescroll == false then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        elseif middlescroll == true and showCpuMiddleScroll == true then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.6, "linear");
            end
        end
        doTweenAlpha('gftween','gf',1,1,'Linear');
    end
    if curStep == 252 then
        --removeLuaSprite('blackToTweenDad',true);
        doTweenAlpha('bftween','boyfriend',1,1,'Linear');
        doTweenAlpha("tweeniconP2", 'iconP1', 1, 1, "linear");
        for i=4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i , 'y') - 100);
            noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            noteTweenY("movementY " .. i, i, getPropertyFromGroup('strumLineNotes', i , 'y') + 100, 0.6, "linear");
        end
    end
    if curStep == 256 then
        doTweenAlpha('bgtween','black',0.9,1,'Linear');
    end
    if curStep == 384 then
        setCamZoom('cam',1.2);
        doTweenAlpha('bgtween','black',0,1,'Linear');
        --doTweenAlpha('gftween','gf',1,1,'Linear');
        changeSide(true);
    end
    if curStep == 896 then
        if middlescroll == true and showCpuMiddleScroll == false then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0, 0.6, "linear");
            end
        elseif middlescroll == true and showCpuMiddleScroll == true then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.6, "linear");
            end
        elseif middlescroll == false then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        end
        shakearrow = false;
        hudmoveAngle = false;
        setProperty('camHUD.angle',0);
        for i=0,7 do
            noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        end
        shakearrow3 = true;
        setCamZoom('cam',1.2);
        doTweenAlpha('bgtween','black',0.8,1,'Linear');
        --doTweenAlpha('gftween','gf',0.2,1,'Linear');
        --changeSide(false);
        resetStaticArrows();
    end
    if curStep == 512 or curStep == 1280 then
        changeHudAngle = true;
        shakehud = true;
        doTweenAlpha('bgtween','black',0.7,0.6,'Linear');
        doZoomTweened(0.9, 0.6);
    end
    if curStep == 640 then
        shakehud = false;
        resetHud();
        for i=4,7 do
            if middlescroll == false then
                noteTweenX('notetweenxbf'..i, i, getPropertyFromGroup('strumLineNotes', i, 'x') - 320, 0.6, 'Linear')
                noteTweenAngle('notetweemanglebf'..i, i, getPropertyFromGroup('strumLineNotes', i, 'angle') - 360, 0.6, 'Linear')
            end
        end
        if middlescroll == false then
            for i=0,3 do
                noteTweenX('notetweenxdad'..i, i, getPropertyFromGroup('strumLineNotes', i, 'x') + 320, 0.6, 'Linear')
                noteTweenAngle('notetweemangledad'..i, i, getPropertyFromGroup('strumLineNotes', i, 'angle') + 360, 0.6, 'Linear')
            end
        elseif middlescroll == true then
            for i=0,1 do
                noteTweenX('notetweenxdad'..i, i, getPropertyFromGroup('strumLineNotes', i, 'x') + 330, 0.6, 'Linear')
                noteTweenAngle('notetweemangledad'..i, i, getPropertyFromGroup('strumLineNotes', i, 'angle') + 360, 0.6, 'Linear')
            end
            for i=2,3 do
                noteTweenX('notetweenxdad'..i, i, getPropertyFromGroup('strumLineNotes', i, 'x') - 335, 0.6, 'Linear')
                noteTweenAngle('notetweemanglebf'..i, i, getPropertyFromGroup('strumLineNotes', i, 'angle') - 360, 0.6, 'Linear')
            end
        end
        for i=0,3 do
            noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.6, "linear");
        end
        shakearrow = true;
        hudmoveAngle = true;
        doTweenAlpha('bgtween','black',0,0.6,'Linear');
        doZoomTweened(0.7, 0.6);
    end
    if curStep == 649 then
        for i=0,7 do
            noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
        end
    end
    if curStep == 1152 then
        shakearrow3 = false;
        setCamZoom('cam',1.2);
        doTweenAlpha('bgtween','black',0,1,'Linear');
        --doTweenAlpha('gftween','gf',1,1,'Linear');
        --changeSide(true);
        resetStaticArrows();
    end
    if curStep == 736 or curStep == 864 then
        shakearrow = false;
        shakearrow2 = true;
        hudmove = true;
    end
    if curStep == 768 or curStep == 895 then
        shakearrow2 = false;
        shakearrow = true;
        hudmove = false;
        resetHud();
    end
    if curStep == 524 or curStep == 536 or curStep == 544 or curStep == 556 or curStep == 568 or curStep == 576 or curStep == 588 or curStep == 600 or curStep == 608 or curStep == 620 or curStep == 632 or curStep == 1292 or curStep == 1304 or curStep == 1312 or curStep == 1324 or curStep == 1336 or curStep == 1344 or curStep == 1356 or curStep == 1368 or curStep == 1376 or curStep == 1388 or curStep == 1400 then
        changeHudAngle = true;
    end
    if curStep == 1408 then
        shakehud = false;
        resetCam();
        cameraFlash('cam', 'FF0000',1);
        setProperty('blackToTweenDad.alpha',0.8);
        doZoomTweened(1.4,0.3);
    end
    if curStep == 1536 then
        removeLuaSprite('black');
        cameraFlash('cam', 'FF0000',1);
        setProperty('blackToTweenDad.alpha',1);
    end
end

function onBeatHit()
    if curBeat >= 224 and curBeat < 288 then
        camBeat();
    end
    if curBeat == 288 then
        resetCam();
    end
end

function changeSide(goBack)
    if curStep > 10 then
        cameraShake('hud',0.02,0.2);
    end
    if goBack == false then
        triggerEvent('Change Character', 'dad', 'evil_panda_side');
        triggerEvent('Change Character', 'bf', 'bf_tootin_side');
        setProperty('dad.x',bf_x);
        setProperty('boyfriend.x',dad_x);
        setPropertyFromGroup('strumLineNotes', 0, 'x', defaultNotePos[5][1]);
        setPropertyFromGroup('strumLineNotes', 1, 'x', defaultNotePos[6][1]);
        setPropertyFromGroup('strumLineNotes', 2, 'x', defaultNotePos[7][1]);
        setPropertyFromGroup('strumLineNotes', 3, 'x', defaultNotePos[8][1]);
        setPropertyFromGroup('strumLineNotes', 4, 'x', defaultNotePos[1][1]);
        setPropertyFromGroup('strumLineNotes', 5, 'x', defaultNotePos[2][1]);
        setPropertyFromGroup('strumLineNotes', 6, 'x', defaultNotePos[3][1]);
        setPropertyFromGroup('strumLineNotes', 7, 'x', defaultNotePos[4][1]);
    else
        triggerEvent('Change Character', 'dad', 'evil_panda');
        triggerEvent('Change Character', 'bf', 'bf_tootin');
        setProperty('dad.x',dad_x);
        setProperty('boyfriend.x',bf_x);
        setPropertyFromGroup('strumLineNotes', 0, 'x', defaultNotePos[1][1]);
        setPropertyFromGroup('strumLineNotes', 1, 'x', defaultNotePos[2][1]);
        setPropertyFromGroup('strumLineNotes', 2, 'x', defaultNotePos[3][1]);
        setPropertyFromGroup('strumLineNotes', 3, 'x', defaultNotePos[4][1]);
        setPropertyFromGroup('strumLineNotes', 4, 'x', defaultNotePos[5][1]);
        setPropertyFromGroup('strumLineNotes', 5, 'x', defaultNotePos[6][1]);
        setPropertyFromGroup('strumLineNotes', 6, 'x', defaultNotePos[7][1]);
        setPropertyFromGroup('strumLineNotes', 7, 'x', defaultNotePos[8][1]);
    end
    if shaderEffects then
        resetShader('dad');
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        --noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end

function camBeat()
    anglething = anglething * -1;
    setProperty('camHUD.angle',anglething*3)
    setProperty('camGame.angle',anglething*3)
    doTweenAngle('turn', 'camHUD', anglething, stepCrochet*0.002, 'circOut')
    doTweenX('tuin', 'camHUD', -anglething*8, crochet*0.001, 'linear')
    doTweenAngle('tt', 'camGame', anglething, stepCrochet*0.002, 'circOut')
    doTweenX('ttrn', 'camGame', -anglething*8, crochet*0.001, 'linear')
end

function resetCam()
    setProperty('camHUD.angle',0);
    setProperty('camGame.angle',0);
    setProperty('camHUD.x',0);
    setProperty('camGame.x',0);
end

function resetHud()
    setProperty('camHUD.x',0);
    setProperty('camHUD.y',0);
end

function doZoomTweened(toGo, time)
    doTweenZoom('camtween','camGame',toGo,time,'smootherstepinout');
    setProperty('defaultCamZoom',toGo);
end