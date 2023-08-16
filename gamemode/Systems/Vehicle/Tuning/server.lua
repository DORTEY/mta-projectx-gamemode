addRemoteEvents{"Spawn->Tuning->Out","Tuning->Load","TuningPart->ShowRemoveAdd","TuningPart->Color"};--addEvent


local TIMER={};

addEventHandler("onResourceStart",resourceRoot,function()
	local TableMarkers={};
	local TableBlips={};
	for i,v in pairs(TUNING["Markers"])do
		TableMarkers[i]=createMarker(v[2],v[3],v[4],"cylinder",3,200,0,0,100);
		TableBlips[i]=createBlip(v[2],v[3],v[4],15,20,90,90,90,255,100);
		if(TableMarkers[i]and v[1])then
			setGarageOpen(v[1],true);--open the garages if they've
		end
		setElementData(TableBlips[i],"tooltipText","Tuningshop");
		setElementData(TableMarkers[i],"Marker->Data->ID",i);
		
		addEventHandler("onMarkerHit",TableMarkers[i],enterTuning);
	end
end)


function enterTuning(elem)
	if(elem and isElement(elem)and getElementType(elem)=="vehicle")then
		local player=getVehicleOccupant(elem,0);--get vehicle driver seat player
		if(player and isElement(player)and isLoggedin(player))then
			if(getElementDimension(source)==getElementDimension(player))then
				local veh=getPedOccupiedVehicle(player);
				if(veh and isElement(veh))then
					if(tostring(getElementData(veh,"Veh->Data->Owner"))==getPlayerName(player))then
						if(getVehicleOccupant(veh,1)==false and getVehicleOccupant(veh,2)==false and getVehicleOccupant(veh,3)==false)then
							local dim=math.random(10000,50000);
							
							setElementSpeed(veh,"km/h",0);
							setElementFrozen(veh,true);
							
							setElementPosition(veh,614.5,-124.1,998.1);
							setElementRotation(veh,0,0,90);
							setElementInterior(veh,3);
							setElementInterior(player,3);
							setElementDimension(player,dim);
							setElementDimension(veh,dim);
							
							if(VEHICLE_TYPES.BIKES[getElementData(veh,"Veh->Data->VehID")])then
								removePedFromVehicle(player);
								warpPedIntoVehicle(player,veh,1);
							end
							
							setElementData(player,"Player->Data->ID",tonumber(getElementData(source,"Marker->Data->ID")));
							triggerClientEvent(player,"Tuning->UI",player,"Open");
						else
							--todo
						end
					else
						--todo
					end
				end
			end
		end
	end
end


addEventHandler("Spawn->Tuning->Out",root,function()
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(not(isTimer(TIMER[client])))then
			TIMER[client]=setTimer(function(client)
				local Table=TUNING["OutSpawn"][tonumber(getElementData(client,"Player->Data->ID"))]or nil;
				
				local veh=getPedOccupiedVehicle(client);
				if(veh and isElement(veh))then
					setElementSpeed(veh,"km/h",0);
					setElementPosition(veh,Table[1],Table[2],Table[3]);
					setElementRotation(veh,0,0,Table[4]);
					setElementInterior(veh,0);
					setElementInterior(client,0);
					setElementDimension(veh,0);
					setElementDimension(client,0);
					setCameraTarget(client);
					
					setElementFrozen(veh,false);
					local VehPaintjob=tonumber(getElementData(veh,"Veh->Data->Paintjob"))or nil;
					local VehLight=tonumber(getElementData(veh,"Veh->Data->Light"))or nil;
					local VehPlate=tonumber(getElementData(veh,"Veh->Data->Numberplate"))or nil;
					if(VehPaintjob~=0 and VehPaintjob~=1 and VehPaintjob~=2)then
						triggerClientEvent(client,"Load->Vehicle->Paintjob->Show",client,veh,VehPaintjob);
					end
					triggerClientEvent(client,"Load->Vehicle->Light->Show",client,veh,VehLight);
					triggerClientEvent(client,"Load->Vehicle->NPlate->Show",client,veh,VehPlate);
					loadVehicleTunings(veh);
					giveVehicleSpecialUpgrade(veh);
					
					if(VEHICLE_TYPES.BIKES[getElementData(veh,"Veh->Data->VehID")])then
						warpPedIntoVehicle(client,veh,0);
					end
					
					removeElementData(client,"Player->Data->ID");
					triggerClientEvent(client,"Tuning->UI",client,"Close");
					TIMER[client]=nil;
				end
			end,500,1,client)
		end
	end
end)



