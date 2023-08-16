addRemoteEvents{"Hospital->Time","Team->Change"};--addEvent


local TeamVehicles={
	{596,1558.7,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1563.0,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1566.4,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1570.4,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1574.5,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1578.6,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1583.6,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1587.5,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1591.4,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{596,1595.4,-1711,5.659657, 0,0,0, "SAPD"},--lspd
	{528,1602.4,-1700.1,6, 0,0,90, "SAPD"},--fbi truck
	{528,1602.4,-1696.0,6, 0,0,90, "SAPD"},--fbi truck
	{528,1602.4,-1691.9,6, 0,0,90, "SAPD"},--fbi truck
	{528,1602.4,-1688.0,6, 0,0,90, "SAPD"},--fbi truck
	{528,1602.4,-1683.9,6, 0,0,90, "SAPD"},--fbi truck
	{596,1545.4,-1684.4,5.6, 0,0,90, "SAPD"},--lspd
	{596,1545.4,-1680.3,5.6, 0,0,90, "SAPD"},--lspd
	{596,1545.4,-1676.2,5.6, 0,0,90, "SAPD"},--lspd
	{596,1545.4,-1672.1,5.6, 0,0,90, "SAPD"},--lspd
	
	{416,2066.7,-1316.5,8.7, 0,0,90, "SAMD"},--ambulance
	{416,2066.7,-1320.5,8.7, 0,0,90, "SAMD"},--ambulance
	{416,2066.7,-1324.6,8.7, 0,0,90, "SAMD"},--ambulance
	{416,2066.7,-1328.5,8.7, 0,0,90, "SAMD"},--ambulance
	{416,2060.3,-1335.3,8.7, 0,0,0, "SAMD"},--ambulance
	{416,2056.2,-1335.3,8.7, 0,0,0, "SAMD"},--ambulance
	{416,2052.0,-1335.3,8.7, 0,0,0, "SAMD"},--ambulance
	{596,2048.4,-1335.3,8.3, 0,0,0, "SAMD"},--lspd
	{596,2043.5,-1335.3,8.3, 0,0,0, "SAMD"},--lspd
	{596,2039.3,-1335.3,8.3, 0,0,0, "SAMD"},--lspd
	{596,2035.2,-1335.3,8.3, 0,0,0, "SAMD"},--lspd
	{596,2031.0,-1335.3,8.3, 0,0,0, "SAMD"},--lspd
	
	{596,1128.1,-1195.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1191.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1187.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1183.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1179.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1175.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1171.6,19.8, 0,0,270, "FIB"},--lspd
	{596,1128.1,-1167.6,19.8, 0,0,270, "FIB"},--lspd
	
	{534,2505.0,-1695.2,13.3, 0,0,0, "Grove"},--remington
	{567,2487.1,-1683.2,13.2, 0,0,270, "Grove"},--savanna
	{567,2505.5,-1676.6,13.2, 0,0,325, "Grove"},--savanna
	{535,2497.3,-1648.9,13.3, 0,0,176, "Grove"},--slamvan
	{560,2461.8,-1683.9,13.2, 0,0,273, "Grove"},--sultan
	{560,2473.2,-1695.8,13.2, 0,0,358, "Grove"},--sultan
	{560,2473.1,-1707.0,13.2, 0,0,358, "Grove"},--sultan
	
	{534,2205.5,-1157.0,25.4, 0,0,270, "Ballas"},--remington
	{567,2205.5,-1165.1,25.5, 0,0,270, "Ballas"},--savanna
	{567,2205.5,-1169.1,25.5, 0,0,270, "Ballas"},--savanna
	{560,2205.5,-1173.1,25.5, 0,0,270, "Ballas"},--sultan
	{560,2205.5,-1176.9,25.5, 0,0,270, "Ballas"},--sultan
	{560,2228.7,-1177.2,25.5, 0,0,90, "Ballas"},--sultan
	{560,2228.7,-1173.6,25.5, 0,0,90, "Ballas"},--sultan
};
addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(TeamVehicles)do
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(v[1]);
		if(isCustom)then--check custom vehicle
			TABLE_VEHICLES[i]=createVehicle(mod.base_id,v[2],v[3],v[4], v[5],v[6],v[7], v[8])
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			setElementData(TABLE_VEHICLES[i],dataName,mod.id);
			setElementData(TABLE_VEHICLES[i],"Veh->Data->VehID",mod.id);
		else
			TABLE_VEHICLES[i]=createVehicle(v[1],v[2],v[3],v[4], v[5],v[6],v[7], v[8]);
			setElementData(TABLE_VEHICLES[i],"Veh->Data->VehID",v[1]);
		end
		setVehicleRespawnPosition(TABLE_VEHICLES[i],v[2],v[3],v[4], v[5],v[6],v[7]);
		
		setElementData(TABLE_VEHICLES[i],"Veh->Data->Owner",v[8]);
		setElementData(TABLE_VEHICLES[i],"Veh->Data->Typ","Team");
		setElementData(TABLE_VEHICLES[i],"Veh->Data->Engine",false);
		--setElementData(TABLE_VEHICLES[i],"Veh->Data->Paintjob->"..v[8],true);
		setVehicleEngineState(TABLE_VEHICLES[i],false);
		setVehicleDamageProof(TABLE_VEHICLES[i],true);
		setElementFrozen(TABLE_VEHICLES[i],true);
		setVehicleOverrideLights(TABLE_VEHICLES[i],1);
		if(TEAMS[v[8]].VehicleRGB)then
			setVehicleColor(TABLE_VEHICLES[i],TEAMS[v[8]].VehicleRGB[1],TEAMS[v[8]].VehicleRGB[2],TEAMS[v[8]].VehicleRGB[3],TEAMS[v[8]].VehicleRGB[4],TEAMS[v[8]].VehicleRGB[5],TEAMS[v[8]].VehicleRGB[6]);
		end
		
		--sirens
		if(getElementData(TABLE_VEHICLES[i],"Veh->Data->Owner")=="SAPD")then
			if(getElementData(TABLE_VEHICLES[i],"Veh->Data->VehID")==596)then--lspd
				removeVehicleSirens(TABLE_VEHICLES[i]);
				addVehicleSirens(TABLE_VEHICLES[i],3,2,true,true,false,false);
				setVehicleSirens(TABLE_VEHICLES[i],1,-0.5,-0.4,1,255,0,0,255,255);
				setVehicleSirens(TABLE_VEHICLES[i],2,0.5,-0.4,1,0,0,255,255,255);
				setVehicleSirens(TABLE_VEHICLES[i],3,0,-0.4,1,255,255,255,255,255);
			end
		end
		if(getElementData(TABLE_VEHICLES[i],"Veh->Data->Owner")=="SAMD")then
			if(getElementData(TABLE_VEHICLES[i],"Veh->Data->VehID")==596)then--lspd
				removeVehicleSirens(TABLE_VEHICLES[i]);
				addVehicleSirens(TABLE_VEHICLES[i],3,2,true,true,false,false);
				setVehicleSirens(TABLE_VEHICLES[i],1,-0.5,-0.4,1,255,0,0,255,255);
				setVehicleSirens(TABLE_VEHICLES[i],2,0.5,-0.4,1,255,0,0,255,255);
				setVehicleSirens(TABLE_VEHICLES[i],3,0,-0.4,1,255,255,255,255,255);
			end
			if(getElementData(TABLE_VEHICLES[i],"Veh->Data->VehID")==416)then--ambulance
				removeVehicleSirens(TABLE_VEHICLES[i]);
				addVehicleSirens(TABLE_VEHICLES[i],3,2,true,true,false,false);
				addVehicleSirens(TABLE_VEHICLES[i],5,5,true,true,false,false);
				setVehicleSirens(TABLE_VEHICLES[i],1,0,0.9,1.3,255,255,255,200,200);
				setVehicleSirens(TABLE_VEHICLES[i],2,0.4,0.9,1.3,255,0,0,200,200);
				setVehicleSirens(TABLE_VEHICLES[i],3,-0.4,0.9,1.3,255,0,0,200,200);
				setVehicleSirens(TABLE_VEHICLES[i],4,-1,-3.7,1.45,255,0,0,200,200);
				setVehicleSirens(TABLE_VEHICLES[i],5,1,-3.7,1.45,255,0,0,200,200);
			end
		end
	end
end)


