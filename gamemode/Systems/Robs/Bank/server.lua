local RobObject=createObject(2949,2317.6,-1.78,25.7,0,0,0,true);
local RobObject2=createObject(2957,2331.2,-18.2,27.3,0,0,0,true);
local RobMarker=createMarker(2317.1,-2.5,25.7,"cylinder",1.1,200,0,0,150);
local RobCol=createColSphere(2308.8,-13.2,25.7,25);

local ROB_MARKERS={};
local ROB_MARKERS_POSITIONS={
	[1]={2321.3,-15.6,25.7,181},
	[2]={2326.5,-15.6,25.7,181},
	[3]={2328.7,-15.7,25.7,264},
	[4]={2328.7,-11.3,25.7,264},
	[5]={2328.7,-9.4,25.7,264},
};
local ROB_ROBBER=nil;
local ROB_STATUS=false;
local ROB_MARKERS_AMOUNT=0;
local ROB_TIMER_PLAYER={};


addEventHandler("onMarkerHit",RobMarker,function(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player")then
		if(isLoggedin(elem))then
			if(getElementDimension(elem)==getElementDimension(source))then
				if(not(isPedInVehicle(elem)))then
					if(isEVIL(elem))then
						if(not isKeyBound(elem,"X","down",startBanrob))then
							bindKey(elem,"X","down",startBanrob);
						end
						triggerClientEvent(elem,"Infobox->UI",elem,"info","Press 'X' to start the robberie!");
					else
						triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"NotInGangTeam"));
					end
				end
			end
		end
	end
end)
addEventHandler("onMarkerLeave",RobMarker,function(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player")then
		if(isLoggedin(elem))then
			if(getElementDimension(elem)==getElementDimension(source))then
				if(not(isPedInVehicle(elem)))then
					if(isKeyBound(elem,"X","down",startBanrob))then
						unbindKey(elem,"X","down",startBanrob);
					end
				end
			end
		end
	end
end)

function startBanrob(player)
	if(not(isEVIL(player)))then
		return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotInGangTeam"));
	end
	
	if(ROB_STATUS==false and isElementWithinMarker(player,RobMarker))then
		if(getTeamMembersOnline("SAPD")>=ROBS["Bank"].COPS_NEEDED or getTeamMembersOnline("FIB")>=ROBS["Bank"].COPS_NEEDED or getTeamMembersOnline("SAPD")+getTeamMembersOnline("FIB")>=ROBS["Bank"].COPS_NEEDED)then
			ROB_STATUS=true;
			setElementFrozen(player,true);
			setPedAnimation(player,"SHOP","SHP_Serve_End",-1,true,false,false);
			toggleAllControls(player,false);
			setElementRotation(player,0,0,275);
			setMarkerSize(RobMarker,0);
			
			triggerClientEvent(player,"Infobox->UI",player,"info","You started to rob the Bank!\nWait 2 Minutes and make sure your\nmates protects you!");
			
			triggerClientEvent(player,"Trigger->Timerbar",player,1*60);
			setElementData(player,"Player->Data->Robbing",true);
			
			setElementData(player,"Wanteds",tonumber(getElementData(player,"Wanteds"))+ROBS["Bank"].WANTEDS);
			if(tonumber(getElementData(player,"Wanteds"))>=6)then
				setElementData(player,"Wanteds",6);
			end
			
			setTimer(function(player)
				ROB_ROBBER=player;
				setPedAnimation(player);
				toggleAllControls(player,true);
				setElementFrozen(player,false);
				setTimer(startJewelerrob2,2*60*1000,1,player)
				
				addEventHandler("onPlayerWasted",ROB_ROBBER,JewelerRobberDieQuit) 
				
				for _,v in pairs(getElementsWithinColShape(RobCol,"player"))do
					outputChatBox("[INFO]: The door opens in 2 minutes!",v,200,200,0);
					triggerClientEvent(v,"Trigger->Timerbar",v,2*60);
				end
				
				sendDiscordMessage("Rob","```The Bank is being robbed!```");
				sendMSGForTeam("#008cff[ROB] #c80000The Bank is being robbed!","SAPD");
				sendMSGForTeam("#008cff[ROB] #c80000The Bank is being robbed!","FIB");
			end,1*60*1000,1,player)
			
			setTimer(function(player)
				for _,v in pairs(getElementsWithinColShape(RobCol,"player"))do
					outputChatBox("[INFO]: The door opens in 1 minutes!",v,200,200,0);
				end
			end,2*60*1000,1,player)
			
			setTimer(function(root)
				setMarkerSize(RobMarker,1.1);
				if(isElement(RobObject))then
					moveObject(RobObject,5*1000,2317.6,-1.78,25.7,0,0,-90);
					moveObject(RobObject2,5*1000,2331.2,-18.2,27.3,0,0,0);
				end
				ROB_STATUS=false;
				
				for i=1,#ROB_MARKERS_POSITIONS,1 do
					if(isElement(ROB_MARKERS[i]))then
						destroyElement(ROB_MARKERS[i]);
						ROB_MARKERS[i]=nil;
					end
				end
				
				sendDiscordMessage("Rob","```The Bank has recovered from the robbery!```");
				sendMSGForTeam("#008cff[ROB] #c80000The Bank has recovered from the robbery!","SAPD");
				sendMSGForTeam("#008cff[ROB] #c80000The Bank has recovered from the robbery!","FIB");
			end,ROBS["Bank"].TIMER_RESET,1,root)
		else
			triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"Rob->NeedAmountOfStateMembers"):format(ROBS["Jeweler"].COPS_NEEDED));
		end
	end
