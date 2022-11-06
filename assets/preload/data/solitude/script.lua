local defaultNotePos = {};
local shakearrow = false;
local shakearrow2 = false;

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
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
           -- setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0)))
        end
    end
    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.15)))
           -- setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0)))
        end
    end
end

function onStepHit()
    if curStep == 352 then
        shakearrow = true;
        setCamZoom('cam',1.2)
    end
    if curStep == 703 then
        shakearrow = false;
        shakearrow2 = true;
        setCamZoom('cam',1.2)
    end
    if curStep == 1087 then
        shakearrow2 = false;
        for i=0,7 do
          --  tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
        end
    end
    if curStep == 320 or curStep == 326 or curStep == 332 or curStep == 338 or curStep == 344 or curStep == 356 or curStep == 362 or curStep == 368 or curStep == 374 or curStep == 384 or curStep == 390 or curStep == 396 or curStep == 402 or curStep == 408 or curStep == 420 or curStep == 426 or curStep == 432 or curStep == 438 or curStep == 484 or curStep == 490 or curStep == 496 or curStep == 502 or curStep == 548 or curStep == 554 or curStep == 560 or curStep == 566 then
        doTweenZoom('camtween','camGame',1,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',1);
    end
    if curStep == 323 or curStep == 329 or curStep == 335 or curStep == 341 or curStep == 352 or curStep == 358 or curStep == 364 or curStep == 370 or curStep == 376 or curStep == 386 or curStep == 392 or curStep == 398 or curStep == 404 or curStep == 410 or curStep == 422 or curStep == 428 or curStep == 434 or curStep == 440 or curStep == 486 or curStep == 492 or curStep == 498 or curStep == 504 or curStep == 550 or curStep == 556 or curStep == 562 or curStep == 568 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
end