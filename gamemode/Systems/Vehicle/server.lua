addRemoteEvents{"Spawn->Vehicle","Despawn->Vehicle","Sell->Vehicle","Trigger->VehicleUI->Items"};--addEvent


local SPAWN_DELAY={};
local VEH_SEATS_TAKEN={};

addEventHandler("Spawn->Vehicle",root,function(ID)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(not(isTimer(SPAWN_DELAY[client])))then
			if(getElementDimension(client)>0)then
				return;
			end
			if(getElementInterior(client)>0)then
				return;
			end
			if(isPedInVehicle(client))then
				return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Vehicle->LeaveBefore"));
			end
			if(not(isElement(TABLE_VEHICLES_USER[ID..getPlayerName(client)])))then
				loadVehicle(client,ID);
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Vehicle->AlreadySpawned"));
			end
		end
	end
end)


addEventHandler("Despawn->Vehicle",root,function(typ,ID)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(typ=="Selected")then
			if(isElement(TABLE_VEHICLES_USER[ID..getPlayerName(client)]))then
				makeVehicleEmpty(TABLE_VEHICLES_USER[ID..getPlayerName(client)]);
				if(isElement(TABLE_VEHICLES_USER[ID..getPlayerName(client)]))then
					destroyElement(TABLE_VEHICLES_USER[ID..getPlayerName(client)]);
					TABLE_VEHICLES_USER[ID..getPlayerName(client)]=nil;
				end
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Vehicle->IsntSpawned"));
			end
		elseif(typ=="All")then
			for _,v in pairs(getElementsByType("vehicle"))do
				if(getElementData(v,"Veh->Data->Typ")=="User" and tostring(getElementData(v,"Veh->Data->Owner"))==getPlayerName(client))then
					makeVehicleEmpty(v);
					
					if(isElement(TABLE_VEHICLES_USER[getElementData(v,"Veh->Data->ID")..getElementData(v,"Veh->Data->Owner")]))then
						destroyElement(TABLE_VEHICLES_USER[getElementData(v,"Veh->Data->ID")..getElementData(v,"Veh->Data->Owner")]);
					end
				end
			end
		end
	end
end)


addEventHandler("Sell->Vehicle",root,function(ID)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(getElementDimension(client)>0)then
			return;
		end
		if(getElementInterior(client)>0)then
			return;
		end
		if(isElement(TABLE_VEHICLES_USER[ID..getPlayerName(client)]))then
			local VehID=tonumber(getElementData(TABLE_VEHICLES_USER[ID..getPlayerName(client)],"Veh->Data->VehID"))or nil;
			if(VehID and VEHICLE.PRICES[VehID])then
				makeVehicleEmpty(TABLE_VEHICLES_USER[ID..getPlayerName(client)]);
				
				triggerClientEvent(client,"Infobox->UI",client,"success","You've sold you car and you\n got "..CURRENCY..VEHICLE.PRICES[VehID]/100*VEHICLE.SellPercent.."");
				setElementData(client,"Money",tonumber(getElementData(client,"Money"))+tonumber(VEHICLE.PRICES[VehID]/100*VEHICLE.SellPercent));
				
				destroyElement(TABLE_VEHICLES_USER[ID..getPlayerName(client)]);
				TABLE_VEHICLES_USER[ID..getPlayerName(client)]=nil;
				
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=? AND ??=?","Vehicles","ID",ID,"Username",getPlayerName(client));
			else
				triggerClientEvent(client,"Infobox->UI",client,"error","You cant sell this vehicle!");
			end
		else
			triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Vehicle->IsntSpawned"));
		end
	end
end)




