--- The Lua environment.
--- @type table | false Only false if the environment is not available.
local env = type(getfenv) == 'function' and getfenv(0)
--- BeamNG's core mod manager.
--- @type table | nil Only nil if the environment is not available.
local core_modmanager = type(env) == 'table' and rawget(env, 'core_modmanager')

if type(core_modmanager) ~= 'table' then
    print('MPModManager: core_modmanager not found')
    return
end

--- Deletes a mod from the game.
--- @type fun(name: string)
local delmod = rawget(core_modmanager, 'deleteMod')
--- Deactivates a mod.
--- @type fun(name: string)
local deamod = rawget(core_modmanager, 'deactivateMod')

rawset(core_modmanager, 'deleteMod', function(name)
    local i = debug.getinfo(2, 'S')
    if not i.short_src:find('MPModManager.lua') then
        return delmod(name)
    end
    print('MPModManager: deleteMod() blocked')
end)

rawset(core_modmanager, 'deactivateMod', function(name)
    local i = debug.getinfo(2, 'S')
    if not i.short_src:find('MPModManager.lua') then
        return deamod(name)
    end
    print('MPModManager: deactivateMod() blocked')
end)
