addRemoteEvents{"Job->Start->Farmer","Job->Farmer->LoadVehicle"};--addEvent


addEventHandler("Job->Start->Farmer",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		local PLAYER_LEVEL=tonumber(getElementData(client,"FarmerLVL"));
		
		if(PLAYER_LEVEL~=0)then
			local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(JOBS["Farmer"].Tiers[PLAYER_LEVEL].VehID);
			if(isCustom)then--check custom vehicle
				TABLE_VEHICLES_JOB[client]=createVehicle(mod.base_id,-27.5,79.1,3.4,0,0,70,".");
				local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
				setElementData(TABLE_VEHICLES_JOB[client],dataName,mod.id);
				
				setJobVehicleDatas(TABLE_VEHICLES_JOB[client],"Farmer",getPlayerName(client),mod.id);
			else
				TABLE_VEHICLES_JOB[client]=createVehicle(JOBS["Farmer"].Tiers[PLAYER_LEVEL].VehID,-27.5,79.1,3.4,0,0,70,".");
				
				setJobVehicleDatas(TABLE_VEHICLES_JOB[client],"Farmer",getPlayerName(client),JOBS["Farmer"].Tiers[PLAYER_LEVEL].VehID);
			end
			
			triggerClientEvent(client,"Infobox->UI",client,"info","Job Vehicle spawned!");
			setElementData(client,"Player->Data->JobRoute",tonumber(PLAYER_LEVEL))
			triggerClientEvent(client,"Job->Create->Farmer->Stuff",client,tonumber(getElementData(client,"Player->Data->JobRoute")));
			setElementData(TABLE_VEHICLES_JOB[client],"Vehicle->Data->Job->TempStuff",0);
		else
			setElementData(client,"Player->Data->JobRoute",tonumber(PLAYER_LEVEL))
			triggerClientEvent(client,"Job->Create->Farmer->Stuff",client,tonumber(getElementData(client,"Player->Data->JobRoute")));
		end
	end
end)

addEventHandler("Job->Farmer->LoadVehicle",root,function()
	if(isLoggedin(client))then
		if(client and isElement(client)and getElementType(client)=="player")then
			if(isElement(TABLE_VEHICLES_JOB[client]))then
				if(tonumber(getElementData(client,"Player->Data->JobRoute"))==5)then--lvl 5
					setElementData(TABLE_VEHICLES_JOB[client],"Vehicle->Data->Job->TempStuff",2);
					triggerClientEvent(client,"Infobox->UI",client,"success","Vehicle was successfully loaded!");
					
					
					JOB_OBJECT_1[client]=createObject(1271,0,0,0);
					JOB_OBJECT_2[client]=createObject(1271,0,0,0);
					
					attachElements(JOB_OBJECT_1[client],TABLE_VEHICLES_JOB[client],-0.5,-2.0,0.3);
					attachElements(JOB_OBJECT_2[client],TABLE_VEHICLES_JOB[client],0.5,-2.0,0.3);
					
					setElementCollisionsEnabled(JOB_OBJECT_1[client],false);
					setElementCollisionsEnabled(JOB_OBJECT_2[client],false);
				end
			end
		end
    end
end)