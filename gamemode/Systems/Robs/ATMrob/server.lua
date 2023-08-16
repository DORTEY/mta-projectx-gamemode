local ROB_BLIP={};
local ROB_ELEMENT={};
local ROB_TIMER_PLAYER={};
local ROB_TIMER_ELEMENT={};



addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in pairs(getElementsByType("object"))do
		if(getElementModel(v)==2942)then
			local x,y,z=getElementPosition(v);
			ROB_ELEMENT[i]=createColSphere(x,y,z,10);
			
			addEventHandler("onColShapeHit",ROB_ELEMENT[i],function(elem)
				if(elem and isElement(elem)and getElementType(elem)=="player")then
					if(isPedInVehicle(elem))then
						return;
					end
					if(isSTATE(elem))then
						return;
					end
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."ATMROB#ffffff] Press 'M' and click on the ATM to start the robbery!",elem,0,0,0,true);
					end
				end
			end)
			addEventHandler("onColShapeLeave",ROB_ELEMENT[i],function(elem)
				if(elem and isElement(elem)and getElementType(elem)=="player")then
					if(isTimer(ROB_TIMER_PLAYER[elem]))then
						killTimer(ROB_TIMER_PLAYER[elem]);
						ROB_TIMER_PLAYER[elem]=nil;
						
						local x,y,z=getElementPosition(source);
						local ATMname=getZoneName(x,y,z,false);--get atm position name
						
						local ELEMENT=getElementData(elem,"Player->Data->Object")or nil;
						if(isElement(ROB_BLIP[ELEMENT]))then
							destroyElement(ROB_BLIP[ELEMENT]);
							ROB_BLIP[ELEMENT]=nil;
						end
						
						sendDiscordMessage("Rob","```A ATM Rob at '"..ATMname.."' has been failed/been aborted!```");
						sendMSGForTeam("#008cff[ROB] #c80000A ATM Rob at "..ATMname.." has been failed/been aborted!","SAPD");
						sendMSGForTeam("#008cff[ROB] #c80000A ATM Rob at "..ATMname.." has been failed/been aborted!","FIB");
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."ATMROB#ffffff] Rob failed because you were to far away!",elem,0,0,0,true);
						triggerClientEvent(elem,"Trigger->Timerbar",elem,1);
						
						removeElementData(elem,"Player->Data->Object");
						removeElementData(elem,"Player->Data->Robbing");
					end
				end
			end)
		end
	end
