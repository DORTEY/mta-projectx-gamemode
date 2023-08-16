addRemoteEvents{"Job->Start->Garbage","Job->Garbage->Fill->Vehicle"};--addEvent


addEventHandler("Job->Start->Garbage",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		local PLAYER_LEVEL=tonumber(getElementData(client,"GarbageLVL"));
		
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(JOBS["Garbage"].Tiers[PLAYER_LEVEL].VehID);
		if(isCustom)then--check custom vehicle
			TABLE_VEHICLES_JOB[client]=createVehicle(mod.base_id,2112.0,-2039.9,13.7,0,0,136,".");
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			setElementData(TABLE_VEHICLES_JOB[client],dataName,mod.id);
			
			setJobVehicleDatas(TABLE_VEHICLES_JOB[client],"Garbage",getPlayerName(client),mod.id);
		else
			TABLE_VEHICLES_JOB[client]=createVehicle(JOBS["Garbage"].Tiers[PLAYER_LEVEL].VehID,2112.0,-2039.9,13.7,0,0,136,".");
			
			setJobVehicleDatas(TABLE_VEHICLES_JOB[client],"Garbage",getPlayerName(client),JOBS["Garbage"].Tiers[PLAYER_LEVEL].VehID);
		end
		
		triggerClientEvent(client,"Infobox->UI",client,"info","Job Vehicle spawned!");
		setElementData(client,"Player->Data->JobRoute",tonumber(PLAYER_LEVEL))
		triggerClientEvent(client,"Job->Create->Garbage->Stuff",client,tonumber(getElementData(client,"Player->Data->JobRoute")));
		setElementData(TABLE_VEHICLES_JOB[client],"Vehicle->Data->Job->TempStuff",0);
	end
end)


addEventHandler("Job->Garbage->Fill->Vehicle",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		if(isElement(TABLE_VEHICLES_JOB[client]))then
			local JobLine=tonumber(getElementData(client,"Player->Data->JobRoute"))or 0;
			if(JobLine==0)then
				if(isPedInVehicle(client))then
					local veh=getPedOccupiedVehicle(client,0);
					if(veh and isElement(veh))then
						if(getElementData(veh,"Veh->Data->VehID")==JOBS["Garbage"].Tiers[JobLine].VehID)then
							if(tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))<tonumber(JOBS["Garbage"].Tiers[JobLine].Limit))then
								local rdm=math.random(3,5);
								setElementData(veh,"Vehicle->Data->Job->TempStuff",tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))+tonumber(rdm));
								
								if(getElementData(veh,"Vehicle->Data->Job->TempStuff")>=tonumber(JOBS["Garbage"].Tiers[JobLine].Limit))then
									setElementData(veh,"Vehicle->Data->Job->TempStuff",tonumber(JOBS["Garbage"].Tiers[JobLine].Limit));
								end
								
								triggerClientEvent(client,"Infobox->UI",client,"info",loc(client,"Job->Garbage->Collected"):format(tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff")),tonumber(JOBS["Garbage"].Tiers[JobLine].Limit)));
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Job->Garbage->VehFull"));
							end
						end
					end
				end
			elseif(JobLine>0)then
				if(not(isPedInVehicle(client)))then
					local veh=GetNearestGarbageVehicle(client);
					if(veh~=false and veh and isElement(veh))then
						if(getElementData(veh,"Veh->Data->VehID")==JOBS["Garbage"].Tiers[JobLine].VehID)then
							if(tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))<tonumber(JOBS["Garbage"].Tiers[JobLine].Limit))then
								local rdm=math.random(4,8);
								setElementData(veh,"Vehicle->Data->Job->TempStuff",tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff"))+tonumber(rdm));
								
								if(getElementData(veh,"Vehicle->Data->Job->TempStuff")>=tonumber(JOBS["Garbage"].Tiers[JobLine].Limit))then
									setElementData(veh,"Vehicle->Data->Job->TempStuff",tonumber(JOBS["Garbage"].Tiers[JobLine].Limit));
								end
								
								triggerClientEvent(client,"Infobox->UI",client,"info",loc(client,"Job->Garbage->Collected"):format(tonumber(getElementData(veh,"Vehicle->Data->Job->TempStuff")),tonumber(JOBS["Garbage"].Tiers[JobLine].Limit)));
							else
								triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Job->Garbage->VehFull"));
							end
						end
					end
				end
			end
		end
	end
end)