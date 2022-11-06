function onStepHit()
    if curStep == 128 or curStep == 256 or curStep == 576 or curStep == 640 then
        beat(0.8,1.1);
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if curStep >= 326 and curStep < 334 or curStep >= 342 and curStep < 348 or curStep >= 360 and curStep < 367 then
        beat(0.75,1.05);
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if curStep >= 453 and curStep < 462 or curStep >= 469 and curStep < 476 or curStep >= 488 and curStep < 495 then
        beat(0.75,1.05);
    end
end

function beat(camforce,hudforce)
    setCamZoom('cam', camforce);
    setCamZoom('hud',hudforce);
end