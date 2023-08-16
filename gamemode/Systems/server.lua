addRemoteEvents{"Trigger->Damage","Hospital->Respawn","Change->Userpanel->Settings","Trigger->Helpmenu->Items","Case->Opening"};--addEvent


--settings
addEventHandler("Change->Userpanel->Settings",root,function(typ,amount)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(isLoggedin(client))then
			assert(type(typ)=="string","Bad argument @ Settings:Change->Userpanel->Settings #1");
			assert(type(amount)=="number","Bad argument @ Settings:Change->Userpanel->Settings #1");
			if(typ and type(typ)=="string" and amount and type(amount)=="number")then
				if(typ=="Hud")then
					if(tonumber(getElementData(client,"HUD"))~=tonumber(amount))then
						setElementData(client,"HUD",tonumber(amount));
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] HUD successfully changed!",client,255,255,255,true);
					end
				end
				if(typ=="Radar")then
					if(tonumber(getElementData(client,"Radar"))~=amount)then
						setElementData(client,"Radar",tonumber(amount));
						triggerClientEvent(client,"Update->Minimap",client);
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Radar successfully changed!",client,255,255,255,true);
					end
				end
				if(typ=="Speedo")then
					if(tonumber(getElementData(client,"Speedo"))~=amount)then
						setElementData(client,"Speedo",tonumber(amount));
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Speedo successfully changed!",client,255,255,255,true);
					end
				end
				if(typ=="BlipsATM")then
					if(tonumber(getElementData(client,"BlipsATM"))~=tonumber(amount))then
						setElementData(client,"BlipsATM",tonumber(amount));
						triggerClientEvent(client,"Locate->ATMs",client,tonumber(amount));
						if(amount==2)then
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Nerby ATM's are now marked!",client,255,255,255,true);
						end
					end
				end
				if(typ=="Hitsound")then
					if(tonumber(getElementData(client,"Hitsound"))~=tonumber(amount))then
						setElementData(client,"Hitsound",tonumber(amount));
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Hitsound successfully changed!",client,255,255,255,true);
					end
				end
				if(typ=="VehBlur")then
					if(tonumber(getElementData(client,"VehBlur"))~=tonumber(amount))then
						setElementData(client,"VehBlur",tonumber(amount));
						if(tonumber(amount)==1)then
							setPlayerBlurLevel(client,0);
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Driving blur successfully disabled!",client,255,255,255,true);
						else
							setPlayerBlurLevel(client,36);
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Driving blur successfully enabled!",client,255,255,255,true);
						end
					end
				end
				if(typ=="LoadVehTextures")then
					if(tonumber(getElementData(client,"LoadVehTextures"))~=tonumber(amount))then
						setElementData(client,"LoadVehTextures",tonumber(amount));
						if(tonumber(amount)==1)then
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Vehicle Textures successfully disabled!",client,255,255,255,true);
						else
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Vehicle Textures successfully enabled!",client,255,255,255,true);
						end
					end
				end
				if(typ=="LoadSkyboxTextures")then
					if(tonumber(getElementData(client,"LoadSkyboxTextures"))~=tonumber(amount))then
						setElementData(client,"LoadSkyboxTextures",tonumber(amount));
						if(tonumber(amount)==1)then
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Skybox successfully disabled! Please reconnect.",client,255,255,255,true);
						else
							outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Skybox successfully enabled! Please reconnect.",client,255,255,255,true);
						end
					end
				end
				if(typ=="Bloodscreen")then
					if(tonumber(getElementData(client,"Bloodscreen"))~=tonumber(amount))then
						setElementData(client,"Bloodscreen",tonumber(amount));
						outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."SETTING#ffffff] Bloodscreen successfully changed!",client,255,255,255,true);
					end
				end
			end
		end
	end
end)

