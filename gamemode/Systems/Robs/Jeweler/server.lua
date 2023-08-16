local RobMarker=createMarker(459.0,-1490.7,22.9,"cylinder",1.1,200,0,0,150);
local RobCol=createColSphere(459.5,-1490.6,22.9,25);

local ROB_MARKERS={};
local ROB_MARKERS_POSITIONS={
	[1]={466.73,-1492.44,22.9,181},
	[2]={468.6,-1492.44,22.9,181},
	[3]={468.6,-1494.9,22.9,3},
	[4]={466.6,-1494.8,22.9,3},
	[5]={466.7,-1499.96,22.9,177},
	[6]={468.6,-1499.96,22.9,177},
	[7]={459.6,-1499.2,22.9,87},
	[8]={459.6,-1506.9,22.9,87},
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
						if(not isKeyBound(elem,"X","down",startJewelerrob))then
							bindKey(elem,"X","down",startJewelerrob);
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
					if(isKeyBound(elem,"X","down",startJewelerrob))then
						unbindKey(elem,"X","down",startJewelerrob);
					end
				end
			end
		end
	end
end)

function startJewelerrob(player)
	if(not(isEVIL(player)))then
		return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotInGangTeam"));
	end
	
	if(ROB_STATUS==false and isElementWithinMarker(player,RobMarker))then
		if(getTeamMembersOnline("SAPD")>=ROBS["Jeweler"].COPS_NEEDED or getTeamMembersOnline("FIB")>=ROBS["Jeweler"].COPS_NEEDED or getTeamMembersOnline("SAPD")+getTeamMembersOnline("FIB")>=ROBS["Jeweler"].COPS_NEEDED)then
			ROB_STATUS=true;
			setElementFrozen(player,true);
			setPedAnimation(player,"SHOP","SHP_Serve_End",-1,true,false,false);
			toggleAllControls(player,false);
			setElementRotation(player,0,0,88);
			setMarkerSize(RobMarker,0);
			
			triggerClientEvent(player,"Infobox->UI",player,"info","You started to rob the Jeweler!\nWait 2 Minutes and make sure your\nmates protects you!");
			
			triggerClientEvent(player,"Trigger->Timerbar",player,1*60);
			setElementData(player,"Player->Data->Robbing",true);
			
			setElementData(player,"Wanteds",tonumber(getElementData(player,"Wanteds"))+ROBS["Jeweler"].WANTEDS);
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
					outputChatBox("[INFO]: The showcases opens in 2 minutes!",v,200,200,0);
					triggerClientEvent(v,"Trigger->Timerbar",v,2*60);
				end
				
				sendDiscordMessage("Rob","```The jeweler is being robbed!```");
				sendMSGForTeam("#008cff[ROB] #c80000The jeweler is being robbed!","SAPD");
				sendMSGForTeam("#008cff[ROB] #c80000The jeweler is being robbed!","FIB");
			end,1*60*1000,1,player)
			
			setTimer(function(player)
				for _,v in pairs(getElementsWithinColShape(RobCol,"player"))do
					outputChatBox("[INFO]: The showcases opens in 1 minutes!",v,200,200,0);
				end
			end,2*60*1000,1,player)
			
			setTimer(function(root)
				setMarkerSize(RobMarker,1.1);
				ROB_STATUS=false;
				
				for i=1,#ROB_MARKERS_POSITIONS,1 do
					if(isElement(ROB_MARKERS[i]))then
						destroyElement(ROB_MARKERS[i]);
						ROB_MARKERS[i]=nil;
					end
				end
				
				sendDiscordMessage("Rob","```The jeweler has recovered from the robbery!```");
				sendMSGForTeam("#008cff[ROB] #c80000The jeweler has recovered from the robbery!","SAPD");
				sendMSGForTeam("#008cff[ROB] #c80000The jeweler has recovered from the robbery!","FIB");
			end,ROBS["Jeweler"].TIMER_RESET,1,root)
		else
			triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"Rob->NeedAmountOfStateMembers"):format(ROBS["Jeweler"].COPS_NEEDED));
		end
	end
end

