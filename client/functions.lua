function OpenMenu()
    lib.registerContext({
        id = 'openMenu',
        title = "Ars job Outfits",
        options = {
            {
                title = "Job Oufits",
                onSelect = function()
                    OpenJobOutfit()
                end,
            },
            {
                title = "Civil Clothes",
                onSelect = function()
                    NormalClothes()
                end,
            },
        }
    })
    lib.showContext('openMenu')

end

function NormalClothes()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)


        if lib.progressBar({
            duration = 2000,
            label = 'Changing Clothes',
            useWhileDead = false,
            allowCuffed = false,
            canCancel = false,
            disable = {
                car = true,
            },
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d'
            },
        }) then
            local model = nil

            if skin.sex == 0  then
                model = GetHashKey("mp_m_freemode_01")
            else
                model = GetHashKey("mp_f_freemode_01")
            end
    
            lib.requestModel(model, 100)
    
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
            lib.showContext('openMenu')
        end
    end)
end

function OpenJobOutfit()
    local opz = {}
    for k,v in pairs(Config.Outfits) do
        for k,v in pairs(Config.Outfits[k]) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job and ESX.PlayerData.job.grade >= v.grade then
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
                            args = args,
                            onSelect = function()
                                if lib.progressBar({
                                    duration = 2000,
                                    label = 'Changing Clothes',
                                    useWhileDead = false,
                                    allowCuffed = false,
                                    canCancel = false,
                                    disable = {
                                        car = true,
                                    },
                                    anim = {
                                        dict = 'clothingshirt',
                                        clip = 'try_shirt_positive_d'
                                    },
                                }) then
                                    lib.showContext('outfits')
                                end
                            end,
                        })
                        lib.registerContext({
                            id = 'outfits',
                            title = 'Job Outfits',
                            menu = 'openMenu',
                            options = opz
                        })
                        lib.showContext('outfits')
                    end
                end)
            end
        end
    end
end


exports("OpenMenu", OpenMenu)
exports("OpenJobOutfit", OpenJobOutfit)

