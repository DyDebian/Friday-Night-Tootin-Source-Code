local defaultNotePos = {};
local default = 0;
local shakearrow = false;
local shakearrow2 = false;

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        table.insert(defaultNotePos, {x, y})
    end
    default = getProperty('defaultCamZoom')
    doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
    setProperty('defaultCamZoom',0.9);
    cameraFlash('cam','008000',1);
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0)))
        end
    end
    if shakearrow2 then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 5 * math.cos((currentBeat + i*0.45) * math.pi))
        end
    end
end

function onStepHit()
    if curStep == 64 or curStep == 832 then
        cameraFlash('cam','FFFFFF',1);
    end
    if curStep == 128 or curStep == 895 then
        setProperty('defaultCamZoom',default);
    end
    if (curStep >= 256 and curStep < 511 or curStep >= 1023 and curStep < 1535) and curStep % 4 == 0 then
        setCamZoom('hud', 1.07);
        if(not(curStep >= 1279 and curStep < 1343 or curStep >= 1407 and curStep < 1471)) then
            setCamZoom('cam', 0.75);
        end
    end
    if curStep == 644 then
        doTweenZoom('camtween','camGame',0.9,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 768 then
        shakearrow = true;
        setCamZoom('cam', 1.0);
        cameraFlash('cam','008000',1);
    end
    if curStep == 1024 or curStep == 1344 or curStep == 1472 then
        shakearrow = false;
        shakearrow2 = true;
    end
    if curStep == 1281 or curStep == 1408 then
        shakearrow2 = false;
        shakearrow = true;
    end
    if curStep == 1536 then
        shakearrow2 = false;
        for i = 0,7 do
            noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
            noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        end
    end
end

function onBeatHit()
    if curBeat == 49 or curBeat == 51 or curBeat == 53 or curBeat == 55 or curBeat == 57 or curBeat == 59 or curBeat == 61 or curBeat == 63 or curBeat == 241 or curBeat == 243 or curBeat == 245 or curBeat == 247 or curBeat == 249 or curBeat == 251 or curBeat == 253 or curBeat == 255 then
        setCamZoom('hud',1.1);
    end
end