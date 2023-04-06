ESX = nil
loaded = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end )
        Citizen.Wait(200)
        PlayerData = ESX.GetPlayerData()
    end
    loaded = true
end)

RegisterCommand("setped", function (source, args)
    local id = args[1]
    local model = args[2]
    TriggerServerEvent("TriggerSetPed", id, model)
end, false)


RegisterNetEvent("SetPlayerPed")
AddEventHandler("SetPlayerPed", function(model)
    local player = PlayerId()
    ESX.TriggerServerCallback("Admin:getRankFromPlayer", function(group) 
        for k, v in pairs(Config.Admins) do
            print(group)
            if v == group then
                print("igen".." | "..group.."="..v)
                if IsModelInCdimage(model) and IsModelValid(model) then
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                      Wait(0)
                    end
                    SetPlayerModel(PlayerId(), model)
                    SetModelAsNoLongerNeeded(model)
                else
                    ESX.ShowNotification("<span style='color:red'>Ismeretlen model</span>")
                end
            end
        end
    end)
end)