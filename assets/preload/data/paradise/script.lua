local defaultZoom = 0.7;

function onCreate()
    makeLuaSprite('white','WhiteBg',-400,0);
    addLuaSprite('white',true);
    setProperty('white.scale.x',2);
    setProperty('white.scale.y',2);
    makeLuaSprite('black','BlackBg',-400,0);
    addLuaSprite('black',true);
    setProperty('black.scale.x',2);
    setProperty('black.scale.y',2);
    setProperty('black.alpha',0);
    makeLuaSprite('red','RedBg',-400,0);
    addLuaSprite('red',true);
    setProperty('red.scale.x',2);
    setProperty('red.scale.y',2);
    setProperty('red.alpha',0);
end

function onSongStart()
    doTweenAlpha('bgtween','white',0,4.5,'Linear');
end

function onStepHit()
    if curStep == 677 or curStep == 741 or curStep == 1087 or curStep == 1135 then
        setProperty('defaultCamZoom',0.9);
    end
    if curStep == 639 or curStep == 703 or curStep == 767 or curStep == 959 or curStep == 1023 or curStep == 1119 or curStep == 1151 then
        setProperty('defaultCamZoom',defaultZoom);
    end
    if curStep == 512 or curStep == 671 or curStep == 735 or curStep == 895 then
        setProperty('defaultCamZoom',0.8);
    end
    if curStep == 681 or curStep == 745 then
        setProperty('defaultCamZoom',1.0);
    end
    if curStep == 685 or curStep == 749 or curStep == 1103 or curStep == 1143 then
        setProperty('defaultCamZoom',1.1);
    end
    if curStep == 1279 then
        setProperty('black.alpha',1);
        setProperty('red.alpha',1);
        doTweenAlpha('bgtween','red',0,1.5,'Linear');
    end
end