function loadVehicle(player,ID)
	if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=? AND ??=?","Vehicles","ID",ID,"Username",getPlayerName(player)),-1);
		if(#result==1)then--check database table existing
			local VehID=result[1]["VehID"];
			
			local PlayerTeam=tostring(getElementData(player,"Player->Data->Team"))or nil;
			if(PlayerTeam~="SAPD" and VEHICLE_TYPES["SAPD"][VehID])then
				return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotInRightTeam"):format("SAPD"));
			end
			if(PlayerTeam~="FIB" and VEHICLE_TYPES["FIB"][VehID])then
				return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotInRightTeam"):format("FIB"));
			end
			
			if(not(isElement(TABLE_VEHICLES_USER[ID..getPlayerName(player)])))then
				--spawn/create vehicle
				local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(VehID);
				if(isCustom)then--check custom vehicle
					TABLE_VEHICLES_USER[ID..getPlayerName(player)]=createVehicle(mod.base_id,0,0,0,0,0,0,".");
					local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
					setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],dataName,mod.id);
				else
					TABLE_VEHICLES_USER[ID..getPlayerName(player)]=createVehicle(VehID,0,0,0,0,0,0,".");
				end
				
				--set datas on element
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->ID",ID);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->VehID",VehID);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Owner",getPlayerName(player));
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Typ","User");
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Typ2",result[1]["Typ"]);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Paintjob",result[1]["Paintjob"]);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Light",result[1]["Lights"]);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Numberplate",result[1]["Numberplate"]);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Horn",result[1]["Horn"]);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Engine",result[1]["Engine"]);
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->DriveTyp",result[1]["DriveTyp"]);
				
				
				local x,y,z=getElementPosition(player);--get player pos
				local _,_,rz=getElementRotation(player);--get player rot
				
				setElementPosition(TABLE_VEHICLES_USER[ID..getPlayerName(player)],x,y,z);
				setElementRotation(TABLE_VEHICLES_USER[ID..getPlayerName(player)],0,0,rz);
				
				warpPedIntoVehicle(player,TABLE_VEHICLES_USER[ID..getPlayerName(player)],0);
				setVehicleOverrideLights(TABLE_VEHICLES_USER[ID..getPlayerName(player)],1);
				setElementHealth(TABLE_VEHICLES_USER[ID..getPlayerName(player)],result[1]["Health"]);
				
				loadVehicleTunings(TABLE_VEHICLES_USER[ID..getPlayerName(player)]);
				giveVehicleSpecialUpgrade(TABLE_VEHICLES_USER[ID..getPlayerName(player)]);
				addVehicleCustomSirens(TABLE_VEHICLES_USER[ID..getPlayerName(player)]);
				giveVehicleCustomHandling(TABLE_VEHICLES_USER[ID..getPlayerName(player)]);
				
				setElementData(TABLE_VEHICLES_USER[ID..getPlayerName(player)],"Veh->Data->Engine",false);
				setVehicleEngineState(TABLE_VEHICLES_USER[ID..getPlayerName(player)],false);
				
				setTimer(function(ID,player)
					if(result[1]["Health"]<250)then
						setElementHealth(TABLE_VEHICLES_USER[ID..getPlayerName(player)],250);
					else
						setElementHealth(TABLE_VEHICLES_USER[ID..getPlayerName(player)],result[1]["Health"]);
					end
				end,500,1,ID,player)
				
				SPAWN_DELAY[player]=setTimer(function(player)
					SPAWN_DELAY[player]=nil;
				end,10*1000,1,player)
			end
		else
			triggerClientEvent(player,"Infobox->UI",player,"error","This vehicle doesn't exist!");
		end
	end
end