addEventHandler("TuningPart->ShowRemoveAdd",root,function(typ,typ2,part)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(isPedInVehicle(client))then
			local veh=getPedOccupiedVehicle(client);
			if(veh and isElement(veh)and getElementData(veh,"Veh->Data->Owner"))then
				local VehOwner=tostring(getElementData(veh,"Veh->Data->Owner"))or nil;
				local VehID=tonumber(getElementData(veh,"Veh->Data->ID"))or nil;
				
				if(isElement(TABLE_VEHICLES_USER[VehID..VehOwner]))then
					if(typ=="Add")then
						if(typ2=="Paintjob")then
							if(tonumber(getElementData(client,"Money"))>=TUNING_CUSTOM["TuningPrices"]["pj_"..part])then--check money
								if(tonumber(part)~=tonumber(getElementData(veh,"Veh->Data->Paintjob")))then--check not double buy
									setVehiclePaintjob(veh,tonumber(3));
									setElementData(veh,"Veh->Data->Paintjob",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Paintjob",tostring(part),"Username",VehOwner,"ID",VehID);
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING_CUSTOM["TuningPrices"]["pj_"..part]);
									triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle already has this tune!");
								end
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING_CUSTOM["TuningPrices"]["pj_"..part]));
							end
						elseif(typ2=="Lights")then
							if(tonumber(getElementData(client,"Money"))>=TUNING_CUSTOM["TuningPrices"]["li_"..part])then--check money
								if(tonumber(part)~=tonumber(getElementData(veh,"Veh->Data->Light")))then--check not double buy
									setElementData(veh,"Veh->Data->Light",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Lights",tonumber(part),"Username",VehOwner,"ID",VehID);
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING_CUSTOM["TuningPrices"]["li_"..part]);
									triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle already has this tune!");
								end
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING_CUSTOM["TuningPrices"]["li_"..part]));
							end
						elseif(typ2=="Numberplate")then
							if(tonumber(getElementData(client,"Money"))>=TUNING_CUSTOM["TuningPrices"]["nplate_"..part])then--check money
								if(tonumber(part)~=tonumber(getElementData(veh,"Veh->Data->Numberplate")))then--check not double buy
									setElementData(veh,"Veh->Data->Numberplate",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Numberplate",tonumber(part),"Username",VehOwner,"ID",VehID);
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING_CUSTOM["TuningPrices"]["nplate_"..part]);
									triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle already has this tune!");
								end
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING_CUSTOM["TuningPrices"]["nplate_"..part]));
							end
						elseif(typ2=="Horns")then
							if(tonumber(getElementData(client,"Money"))>=TUNING_CUSTOM["TuningPrices"]["h_"..part])then--check money
								if(tonumber(part)~=tonumber(getElementData(veh,"Veh->Data->Horn")))then--check not double buy
									setElementData(veh,"Veh->Data->Horn",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Horn",tonumber(part),"Username",VehOwner,"ID",VehID);
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING_CUSTOM["TuningPrices"]["h_"..part]);
									triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle already has this tune!");
								end
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING_CUSTOM["TuningPrices"]["h_"..part]));
							end
						elseif(typ2=="Engine")then
							if(tonumber(getElementData(client,"Money"))>=TUNING_CUSTOM["TuningPrices"]["eng_"..part])then--check money
								if(tonumber(part)~=tonumber(getElementData(veh,"Veh->Data->Engine")))then--check not double buy
									setElementData(veh,"Veh->Data->Engine",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Engine",tonumber(part),"Username",VehOwner,"ID",VehID);
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING_CUSTOM["TuningPrices"]["eng_"..part]);
									triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle already has this tune!");
								end
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING_CUSTOM["TuningPrices"]["eng_"..part]));
							end
						elseif(typ2=="Drive type")then
							if(tonumber(getElementData(client,"Money"))>=TUNING_CUSTOM["TuningPrices"]["drive_"..tostring(part)])then--check money
								if(tostring(part)~=tostring(getElementData(veh,"Veh->Data->DriveTyp")))then--check not double buy
									setElementData(veh,"Veh->Data->DriveTyp",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","DriveTyp",tostring(part),"Username",VehOwner,"ID",VehID);
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING_CUSTOM["TuningPrices"]["drive_"..tostring(part)]);
									triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle already has this tune!");
								end
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING_CUSTOM["TuningPrices"]["drive_"..tostring(part)]));
							end
						else
							if(tonumber(getElementData(client,"Money"))>=TUNING["TuningPrices"][part])then--check money
								if(part==0 or part==1 or part==2)then--check default paintjobs
									setVehiclePaintjob(veh,tonumber(part));
									setElementData(veh,"Veh->Data->Paintjob",tostring(part));
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Paintjob",tostring(part),"Username",VehOwner,"ID",VehID);
								else
									addVehicleUpgrade(veh,tonumber(part));
									saveVehicleTunings(veh);
								end
								triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
								setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING["TuningPrices"][tonumber(part)]);
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING["TuningPrices"][tonumber(part)]));
							end
						end
					elseif(typ=="Remove")then
						if(part)then
							if(part==0 or part==1 or part==2)then
								if(getElementData(veh,"Veh->Data->Paintjob")~=9999)then
									setVehiclePaintjob(veh,tonumber(3));
									setElementData(veh,"Veh->Data->Paintjob",9999);
									dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Paintjob",9999,"Username",VehOwner,"ID",VehID);
								else
									triggerClientEvent(client,"Infobox->UI",client,"error","This vehicle doesn't have a Paintjob!");
								end
							else
								removeVehicleUpgrade(veh,tonumber(part));
								saveVehicleTunings(veh);
							end
						end
					elseif(typ=="Show")then
						if(part)then
							if(typ2=="Paintjob")then
								setVehiclePaintjob(veh,tonumber(3));
								triggerClientEvent(client,"Load->Vehicle->Paintjob->Show",client,veh,tonumber(part));
							elseif(typ2=="Lights")then
								triggerClientEvent(client,"Load->Vehicle->Light->Show",client,veh,tonumber(part));
							elseif(typ2=="Numberplate")then
								triggerClientEvent(client,"Load->Vehicle->NPlate->Show",client,veh,tonumber(part));
							elseif(typ2=="Drive type")then
								--nothing
							else
								if(part==0 or part==1 or part==2)then
									setVehiclePaintjob(veh,tonumber(part));
								else
									--local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(tonumber(part));
									--if(isCustom)then
									--	print(object)
									--	addVehicleUpgrade(veh,tonumber(mod.base_id));
									--	print(mod.id)
									--	local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
									--	setElementData(object,dataName,mod.id);
									--else
										addVehicleUpgrade(veh,tonumber(part));
									--end
								end
							end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("TuningPart->Color",root,function(typ,colorR,colorG,colorB)
	if(client and isElement(client)and getElementType(client)=="player" and isLoggedin(client))then
		if(isPedInVehicle(client))then
			local veh=getPedOccupiedVehicle(client);
			if(veh and isElement(veh)and getElementData(veh,"Veh->Data->Owner"))then
				local VehOwner=tostring(getElementData(veh,"Veh->Data->Owner"))or nil;
				local VehID=tonumber(getElementData(veh,"Veh->Data->ID"))or nil;
				
				if(isElement(TABLE_VEHICLES_USER[VehID..VehOwner]))then
					if(typ=="Bodycolor")then
						if(tonumber(getElementData(client,"Money"))>=TUNING["TuningPrices"][typ])then
							local ColorString=colorR.."|"..colorG.."|"..colorB;
							loadVehicleTunings(veh);
							setVehicleColor(veh,colorR,colorG,colorB,colorR,colorG,colorB);
							
							triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
							setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING["TuningPrices"][typ]);
							
							dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","ColorBody",ColorString,"Username",VehOwner,"ID",VehID);
						else
							triggerClientEvent(player,"Infobox->UI",player,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING["TuningPrices"][typ]));
						end
					elseif(typ=="Lightcolor")then
						if(tonumber(getElementData(client,"Money"))>=TUNING["TuningPrices"][typ])then
							local ColorString=colorR.."|"..colorG.."|"..colorB;
							loadVehicleTunings(veh);
							setVehicleHeadLightColor(veh,colorR,colorG,colorB,colorR,colorG,colorB);
							
							triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"ShopT->MSG->Bought->Item"));
							setElementData(client,"Money",tonumber(getElementData(client,"Money"))-TUNING["TuningPrices"][typ]);
							
							dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","ColorLight",ColorString,"Username",VehOwner,"ID",VehID);
						else
							triggerClientEvent(player,"Infobox->UI",player,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,TUNING["TuningPrices"][typ]));
						end
					end
				end
			end
		end
	end