local CASE_REWARD_TEXT={};
local CASE_REWARD_AMOUNT={};
local CASE_REWARD_RANDOM={};
addEventHandler("Case->Opening",root,function()
	if(client and isElement(client)and isLoggedin(client))then
		local resultDaily=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Cases","Username",getPlayerName(client)),-1);
		if(#resultDaily==0)then
			CASE_REWARD_RANDOM[client]=math.random(1,100);
			
			if(CASE_REWARD_RANDOM[client]>0 and CASE_REWARD_RANDOM[client]<=85)then
				CASE_REWARD_TEXT[client]="Money";
				CASE_REWARD_AMOUNT[client]=math.random(2000,9000);
				setElementData(client,"Money",tonumber(getElementData(client,"Money"))+CASE_REWARD_AMOUNT[client]);
				
				sendDiscordMessage("Cases","```"..getPlayerName(client)..": opened a case and received "..CASE_REWARD_TEXT[client].." x"..CASE_REWARD_AMOUNT[client].."```");
			elseif(CASE_REWARD_RANDOM[client]>85 and CASE_REWARD_RANDOM[client]<=100)then
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Premium","Username",getPlayerName(client)),-1);
				if(#result==0)then
					CASE_REWARD_TEXT[client]="VIP hours";
					CASE_REWARD_AMOUNT[client]=math.random(1,3);
					
					setElementData(client,"Player->Data->Premium",1);
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Time) VALUES ('"..getPlayerName(client).."','"..getSecTime(CASE_REWARD_AMOUNT[client]).."')","Player_Premium");
					checkPremium(client);
					
					sendDiscordMessage("Cases","```"..getPlayerName(client)..": opened a case and received "..CASE_REWARD_TEXT[client].." x"..CASE_REWARD_AMOUNT[client].."```");
				else
					CASE_REWARD_TEXT[client]="Money";
					CASE_REWARD_AMOUNT[client]=math.random(2000,9000);
					setElementData(client,"Money",tonumber(getElementData(client,"Money"))+CASE_REWARD_AMOUNT[client]);
					
					sendDiscordMessage("Cases","```"..getPlayerName(client)..": opened a case and received "..CASE_REWARD_TEXT[client].." x"..CASE_REWARD_AMOUNT[client].."```");
				end
			end
			
			
			dbExec(DB.HANDLER,"INSERT INTO ?? (Username) VALUES (?)","Player_Cases",getPlayerName(client));
			triggerClientEvent(client,"Case->Show->Reward",client,"Reward: "..CASE_REWARD_TEXT[client].." x"..CASE_REWARD_AMOUNT[client]);
		else
			triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"CaseAlreadyOpened"));
			triggerClientEvent(client,"Case->Show->Reward",client,loc(client,"CaseAlreadyOpened"));
		end
	end
end)


