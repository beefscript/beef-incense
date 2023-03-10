local checkitem = false
local firstspawn = false
local npc = nil
local blip = nil
local weapon = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("guanyu")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    --x = -892.47259521484, y = -854.11791992188, z = 21.050981521606, h = 274.00146484375
    if firstspawn == false then
        npc = CreatePed(6, hash, -892.56, -854.28, 20.050981521606, 285.82, false, false)
        --weapon = CreateObject(GetHashKey("weapon_golfclub"), -892.56, -854.28, 20.050981521606, false, false, false )
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, false, false)
        SetEntityDynamic(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetPedComponentVariation(npc, 3,0,0, 2)
        GiveWeaponToPed(npc, GetHashKey("weapon_rayminigun"), 0, false, true)
        SetCurrentPedWeapon(npc, GetHashKey("weapon_rayminigun"), true)
        blip = AddBlipForCoord(-892.56, -854.28, 19.57)
        SetBlipAsShortRange(blip, true)
        SetBlipBright(blip, true)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, 1.5)
        SetBlipSprite(blip, 487)
        BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Quan Nhị Ca")
		EndTextCommandSetBlipName(blip)
    --[[     local blip2 = AddBlipForCoord(602.20776367188, -444.02914428711, 24.744916915894)
        SetBlipAsShortRange(blip2, true)
        SetBlipBright(blip2, true)
        SetBlipColour(blip2, 1)
        SetBlipDisplay(blip2, 2)
        SetBlipScale(blip2, 1.5)
        SetBlipSprite(blip2, 176)
        BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("TRUNG TÂM CƯỚP")
		EndTextCommandSetBlipName(blip2)
        local blip2Radius = AddBlipForRadius(602.20776367188, -444.02914428711, 24.744916915894, 100.0)
        SetBlipHighDetail(blip2Radius, true) 
	    SetBlipColour(blip2Radius, 1) 
	    SetBlipAlpha (blip2Radius, 128)
        local blip3Radius = AddBlipForRadius( -456.89904785156, -2276.6740722656, 8.5157823562622, 100.0)
        SetBlipHighDetail(blip3Radius, true) 
        SetBlipColour(blip3Radius, 1) 
        SetBlipAlpha (blip3Radius, 128) ]]

        local bone = GetPedBoneIndex(GetPlayerPed(-1), 24816)
        RequestModel("w_me_gclub")
        while not HasModelLoaded("w_me_gclub") do
            Wait(100)
        end 
        weapon = CreateObject(GetHashKey("w_me_gclub"),  -892.58380126953, -853.76354980469, 20.050981521606, false, true, false)
        FreezeEntityPosition(weapon, true)
        --AttachEntityToEntity(weapon, npc, bone,  0.075, -0.15, -0.02, 0.0, 165.0, 0.0, 1, 1, 0, 0, 2, 1)
    end

    while true do 
        Wait(1000)
        if IsPlayerFreeAimingAtEntity(PlayerId(), npc) then 
            SetEntityHealth(PlayerPedId(), 0)
            --TriggerEvent("lr_gang:client:notify", "danger", "Bạn đã bị Quan Nhị Ca ")
        end
    end

end)

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR, isMelee)
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
  }

  if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end -- reposition for melee items
  if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end
	AttachEntityToEntity(attached_weapons[attachModel].handle, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

RegisterNetEvent('beef:baolixi')
AddEventHandler('beef:baolixi', function()
    if lib.progressBar({
        duration = 5000,
        label = 'Open Lucky Money',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
        },
        anim = {
            dict = 'amb@code_human_wander_texting_fat@male@idle_a',
            clip = 'idle_a',
        }
    }) then
            TriggerServerEvent('beef:sudunglixi')
        end
end)

-- Key controls
Citizen.CreateThread(function()
    local shown = false
    local inDistance = false
	while true do
        inDistance = false
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zone) do
			local dist = GetDistanceBetweenCoords(coords, v.coords, true)
			    if dist < 4 then
                    inDistance = true
				    if IsControlJustReleased(0, 38) then
                            TriggerEvent('beef:checkitem')
                            Ani()
                            if checkitem == true then
					            FreezeEntityPosition(PlayerPedId() ,true)
                                if lib.progressBar({
                                    duration = 15000,
                                    label = 'Burning Incense',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        move = true,
                                        car = true,
                                    },
                                    anim = {
                                        dict = 'timetable@amanda@ig_4',
                                        clip = 'ig_4_base',
                                    }
                                }) then
                                        FreezeEntityPosition(PlayerPedId() ,false)
                                        ESX.Game.DeleteObject(prop8)
                                        ClearPedSecondaryTask(ped)
                                        TriggerServerEvent('beef:lixi')
                                    end
                                else
                                    exports['okokNotify']:Alert("Thông Báo", "Bạn không có nhang cúng !", 5000, 'error')
				                end
                            end
                    end
                end
            if not shown and inDistance then
                exports['okokTextUI']:Open('[E] Offer Sacrifices', 'lightgreen', 'left')
                shown = true
            elseif shown and not inDistance then
                exports['okokTextUI']:Close()
                shown = false
            end
		end
end)

RegisterNetEvent('beef:checkitem')
AddEventHandler('beef:checkitem', function()
    local count = exports.ox_inventory:Search('count', 'incense')
    if count > 0 then 
        TriggerServerEvent('beef:thapnhang')
        checkitem = true
    else
        checkitem = false
    end
end)

function Ani()
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local boneIndex = GetPedBoneIndex(ped, 57005)

    prop8 = CreateObject(GetHashKey('lotus'), x, y, z, true, true, true)

    AttachEntityToEntity(prop8, ped, boneIndex, 0.3, 0.08, 0.02, -47.4, 73.3, -32.8, true, true, false, true, 0, true)

end

