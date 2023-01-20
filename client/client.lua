ESX = exports.es_extended:getSharedObject()

local positions ={}

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
    for k,v in pairs(Config.Outfits) do
        for i = 1, #k, 1 do
            positions[i] = lib.points.new({
                coords = v.coords,
                distance = 5,
                eleId = k,
                onEnter = function(self)
                    lib.showTextUI('[E] - Interact', {position = "top-center",icon = 'hand',style = {borderRadius = 0,backgroundColor = '#3a4d57',color = 'white'}})
                end,
                onExit = function()
                    lib.hideTextUI()
                end,
                nearby = function(self)
                    DrawMarker(21, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5, 0.5, 58, 77, 87, 100, false, false, 2, true, nil, nil, false)
                    if self.currentDistance < 3 and not IsEntityDead(cache.ped) and IsControlJustPressed(0, 38) then
                        OpenMenu()
                        if Config.UseCutScene then
                            dressingRoom()
                        end
                        lastPos = v.coords
                    end
                end
            })
        end
    end
end)

-- RegisterCommand("f", function()
--     print(GetFinalRenderedCamCoord())
--     print(GetFinalRenderedCamRot(1))
--     -- lib.setClipboard(GetFinalRenderedCamCoord().x..","..GetFinalRenderedCamCoord().y..","..GetFinalRenderedCamCoord().z)
--     lib.setClipboard(GetFinalRenderedCamRot().x..","..GetFinalRenderedCamRot().y..","..GetFinalRenderedCamRot().z)
-- end)


RegisterNetEvent('ars-job-outfit:takeOutfit')
AddEventHandler('ars-job-outfit:takeOutfit',function(data)
    exports['fivem-appearance']:setPedComponents(cache.ped, {data.torso,data.undershirt,data.pants,data.shoes,data.bag,data.accesories,data.kevlar,data.badge,data.arms})  
    exports['fivem-appearance']:setPedProps(cache.ped, {data.hat})     
end)
