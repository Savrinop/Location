Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

-- MENU FUNCTION --
local open = false 
local mainMenu = RageUI.CreateMenu('Location', 'Nos Vehicules')
mainMenu.Closed = function()
  open = false
end

function OpenMenuLocation()
    if open then 
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
        while open do 
           RageUI.IsVisible(mainMenu,function() 

             RageUI.Button("Blista", nil, {RightLabel = "→"}, true , {
                 onSelected = function()
                    spawnCar('blista')
                    RageUI.CloseAll()
                end
             })

             RageUI.Button("Panto", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    spawnCar('panto')
                    
                   RageUI.CloseAll()
               end
            })

            RageUI.Button("Faggio", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    spawnCar('faggio')
                   RageUI.CloseAll()
               end
            })

           end)
         Wait(0)
        end
     end)
  end
end

-- SPAWN VOITURE --
spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local vehicle = CreateVehicle(car, -1033.37, -2730.6, 20.07, 242.04, true, false)
	SetVehicleNumberPlateText(vehicle, "Location")
	SetVehicleCustomPrimaryColour(nil) --- Changer la couleurs du vehicules quand il spawn
	SetVehicleCustomSecondaryColour(nil) ---Changer la couleurs du vehicules quand il spawn (couleur secondaire)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    ESX.ShowNotification("Bonne Route !")
end
-----------------------------------------------------------------------------------------------------------------------------
--- OUVERTURE MENU ---
----------------------


local position = {
    {x = -1034.37, y = -2733.33, z = 20.17} -- POSITION MENU
}

Citizen.CreateThread(function()
    while true do
        NearZone = false

        for k,v in pairs(position) do

                local interval = 1
                local pos = GetEntityCoords(GetPlayerPed(-1), false)
                local dest = vector3(v.x, v.y, v.z)
                local distance = GetDistanceBetweenCoords(pos, dest, true)
                if distance > 2 then
                    interval = 1
                else
                    interval = 1

                    local dist = Vdist(pos.x, pos.y, pos.z, position[k].x, position[k].y, position[k].z)
                    NearZone = true 

                    if distance < 1 then
                        if not InAction then 
                        Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour ouvrir le ~b~Menu Location", 0) 
                    end
                    if IsControlJustReleased(1,51) then
                        OpenMenuLocation()
                    end

                end
                break
            end
        end
        if not NearZone then 
            Wait(500)
        else
            Wait(1)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------
---- PNJ ----
-------------

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_m_security_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_security_01", -1033.95, -2732.63, 19.17, 148.99, false, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

-----------------------------------------------------------------------------------------------------------------------------
----- BLIPS -----
-----------------

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-1033.95, -2732.63, 20.17) -- Coordonnés du Blips

    SetBlipSprite (blip, 56) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.65) -- Taille du blip
    SetBlipColour (blip, 11) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Location') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)