local Garages={9};
addEventHandler("onResourceStart",resourceRoot,function()
	for _,v in pairs(Garages)do
		setGarageOpen(v,true);
	end
end)


function createPlayerBlip(player,team)--create player blip on map
	TABLE_PLAYER_BLIPS[player]=createBlipAttachedTo(player,1,12,math.random(0,255),math.random(0,255),math.random(0,255),255,0,9999);
	setElementData(TABLE_PLAYER_BLIPS[player],"tooltipText",getPlayerName(player));
	
	if(getElementData(player,"Wanteds")>=WANTED_AMOUNT_BLIP)then
		setBlipColor(TABLE_PLAYER_BLIPS[player],255,0,0,255);
	else
		setBlipColor(TABLE_PLAYER_BLIPS[player],TEAMS[team].RGB[1],TEAMS[team].RGB[2],TEAMS[team].RGB[3],255);
	end
end
function destroyPlayerBlip(player)
	if(isElement(TABLE_PLAYER_BLIPS[player]))then
		destroyElement(TABLE_PLAYER_BLIPS[player]);
		TABLE_PLAYER_BLIPS[player]=nil;
	end
end
function updatePlayerBlipColor(player)--update blip color
	if(player and isElement(player))then
		if(isElement(TABLE_PLAYER_BLIPS[player]))then
			local PlayerTeam=tostring(getElementData(player,"Player->Data->Team"))or "Civilian";
			if(tonumber(getElementData(player,"Wanteds"))>=WANTED_AMOUNT_BLIP)then
				setBlipColor(TABLE_PLAYER_BLIPS[player],255,0,0,255);
			else
				setBlipColor(TABLE_PLAYER_BLIPS[player],TEAMS[PlayerTeam].RGB[1],TEAMS[PlayerTeam].RGB[2],TEAMS[PlayerTeam].RGB[3],255);
			end
		end
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isLoggedin(source))then
		local pname=getPlayerName(source);
		--destroy blip from map
		destroyPlayerBlip(source);
		--destroy pickup and blip from dead player
		if(isElement(TABLE_PLAYER_DEATH_PICKUP[pname]))then
			destroyElement(TABLE_PLAYER_DEATH_PICKUP[pname]);
			TABLE_PLAYER_DEATH_PICKUP[pname]=nil;
		end
		if(isElement(TABLE_PLAYER_DEATH_BLIP[pname]))then
			destroyElement(TABLE_PLAYER_DEATH_BLIP[pname]);
			TABLE_PLAYER_DEATH_BLIP[pname]=nil;
		end
	end