addEventHandler("Trigger->Helpmenu->Items",root,function(typ,category)
	if(client and isElement(client)and isLoggedin(client))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ??","Helpmenu"),-1);
		local Table={};
		if(#result>=1)then
			for _,v in pairs(result)do
				if(typ=="All")then
					table.insert(Table,{v["Category"],v["CategoryText"]});
				elseif(typ=="Specific")then
					if(string.find(string.upper(v["Category"]),string.upper(category),1,true))then
						table.insert(Table,{v["Category"],v["CategoryText"]});
					end
				end
			end
			triggerClientEvent(client,"Show->Helpmenu->Items",client,Table);
		else
			outputDebugString("Failed to load 'Helpmenu' database table!",1);
		end
	end
end)


function updateLevel(player,typ,expgot)
	if(player and isElement(player)and getElementType(player)=="player")then
		if(not(isLoggedin(player)))then
			return;
		end
		if(typ=="Overall")then
			triggerClientEvent(player,"Trigger->Levelbar",player,expgot);
			local Level=tonumber(getElementData(player,typ.."LVL"))or 0;
			local EXP=tonumber(getElementData(player,typ.."EXP"))or 0;
			if(LEVEL.EXPforNextLevelUP[Level]and EXP>=LEVEL.EXPforNextLevelUP[Level])then
				setElementData(player,typ.."LVL",tonumber(getElementData(player,typ.."LVL"))+1);
				setElementData(player,typ.."EXP",tonumber(0));
			end
		end
		if(typ=="Farmer")then
			if(JOBS[typ].LevelsEXP[tonumber(getElementData(player,typ.."LVL"))]and tonumber(getElementData(player,typ.."EXP"))>=JOBS[typ].LevelsEXP[tonumber(getElementData(player,typ.."LVL"))])then
				setElementData(player,typ.."LVL",tonumber(getElementData(player,typ.."LVL"))+1);
				setElementData(player,typ.."EXP",tonumber(0));
				
				outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."JOB#ffffff] You have reached a level up in this job!",player,0,0,0,true);
				
				setElementData(player,"OverallEXP",tonumber(getElementData(player,"OverallEXP"))+50);
				updateLevel(player,"Overall",tonumber(50));
				
				if(tonumber(getElementData(player,typ.."LVL"))==1)then
					addPlayerAchievment(client,"FarmerLevel1");
				elseif(tonumber(getElementData(player,typ.."LVL"))==2)then
					addPlayerAchievment(client,"FarmerLevel2");
				elseif(tonumber(getElementData(player,typ.."LVL"))==3)then
					addPlayerAchievment(client,"FarmerLevel3");
				elseif(tonumber(getElementData(player,typ.."LVL"))==4)then
					addPlayerAchievment(client,"FarmerLevel4");
				elseif(tonumber(getElementData(player,typ.."LVL"))==5)then
					addPlayerAchievment(client,"FarmerLevel5");
				end
			end
		end
		if(typ=="Garbage")then
			if(JOBS[typ].LevelsEXP[tonumber(getElementData(player,typ.."LVL"))]and tonumber(getElementData(player,typ.."EXP"))>=JOBS[typ].LevelsEXP[tonumber(getElementData(player,typ.."LVL"))])then
				setElementData(player,typ.."LVL",tonumber(getElementData(player,typ.."LVL"))+1);
				setElementData(player,typ.."EXP",tonumber(0));
				
				outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."JOB#ffffff] You have reached a level up in this job!",player,0,0,0,true);
				
				setElementData(player,"OverallEXP",tonumber(getElementData(player,"OverallEXP"))+50);
				updateLevel(player,"Overall",tonumber(50));
				
				if(tonumber(getElementData(player,typ.."LVL"))==1)then
					addPlayerAchievment(client,"GarbageLevel1");
				elseif(tonumber(getElementData(player,typ.."LVL"))==2)then
					addPlayerAchievment(client,"GarbageLevel2");
				elseif(tonumber(getElementData(player,typ.."LVL"))==3)then
					addPlayerAchievment(client,"GarbageLevel3");
				end
			end
		end
	end
end

