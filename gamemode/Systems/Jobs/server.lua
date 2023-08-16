addRemoteEvents{"Job->Join","Job->Leave","Job->SellItem","Job->GiveReward"};--addEvent


local Table_TempSkins={};
addEventHandler("Job->Join",root,function(job,ped)
	if(client and isElement(client)and isLoggedin(client))then
		if(getElementData(client,"Player->Data->Job")or getElementData(client,"Player->Data->Job")==tostring(job))then
			return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"AlreadyInJob"):format(tostring(getElementData(client,"Player->Data->Job"))));
		end
		if(getElementData(client,"Player->Data->Team")~="Civilian")then
			return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotInCivilianTeam"));
		end
		if(tonumber(getElementData(client,"Wanteds"))>0)then
			return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"CantDoThatCuzWanteds"));
		end
		
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(getElementData(client,"SkinID"));
		if(isCustom)then--check custom skin
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			removeElementData(client,dataName);
		end
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(ped);
		if(isCustom)then--check new custom skin
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			removeElementData(client,dataName);
			setElementModel(client,mod.base_id);
			setElementData(client,dataName,mod.id);
			setElementModel(client,mod.base_id);
		else
			setElementModel(client,ped);
		end
		Table_TempSkins[client]=ped;
		
		triggerClientEvent(client,"Infobox->UI",client,"success",loc(client,"JobJoined"):format(tostring(job)));
		outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."JOB#ffffff] "..loc(client,"JobJoined"):format(tostring(job)).."",client,255,255,255,true);
		setElementData(client,"Player->Data->Job",tostring(job));
		
		if(job=="Farmer")then
			triggerClientEvent(client,"Job->Create->Farmer->Stuff",client,"Step->1");
		end
		if(job=="Garbage")then
			triggerClientEvent(client,"Job->Create->Garbage->Stuff",client,"Step->1");
		end
	end
end)
function leaveJob()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(not getElementData(client,"Player->Data->Job"))then
			return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"JobAlready"));
		end
		
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(Table_TempSkins[client]);
		if(isCustom)then--check old custom skin
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			removeElementData(client,dataName);
		end
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(getElementData(client,"SkinID"));
		if(isCustom)then--check custom skin
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			removeElementData(client,dataName);
			setElementModel(client,mod.base_id);
			setElementData(client,dataName,mod.id);
			setElementModel(client,mod.base_id);
		else
			setElementModel(client,getElementData(client,"SkinID"));
		end
		
		
		outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."JOB#ffffff] "..loc(client,"JobLeaved"):format(tostring(getElementData(client,"Player->Data->Job"))).."",client,255,255,255,true);
		--triggerClientEvent(client,"Infobox->UI",client,"info",loc(client,"JobLeaved"):format(tostring(getElementData(client,"Player->Data->Job"))));
		
		if(tostring(getElementData(client,"Player->Data->Job"))=="Farmer")then
			triggerClientEvent(client,"Job->Destroy->Farmer->Stuff",client);
		end
		if(tostring(getElementData(client,"Player->Data->Job"))=="Garbage")then
			triggerClientEvent(client,"Job->Destroy->Garbage->Stuff",client);
		end
		if(isElement(TABLE_VEHICLES_JOB[client]))then
			makeVehicleEmpty(TABLE_VEHICLES_JOB[client]);
			destroyElement(TABLE_VEHICLES_JOB[client]);
			TABLE_VEHICLES_JOB[client]=nil;
		end
		if(isElement(JOB_OBJECT_1[client]))then
			destroyElement(JOB_OBJECT_1[client]);
			destroyElement(JOB_OBJECT_2[client]);
			JOB_OBJECT_1[client]=nil;
			JOB_OBJECT_2[client]=nil;
		end
		removeElementData(client,"Player->Data->Job");
		Table_TempSkins[client]=nil;
	end
end
addEventHandler("Job->Leave",root,leaveJob)

addEventHandler("Job->SellItem",root,function(item,amount)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		if(getInventoryCount(client,item)>=amount)then
			setElementData(client,"Money",tonumber(getElementData(client,"Money"))+amount*getElementData(root,"Item->Price->"..item));
			takeInventory(client,item,tonumber(amount));
			
			triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"Job->SelledItem"):format(amount,loc(client,"Item->Name->"..item),CURRENCY..amount*getElementData(root,"Item->Price->"..item)));
		else
			triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughItemAmount"):format(loc(client,"Item->Name->"..item)));
		end
	end
end)