end)





function checkIfMedicRespawn(client)--create stuff when player dies
	local pname=getPlayerName(client)
	if(isElement(TABLE_PLAYER_DEATH_PICKUP[pname]))then
		destroyElement(TABLE_PLAYER_DEATH_PICKUP[pname]);
		TABLE_PLAYER_DEATH_PICKUP[pname]=nil;
	end
	if(isElement(TABLE_PLAYER_DEATH_BLIP[pname]))then
		destroyElement(TABLE_PLAYER_DEATH_BLIP[pname]);
		TABLE_PLAYER_DEATH_BLIP[pname]=nil;
	end
	
	if(getElementData(client,"Jailtime")==0)then
		local x,y,z=getElementPosition(client);
		local r,g,b=math.random(0,255),math.random(0,255),math.random(0,255);
		
		TABLE_PLAYER_DEATH_PICKUP[pname]=createPickup(x,y,z,3,1240,1000);
		TABLE_PLAYER_DEATH_BLIP[pname]=createBlip(x,y,z,1,5,r,g,b,255,0,99999,root);
		
		local zonename1=getZoneName(x,y,z,false);
		local zonename2=getZoneName(x,y,z,true);
		
		setElementVisibleTo(TABLE_PLAYER_DEATH_BLIP[pname],root,false);
		
		for i,v in pairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				if(getElementData(v,"Player->Data->Team")=="SAMD")then
					setElementVisibleTo(TABLE_PLAYER_DEATH_BLIP[pname],v,true);
					setElementData(TABLE_PLAYER_DEATH_BLIP[pname],"tooltipText",loc(v,"Dead->MSG->ToSAMD->OnMap"):format(zonename1,zonename2));
					outputChatBox(loc(v,"Dead->MSG->ToSAMD"):format(zonename1,zonename2),v,0,200,0);
				end
			end
		end
		addEventHandler("onPickupHit",TABLE_PLAYER_DEATH_PICKUP[pname],medicOnMarkerHitRevive);
	end
