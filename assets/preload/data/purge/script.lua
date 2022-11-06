local defaultNotePos = {};
local hudbeat = false;
local hudbeattime = 4;
local hudXmove = false;
local hudYmove = false;
local hudXmovebig = false;
local hudYmovebig = false;
local hudshake = false;
local force=32;
local camzoombeat = false;
local gunbeat = false;
local yamount = 35;
local yamountsmall = 15;
local xamount = 30;
local xamountsmall = 10;
local doybump = true;
local shakearrow = false;
local shakearrow2 = false;

function onCreate()
    addCharacterToList('pico-speaker-tootin-clone','gf');
end

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

    if hudbeat == true then
        setCamZoom("hud",1.05);
        setCamZoom("cam",0.8);
        hudbeat = false;
    end

    if hudXmove == true then
        setProperty('camHUD.x', force *math.sin(currentBeat));
    end

    if hudYmove == true then
        setProperty('camHUD.y', force *math.cos(currentBeat));
    end

    if hudXmovebig then
        setProperty('camHUD.x', force *math.sin(currentBeat) * math.pi);
    end

    if hudYmovebig then
        setProperty('camHUD.y', force *math.cos(currentBeat) * math.pi);
    end

    if hudshake == true then
        setProperty('camHUD.angle', 4 *math.sin(currentBeat));
    end

    if camzoombeat == true then
        setCamZoom("cam",0.8);
        camzoombeat = false;
    end
    
    if shakearrow == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.25)))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 0 * math.cos((currentBeat + i*0) * math.pi))
        end
    end

    if shakearrow2 == true then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0) * math.pi))
        end
    end
end

function onStepHit()
    if curStep == 1 then
        for i=0,7 do
            noteTweenAlpha("movementAlphaTween " .. i, i, 0, 0.6, "linear");
        end
    end
    if curStep == 64 then
        if middlescroll == false then
            for i=0,7 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        elseif middlescroll == true and showCpuMiddleScroll == true then
            for i=0,3 do
                noteTweenAlpha("movementAlpha " .. i, i, 0.35, 0.6, "linear");
            end
            for i=4,7 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        elseif middlescroll == true and showCpuMiddleScroll == false then
            for i=4,7 do
                noteTweenAlpha("movementAlpha " .. i, i, 1, 0.6, "linear");
            end
        end
    end
    if curStep == 128 then
        setCamZoom("hud",2);
    end
    if curStep == 383 then
        hudXmove = true;
    end
    if curStep >= 383 and curStep < 640 and curStep % hudbeattime == 0 or curStep >= 1279 and curStep <= 1527 and curStep % hudbeattime == 0 then
        hudbeat = true;
        arrowBump(xamount,xamountsmall,0.2);
        if doybump == true then
            arrowBumpYaxis(yamount,yamountsmall,0.2);
            yamount = yamount * -1;
            yamountsmall = yamountsmall * -1;
        end
    end
    if curStep >= 1024 and curStep <= 1263 and curStep % 4 == 0 then
        arrowBump(xamount,xamountsmall,0.2);
        arrowBumpYaxis(yamount,yamountsmall,0.2);
        yamount = yamount * -1;
        yamountsmall = yamountsmall * -1;
    end
    if curStep == 640 then
        hudXmove = false;
        resetHud();
    end
    if curStep == 672 then
        camzoombeat = true;
        hudYmove = true;
        force = 12;
        shakearrow = true;
    end
    if curStep == 895 then
        triggerEvent('Change Character', 'gf', 'pico-speaker-tootin-clone');
        setProperty('gf.x', getProperty('gf.x') - 115);
    end
    if curStep == 896 then
        hudYmove = false;
        resetHud();
        gunbeat = true;
        hudbeattime = 1;
        shakearrow = false;
        resetStaticArrows();
    end
    if curStep == 1024 then
        triggerEvent('Change Character', 'gf', 'gf');
        camzoombeat = true;
        force = 32;
        hudXmove = true;
    end
    if curStep == 1279 then
        hudXmove = false;
        force = 12;
        resetHud();
        hudshake = true;
        hudXmovebig = true;
        hudYmovebig = true;
        shakearrow2 = true;
    end
    if curStep == 1535 then
        hudshake = false;
        hudXmovebig = false;
        hudYmovebig = false;
        resetHud();
        shakearrow2 = false;
        resetStaticArrows();
    end
    if curStep >= 896 and curStep <= 1023 and gunbeat == true and curStep % hudbeattime == 0 then
        camzoombeat = true;
        --objectPlayAnimation('gf', 'shoot' + math.random(1,4), true);
    end
    if curStep == 899 or curStep == 905 or curStep == 915 or curStep == 921 or curStep == 927 or curStep == 931 or curStep == 937 or curStep == 943 or curStep == 949 or curStep == 955 or curStep == 963 or curStep == 969 or curStep == 979 or curStep == 985 or curStep == 911 or curStep == 995 or curStep == 1001 or curStep == 1007 or curStep == 1013 then
        hudbeattime = 2;
    end
    if curStep == 902 or curStep == 912 or curStep == 918 or curStep == 924 or curStep == 928 or curStep == 934 or curStep == 940 or curStep == 946 or curStep == 952 or curStep == 960 or curStep == 966 or curStep == 976 or curStep == 982 or curStep == 988 or curStep == 992 or curStep == 998 or curStep == 1004 or curStep == 1009 then
        hudbeattime = 1;
    end
    if curStep == 909 or curStep == 973 or curStep == 1015 or curStep == 953 then
        gunbeat = false;
    end
    if curStep == 912 or curStep == 976 or curStep == 960 then
        gunbeat = true;
    end
    if curStep == 1015 then
        hudbeattime = 4;
    end
    if curStep == 1278 then
        xamount = 25;
        xamountsmall = 10;
        doybump = false;
    end
end

function arrowBump(amount, smallamount, time)
    for i = 0,7 do
        thing = 0;
        if i == 4 or i == 0 then
            thing = -amount
        end
        if i == 5 or i == 1 then
            thing = -smallamount
        end
        if i == 6 or i == 2 then
            thing = smallamount
        end
        if i == 7 or i == 3 then
            thing = amount
        end
        setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + thing);
        noteTweenX("movementXbump " .. i, i, defaultNotePos[i + 1][1], time, "linear");
    end
end

function arrowBumpYaxis(amount, smallamount, time)
    for i = 0,7 do
        thing = 0;
        if i == 4 or i == 0 then
            thing = -amount
        end
        if i == 5 or i == 1 then
            thing = -smallamount
        end
        if i == 6 or i == 2 then
            thing = smallamount
        end
        if i == 7 or i == 3 then
            thing = amount
        end
        setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y') + thing);
        noteTweenY("movementYbump " .. i, i, defaultNotePos[i + 1][2], time, "linear");
    end
end

function resetStaticArrows()
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], 0.6, "linear");
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], 0.6, "linear");
        noteTweenAngle("movementAngle " .. i, i, defaultNotePos[i + 1][3], 0.6, "linear");
    end
end

function resetHud()
    setProperty('camHUD.angle', 0);
    setProperty('camHUD.x', 0);
    setProperty('camHUD.y',0);
end