end

function startJewelerrob2(player)
	if(isElement(RobObject))then
		moveObject(RobObject,5*1000,2317.6,-1.78,25.7,0,0,90);
	end
	for i=1,#ROB_MARKERS_POSITIONS,1 do
		ROB_MARKERS[i]=createMarker(ROB_MARKERS_POSITIONS[i][1],ROB_MARKERS_POSITIONS[i][2],ROB_MARKERS_POSITIONS[i][3],"cylinder",1.07,0,255,0,70);
		setElementData(ROB_MARKERS[i],"Marker->Data->Rotation",ROB_MARKERS_POSITIONS[i][4]);
		ROB_MARKERS_AMOUNT=i;
		
		addEventHandler("onMarkerHit",ROB_MARKERS[i],function(hitElem)
			if(hitElem and isElement(hitElem)and getElementType(hitElem)=="player")then
				if(isLoggedin(hitElem))then
					if(getElementDimension(hitElem)==getElementDimension(source))then
						if(not(isPedInVehicle(hitElem)))then
							if(ROB_STATUS==true and isElementWithinMarker(hitElem,source))then
								if(isSTATE(hitElem))then
									setElementFrozen(hitElem,true);
									setPedAnimation(hitElem,"SHOP","SHP_Serve_Loop",-1,true,false,false);
									toggleAllControls(hitElem,false);
									setElementData(hitElem,"Player->Data->Robbing",true);
									
									setElementRotation(hitElem,0,0,getElementData(source,"Marker->Data->Rotation"));
									setTimer(function(source)
										destroyElement(source);
									end,250,1,source)
									
									triggerClientEvent(hitElem,"Infobox->UI",hitElem,"info","Prey is secured...\nWait "..ROBS["Bank"].TIMER.." second(s)!");
									if(not isKeyBound(hitElem,"X","down",cancelBankrob))then
										bindKey(hitElem,"X","down",cancelBankrob);
									end
									
									ROB_TIMER_PLAYER[hitElem]=setTimer(function(hitElem)
										local rdm=math.random(ROBS["Bank"].REWARD_AMOUNT[1],ROBS["Bank"].REWARD_AMOUNT[2]);
										
										setPedAnimation(hitElem);
										setElementFrozen(hitElem,false);
										toggleAllControls(hitElem,true);
										
										setElementData(hitElem,"Money",tonumber(getElementData(hitElem,"Money"))+tonumber(rdm));
										triggerClientEvent(hitElem,"Infobox->UI",hitElem,"success","You could secure x"..rdm.."!\nYou got "..CURRENCY..rdm2.."");
										
										setElementData(hitElem,"OverallEXP",tonumber(getElementData(hitElem,"OverallEXP"))+tonumber(ROBS["Bank"].REWARD_EXP));
										updateLevel(hitElem,"Overall",tonumber(ROBS["Bank"].REWARD_EXP));
										
										if(isKeyBound(hitElem,"X","down",cancelBankrob))then
											unbindKey(hitElem,"X","down",cancelBankrob);
										end
										
										removeElementData(hitElem,"Player->Data->Robbing");
										
										ROB_MARKERS_AMOUNT=ROB_MARKERS_AMOUNT-1;
										
										if(ROB_MARKERS_AMOUNT==0)then
											sendDiscordMessage("Rob","```The Bank could be saved!```");
											sendMSGForTeam("#008cff[ROB] #c80000The Bank could be saved!","SAPD");
											sendMSGForTeam("#008cff[ROB] #c80000The Bank could be saved!","FIB");
										end
									end,ROBS["Bank"].TIMER*1000,1,hitElem)
								elseif(isEVIL(hitElem))then
									setElementFrozen(hitElem,true);
									setPedAnimation(hitElem,"SHOP","SHP_Serve_Loop",-1,true,false,false);
									toggleAllControls(hitElem,false);
									setElementData(hitElem,"Player->Data->Robbing",true);
									
									setElementRotation(hitElem,0,0,getElementData(source,"Marker->Data->Rotation"));
									setTimer(function(source)
										destroyElement(source);
									end,250,1,source)
									
									triggerClientEvent(hitElem,"Infobox->UI",hitElem,"info","You are robbing the Safe...\nWait "..ROBS["Bank"].TIMER.." second(s)!\nPress 'X' to cancel!");
									if(not isKeyBound(hitElem,"X","down",cancelBankrob))then
										bindKey(hitElem,"X","down",cancelBankrob);
									end
									
									ROB_TIMER_PLAYER[hitElem]=setTimer(function(hitElem)
										local rdm=math.random(ROBS["Bank"].REWARD_AMOUNT[1],ROBS["Bank"].REWARD_AMOUNT[2]);
										setPedAnimation(hitElem);
										setElementFrozen(hitElem,false);
										toggleAllControls(hitElem,true);
										
										setElementData(hitElem,"Money",tonumber(getElementData(hitElem,"Money"))+tonumber(rdm));
										triggerClientEvent(hitElem,"Infobox->UI",hitElem,"success","You were able to rob "..CURRENCY..rdm.."!");
										
										setElementData(hitElem,"OverallEXP",tonumber(getElementData(hitElem,"OverallEXP"))+tonumber(ROBS["Bank"].REWARD_EXP));
										updateLevel(hitElem,"Overall",tonumber(ROBS["Bank"].REWARD_EXP));
										
										if(isKeyBound(hitElem,"X","down",cancelBankrob))then
											unbindKey(hitElem,"X","down",cancelBankrob);
										end
										
										removeElementData(hitElem,"Player->Data->Robbing");
										
										ROB_MARKERS_AMOUNT=ROB_MARKERS_AMOUNT-1;
										if(ROB_MARKERS_AMOUNT==2)then
											if(isElement(RobObject2))then
												moveObject(RobObject2,5*1000,2331.2,-18.2,29.5,0,0,0);
											end
										end
										if(isElement(ROB_ROBBER))then
											removeEventHandler("onPlayerWasted",ROB_ROBBER,JewelerRobberDieQuit);
											ROB_ROBBER=nil;
										end
										if(ROB_MARKERS_AMOUNT==0)then
											sendDiscordMessage("Rob","```The Bank was successfully robbed!```");
											sendMSGForTeam("#008cff[ROB] #c80000The Bank was successfully robbed!","SAPD");
											sendMSGForTeam("#008cff[ROB] #c80000The Bank was successfully robbed!","FIB");
										end
									end,ROBS["Bank"].TIMER*1000,1,hitElem)
								end
							end
						end
					end
				end
			end
		end)
	end