end



local function revivePlayer(player,target)--revive function
	if(isElement(player)and isLoggedin(player))then
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(player);
			if(isPedDead(target)and getElementData(target,"Hospitaltime")>=1)then
				TABLE_PLAYER_REVIVETIMER[player]=setTimer(function(player,target)
					if(isElement(target)and isLoggedin(target))then
						triggerClientEvent(target,"Hospital->UI",target,"Destroy");--destroy UI from target
						setCameraTarget(target)
						
						local PlayerTeam=tostring(getElementData(target,"Player->Data->Team"))or "Civilian";
						
						if(PlayerTeam~="Civilian")then
							local rdmSkin=math.random(1,#TEAMS[PlayerTeam].Peds[1]);
							skin=TEAMS[PlayerTeam].Peds[1][rdmSkin];
						else
							skin=getElementData(target,"SkinID");
						end
						
						local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(skin);
						if(isCustom)then--check custom skin
							local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
							spawnPlayer(target,x,y,z,0,mod.base_id,getElementInterior(target),getElementDimension(target));
							removeElementData(target,dataName);
							setElementData(target,dataName,mod.id);
						else
							spawnPlayer(target,x,y,z,0,skin,getElementInterior(target),getElementDimension(target))
						end
						
						--give saved weapons
						if(TABLE_PLAYER_WEAPON_SAVE_TEMP[target])then
							for weapon,ammo in pairs(TABLE_PLAYER_WEAPON_SAVE_TEMP[target])do
								giveWeapon(target,tonumber(weapon),tonumber(ammo));
							end
							TABLE_PLAYER_WEAPON_SAVE_TEMP[target]=nil;
						end
						
						
						setElementHealth(target,50);
						setElementData(target,"Hunger",60);
						setElementData(target,"Hospitaltime",0);
						
						setPedAnimation(target);
						toggleAllControls(target,true);
						setElementFrozen(target,false);
						setPedHeadless(target,false);
						jailCheck(target);
						
						setElementData(player,"Money",tonumber(getElementData(player,"Money"))+REVIVE_MONEY);
						
						outputChatBox(loc(target,"Revive->MSG->GotRevived"):format(getPlayerName(player)),target,0,200,0);
						outputChatBox(loc(player,"Revive->MSG->YouRevived"):format(getPlayerName(target),CURRENCY..REVIVE_MONEY),player,0,200,0);
					end
				end,2200,1,player,target)
			end
		end
	end
end
function medicOnMarkerHitRevive(elem)--revive start function
	if(getElementType(elem)=="player")then
		if(isElement(elem)and isLoggedin(elem))then
			if(getElementData(elem,"Player->Data->Team")=="SAMD")then
				if(getElementHealth(elem)>0)then
					local pname=nil
					for i,v in pairs(TABLE_PLAYER_DEATH_PICKUP)do
						if(v==source)then
							pname=i;
							
							local target=getPlayerFromName(i);
							if(isElement(target))then
								if(not(isPedDead(elem)))then
									toggleAllControls(elem,false);
									setPedAnimation(elem,"MEDIC","CPR",-1,true,false,false);
									setTimer(function(elem,target)
										if(isElement(elem))then
											setPedAnimation(elem)
											toggleAllControls(elem,true)
										end
										revivePlayer(elem,target);
									end,7000,1,elem,target)
								end
							end
							break;
						end
					end
					if(isElement(TABLE_PLAYER_DEATH_PICKUP[pname]))then
						destroyElement(TABLE_PLAYER_DEATH_PICKUP[pname]);
						TABLE_PLAYER_DEATH_PICKUP[pname]=nil;
					end
					if(isElement(TABLE_PLAYER_DEATH_BLIP[pname]))then
						destroyElement(TABLE_PLAYER_DEATH_BLIP[pname]);
						TABLE_PLAYER_DEATH_BLIP[pname]=nil;
					end
				end
			end
		end
	end
end


addEvent("Hospital->Time",true)--update hospital time serverside
addEventHandler("Hospital->Time",root,function(typ,time)
	if(isElement(client)and isLoggedin(client))then
		if(typ=="update")then
			setElementData(client,"Hospitaltime",getElementData(client,"Hospitaltime")-time);
		elseif(typ=="set")then
			setElementData(client,"Hospitaltime",time);
		end
	end
end)




function isSTATE(player)
	if(getElementData(player,"Player->Data->Team")=="SAPD" or getElementData(player,"Player->Data->Team")=="FIB")then
		return true;
	else
		return false;
	end
end
function isEVIL(player)
	if(getElementData(player,"Player->Data->Team")=="Grove" or getElementData(player,"Player->Data->Team")=="Ballas")then
		return true;
	else
		return false;
	end
end

function sendMSGForTeam(text,team)
	for _,v in ipairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			if(tostring(getElementData(v,"Player->Data->Team"))==tostring(team))then
				outputChatBox(text,v,0,0,0,true);
			end
		end
	end
end




addCommandHandler("team",function(player,cmd)
	if(not(isLoggedin(player)))then
		return;
	end
	if(getElementDimension(player)>0)then
		return;
	end
	if(getElementInterior(player)>0)then
		return;
	end
	if(tonumber(getElementData(player,"Jailtime"))>0)then
		return;
	end
	if(getElementData(player,"Player->Data->Job"))then
		return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"LeaveJobBefore"));
	end
	if(tonumber(getElementData(player,"TeamChangeDelay"))>0)then
		return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"TeamChangeDelay"):format(tonumber(getElementData(player,"TeamChangeDelay"))));
	end
	
	triggerClientEvent(player,"TeamSelect->UI",player,"Open","Switch");--open team select UI
