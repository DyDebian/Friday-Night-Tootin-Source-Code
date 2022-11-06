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
    if curStep == 1279 then
        setProperty('black.alpha',1);
        setProperty('red.alpha',1);
        doTweenAlpha('bgtween','red',0,1.5,'Linear');
    end
end
