function onStepHit()
    if curStep == 512 or curStep == 640 then
        doTweenZoom('camtween','camGame',0.8,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.8);
    end
    if curStep == 544 or curStep == 672 or curStep == 896 then
        doTweenZoom('camtween','camGame',0.7,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.7);
    end
    if curStep == 768 then
        doTweenZoom('camtween','camGame',0.85,0.6,'smootherstepinout');
        setProperty('defaultCamZoom',0.85);
    end
    if curStep == 1151 then
        noteTweenX('notetween0x', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') - 100, 3, 'Linear')--3
        noteTweenX('notetween1x', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') - 50, 6, 'Linear')--6
        noteTweenX('notetween2x', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') + 50, 3, 'Linear')--3
        noteTweenX('notetween3x', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') + 100, 3, 'Linear')--3
        noteTweenX('notetween4x', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') - 100, 3, 'Linear')
        noteTweenX('notetween5x', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') - 50, 6, 'Linear')
        noteTweenX('notetween6x', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') + 50, 3, 'Linear')
        noteTweenX('notetween7x', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') + 100, 3, 'Linear')
        noteTweenY('notetween0y', 0, getPropertyFromGroup('strumLineNotes', 0, 'y') + 300, 3, 'Linear')--3
        noteTweenY('notetween1y', 1, getPropertyFromGroup('strumLineNotes', 1, 'y') + 325, 6, 'Linear')--6
        noteTweenY('notetween2y', 2, getPropertyFromGroup('strumLineNotes', 2, 'y') + 483, 3, 'Linear')--3
        noteTweenY('notetween3y', 3, getPropertyFromGroup('strumLineNotes', 3, 'y') + 602, 3, 'Linear')--3
        noteTweenY('notetween4y', 4, getPropertyFromGroup('strumLineNotes', 4, 'y') + 300, 3, 'Linear')
        noteTweenY('notetween5y', 5, getPropertyFromGroup('strumLineNotes', 5, 'y') + 325, 6, 'Linear')
        noteTweenY('notetween6y', 6, getPropertyFromGroup('strumLineNotes', 6, 'y') + 483, 3, 'Linear')
        noteTweenY('notetween7y', 7, getPropertyFromGroup('strumLineNotes', 7, 'y') + 602, 3, 'Linear')
        noteTweenAngle('notetweem0angle', 0, getPropertyFromGroup('strumLineNotes', 0, 'angle') - 60, 3, 'Linear')
        noteTweenAngle('notetweem1angle', 2, getPropertyFromGroup('strumLineNotes', 2, 'angle') + 30, 3, 'Linear')
        noteTweenAngle('notetweem2angle', 3, getPropertyFromGroup('strumLineNotes', 3, 'angle') + 60, 3, 'Linear')
        noteTweenAngle('notetweem1angle', 4, getPropertyFromGroup('strumLineNotes', 4, 'angle') - 60, 3, 'Linear')
        noteTweenAngle('notetweem2angle', 6, getPropertyFromGroup('strumLineNotes', 6, 'angle') + 30, 3, 'Linear')
        noteTweenAngle('notetweem3angle', 7, getPropertyFromGroup('strumLineNotes', 7, 'angle') + 30, 3, 'Linear')
        for i=0,7 do
            noteTweenAlpha('notetweemalpha'..i, i, 0, 1.5, 'Linear')
        end
    end
end