end)

addEventHandler("Team->Change",root,function(team)
	if(not(isLoggedin(client)))then
		return;
	end
	if(getElementDimension(client)>0)then
		return;
	end
	if(getElementInterior(client)>0)then
		return;
	end
	if(tonumber(getElementData(client,"Jailtime"))>0)then
		return;
	end
	if(tostring(team)=="SAPD" and tonumber(getElementData(client,"Wanteds"))>0)then
		return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"CantDoThatCuzWanteds"));
	end
	if(tostring(team)=="FIB" and tonumber(getElementData(client,"Wanteds"))>0)then
		return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"CantDoThatCuzWanteds"));
	end
	if(getElementData(client,"Player->Data->Job"))then
		return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"LeaveJobBefore"));
	end
	
	local pname=getPlayerName(client);
	if(tonumber(getElementData(client,"TeamChangeDelay"))>0)then
		return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"TeamChangeDelay"):format(tonumber(getElementData(client,"TeamChangeDelay"))));
	end
	
	if(getTeamMembersOnline(team)<getTeamMembersLimit(team))then
		triggerClientEvent(client,"TeamSelect->UI",client,"Destroy");--destroy team select UI
		
		local dataNameOld=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType("player");
		local id=tonumber(getElementData(client,dataNameOld));
		if(id)then--remove old custom ped if player has
			removeElementData(client,dataNameOld);
		end
		
		
		setElementData(client,"Player->Data->Team",tostring(team));
		
		if(tostring(team)~="Civilian")then
			local rdmSkin=math.random(1,#TEAMS[team].Peds[1]);--get random team skin(gender binded)
			skin=TEAMS[team].Peds[1][rdmSkin];
		else
			skin=getMySQLData("Player_Accounts","Username",pname,"SkinID");
		end
		
		if(TEAMS[tostring(team)].Weapon)then
			giveWeapon(client,TEAMS[tostring(team)].Weapon,1);
		else
			takeWeapon(client,3);
		end
		
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(skin);
		if(isCustom)then--check custom skin
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			setElementModel(client,mod.base_id);
			
			setElementData(client,dataName,mod.id);
		else
			setElementModel(client,skin);
		end
		
		setElementData(client,"TeamChangeDelay",10);
	else
		triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"TeamSelect->Full"));
	end
end)