function addVehicleCustomSirens(veh)
	if(veh and isElement(veh))then
		local vehTyp=tostring(getElementData(veh,"Veh->Data->Typ2"))or nil;
		if(vehTyp=="SAPD")then
			if(tonumber(getElementData(veh,"Veh->Data->VehID"))==596 or tonumber(getElementData(veh,"Veh->Data->VehID"))==597)then
				removeVehicleSirens(veh);
				addVehicleSirens(veh,3,2,true,true,false,false);
				setVehicleSirens(veh,1,-0.5,-0.4,1,255,0,0,255,255);
				setVehicleSirens(veh,2,0.5,-0.4,1,0,0,255,255,255);
				setVehicleSirens(veh,3,0,-0.4,1,255,255,255,255,255);
				setElementData(veh,"Veh->Data->Paintjob->SAPD",true);
			end
			if(tonumber(getElementData(veh,"Veh->Data->VehID"))==599)then
				setElementData(veh,"Veh->Data->Paintjob->SAPD",true);
			end
		end
		
		if(vehTyp=="SAMD")then
			if(getElementData(veh,"Veh->Data->VehID")==596)then--lspd
				removeVehicleSirens(veh);
				addVehicleSirens(veh,3,2,true,true,false,false);
				setVehicleSirens(veh,1,-0.5,-0.4,1,255,0,0,255,255);
				setVehicleSirens(veh,2,0.5,-0.4,1,255,0,0,255,255);
				setVehicleSirens(veh,3,0,-0.4,1,255,255,255,255,255);
				setElementData(veh,"Veh->Data->Paintjob->SAMD",true);
			end
			if(getElementData(veh,"Veh->Data->VehID")==416)then--ambulance
				removeVehicleSirens(veh);
				addVehicleSirens(veh,3,2,true,true,false,false);
				addVehicleSirens(veh,5,5,true,true,false,false);
				setVehicleSirens(veh,1,0,0.9,1.3,255,255,255,200,200);
				setVehicleSirens(veh,2,0.4,0.9,1.3,255,0,0,200,200);
				setVehicleSirens(veh,3,-0.4,0.9,1.3,255,0,0,200,200);
				setVehicleSirens(veh,4,-1,-3.7,1.45,255,0,0,200,200);
				setVehicleSirens(veh,5,1,-3.7,1.45,255,0,0,200,200);
				setElementData(veh,"Veh->Data->Paintjob->SAMD",true);
			end
		end
	end
end
function giveVehicleCustomHandling(veh)
	if(veh and isElement(veh))then
		local vehID=tonumber(getElementData(veh,"Veh->Data->VehID"))or nil;
		if(vehID and vehID~=nil)then
			if(vehID==604)then--glendale damaged
				setVehicleHandling(veh,"maxVelocity",90.0);
			end
		end
	end
end


addEventHandler("onPlayerQuit",root,function()
	if(isLoggedin(source))then
		if(isPedInVehicle(source))then
			local veh=getPedOccupiedVehicle(source);
			if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
				if(getElementData(veh,"Veh->Data->Typ")=="Team")then
					respawnVehicle(veh);
					setVehicleEngineState(veh,false);
					setElementData(veh,"Veh->Data->Engine",false);
					setVehicleDamageProof(veh,true);
					setElementFrozen(veh,true);
					setVehicleOverrideLights(veh,1);
				end
			end
		end
		for _,v in pairs(getElementsByType("vehicle"))do
			if(getElementData(v,"Veh->Data->Typ")=="User" and tostring(getElementData(v,"Veh->Data->Owner"))==getPlayerName(source))then
				makeVehicleEmpty(v);
				
				if(isElement(TABLE_VEHICLES_USER[getElementData(v,"Veh->Data->ID")..getElementData(v,"Veh->Data->Owner")]))then
					destroyElement(TABLE_VEHICLES_USER[getElementData(v,"Veh->Data->ID")..getElementData(v,"Veh->Data->Owner")]);
				end
			end
		end
	end
end)


local VehicleUIStatus={};
function openVehicleUI(player)
	if(not(isLoggedin(player)))then
		return;
	end
	
	if(not(VehicleUIStatus[player]))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Vehicles","Username",getPlayerName(player)),-1);
		if(#result==0)then
			triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"Vehicle->NoVehicles"));
		else
			triggerClientEvent(player,"Vehicle->UI",player,"Open");
		end
		VehicleUIStatus[player]=true;
	else
		triggerClientEvent(player,"Vehicle->UI",player,"Close");
		VehicleUIStatus[player]=nil;
	end
end

