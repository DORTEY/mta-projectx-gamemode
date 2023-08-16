local TABLE={--colTYP,pedID,x,y,z,rot,int,dim, colX,colY,colW,colH,colRange
	{"circle",205,1203.4,-903.6,43.3,102,0,0, 1198.1,-904.3,15},--LS mulholland(burgershot)
	{"circle",205,809.6,-1621.1,13.5,90,0,0, 801.5,-1619.3,12},--LS marina
	{"square",11,1014.4,-926.4,42.3,101,0,0, 996.6,-931.3,20,25},--LS mulholland(tankstation)
	{"square",11,1915.3,-1768.0,13.5,270,0,0, 1911.4,-1789.0,20,25},--LS idlewood
};
local ROB_BLIP={};
local ROB_ELEMENT={};
local ROB_ELEMENT_STATUS={};
local ROB_PLAYER_PED={};
local ROB_PLAYER_SHOP={};
local ROB_PLAYER_SHOP_POS={};
local ROB_TIMER_PLAYER={};
local ROB_TIMER_2_PLAYER={};


addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in pairs(TABLE)do
		if(#TABLE>0)then
			TABLE[i]=createPed(v[2],v[3],v[4],v[5],v[6],true);
			setElementDimension(TABLE[i],v[7]);
			setElementInterior(TABLE[i],v[8]);
			setElementFrozen(TABLE[i],true);
			
			if(v[1]=="circle")then
				ROB_ELEMENT[i]=createColSphere(v[9],v[10],v[5],v[11]);
			elseif(v[1]=="square")then
				ROB_ELEMENT[i]=createColRectangle(v[9],v[10],v[11],v[12]);
			end
			
			addEventHandler("onColShapeHit",ROB_ELEMENT[i],function(elem)
				if(elem and isElement(elem)and getElementType(elem)=="player")then
					if(isPedInVehicle(elem))then
						return;
					end
					if(isSTATE(elem))then
						return;
					end
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						if(not(ROB_ELEMENT_STATUS[TABLE[i]]))then
							ROB_PLAYER_PED[elem]=TABLE[i];
							ROB_PLAYER_SHOP[elem]=TABLE[i];
							ROB_PLAYER_SHOP_POS[elem]={v[2],v[3],v[4]};
							
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SHOPROB#ffffff] Press 'X' with a gun in your hand to start the robbery!",elem,0,0,0,true);
							
							if(not isKeyBound(elem,"X","down",startShopRob))then
								bindKey(elem,"X","down",startShopRob);
							end
						else
							triggerClientEvent(elem,"Infobox->UI",elem,"error","This Shop got robbed already!\nTry again later!");
						end
					end
				end
			end)
			
			addEventHandler("onColShapeLeave",ROB_ELEMENT[i],function(elem)
				if(elem and isElement(elem)and getElementType(elem)=="player")then
					if(isTimer(ROB_TIMER_PLAYER[elem]))then
						killTimer(ROB_TIMER_PLAYER[elem]);
						ROB_TIMER_PLAYER[elem]=nil;
						
						if(isTimer(ROB_TIMER_2_PLAYER[elem]))then
							killTimer(ROB_TIMER_2_PLAYER[elem]);
							ROB_TIMER_2_PLAYER[elem]=nil;
						end
						
						local x,y,z=ROB_PLAYER_SHOP_POS[elem][1],ROB_PLAYER_SHOP_POS[elem][2],ROB_PLAYER_SHOP_POS[elem][3];
						local SHOPname=getZoneName(x,y,z,false);--get shop position name
						
						if(isElement(ROB_BLIP[ROB_PLAYER_PED[elem]]))then
							destroyElement(ROB_BLIP[ROB_PLAYER_PED[elem]]);
							ROB_BLIP[ROB_PLAYER_PED[elem]]=nil;
						end
						
						ROB_PLAYER_PED[elem]=nil;
						
						sendDiscordMessage("Rob","```A Shop Rob at '"..SHOPname.."' has been failed/been aborted!```");
						sendMSGForTeam("#008cff[ROB] #c80000A Shop Rob at "..SHOPname.." has been failed/been aborted!","SAPD");
						sendMSGForTeam("#008cff[ROB] #c80000A Shop Rob at "..SHOPname.." has been failed/been aborted!","FIB");
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SHOPROB#ffffff] Rob failed because you were to far away!",elem,0,0,0,true);
						triggerClientEvent(elem,"Trigger->Timerbar",elem,1);
						removeElementData(elem,"Player->Data->Robbing");
					end
					if(isKeyBound(elem,"X","down",startShopRob))then
						unbindKey(elem,"X","down",startShopRob);
					end
				end
			end)
		end
	end
end)


