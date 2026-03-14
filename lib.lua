local Lib = {}

function Lib:init()
    TableUtils.merge(MUSIC_VOLUMES, {
        ch4_battle = 0.7,
        titan_spawn = 0.7
    })
end

return Lib