addEventHandler("Trigger->VehicleUI->Items",root,function()
	if(client and isElement(client)and isLoggedin(client))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ??","Vehicles"),-1);
		local Table={};
		if(#result>=1)then
			for _,v in pairs(result)do
				if(VEHICLE.NAMES[tonumber(v["VehID"])])then
					Carname=VEHICLE.NAMES[tonumber(v["VehID"])];
				else
					Carname=getVehicleNameFromModel(tonumber(v["VehID"]));
				end
				if(v["Username"]==getPlayerName(client))then
					table.insert(Table,{v["ID"],tonumber(v["VehID"]),tostring(Carname),math.floor(100/100*v["Health"])});
				end
			end
			triggerClientEvent(client,"Show->VehicleUI->Items",client,Table);
		else
			outputDebugString("Failed to load 'Vehicles' database table!",1);
		end
	end
end)





addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if(veh)then
		if(seat==0)then
			if(veh and isElement(veh))then
				if(not(getElementData(veh,"Veh->Data->Engine")))then
					setElementData(veh,"Veh->Data->Engine",false);
					setVehicleEngineState(veh,false);
				end
				if(isTimer(TABLE_VEHICLE_RESPAWNTIMER[veh]))then
					killTimer(TABLE_VEHICLE_RESPAWNTIMER[veh]);
					TABLE_VEHICLE_RESPAWNTIMER[veh]=nil;
				end
				if(isVehicleDamageProof(veh))then
					setVehicleDamageProof(veh,false);
				end
				if(getElementData(veh,"Veh->Data->Typ")=="Team")then
					if(isElementFrozen(veh))then
						setElementFrozen(veh,false);
					end
				end
			end
			if(getElementType(source)=="player")then
				if(not isKeyBound(source,"X","DOWN",toggleVehicleEngine))then
					bindKey(source,"X","DOWN",toggleVehicleEngine,"Engine on/off");
				end
				if(not isKeyBound(source,"L","DOWN",toggleVehicleLights))then
					bindKey(source,"L","DOWN",toggleVehicleLights,"Lights on/off");
				end
				bindKey(source,"H","DOWN",playCustomHorn,"Custom Horn On");
				bindKey(source,"H","UP",playCustomHorn,"Custom Horn Off");
			end
		end
	end
end)

addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		if(getElementType(source)=="player")then
			if(isKeyBound(source,"X","DOWN",toggleVehicleEngine))then
				unbindKey(source,"X","DOWN",toggleVehicleEngine);
			end
			if(isKeyBound(source,"L","DOWN",toggleVehicleLights))then
				unbindKey(source,"L","DOWN",toggleVehicleLights);
			end
			unbindKey(source,"H","DOWN",playCustomHorn);
			unbindKey(source,"H","UP",playCustomHorn);
		end
		
		if(getElementData(veh,"Veh->Data->Typ")=="Team")then
			if(getElementHealth(veh)>260)then
				setVehicleDamageProof(veh,true);
			else
				setVehicleDamageProof(veh,false);
			end
			if(not(TABLE_VEHICLE_RESPAWNTIMER[veh]))then
				TABLE_VEHICLE_RESPAWNTIMER[veh]=setTimer(function(veh)
					respawnVehicle(veh);
					setElementData(veh,"Veh->Data->Engine",false);
					setVehicleEngineState(veh,false);
					setElementFrozen(veh,true);
				end,VEHICLE_RESPAWNTIME,1,veh)
			end
		elseif(getElementData(veh,"Veh->Data->Typ")=="User")then
			if(getElementHealth(veh)>260)then
				setVehicleDamageProof(veh,true);
			else
				setVehicleDamageProof(veh,false);
			end
			local VehID=tonumber(getElementData(veh,"Veh->Data->ID"))or nil;
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Vehicles","Health",getElementHealth(veh),"ID",VehID);
			
			triggerClientEvent(root,"Vehicle->StopHorn",root,veh);
		end
	end
end)


