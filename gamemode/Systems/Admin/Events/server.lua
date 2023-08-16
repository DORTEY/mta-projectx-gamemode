addRemoteEvents{"Admin->EventStart","Event->TeleportBack"};--addEvent


local TABLE_PLAYER_SAVE_POS_TEMP={};


addEventHandler("Admin->EventStart",root,function(eventID)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.EventStart==true)then
			if(EVENTS[tonumber(eventID)])then
				if(not(EVENTS[tonumber(eventID)].Status))then
					EVENTS[tonumber(eventID)].Status=true;
					EVENTS.STARTET_EVENT=tonumber(eventID);
					outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."EVENT#ffffff] The event called "..EVENTS[tonumber(eventID)].Name.." has been started!",root,0,0,0,true);
					if(EVENTS[tonumber(eventID)].Description)then
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."EVENT#ffffff] "..EVENTS[tonumber(eventID)].Description,root,0,0,0,true);
					end
					
					if(EVENTS[tonumber(eventID)].Name=="5 Towers")then
						startEvent5Towers();
					end
				else
					EVENTS.STARTET_EVENT=nil;
					EVENTS[tonumber(eventID)].Status=false;
					outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."EVENT#ffffff] The event "..EVENTS[tonumber(eventID)].Name.." has been ended!",root,0,0,0,true);
					
					if(EVENTS[tonumber(eventID)].Name=="5 Towers")then
						stopEvent5Towers();
					end
				end
			end
		end
	end
end)



addCommandHandler("eventwarp",function(player,cmd,...)
	if(player and isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(isPedDead(player))then
			return;
		end
		--if(isPedInVehicle(player))then
		--	return;
		--end
		if(tonumber(getElementData(player,"EventDelay"))>0)then
			return;
		end
		
		if(EVENTS.STARTET_EVENT)then
			if(EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Status)then
				local x,y,z=getElementPosition(player);
				local int=getElementInterior(player);
				local dim=getElementDimension(player);
				TABLE_PLAYER_SAVE_POS_TEMP[player]={x,y,z,int,dim};
				
				if(tonumber(getElementData(root,"Event->Data->PlayerCount"))<EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Limit)then
					setElementData(root,"Event->Data->PlayerCount",tonumber(getElementData(root,"Event->Data->PlayerCount"))+1);
					triggerClientEvent(player,"Infobox->UI",player,"info","You joined the Event!");
					
					setElementPosition(player,EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Coords[1],EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Coords[2],EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Coords[3]);
					setElementInterior(player,EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Coords[4]);
					setElementDimension(player,EVENTS[tonumber(EVENTS.STARTET_EVENT)].Teleport.Coords[5]);
					setElementData(player,"Player->Data->EventID",tonumber(EVENTS.STARTET_EVENT))--eventID
					setElementData(player,"EventDelay",20);
				else
					triggerClientEvent(player,"Infobox->UI",player,"error","Event is already full!");
				end
			end
		end
	end
end)


addEventHandler("onPlayerQuit",root,function()
	if(getElementData(source,"Player->Data->EventID"))then
		removeElementData(source,"Player->Data->EventID");
		setElementData(root,"Event->Data->PlayerCount",tonumber(getElementData(root,"Event->Data->PlayerCount"))-1);
	end
end)
addEventHandler("onPlayerWasted",root,function()
	if(getElementData(source,"Player->Data->EventID"))then
		removeElementData(source,"Player->Data->EventID");
		setElementData(root,"Event->Data->PlayerCount",tonumber(getElementData(root,"Event->Data->PlayerCount"))-1);
	end
end)


function eventWarpBack(player)
	if(player and isElement(player)and getElementType(player)=="player" and(not client or client==player))then
		if(not(isLoggedin(player)))then
			return;
		end
		
		if(isPedInVehicle(player))then
			local veh=getPedOccupiedVehicle(player);
			if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
				if(EVENT_VEHICLE[veh])then
					makeVehicleEmpty(veh);
					
					respawnVehicle(veh);
					fixVehicle(veh);
					setElementFrozen(veh,true);
					setVehicleLocked(veh,true);
					setElementData(veh,"Veh->Data->Engine",false);
					setVehicleEngineState(veh,false);
				end
			end
		end
		if(TABLE_PLAYER_SAVE_POS_TEMP[player][1])then
			setElementPosition(player,TABLE_PLAYER_SAVE_POS_TEMP[player][1],TABLE_PLAYER_SAVE_POS_TEMP[player][2],TABLE_PLAYER_SAVE_POS_TEMP[player][3]);
			setElementInterior(player,TABLE_PLAYER_SAVE_POS_TEMP[player][4]);
			setElementDimension(player,TABLE_PLAYER_SAVE_POS_TEMP[player][5]);
		end
		
		removeElementData(player,"Player->Data->EventID");
	end
end
addEventHandler("Event->TeleportBack",root,eventWarpBack)