end

function cancelBankrob(player)
	if(ROB_STATUS==true)then
		if(isTimer(ROB_TIMER_PLAYER[player]))then
			killTimer(ROB_TIMER_PLAYER[player]);
			ROB_TIMER_PLAYER[player]=nil;
			
			setPedAnimation(player);
			setElementFrozen(player,false);
			toggleAllControls(player,true);
			
			if(isKeyBound(player,"X","down",cancelBankrob))then
				unbindKey(player,"X","down",cancelBankrob);
			end
			removeElementData(player,"Player->Data->Robbing");
		end
	end
end

function JewelerRobberDieQuit()
	sendMSGForTeam("#008cff[ROB] #c80000The Bank robbery has failed/been aborted!","SAPD");
	sendMSGForTeam("#008cff[ROB] #c80000The Bank robbery has failed/been aborted!","FIB");
	if(isElement(ROB_ROBBER))then
		removeEventHandler("onPlayerWasted",ROB_ROBBER,JewelerRobberDieQuit);
		ROB_ROBBER=nil;
	end
	
	
	for i=1,#ROB_MARKERS_POSITIONS do
		if(isElement(ROB_MARKERS[i]))then
			destroyElement(ROB_MARKERS[i]);
			ROB_MARKERS[i]=nil;
		end
	end
	
	setMarkerSize(RobMarker,1.1);
	ROB_STATUS=false;
end


local function destroyElementsAfterQuitDead(player)
	if(isTimer(ROB_TIMER_PLAYER[source]))then
		killTimer(ROB_TIMER_PLAYER[source]);
		ROB_TIMER_PLAYER[source]=nil;
		
		removeElementData(player,"Player->Data->Robbing");
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)