function startShopRob(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player")then
		if(not(isLoggedin(elem)))then
			return;
		end
		if(not(isEVIL(elem)))then
			return triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"NotInGangTeam"));
		end
		
		if(getPedWeapon(elem)==0)then
			return triggerClientEvent(elem,"Infobox->UI",elem,"error","You need a weapon in your hand!");
		end
		
		if(not(ROB_PLAYER_PED[elem]))then
			return;
		end
		
		if(getTeamMembersOnline("SAPD")>=ROBS["Shop"].COPS_NEEDED or getTeamMembersOnline("FIB")>=ROBS["Shop"].COPS_NEEDED or getTeamMembersOnline("SAPD")+getTeamMembersOnline("FIB")>=ROBS["Shop"].COPS_NEEDED)then
			if(not(ROB_ELEMENT_STATUS[ROB_PLAYER_PED[elem]]))then
				if(getElementData(elem,"Player->Data->Robbing"))then
					return;
				end
				ROB_ELEMENT_STATUS[ROB_PLAYER_PED[elem]]=true;
				setPedAnimation(ROB_PLAYER_PED[elem],"shop","SHP_HandsUp_Scr",-1,false,true,true,nil,nil);
				
				triggerClientEvent(elem,"Infobox->UI",elem,"info","You're robbing the store...\n\nWait 2 minutes and do not\nmove away from the store!");
				
				setElementData(elem,"Player->Data->TempMoney",0);
				
				local x,y,z=getElementPosition(ROB_PLAYER_PED[elem]);--get position from ped
				local SHOPname=getZoneName(x,y,z,false);--get shop position name
				
				ROB_BLIP[ROB_PLAYER_PED[elem]]=createBlip(x,y,z,1,12,180,0,0,255,0);
				setElementVisibleTo(ROB_BLIP[ROB_PLAYER_PED[elem]],root,false);
				
				for _,v in pairs(getElementsByType("player"))do
					if(isLoggedin(v)and isSTATE(v))then
						setElementVisibleTo(ROB_BLIP[ROB_PLAYER_PED[elem]],v,true);
					end
				end
				
				sendDiscordMessage("Rob","```A Shop at '"..SHOPname.."' is being robbed!```");
				sendMSGForTeam("#008cff[ROB] #c80000A Shop at "..SHOPname.." is being robbed!","SAPD");
				sendMSGForTeam("#008cff[ROB] #c80000A Shop at "..SHOPname.." is being robbed!","FIB");
				
				triggerClientEvent(elem,"Trigger->Timerbar",elem,ROBS["Shop"].TIMER*60);
				setElementData(elem,"Player->Data->Robbing",true);
				
				setElementData(elem,"Wanteds",tonumber(getElementData(elem,"Wanteds"))+ROBS["Shop"].WANTEDS);
				if(tonumber(getElementData(elem,"Wanteds"))>=6)then
					setElementData(elem,"Wanteds",6);
				end
				
				
				ROB_TIMER_2_PLAYER[elem]=setTimer(function(elem)
					if(elem and isElement(elem)and isLoggedin(elem))then
						local rdm=math.random(ROBS["Shop"].REWARD_AMOUNT[1],ROBS["Shop"].REWARD_AMOUNT[2]);
						
						setElementData(elem,"Player->Data->TempMoney",tonumber(getElementData(elem,"Player->Data->TempMoney"))+tonumber(rdm));
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SHOPROB#ffffff] Du get "..CURRENCY..rdm.."",elem,0,0,0,true);
					end
				end,ROBS["Shop"].TIMER*1000,0,elem)
				
				local ShopElem=ROB_PLAYER_SHOP[elem];
				ROB_ELEMENT[ShopElem]=setTimer(function()
					ROB_ELEMENT_STATUS[ShopElem]=nil;
					if(isElement(ROB_BLIP[ShopElem]))then
						destroyElement(ROB_BLIP[ShopElem]);
						ROB_BLIP[ShopElem]=nil;
					end
				end,ROBS["Shop"].TIMER_RESET,1)
				
				ROB_TIMER_PLAYER[elem]=setTimer(function(elem)
					if(elem and isElement(elem)and isLoggedin(elem))then
						if(isTimer(ROB_TIMER_2_PLAYER[elem]))then
							killTimer(ROB_TIMER_2_PLAYER[elem]);
							ROB_TIMER_2_PLAYER[elem]=nil;
						end
						
						setPedAnimation(ROB_PLAYER_PED[elem]);
						
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SHOPROB#ffffff] Shoplifting successful! Escape for 1 minute without dying to keep the money!",elem,0,0,0,true);
						triggerClientEvent(elem,"Trigger->Timerbar",elem,1*60);
						
						ROB_TIMER_2_PLAYER[elem]=setTimer(function(elem)
							local x,y,z=ROB_PLAYER_SHOP_POS[elem][1],ROB_PLAYER_SHOP_POS[elem][2],ROB_PLAYER_SHOP_POS[elem][3];
							local SHOPname=getZoneName(x,y,z,false);--get shop position name
							
							if(isElement(ROB_BLIP[ROB_PLAYER_PED[elem]]))then
								destroyElement(ROB_BLIP[ROB_PLAYER_PED[elem]]);
								ROB_BLIP[ROB_PLAYER_PED[elem]]=nil;
							end
							
							sendDiscordMessage("Rob","```The Shop at '"..SHOPname.."' got robbed successfully!```");
							sendMSGForTeam("#008cff[ROB] #c80000The Shop at "..SHOPname.." got robbed successfully!","SAPD");
							sendMSGForTeam("#008cff[ROB] #c80000The Shop at "..SHOPname.." got robbed successfully!","FIB");
							
							setElementData(elem,"Money",tonumber(getElementData(elem,"Money"))+tonumber(getElementData(elem,"Player->Data->TempMoney")));
							
							setElementData(elem,"OverallEXP",tonumber(getElementData(elem,"OverallEXP"))+tonumber(ROBS["Shop"].REWARD_EXP));
							updateLevel(elem,"Overall",tonumber(ROBS["Shop"].REWARD_EXP));
							
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SHOPROB#ffffff] You were able to rob "..CURRENCY..tonumber(getElementData(elem,"Player->Data->TempMoney")).."!",elem,0,0,0,true);
							
							setElementData(elem,"Player->Data->TempMoney",0);
							removeElementData(elem,"Player->Data->Robbing");
						end,1*60*1000,1,elem)
						--end,20*1000,1,elem)
					end
				end,2*60*1000,1,elem)
				--end,30*1000,1,elem)
			else
				triggerClientEvent(elem,"Infobox->UI",elem,"error","This Shop got robbed already!\nTry again later!");
			end
		else
			triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"Rob->NeedAmountOfStateMembers"):format(ROBS["Shop"].COPS_NEEDED));
		end
	end