--damage/death systems
addEventHandler("onPlayerWasted",root,function(ammo,attacker,weapon,bodypart)
	if(isElement(source)and isLoggedin(source))then
		local pname=getPlayerName(source);
		local x,y,z=getElementPosition(source);
		
		if(isElement(TABLE_PLAYER_DEATH_PICKUP[pname]))then
			destroyElement(TABLE_PLAYER_DEATH_PICKUP[pname]);
			TABLE_PLAYER_DEATH_PICKUP[pname]=nil;
		end
		if(isElement(TABLE_PLAYER_DEATH_BLIP[pname]))then
			destroyElement(TABLE_PLAYER_DEATH_BLIP[pname]);
			TABLE_PLAYER_DEATH_BLIP[pname]=nil;
		end
		
		--save weapons & ammo
		if(not(TABLE_PLAYER_WEAPON_SAVE_TEMP[source]))then
			TABLE_PLAYER_WEAPON_SAVE_TEMP[source]={};
		end
		for i=0,12 do
			local weapon=getPedWeapon(source,i);
			if(weapon>0)then
				local ammo=getPedTotalAmmo(source,i);
				if(ammo>0)then
					TABLE_PLAYER_WEAPON_SAVE_TEMP[source][weapon]=ammo;
				end
			end
		end
		
		
		if(isPedInVehicle(source))then
			removePedFromVehicle(source);
		end
		setElementDimension(source,getElementDimension(source));
		setElementInterior(source,getElementInterior(source));
		
		TABLE_PLAYER_DEATH_PICKUP[pname]=createPickup(x,y,z,3,1240,1000);
		
		setElementInterior(TABLE_PLAYER_DEATH_PICKUP[pname],getElementInterior(source));
		setElementDimension(TABLE_PLAYER_DEATH_PICKUP[pname],getElementDimension(source));
		
		checkIfMedicRespawn(source);
		
		if(getElementData(source,"Hospitaltime")<=0)then
			if(getTeamMembersOnline("SAMD")>0)then
				if(getElementData(source,"Player->Data->Premium"))then
					triggerClientEvent(source,"Hospital->UI",source,"create",HOSPITAL_WAITTIME_MEDIC_ONLINE_VIP);
					setElementData(source,"Hospitaltime",HOSPITAL_WAITTIME_MEDIC_ONLINE_VIP);
				else
					triggerClientEvent(source,"Hospital->UI",source,"create",HOSPITAL_WAITTIME_MEDIC_ONLINE);
					setElementData(source,"Hospitaltime",HOSPITAL_WAITTIME_MEDIC_ONLINE);
				end
			else
				triggerClientEvent(source,"Hospital->UI",source,"create",HOSPITAL_WAITTIME);
				setElementData(source,"Hospitaltime",HOSPITAL_WAITTIME);
			end
		end
		if(attacker and attacker~=source and getElementType(attacker)=="player")then
			setElementData(attacker,"Kills",tonumber(getElementData(attacker,"Kills"))+1);
			setElementData(source,"Deaths",tonumber(getElementData(source,"Deaths"))+1);
			setElementData(attacker,"OverallEXP",tonumber(getElementData(attacker,"OverallEXP"))+5);
			updateLevel(attacker,"Overall",tonumber(5));
			
			if(tonumber(getElementData(attacker,"Kills"))>=25)then
				addPlayerAchievment(attacker,"25Kills");
			end
			if(tonumber(getElementData(attacker,"Kills"))>=50)then
				addPlayerAchievment(attacker,"50Kills");
			end
			if(tonumber(getElementData(attacker,"Kills"))>=100)then
				addPlayerAchievment(attacker,"100Kills");
			end
			if(tonumber(getElementData(attacker,"Kills"))>=200)then
				addPlayerAchievment(attacker,"200Kills");
			end
			if(tonumber(getElementData(source,"Deaths"))>=50)then
				addPlayerAchievment(source,"50Deaths");
			end
			if(tonumber(getElementData(source,"Deaths"))>=100)then
				addPlayerAchievment(source,"100Deaths");
			end
			
			if(isSTATE(attacker))then
				if(getElementData(source,"Wanteds")>=1)then
					setElementData(source,"Jailtime",tonumber(getElementData(source,"Wanteds"))*WANTED_TIME_DEATH);
					setElementData(attacker,"Money",tonumber(getElementData(attacker,"Money"))+tonumber(getElementData(source,"Wanteds"))*WANTED_TIME_DEATH_EARN_MONEY);
					outputChatBox("#c80000"..getPlayerName(source).."#ffffff got arrested by #00b4ff"..getPlayerName(attacker).."#ffffff for "..getElementData(source,"Wanteds")*WANTED_TIME_DEATH.." Minutes",root,0,0,0,true);
					outputChatBox("#ffffffYou've arrested #c80000"..getPlayerName(source).."#ffffff and you got "..CURRENCY..getElementData(source,"Wanteds")*WANTED_TIME_DEATH_EARN_MONEY,attacker,0,0,0,true);
					
					setElementData(attacker,"OverallEXP",tonumber(getElementData(attacker,"OverallEXP"))+tonumber(getElementData(source,"Wanteds"))*WANTED_TIME_DEATH_EARN_EXP);
					updateLevel(attacker,"Overall",tonumber(getElementData(source,"Wanteds"))*WANTED_TIME_DEATH_EARN_EXP);
				end
			end
		end
	end
end)