function toggleVehicleEngine(player)--toggle vehicle engine (on/off)
	if(player and isElement(player)and isLoggedin(player))then
		if(isPedInVehicle(player)and getPedOccupiedVehicleSeat(player)==0)then
			local veh=getPedOccupiedVehicle(player);
			if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
				local VehOwner=getElementData(veh,"Veh->Data->Owner")or nil;
				if(getVehicleEngineState(veh)and getElementData(veh,"Veh->Data->Engine")==true)then
					setElementData(veh,"Veh->Data->Engine",false);
					setVehicleEngineState(veh,false);
				elseif(VehOwner==getPlayerName(player)or VehOwner==getElementData(player,"Player->Data->Team")or getElementData(player,"AdminLevel")>=5)then
					setElementData(veh,"Veh->Data->Engine",true);
					setVehicleEngineState(veh,true);
				end
			end
		end
	end
end
function toggleVehicleLights(player)--toggle vehicle lights (on/off)
	if(player and isElement(player)and isLoggedin(player))then
		if(isPedInVehicle(player)and getPedOccupiedVehicleSeat(player)==0)then
			local veh=getPedOccupiedVehicle(player);
			if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
				if(getVehicleOverrideLights(veh)~=2)then
					setVehicleOverrideLights(veh,2);
				else
					setVehicleOverrideLights(veh,1);
				end
			end
		end
	end
end

function playCustomHorn(player,btn,state)
	if(player and isElement(player)and isLoggedin(player))then
		if(isPedInVehicle(player)and getPedOccupiedVehicleSeat(player)==0)then
			if(btn and state)then
				local veh=getPedOccupiedVehicle(player);
				if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
					local HORN=tonumber(getElementData(veh,"Veh->Data->Horn"))or nil;
					if(HORN and HORN>0)then
						toggleControl(player,"horn",false);
						if(state=="down")then
							triggerClientEvent(root,"Vehicle->PlayHorn",root,player);
						elseif(state=="up")then
							triggerClientEvent(root,"Vehicle->StopHorn",root,veh);
						end
					else
						toggleControl(player,"horn",true);
					end
				end
			end
		end
	end
end

addCommandHandler("shuff",function(player,cmd)--change seat from passenger to driver
	if(player and isElement(player)and isLoggedin(player))then
		local veh=getPedOccupiedVehicle(player);
		if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
			if(getPedOccupiedVehicleSeat(player)~=0)then
				if(getVehicleOccupant(veh,0)==false)then
					warpPedIntoVehicle(player,veh,0);
				end
			end
		end
	end
end)



addEventHandler("onVehicleDamage",root,function(loss)
	if(source and isElement(source)and loss)then
		if(getVehicleOccupant(source,0))then
			setElementHealth(source,getElementHealth(source)-loss);
		else
			if(getElementHealth(source,loss)>1000)then
				setElementHealth(source,1000);
			else
				setElementHealth(source,getElementHealth(source)+loss);
			end
		end
	end
end)
addEventHandler("onVehicleExplode",root,function()
	if(source and isElement(source))then
		local rdm=math.random(1,3);
		local x,y,z=getElementPosition(source);
		if(x and y and z)then
			triggerClientEvent(root,"Play->Sound->3D",root,"Explosions/"..rdm.."",x,y,z,0.5,250);
		end
		if(getElementData(source,"Veh->Data->Typ")=="Team")then
			setTimer(function(source)
				respawnVehicle(source);
				setElementFrozen(source,true);
			end,VEHICLE_RESPAWNTIME_BLOW,1,source)
		end
	end
end)







function GetNearestVehicle(player)--nearst vehicles
    local x,y,z=getElementPosition(player);
    local prevDistance;
    local nearestVehicle;
    for _,v in ipairs(getElementsByType("vehicle"))do
        local distance=getDistanceBetweenPoints3D(x,y,z,getElementPosition(v));
        if(distance<=(prevDistance or distance+1))then
            prevDistance=distance;
			if(prevDistance<7)then
				nearestVehicle=v;
			else
				nearestVehicle=false;
			end
        end
    end
    return nearestVehicle or false;
end

function makeVehicleEmpty(veh)
	if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
		for i=0,10 do
			VEH_SEATS_TAKEN[i]=getVehicleOccupant(veh,i);
			if(VEH_SEATS_TAKEN[i])then--remove all peds inside the vehicle
				removePedFromVehicle(VEH_SEATS_TAKEN[i]);
			end
		end
	end
end