local Amount={};
addEventHandler("Job->GiveReward",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		local PLAYER_JOBROUTE=tonumber(getElementData(client,"Player->Data->JobRoute"))or nil;
		if(PLAYER_JOBROUTE)then
			if(getElementData(client,"Player->Data->Job")=="Farmer")then
				if(not(Amount[client]))then
					Amount[client]=0;
				end
				Amount[client]=Amount[client]+1;
				local rdmEXP=math.random(2,4);
				outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."JOB#ffffff] You have earned "..CURRENCY..JOBS["Farmer"].Tiers[PLAYER_JOBROUTE].Price.."",client,0,0,0,true);
				
				setElementData(client,"Money",tonumber(getElementData(client,"Money"))+tonumber(JOBS["Farmer"].Tiers[PLAYER_JOBROUTE].Price));
				setElementData(client,"FarmerEXP",tonumber(getElementData(client,"FarmerEXP"))+math.random(1,2));
				updateLevel(client,"Farmer");
				if(Amount[client]>=5)then
					setElementData(client,"OverallEXP",tonumber(getElementData(client,"OverallEXP"))+tonumber(rdmEXP));
					updateLevel(client,"Overall",tonumber(rdmEXP));
					Amount[client]=0;
				end
				
				if(isElement(TABLE_VEHICLES_JOB[client]))then
					setElementData(TABLE_VEHICLES_JOB[client],"Vehicle->Data->Job->TempStuff",0);
					if(isElement(JOB_OBJECT_1[client]))then
						destroyElement(JOB_OBJECT_1[client]);
						destroyElement(JOB_OBJECT_2[client]);
						JOB_OBJECT_1[client]=nil;
						JOB_OBJECT_2[client]=nil;
					end
				end
			end
			if(getElementData(client,"Player->Data->Job")=="Garbage")then
				if(isElement(TABLE_VEHICLES_JOB[client]))then
					if(isPedInVehicle(client)and getPedOccupiedVehicleSeat(client)==0)then
						local veh=getPedOccupiedVehicle(client);
						if(veh and isElement(veh))then
							if(getElementData(veh,"Vehicle->Data->Job->TempStuff")~=0)then
								if(tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))>=tonumber(JOBS["Garbage"].Tiers[PLAYER_JOBROUTE].Limit/100*50))then
									triggerClientEvent(client,"Infobox->UI",client,"success",loc(client,"Job->Garbage->VehEmptied"):format(CURRENCY,tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))*tonumber(JOBS["Garbage"].Tiers[PLAYER_JOBROUTE].Price)));
									setElementData(client,"Money",tonumber(getElementData(client,"Money"))+tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))*tonumber(JOBS["Garbage"].Tiers[PLAYER_JOBROUTE].Price));
									setElementData(client,"GarbageEXP",tonumber(getElementData(client,"GarbageEXP"))+tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))/100*70);
									updateLevel(client,"Garbage");
									
									setElementData(client,"OverallEXP",tonumber(getElementData(client,"OverallEXP"))+tonumber(40));
									updateLevel(client,"Overall",tonumber(40));
									
									if(isElement(TABLE_VEHICLES_JOB[client]))then
										destroyElement(TABLE_VEHICLES_JOB[client]);
										TABLE_VEHICLES_JOB[client]=nil;
										triggerClientEvent(client,"Job->Destroy->Garbage->Stuff",client);
										leaveJob(client);
									end
								else
									triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Job->Garbage->VehNeed50"));
								end
							end
						end
					end
				end
			end
		end
	end
end)


local function destroyElementsAfterQuitDead(player)
	if(isElement(TABLE_VEHICLES_JOB[player]))then
		makeVehicleEmpty(TABLE_VEHICLES_JOB[player]);
		destroyElement(TABLE_VEHICLES_JOB[player]);
		TABLE_VEHICLES_JOB[player]=nil;
	end
	if(isElement(JOB_OBJECT_1[player]))then
		destroyElement(JOB_OBJECT_1[player]);
		destroyElement(JOB_OBJECT_2[player]);
		JOB_OBJECT_1[player]=nil;
		JOB_OBJECT_2[player]=nil;
	end
	
	if(isLoggedin(player))then
		if(getElementData(player,"Player->Data->Job")=="Farmer")then
			triggerClientEvent(player,"Job->Destroy->Farmer->Stuff",player);
		end
		
		if(getElementData(source,"Player->Data->Job"))then
			removeElementData(source,"Player->Data->Job");--remove job data if exist
		end
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)


function setJobVehicleDatas(veh,typ,owner,vehid)
	if(veh and typ and owner)then
		setElementData(veh,"Veh->Data->VehID",tonumber(vehid));
		
		setElementData(veh,"Veh->Data->Owner",owner);
		setElementData(veh,"Veh->Data->Job",true);
		setElementData(veh,"Veh->Data->Job->"..typ,true);
		setElementData(veh,"Veh->Data->Engine",false);
		
		setVehicleEngineState(veh,false);
		setVehicleOverrideLights(veh,1);
		
		if(JOBS[typ].VehicleColor)then
			setVehicleColor(veh,JOBS[typ].VehicleColor[1],JOBS[typ].VehicleColor[2],JOBS[typ].VehicleColor[3],JOBS[typ].VehicleColor[1],JOBS[typ].VehicleColor[2],JOBS[typ].VehicleColor[3]);
		end
	end
end



--click on peds/objects etc
addEventHandler("onPlayerClick",root,function(btn,state,elem)
	if(not(isLoggedin(source)))then
		return;
	end
	if(isPedDead(source))then
		return;
	end
	if(isClickedState(source)==true)then
		return;
	end
	
	if(state=="down" and btn=="left")then
		if(elem and isElement(elem))then
			local x,y,z=getElementPosition(source);
			local ox,oy,oz=getElementPosition(elem);
			if(getElementDimension(source)==getElementDimension(elem))then
				if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3.5)then
					if(getElementType(elem)=="ped")then
						if(getElementData(elem,"Ped->Data->Job->Miner"))then
							triggerClientEvent(source,"Job->Mine->UI",source,"Open");
						elseif(getElementData(elem,"Ped->Data->Job->Farmer"))then
							triggerClientEvent(source,"Job->Farmer->UI",source,"Open");
						elseif(getElementData(elem,"Ped->Data->Job->Garbage"))then
							triggerClientEvent(source,"Job->Garbage->UI",source,"Open");
						end
					end
				end
			end
		end
	end
end)