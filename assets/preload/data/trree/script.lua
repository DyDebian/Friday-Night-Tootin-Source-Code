local defaultNotePos = {};
local beatstepamount = 9;
local shakearrow = false;

function onSongStart()
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x');

        table.insert(defaultNotePos, {x});
    end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60);

    if shakearrow then
        for i=0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 38 * math.sin((currentBeat + i*0)))
        end
    end
end

function onStepHit()
    if curStep == 256 then
        shakearrow = true
        setCamZoom('cam',1.4)
    end
       if curStep == 383 then
        shakearrow = false;
        resetStaticArrows(0.6);
    end
       if curStep == 639 then
        shakearrow = true;
        setCamZoom('cam',1.2)
    end
       if curStep == 655 then
        setCamZoom('cam',1.2)
    end
       if curStep == 671 then
        setCamZoom('cam',1.2)
    end
       if curStep == 687 then
        setCamZoom('cam',1.2)
    end
       if curStep == 774 then
        shakearrow = false;
        resetStaticArrows(0.6);
    end
      if curStep == 728 then
        beatstepamount = 8;
    end
      if curStep == 735 then
        beatstepamount = 4;
    end
      if curStep == 751 then
        beatstepamount = 2;
    end
      if curStep == 760 then
        beatstepamount = 1;
    end
      if curStep == 703 then
        setCamZoom('cam',1.2)
    end
      if curStep > 702 and curStep < 764 and curStep % beatstepamount == 0 then
        setCamZoom('cam',1.2)
    end
end

function resetStaticArrows(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear");
    end
end