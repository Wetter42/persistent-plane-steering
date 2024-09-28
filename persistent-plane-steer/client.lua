local player = GetPlayerPed(-1)
local vehprevflag = 0
local threadflag = 0
local ppsteer = 0.0
local taxiportkey = 89
local taxistarkey = 90
local null = 0
local pilotseat = -1

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	persist_taxi(player)
end)





AddEventHandler("gameEventTriggered", function(event, args)
	if event == "CEventNetworkPlayerEnteredVehicle" then
        	--This is a flag to prevent event firing twice when teleporting into vehicles;
		Wait(200)
		if vehprevflag == 0 then
			vehprevflag = 1
			print("initiate function just once?")
			persist_taxi(player)
		else
			return
		end
	end
	Wait(1000)
	vehprevflag = 0
end)


function persist_taxi(plyr)
	veh = GetVehiclePedIsIn(player)
	if threadflag == 0 then
		Citizen.CreateThread(function()
			print("Starting independant thread")
			threadflag = 1
			while IsPedInAnyPlane(plyr) and GetPedInVehicleSeat(veh, pilotseat) == player and IsVehicleDriveable(veh) do
				if not IsEntityInAir(veh) then
					if IsControlPressed(null, taxistarkey) or IsControlPressed(null, taxiportkey) and DoesEntityExist(veh) then
						ppsteer = GetVehicleSteeringAngle(veh)
					elseif IsControlReleased(null, taxiportkey) and IsControlReleased(null, taxistarkey) and DoesEntityExist(veh) then
						SetVehicleSteeringAngle(veh, ppsteer)
					end
				else
					ppsteer = 0.0
				end
			Wait()
			end
			threadflag = 0
		end)
		print("Terminating thread")
	else
		return
	end
	
end