function startJewelerrob2(player)
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
									
									triggerClientEvent(hitElem,"Infobox->UI",hitElem,"info","Prey is secured...\nWait "..ROBS["Jeweler"].TIMER.." second(s)!");
									if(not isKeyBound(hitElem,"X","down",cancelJewelerrob))then
										bindKey(hitElem,"X","down",cancelJewelerrob);
									end
									
									ROB_TIMER_PLAYER[hitElem]=setTimer(function(hitElem)
										local rdm=math.random(ROBS["Jeweler"].REWARD_AMOUNT[1],ROBS["Jeweler"].REWARD_AMOUNT[2]);
										
										setPedAnimation(hitElem);
										setElementFrozen(hitElem,false);
										toggleAllControls(hitElem,true);
										
										setElementData(hitElem,"Money",tonumber(getElementData(hitElem,"Money"))+tonumber(rdm));
										triggerClientEvent(hitElem,"Infobox->UI",hitElem,"success","You could secure x"..rdm.."!\nYou got "..CURRENCY..rdm2.."");
										
										setElementData(hitElem,"OverallEXP",tonumber(getElementData(hitElem,"OverallEXP"))+tonumber(ROBS["Jeweler"].REWARD_EXP));
										updateLevel(hitElem,"Overall",tonumber(ROBS["Jeweler"].REWARD_EXP));
										
										if(isKeyBound(hitElem,"X","down",cancelJewelerrob))then
											unbindKey(hitElem,"X","down",cancelJewelerrob);
										end
										
										removeElementData(hitElem,"Player->Data->Robbing");
										
										ROB_MARKERS_AMOUNT=ROB_MARKERS_AMOUNT-1;
										
										if(ROB_MARKERS_AMOUNT==0)then
											sendDiscordMessage("Rob","```The jeweler could be saved!```");
											sendMSGForTeam("#008cff[ROB] #c80000The jeweler could be saved!","SAPD");
											sendMSGForTeam("#008cff[ROB] #c80000The jeweler could be saved!","FIB");
										end
									end,ROBS["Jeweler"].TIMER*1000,1,hitElem)
								elseif(isEVIL(hitElem))then
									setElementFrozen(hitElem,true);
									setPedAnimation(hitElem,"SHOP","SHP_Serve_Loop",-1,true,false,false);
									toggleAllControls(hitElem,false);
									setElementData(hitElem,"Player->Data->Robbing",true);
									
									setElementRotation(hitElem,0,0,getElementData(source,"Marker->Data->Rotation"));
									setTimer(function(source)
										destroyElement(source);
									end,250,1,source)
									
									triggerClientEvent(hitElem,"Infobox->UI",hitElem,"info","You are robbing the showcase...\nWait "..ROBS["Jeweler"].TIMER.." second(s)!\nPress 'X' to cancel!");
									if(not isKeyBound(hitElem,"X","down",cancelJewelerrob))then
										bindKey(hitElem,"X","down",cancelJewelerrob);
									end
									
									ROB_TIMER_PLAYER[hitElem]=setTimer(function(hitElem)
										local rdm=math.random(ROBS["Jeweler"].REWARD_AMOUNT[1],ROBS["Jeweler"].REWARD_AMOUNT[2]);
										setPedAnimation(hitElem);
										setElementFrozen(hitElem,false);
										toggleAllControls(hitElem,true);
										
										setElementData(hitElem,"Money",tonumber(getElementData(hitElem,"Money"))+tonumber(rdm));
										triggerClientEvent(hitElem,"Infobox->UI",hitElem,"success","You were able to rob "..CURRENCY..rdm.."!");
										
										setElementData(hitElem,"OverallEXP",tonumber(getElementData(hitElem,"OverallEXP"))+tonumber(ROBS["Jeweler"].REWARD_EXP));
										updateLevel(hitElem,"Overall",tonumber(ROBS["Jeweler"].REWARD_EXP));
										
										if(isKeyBound(hitElem,"X","down",cancelJewelerrob))then
											unbindKey(hitElem,"X","down",cancelJewelerrob);
										end
										
										removeElementData(hitElem,"Player->Data->Robbing");
										
										ROB_MARKERS_AMOUNT=ROB_MARKERS_AMOUNT-1;
										
										if(isElement(ROB_ROBBER))then
											removeEventHandler("onPlayerWasted",ROB_ROBBER,JewelerRobberDieQuit);
											ROB_ROBBER=nil;
										end
										if(ROB_MARKERS_AMOUNT==0)then
											sendDiscordMessage("Rob","```The jeweler was successfully robbed!```");
											sendMSGForTeam("#008cff[ROB] #c80000The jeweler was successfully robbed!","SAPD");
											sendMSGForTeam("#008cff[ROB] #c80000The jeweler was successfully robbed!","FIB");
										end
									end,ROBS["Jeweler"].TIMER*1000,1,hitElem)
								end
							end
						end
					end
				end
			end
		end)
	end
end

function cancelJewelerrob(player)
	if(ROB_STATUS==true)then
		if(isTimer(ROB_TIMER_PLAYER[player]))then
			killTimer(ROB_TIMER_PLAYER[player]);
			ROB_TIMER_PLAYER[player]=nil;
			
			setPedAnimation(player);
			setElementFrozen(player,false);
			toggleAllControls(player,true);
			
			if(isKeyBound(player,"X","down",cancelJewelerrob))then
				unbindKey(player,"X","down",cancelJewelerrob);
			end
			removeElementData(player,"Player->Data->Robbing");
		end
	end
end

function JewelerRobberDieQuit()
	sendDiscordMessage("Rob","```The jewelery robbery has failed/been aborted!```");
	sendMSGForTeam("#008cff[ROB] #c80000The jewelery robbery has failed/been aborted!","SAPD");
	sendMSGForTeam("#008cff[ROB] #c80000The jewelery robbery has failed/been aborted!","FIB");
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