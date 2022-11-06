local defaultNotePos = {};
local camzoom = false;
local dadFloat = false;
local shakearrow = false;
local shakearrow2 = false;

function onCreate()
    addCharacterToList('bf_tootin_shadow', 'bf');
    addCharacterToList('evil_bf_tootin_shadow', 'dad');
    makeLuaSprite('black','BlackBg',-400,0);
    makeLuaSprite('red','RedBg',-400,0);
    setProperty('black.scale.x',2);
    setProperty('black.scale.y',2);
    setProperty('red.scale.x',2);
    setProperty('red.scale.y',2);
    addLuaSprite('black',false);
    addLuaSprite('red',false);
    setProperty('black.alpha',1);
    setProperty('red.alpha',0);
    setProperty('limo.alpha',0);
    setProperty('gf.alpha',0);
    setProperty('skipArrowStartTween',true);
    triggerEvent('Change Character', 'bf', 'bf_tootin_shadow');
    triggerEvent('Change Character', 'dad', 'evil_bf_tootin_shadow');
end

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')


        table.insert(defaultNotePos, {x, y, angle})

        noteTweenAlpha("movementAlpha " .. i, i, 0, 0.6, "linear");
    end
    hideHudTweened(false);
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if camzoom then
        setCamZoom('cam',2);
        camzoom = false;
    end

    if dadFloat then
        setProperty('dad.x', getProperty('dad.x') + 5*math.sin(currentBeat));  --[[ type 1: x:5 y:0.8, type 2: x:2 y:0.6]]--
        setProperty('dad.y', getProperty('dad.y') + 0.8*math.cos(currentBeat));
    end

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 84 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.sin((currentBeat + i*1)))
        end
    end
    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 64 * math.sin((currentBeat + i*0.25)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 25 * math.cos((currentBeat + i*0.15) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'angle', defaultNotePos[i + 1][3] + 15 * math.sin((currentBeat + i*0)))
        end
    end
end

function onStepHit()
    
    if curStep == 319 or curStep == 351 or curStep == 383 or curStep == 415 then
		doTweenAlpha("tweenRedBg", 'red', 1, 0.6, "linear");
	end
	if curStep == 335 or curStep == 367 or curStep == 399 or curStep == 431 then
		doTweenAlpha("tweenRedBg", 'red', 0, 0.6, "linear");
	end
    if curStep == 439 then
        removeLuaSprite('red',true);
		triggerEvent('Change Character', 'bf', 'bf_tootin');
        triggerEvent('Change Character', 'dad', 'evil_bf_tootin');
        setProperty('boyfriend.alpha',0);
        setProperty('dad.alpha',0);
	end
    if curStep == 440 then
        if middlescroll == false then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        elseif middlescroll == true and showCpuMiddleScroll == true then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.6, "linear");
            end
        end
        doTweenAlpha("tweendad", 'dad', 1, 0.6, "linear");
	end
	if curStep == 568 then
		for i=4,7 do
			noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
		end
		doTweenAlpha("tweenbf", 'boyfriend', 1, 0.6, "linear");
	end
    if curStep == 704 then
        hideHudTweened(true);
		doTweenAlpha("tweenBlackBg", 'black', 0, 0.6, "linear");
        doTweenAlpha("tweenLimo", 'limo', 1, 0.6, "linear");
        doTweenAlpha("tweenGf", 'gf', 1, 0.6, "linear");
        shakearrow = true;
		camzoom = true;
	end
    if curStep == 720 then
        dadFloat = true;
    end
    if curStep == 992 then
		camzoom = true;
		shakearrow = false;
		shakearrow2 = true;
	end
    if curStep == 1148 then
		shakearrow2 = false;
        resetStaticArrows();
    end
    if curStep == 1472 then
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
    end
    if curStep == 1981 then
        dadFloat = false;
		doTweenAlpha("tweenDad", 'dad', 0, 0.6, "linear");
	end
end

function hideHudTweened(toShow)
    if toShow then
        doTweenAlpha("tweeniconP1", 'iconP1', 1, 0.6, "linear");
        doTweenAlpha("tweeniconP2", 'iconP2', 1, 0.6, "linear");
        doTweenAlpha("tweenhealthBar", 'healthBar', 1, 0.6, "linear");
        doTweenAlpha("tweenscoreTxt", 'scoreTxt', 1, 0.6, "linear");
    else
        doTweenAlpha("tweeniconP1", 'iconP1', 0, 0.6, "linear");
        doTweenAlpha("tweeniconP2", 'iconP2', 0, 0.6, "linear");
        doTweenAlpha("tweenhealthBar", 'healthBar', 0, 0.6, "linear");
        doTweenAlpha("tweenscoreTxt", 'scoreTxt', 0, 0.6, "linear");
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end