end)



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
	if(isSTATE(source))then
		return;
	end
	if(getElementData(source,"Player->Data->Robbing"))then
		return;
	end
	
	if(state=="down" and btn=="left")then
		if(elem and isElement(elem))then
			local x,y,z=getElementPosition(source);
			local ox,oy,oz=getElementPosition(elem);
			local model=getElementModel(elem);
			if(getElementDimension(source)==getElementDimension(elem))then
				if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3.2)then
					if(getElementType(elem)=="object")then
						if(model==2942)then
							if(not(getElementData(elem,"Object->Data->GotRobbed")))then
								setElementData(elem,"Object->Data->GotRobbed",true);
								setElementData(source,"Player->Data->Object",elem);
								local ATMname=getZoneName(x,y,z,false);--get atm position name
								
								ROB_BLIP[elem]=createBlip(x,y,z,1,12,180,0,0,255,0);
								setElementVisibleTo(ROB_BLIP[elem],root,false);
								
								for _,v in pairs(getElementsByType("player"))do
									if(isLoggedin(v)and isSTATE(v))then
										setElementVisibleTo(ROB_BLIP[elem],v,true);
									end
								end
								
								triggerClientEvent(source,"Infobox->UI",source,"info","You started to rob the ATM!\nWait "..ROBS["ATM"].TIMER.." Minutes and make sure your\nmates protects you!\nAlso dont leave the ATM!",10);
								sendDiscordMessage("Rob","```A ATM at '"..ATMname.."' is being robbed!```");
								sendMSGForTeam("#008cff[ROB] #c80000A ATM at "..ATMname.." is being robbed!","SAPD");
								sendMSGForTeam("#008cff[ROB] #c80000A ATM at "..ATMname.." is being robbed!","FIB");
								
								triggerClientEvent(source,"Trigger->Timerbar",source,ROBS["ATM"].TIMER*60);
								setElementData(source,"Player->Data->Robbing",true);
								
								setElementData(source,"Wanteds",tonumber(getElementData(source,"Wanteds"))+ROBS["ATM"].WANTEDS);
								if(tonumber(getElementData(source,"Wanteds"))>=6)then
									setElementData(source,"Wanteds",6);
								end
								
								ROB_TIMER_PLAYER[source]=setTimer(function(source)
									if(source and isElement(source)and isLoggedin(source))then
										local rdm=math.random(ROBS["ATM"].REWARD_AMOUNT[1],ROBS["ATM"].REWARD_AMOUNT[2]);
										
										if(isElement(ROB_BLIP[elem]))then
											destroyElement(ROB_BLIP[elem]);
											ROB_BLIP[elem]=nil;
										end
										
										sendDiscordMessage("Rob","```The ATM at '"..ATMname.."' got robbed successfully!```");
										sendMSGForTeam("#008cff[ROB] #c80000The ATM at "..ATMname.." got robbed successfully!","SAPD");
										sendMSGForTeam("#008cff[ROB] #c80000The ATM at "..ATMname.." got robbed successfully!","FIB");
										
										setElementData(source,"Money",tonumber(getElementData(source,"Money"))+tonumber(rdm));
										
										setElementData(source,"OverallEXP",tonumber(getElementData(source,"OverallEXP"))+tonumber(ROBS["ATM"].REWARD_EXP));
										updateLevel(source,"Overall",tonumber(ROBS["ATM"].REWARD_EXP));
										
										outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."ATMROB#ffffff] You were able to rob "..CURRENCY..rdm.."!",source,0,0,0,true);
										
										if(isElement(ROB_BLIP[elem]))then
											destroyElement(ROB_BLIP[elem]);
											ROB_BLIP[elem]=nil;
										end
									end
								end,ROBS["ATM"].TIMER*60*1000,1,source)
								
								setTimer(function(elem)
									removeElementData(elem,"Object->Data->GotRobbed");
									if(isElement(ROB_BLIP[elem]))then
										destroyElement(ROB_BLIP[elem]);
										ROB_BLIP[elem]=nil;
									end
								end,ROBS["ATM"].TIMER_RESET,1,elem)
							else
								triggerClientEvent(source,"Infobox->UI",source,"error","This ATM got robbed already!\nTry again later!");
							end
						end
					end
				end
			end
		end
	end
end)



local function destroyElementsAfterQuitDead(player)
	if(isTimer(ROB_TIMER_PLAYER[player]))then
		killTimer(ROB_TIMER_PLAYER[player]);
		ROB_TIMER_PLAYER[player]=nil;
		
		local ELEMENT=getElementData(player,"Player->Data->Object")or nil;
		local x,y,z=getElementPosition(ELEMENT);
		local ATMname=getZoneName(x,y,z,false);--get atm position name
		
		if(isElement(ROB_BLIP[ELEMENT]))then
			destroyElement(ROB_BLIP[ELEMENT]);
			ROB_BLIP[ELEMENT]=nil;
		end
		
		sendMSGForTeam("#008cff[ROB] #c80000A ATM Rob at "..ATMname.." has been failed/been aborted!","SAPD");
		sendMSGForTeam("#008cff[ROB] #c80000A ATM Rob at "..ATMname.." has been failed/been aborted!","FIB");
		removeElementData(player,"Player->Data->Object");
		removeElementData(player,"Player->Data->Robbing");
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)