function damagePlayer(player,amount,attacker,weapon)
	if(player and isElement(player))then
		if(isLoggedin(player))then
			if(getPedArmor(player)>0)then
				if(getPedArmor(player)>=amount)then
					setPedArmor(player,getPedArmor(player)-amount);
				else
					setPedArmor(player,0);
					
					amount=math.abs(getPedArmor(player)-amount);
					setElementHealth(player,getElementHealth(player)-amount);
					
					if(getElementHealth(player)-amount<=0)then
						killPed(player,attacker,weapon);
					end
				end
			else
				if(getElementHealth(player)-amount<=0)then
					killPed(player,attacker,weapon);
				end
				setElementHealth(player,getElementHealth(player)-amount);
			end
		end
	end
end

addEventHandler("Trigger->Damage",root,function(target,weapon,bodypart,loss)
	if(client and isElement(client))then
		if(isLoggedin(client))then
			if(weapon and bodypart and loss)then
				--cancel some damage
				if(getElementData(client,"Player->Data->AdminDuty")==true)then
					return false;
				end
				if(getElementData(target,"Player->Data->AdminDuty")==true)then
					return false;
				end
				if(getElementData(client,"Player->Data->Savezone"))then
					return false;
				end
				if(getElementData(target,"Player->Data->Savezone"))then
					return false;
				end
				if(getElementData(client,"Jailtime")>0)then
					return false;
				end
				if(getElementData(target,"Jailtime")>0)then
					return false;
				end
				if(tostring(getElementData(client,"Player->Data->Team"))==tostring(getElementData(target,"Player->Data->Team")))then
					return false;
				end
				
				if(isSTATE(client)and tonumber(getElementData(target,"Wanteds"))<1)then
					return false;
				end
				if(tostring(getElementData(client,"Player->Data->Team"))=="Civilian" and tonumber(getElementData(client,"Wanteds"))<1 and isSTATE(target))then
					return false;
				end
				
				if(isEVIL(client)and tostring(getElementData(target,"Player->Data->Team"))=="Civilian")then
					return false;
				end
				if(tostring(getElementData(client,"Player->Data->Team"))=="Civilian" and isEVIL(target))then
					return false;
				end
				if(isEVIL(client)and isSTATE(target)and tonumber(getElementData(client,"Wanteds"))<1)then
					return false;
				end
				
				
				if(not(isPedDead(target)))then
					triggerClientEvent(target,"Bloodscreen->UI",target,tonumber(getElementData(target,"Bloodscreen")));
				end
				
				--calculate damage
				local damage=WeaponDamage[weapon]and WeaponDamage[weapon][bodypart]or 1;
				
				--headshot (sniper)
				if(weapon==34 and bodypart==9)then
					setPedHeadless(target,true);
					killPed(target,client,weapon,bodypart);
				end
				
				--arrest with stick
				if(getPedWeapon(client)==3 and isSTATE(client))then
					if(tonumber(getElementData(target,"Wanteds"))>=1)then
						if(not(TABLE_PLAYER_STICK_HITS[target]))then
							TABLE_PLAYER_STICK_HITS[target]=0;
						end
						
						TABLE_PLAYER_STICK_HITS[target]=TABLE_PLAYER_STICK_HITS[target]+1;
						
						if(TABLE_PLAYER_STICK_HITS[target]>=5)then
							setElementData(target,"Jailtime",tonumber(getElementData(target,"Wanteds"))*WANTED_TIME_DEATH);
							setElementData(client,"Money",tonumber(getElementData(client,"Money"))+tonumber(getElementData(target,"Wanteds"))*WANTED_TIME_DEATH_EARN_MONEY);
							outputChatBox("#c80000"..getPlayerName(target).."#ffffff got arrested by #00b4ff"..getPlayerName(client).."#ffffff for "..getElementData(target,"Wanteds")*WANTED_TIME_DEATH.." Minutes",root,0,0,0,true);
							outputChatBox("#ffffffYou've arrested #c80000"..getPlayerName(target).."#ffffff and you got "..CURRENCY..getElementData(target,"Wanteds")*WANTED_TIME_DEATH_EARN_MONEY,client,0,0,0,true);
							
							setElementData(client,"OverallEXP",tonumber(getElementData(client,"OverallEXP"))+tonumber(getElementData(target,"Wanteds"))*WANTED_TIME_DEATH_EARN_EXP);
							updateLevel(client,"Overall",tonumber(getElementData(target,"Wanteds"))*WANTED_TIME_DEATH_EARN_EXP);
							jailCheck(target);
						end
					end
				end
				
				if(damage)then
					damagePlayer(target,damage,client,weapon);
				else
					damagePlayer(target,loss,client,weapon);
				end
			end
		end
	end
end)


