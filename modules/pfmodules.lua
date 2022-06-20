local modules = {}; do
    coroutine.wrap(function()
        for i,v in next, getloadedmodules() do
            if (v.Name == "camera") then
                modules.camera = require(v);
            elseif (v.Name == "network") then
                modules.network = require(v);
            elseif (v.Name == "particle") then
                modules.particle = require(v);
            elseif (v.Name == "sound") then
                modules.sound = require(v);
            elseif (v.Name == "input") then
                modules.input = require(v);
            elseif (v.Name == "uiscaler") then
                modules.uiscaler = require(v);
            elseif (v.Name == "effects") then
                modules.effects = require(v);
            elseif (v.Name == "ScreenCull") then
                modules.screencull = require(v);
            elseif (v.Name == "Raycast") then
                modules.raycast = require(v);
            elseif (v.Name == "BulletCheck") then
                modules.bulletcheck = require(v);
            elseif (v.Name == "vector") then
                modules.vector = require(v);
            elseif (v.Name == "ReplicationSmoother") then
                modules.replicationsmoother = require(v);
            elseif (v.Name == "animation") then
                modules.animation = require(v);
            elseif (v.Name == "spring") then
                modules.spring = require(v);
            elseif (v.Name == "HeartbeatRunner") then
                modules.heartbeatrunner = require(v);
            elseif (v.Name == "cframe") then
                modules.cframe = require(v);
            end
        end

        modules.replication = debug.getupvalue(modules.camera.setspectate, 1);
        modules.char = debug.getupvalue(modules.camera.step, 7);
        modules.hud = debug.getupvalue(modules.camera.step, 20);
        modules.gamelogic = debug.getupvalue(modules.hud.updateammo, 4);
        modules.roundsystem = debug.getupvalue(modules.hud.spot, 6);
        modules.menu = debug.getupvalue(modules.hud.radarstep, 1);
        modules.loadplayer = debug.getupvalue(modules.replication.getupdater, 2);
        modules.remoteevent = modules.network and debug.getupvalue(modules.network.send, 1);
        modules.networkfunctions = modules.remoteevent and debug.getupvalue(getconnections(modules.remoteevent.OnmodulesEvent)[1].Function, 1);

        setreadonly(modules.particle, false);

        for i,v in next, modules.networkfunctions do
            local constants = debug.getconstants(v);

            if (table.find(constants, "KNIFE") and table.find(constants, "GRENADE")) then
                modules.loadgun = debug.getupvalue(v, 6);
                modules.loadknife = debug.getupvalue(v, 7);
            elseif (table.find(constants, "killfeed")) then
                modules.killfeed = i;
            end
        end

        for i,v in next, debug.getupvalues(modules.loadgun) do
            if (typeof(v) == "function") then
                local name = debug.getinfo(v).name;

                if (name == "gunsway" or name == "gunbob") then
                    modules[name] = v;
                end
            end
        end
    end)();
end
return modules;
