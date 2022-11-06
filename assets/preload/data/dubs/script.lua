function onSongStart()
    setProperty('camZooming',true);
end

--[[
function onBeatHit()
    if curBeat == 4 or curBeat == 12 or curBeat == 20 or curBeat == 28 or curBeat == 36 or curBeat == 44 or curBeat == 52 or curBeat == 60 or curBeat == 68 or curBeat == 100 or curBeat == 108 or curBeat == 116 or curBeat == 124 or curBeat == 140 or curBeat == 148 or curBeat == 156 or curBeat == 164 or curBeat == 172 or curBeat == 180 or curBeat == 188 or curBeat == 196 or curBeat == 204 or curBeat == 212 or curBeat == 220 or curBeat == 228 or curBeat == 236 or curBeat == 244 or curBeat == 252 then
        setCamZoom('hud',1.15);
    end
end
--]] --using a better way