--respawn after dead
addEventHandler("Hospital->Respawn",root,function()
	if(isElement(client)and isLoggedin(client))then
		setCameraTarget(client,client);
		local x,y,z=getElementPosition(client);
		local pname=getPlayerName(client);
		
		local PlayerTeam=tostring(getElementData(client,"Player->Data->Team"))or "Civilian";
		
		if(PlayerTeam~="Civilian")then
			local rdmSkin=math.random(1,#TEAMS[PlayerTeam].Peds[1]);--get random team skin(gender binded)
			skin=TEAMS[PlayerTeam].Peds[1][rdmSkin];
		else
			skin=getElementData(client,"SkinID");
		end
		
		if(x and y and z)then
			local dataNameOld=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType("player");
			local id=tonumber(getElementData(client,dataNameOld));
			if(id)then--remove old custom ped if player has
				removeElementData(client,dataNameOld);
			end
			local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(skin);
			if(isCustom)then--check custom skin
				if(PlayerTeam~="Civilian")then
					spawnPlayer(client,TEAMS[PlayerTeam].SpawnPOS[1],TEAMS[PlayerTeam].SpawnPOS[2],TEAMS[PlayerTeam].SpawnPOS[3],TEAMS[PlayerTeam].SpawnPOS[6],mod.base_id,TEAMS[PlayerTeam].SpawnPOS[4],TEAMS[PlayerTeam].SpawnPOS[5]);
				else
					spawnPlayer(client,2026,-1404.5,17,180,mod.base_id,0,0);
				end
				local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
				setElementData(client,dataName,mod.id);
			else
				if(PlayerTeam~="Civilian")then
					spawnPlayer(client,TEAMS[PlayerTeam].SpawnPOS[1],TEAMS[PlayerTeam].SpawnPOS[2],TEAMS[PlayerTeam].SpawnPOS[3],TEAMS[PlayerTeam].SpawnPOS[6],skin,TEAMS[PlayerTeam].SpawnPOS[4],TEAMS[PlayerTeam].SpawnPOS[5]);
				else
					spawnPlayer(client,2026,-1404.5,17,180,skin,0,0);
				end
			end
		end
		
		--give saved weapons
		if(TABLE_PLAYER_WEAPON_SAVE_TEMP[source])then
			for weapon,ammo in pairs(TABLE_PLAYER_WEAPON_SAVE_TEMP[source])do
				giveWeapon(source,tonumber(weapon),tonumber(ammo));
			end
			TABLE_PLAYER_WEAPON_SAVE_TEMP[source]=nil;
		end
		
		setPedHeadless(client,false);
		toggleAllControls(client,true);
		setElementFrozen(client,false);
		setPedAnimation(client);
		
		setElementHealth(client,65);
		setElementData(client,"Hunger",50);
		setElementData(client,"Hospitaltime",0);
		
		jailCheck(client);
		
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


local PLAYER_WANTEDTIMER={};
function jailCheck(player)--check player has jail time
	if(getElementData(player,"Jailtime")>0)then
		if(isPedInVehicle(player))then
			removePedFromVehicle(player);
		end
		local rdm=math.random(1,#JailPositions[1]);
		local x,y,z=JailPositions[rdm][1],JailPositions[rdm][2],JailPositions[rdm][3];
		setElementPosition(player,x,y,z);
		setPedRotation(player,0);
		setElementInterior(player,0);
		setElementDimension(player,0);
		toggleAllControls(player,true);
		setElementData(player,"Wanteds",0);
		
		updatePlayerBlipColor(player);
		
		if(isElement(TABLE_PLAYER_STICK_HITS[player]))then
			TABLE_PLAYER_STICK_HITS[player]=nil;
		end
		
		if(isTimer(PLAYER_WANTEDTIMER[player]))then
			killTimer(PLAYER_WANTEDTIMER[player]);
			PLAYER_WANTEDTIMER[player]=nil;
		end
		PLAYER_WANTEDTIMER[player]=setTimer(function(player)
			if(tonumber(getElementData(player,"Hospitaltime"))==0)then
				if(tonumber(getElementData(player,"Jailtime"))>0)then
					setElementData(player,"Jailtime",tonumber(getElementData(player,"Jailtime"))-1);
					outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."JAIL#ffffff] "..tonumber(getElementData(player,"Jailtime")).." minute(s) left...",player,255,255,255,true);
					if(tonumber(getElementData(player,"Jailtime"))==0)then
						freePlayerJail(player);
						PLAYER_WANTEDTIMER[player]=nil;
					end
				end
			end
		end,1*60*1000,0,player);
	end
end
function freePlayerJail(player)
	fadeElementPosition(player,1569,-1683.5,16.6,0,0,0,true);
	setElementData(player,"Jailtime",0);
	
	updatePlayerBlipColor(player);
	
	if(isTimer(PLAYER_WANTEDTIMER[player]))then
		killTimer(PLAYER_WANTEDTIMER[player]);
		PLAYER_WANTEDTIMER[player]=nil;
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isLoggedin(source))then
		if(isTimer(PLAYER_WANTEDTIMER[source]))then
			killTimer(PLAYER_WANTEDTIMER[source]);
			PLAYER_WANTEDTIMER[source]=nil;
		end
	end
end)




