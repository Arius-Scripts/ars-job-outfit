ESX = exports.es_extended:getSharedObject()



RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout') 
AddEventHandler('esx:playerLogout', function(xPlayer, isNew)
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)



CreateThread(function()
    while true do
        Sleep = 500
        if ESX.IsPlayerLoaded() then
            for k, v in pairs(Config.Jobs) do
                local dist = #(GetEntityCoords(cache.ped)-(type(v.coords) == type(vector3(0,0,0)) and v.coords or 0))
                for job,a in pairs(Config.Jobs[k]) do
                    if dist < 5.0 and ESX.PlayerData.job.name == a.job then
                        Sleep = 1
                        DrawMarker(21, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5, 0.5, 87, 58, 60, 100, false, false, 2, true, nil, nil, false)
                        ESX.ShowHelpNotification('[E] - to open the menu')
                        if dist < 2.0 then
                            if IsControlJustReleased(0, 38) then
                                ApriMenu()
                            end
                        end
                    end
                end
            end
        end
        Wait(Sleep)
    end
end)



ApriMenu = function()
    lib.registerContext({
        id = 'openMenu',
        title = "Outfit",
        options = {
            {
                title = "Outfit",
                event = 'ars-job-outfit:outfit',
            },
            {
                title = "Normal Clothes",
                onSelect = function()
                    NormalClothes()
                end,
            }
        }
    })
    lib.showContext('openMenu')
end


NormalClothes = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        local model = nil

        if skin.sex == 0  then
        model = GetHashKey("mp_m_freemode_01")
        else
        model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)
end




RegisterNetEvent('ars-job-outfit:outfit', function()
    local opz = {}

    for k,v in pairs(Config.Jobs) do
        for k,v in pairs(Config.Jobs[k]) do

            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    if skin.model == v.model then
                        args = {
                            torso = v.torso,
                            undershirt = v.undershirt,
                            arms = v.arms,
                            pants = v.pants,
                            shoes = v.shoes,
                            bag = v.bag,
                            accesories = v.accesories,
                            kevlar = v.kevlar,
                            badge = v.badge,
                            hat = v.hat
                        }
                        table.insert(opz, {
                            title = v.outfitName,
                            event = 'ars-job-outfit:takeOutfit',
                            args = args
                        })
                        lib.registerContext({
                            id = 'outfits',
                            title = 'Change Clothes',
                            options = opz
                        })
                        lib.showContext('outfits')
                    end
                end)
            end
        end
    end
end)



RegisterNetEvent('ars-job-outfit:takeOutfit')
AddEventHandler('ars-job-outfit:takeOutfit',function(data)
    exports['fivem-appearance']:setPedComponents(cache.ped, {data.torso,data.undershirt,data.pants,data.shoes,data.bag,data.accesories,data.kevlar,data.badge,data.arms})  
    exports['fivem-appearance']:setPedProps(cache.ped, {data.hat})     
end)