end)





function loadVehicleTunings(veh)
	if(veh and isElement(veh))then
		for i=0,16 do
			local upgrade=getVehicleUpgradeOnSlot(veh,i);
			if(upgrade)then
				removeVehicleUpgrade(veh,upgrade);
			end
		end
		
		local VehOwner=tostring(getElementData(veh,"Veh->Data->Owner"))or nil;
		local VehID=tonumber(getElementData(veh,"Veh->Data->ID"))or nil;
		
		if(isElement(TABLE_VEHICLES_USER[VehID..VehOwner]))then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=? AND ??=?","Tunings","Vehicles","Username",VehOwner,"ID",VehID),-1);
			if(#result==1)then--check database table existing
				local tunings=result[1]["Tunings"];
				for i=1,17 do
					local tstring=gettok(tunings,i,string.byte("|"));
					if(tstring and #tstring>=1 and tstring~=0)then
						addVehicleUpgrade(veh,tstring);
					end
				end
			end
			
			local VehicleColorBody=getMySQLData2("Vehicles","Username",VehOwner,"ID",VehID,"ColorBody");
			local BodyR=tonumber(gettok(VehicleColorBody,1,string.byte("|")));
			local BodyG=tonumber(gettok(VehicleColorBody,2,string.byte("|")));
			local BodyB=tonumber(gettok(VehicleColorBody,3,string.byte("|")));
			setVehicleColor(veh,BodyR,BodyG,BodyB,BodyR,BodyG,BodyB);
			
			local VehicleColorLight=getMySQLData2("Vehicles","Username",VehOwner,"ID",VehID,"ColorLight");
			local LightR=tonumber(gettok(VehicleColorLight,1,string.byte("|")));
			local LightG=tonumber(gettok(VehicleColorLight,2,string.byte("|")));
			local LightB=tonumber(gettok(VehicleColorLight,3,string.byte("|")));
			setVehicleHeadLightColor(veh,LightR,LightG,LightB);
			
			local VehiclePaintjob=tonumber(getMySQLData2("Vehicles","Username",VehOwner,"ID",VehID,"Paintjob"));
			if(VehiclePaintjob~=9999)then
				if(VehiclePaintjob==0 or VehiclePaintjob==1 or VehiclePaintjob==2)then
					setVehiclePaintjob(veh,tonumber(VehiclePaintjob));
					setElementData(veh,"Veh->Data->Paintjob",VehiclePaintjob);
				end
			else
				setVehiclePaintjob(veh,tonumber(3));
			end
		end
	end
end
addEventHandler("Tuning->Load",root,loadVehicleTunings)

function saveVehicleTunings(veh)
	if(veh and isElement(veh))then
		local VehOwner=tostring(getElementData(veh,"Veh->Data->Owner"))or nil;
		local VehID=tonumber(getElementData(veh,"Veh->Data->ID"))or nil;
		
		if(isElement(TABLE_VEHICLES_USER[VehID..VehOwner]))then
			local tunings="";
			for i=0,16 do
				local upgrade=getVehicleUpgradeOnSlot(veh,i);
				if(upgrade)then
					tunings=tunings..upgrade.."|";
				else
					tunings=tunings.."0|";
				end
			end
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Vehicles","Tunings",tunings,"Username",VehOwner,"ID",VehID);
		end
	end
end




function giveVehicleSpecialUpgrade(elem)
	if(elem and isElement(elem)and getElementType(elem)=="vehicle")then
		local model=getElementModel(elem);
		local thisveh=getOriginalHandling(model);
		
		setVehicleHandling(elem,"driveType",tostring(getElementData(elem,"Veh->Data->DriveTyp")));
		
		local sportmotor=tonumber(getElementData(elem,"Veh->Data->Engine"));
		if(sportmotor and sportmotor>0)then
			if(sportmotor==5)then
				setVehicleHandling(elem,"maxVelocity",(thisveh['maxVelocity']*(1+0.4*sportmotor)));
				setVehicleHandling(elem,"engineAcceleration",(thisveh['engineAcceleration']*(1+0.3*sportmotor)));
				setVehicleHandling(elem,"engineInertia",(thisveh['engineInertia']*(1+0.3*sportmotor)));
				setVehicleHandling(elem,"brakeDeceleration",(thisveh['brakeDeceleration']*(1+0.3*sportmotor)));
				setVehicleHandling(elem,"tractionMultiplier",(thisveh['tractionMultiplier']*(1+0.1*sportmotor)));
			elseif(sportmotor==4)then
				setVehicleHandling(elem,"maxVelocity",(thisveh['maxVelocity']*(1+0.3*sportmotor)));
				setVehicleHandling(elem,"engineAcceleration",(thisveh['engineAcceleration']*(1+0.27*sportmotor)));
				setVehicleHandling(elem,"engineInertia",(thisveh['engineInertia']*(1+0.27*sportmotor)));
				setVehicleHandling(elem,"brakeDeceleration",(thisveh['brakeDeceleration']*(1+0.27*sportmotor)));
				setVehicleHandling(elem,"tractionMultiplier",(thisveh['tractionMultiplier']*(1+0.1*sportmotor)));
			elseif(sportmotor==3)then
				setVehicleHandling(elem,"maxVelocity",(thisveh['maxVelocity']*(1+0.24*sportmotor)));
				setVehicleHandling(elem,"engineAcceleration",(thisveh['engineAcceleration']*(1+0.24*sportmotor)));
				setVehicleHandling(elem,"engineInertia",(thisveh['engineInertia']*(1+0.24*sportmotor)));
				setVehicleHandling(elem,"brakeDeceleration",(thisveh['brakeDeceleration']*(1+0.25*sportmotor)));
				setVehicleHandling(elem,"tractionMultiplier",(thisveh['tractionMultiplier']*(1+0.11*sportmotor)));
			elseif(sportmotor==2)then
				setVehicleHandling(elem,"maxVelocity",(thisveh['maxVelocity']*(1+0.2*sportmotor)));
				setVehicleHandling(elem,"engineAcceleration",(thisveh['engineAcceleration']*(1+0.2*sportmotor)));
				setVehicleHandling(elem,"engineInertia",(thisveh['engineInertia']*(1+0.2*sportmotor)));
				setVehicleHandling(elem,"brakeDeceleration",(thisveh['brakeDeceleration']*(1+0.22*sportmotor)));
				setVehicleHandling(elem,"tractionMultiplier",(thisveh['tractionMultiplier']*(1+0.14*sportmotor)));
			elseif(sportmotor==1)then
				setVehicleHandling(elem,"maxVelocity",(thisveh['maxVelocity']*(1+0.2*sportmotor)));
				setVehicleHandling(elem,"engineAcceleration",(thisveh['engineAcceleration']*(1+0.2*sportmotor)));
				setVehicleHandling(elem,"engineInertia",(thisveh['engineInertia']*(1+0.2*sportmotor)));
				setVehicleHandling(elem,"brakeDeceleration",(thisveh['brakeDeceleration']*(1+0.22*sportmotor)));
				setVehicleHandling(elem,"tractionMultiplier",(thisveh['tractionMultiplier']*(1+0.14*sportmotor)));
			end
		end
		
		local Radtype=tostring(getElementData(elem,"Veh->Data->Radtype"));
		if(Radtype)then
			setVehicleHandling(elem,"driveType",Radtype);
		end
	end
end