local NOT_LOG_COMMANDS={
	["say"]=true,["whois"]=true,["Toggle"]=true,["Previous"]=true,["Reload"]=true,["restart"]=true,
	["stop"]=true,["aduty"]=true,["Next"]=true,
};

addEventHandler("onPlayerCommand",root,function(cmd)
	if(not(NOT_LOG_COMMANDS[cmd]))then
		sendDiscordMessage("Command->Used",getPlayerName(source).." used the command "..cmd);
	end
	
	if(cmd=="whois")then
	    cancelEvent();
	end
end)


--update markers from /aduty
addEventHandler("onElementDimensionChange",root,function(_,dim)
	if(source and getElementType(source)=="player")then
		if(ADUTY_MARKER[source])then
			setElementDimension(ADUTY_MARKER[source],dim);
		end
	end
end)

addEventHandler("onElementInteriorChange",root,function(_,int)
	if(source and getElementType(source)=="player")then
		if(ADUTY_MARKER[source])then
			setElementInterior(ADUTY_MARKER[source],int);
		end
	end
end)



--weather
local rnd=math.random(1,18);
setWeather(rnd);
WeatherID=rnd;

function generateWeather()
	WeatherID=math.random(1,18);
	
	setTimer(function()
		resetWaterColor();
		setWeather(WeatherID);
		setTimer(generateWeather,30*60*1000,1);
	end,1*1000,1)
end
addEventHandler("onResourceStart",resourceRoot,generateWeather)


function syncWeatherTime(player)
	local sHour,sMinute=getTime();
	triggerClientEvent(player,"Sync->WeatherTime",player,WeatherID,sHour,sMinute);
end








addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent();
end)