end


local function destroyElementsAfterQuitDead(player)
	if(isTimer(ROB_TIMER_2_PLAYER[player]))then
		killTimer(ROB_TIMER_2_PLAYER[player]);
		ROB_TIMER_2_PLAYER[player]=nil;
	end
	if(isElement(ROB_BLIP[ROB_PLAYER_PED[player]]))then
		destroyElement(ROB_BLIP[ROB_PLAYER_PED[player]]);
		ROB_BLIP[ROB_PLAYER_PED[player]]=nil;
	end
	
	if(ROB_PLAYER_SHOP[player])then
		local x,y,z=getElementPosition(ROB_PLAYER_SHOP[player]);
		local SHOPname=getZoneName(x,y,z,false);--get atm position name
		
		if(ROB_PLAYER_PED[player])then
			setPedAnimation(ROB_PLAYER_PED[player]);
		end
		
		sendDiscordMessage("Rob","```A Shop Rob at '"..SHOPname.."' has been failed/been aborted!```");
		sendMSGForTeam("#008cff[ROB] #c80000A Shop Rob at "..SHOPname.." has been failed/been aborted!","SAPD");
		sendMSGForTeam("#008cff[ROB] #c80000A Shop Rob at "..SHOPname.." has been failed/been aborted!","FIB");
	end
	
	removeElementData(player,"Player->Data->Robbing");
	
	
	ROB_PLAYER_PED[player]=nil;
	ROB_PLAYER_SHOP[player]=nil;
	ROB_PLAYER_SHOP_POS[player]=nil;
	
	if(isTimer(ROB_TIMER_PLAYER[player]))then
		killTimer(ROB_TIMER_PLAYER[player]);
		ROB_TIMER_PLAYER[player]=nil;
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)