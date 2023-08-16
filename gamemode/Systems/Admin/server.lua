addRemoteEvents{"Admin->Player->Kick","Admin->Player->Ban","Admin->Player->UnBan",
"Admin->Player->Goto","Admin->Player->Gethere","Admin->Player->Freeze","Admin->Player->RepairVeh",
"Admin->ClearChat", "Trigger->AdminUI->Bans","Trigger->AdminUI->ADs",
"Admin->Give","Admin->ClearAdlist",
"Admin->SetServerPassword","Admin->Player->Kick->All","Admin->GenerateCodes"};--addEvent


local AHIDE_TOGGLE={};
--admin duty
addCommandHandler("aduty",function(player,cmd)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getElementData(player,"AdminLevel"))>=1)then
			if(not(ADUTY_LastSkin[player]))then
				local x,y,z=getElementPosition(player);
				ADUTY_MARKER[player]=createMarker(x,y,z,"arrow",0.25,SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],160);
				setElementDimension(ADUTY_MARKER[player],getElementDimension(player));
				setElementInterior(ADUTY_MARKER[player],getElementInterior(player));
				attachElements(ADUTY_MARKER[player],player,0,0,1.2);
				
				ADUTY_LastSkin[player]=getElementData(player,"SkinID");
				
				local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(ADUTY_LastSkin[player]);
				if(isCustom)then--check custom skin
					local dataName2=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
					removeElementData(player,dataName2);
				end
				
				setElementModel(player,93);
				setElementData(player,"Player->Data->AdminDuty",true);
				removeEventHandler("onPlayerQuit",player,quitAdminDuty);
				removeEventHandler("onPlayerWasted",player,quitAdminDuty);
				addEventHandler("onPlayerQuit",player,quitAdminDuty);
				addEventHandler("onPlayerWasted",player,quitAdminDuty);
				triggerClientEvent(player,"Infobox->UI",player,"info","Admin modus entered!");
			else
				if(isElement(ADUTY_MARKER[player]))then
					destroyElement(ADUTY_MARKER[player]);
					ADUTY_MARKER[player]=nil;
				end
				local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(ADUTY_LastSkin[player]);
				if(isCustom)then--check custom skin
					local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
					removeElementData(player,dataName);
					setElementModel(player,mod.base_id);
					setElementData(player,dataName,mod.id);
				else
					setElementModel(player,ADUTY_LastSkin[player]);
				end
				ADUTY_LastSkin[player]=nil;
				setElementData(player,"Player->Data->AdminDuty",false);
				removeEventHandler("onPlayerQuit",player,quitAdminDuty);
				removeEventHandler("onPlayerWasted",player,quitAdminDuty);
				triggerClientEvent(player,"Infobox->UI",player,"info","Admin modus leaved!");
			end
		end
	end
end)
function quitAdminDuty()
	if(ADUTY_LastSkin[source])then
		ADUTY_LastSkin[source]=nil;
	end
	if(isElement(ADUTY_MARKER[source]))then
		destroyElement(ADUTY_MARKER[source]);
		ADUTY_MARKER[source]=nil;
	end
end

addCommandHandler("ahide",function(player,cmd)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getElementData(player,"AdminLevel"))>=3)then
			if(not(AHIDE_TOGGLE[player]))then
				AHIDE_TOGGLE[player]=true;
				destroyPlayerBlip(player);
				triggerClientEvent(player,"Infobox->UI",player,"info","Admin hide modus entered!");
			else
				AHIDE_TOGGLE[player]=nil;
				createPlayerBlip(player,tostring(getElementData(player,"Player->Data->Team")));
				triggerClientEvent(player,"Infobox->UI",player,"info","Admin hide modus leaved!");
			end
		end
	end
end)


--teleport to coords
addCommandHandler("xyz",function(player,cmd,x,y,z)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getElementData(player,"AdminLevel"))>=5)then
			if(isPedInVehicle(player))then
				local veh=getPedOccupiedVehicle(player);
				if(veh)then
					setElementPosition(veh,x,y,z);
				end
			else
				setElementPosition(player,x,y,z);
			end
		end
	end
end)


--give premium
addCommandHandler("givepremium",function(player,cmd,tplayer,level)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tplayer)then
			if(tonumber(getElementData(player,"AdminLevel"))>=6)then
				if(level and #level>0)then
					local target=getPlayerFromName(tplayer);
					if(isElement(target)and isLoggedin(target))then
						local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Premium","Username",getPlayerName(target)),-1);
						if(#result==0)then
							setElementData(target,"Player->Data->Premium",1);
							dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Time) VALUES ('"..getPlayerName(target).."','"..getSecTime(level).."')","Player_Premium");
							checkPremium(target);
						else
							triggerClientEvent(player,"Infobox->UI",player,"error","This player already has Premium!");
						end
					end
				end
			end
		end
	end
end)

--give admin level
addCommandHandler("giveadmin",function(player,cmd,tplayer,level)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tplayer)then
			if(tonumber(getElementData(player,"AdminLevel"))>=7)then
				if(level and #level>0)then
					local target=getPlayerFromName(tplayer);
					if(isElement(target)and isLoggedin(target))then
						setElementData(target,"AdminLevel",tonumber(level));
					end
				end
			end
		end
	end
end)





--revive player
addCommandHandler("rev",function(player,cmd,tplayer)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getElementData(player,"AdminLevel"))>=3)then
			if(tplayer)then
				local target=getPlayerFromName(tplayer);
				if(isElement(target)and isLoggedin(target))then
					if(isPedDead(target)and getElementData(target,"Hospitaltime")>=1)then
						local x,y,z=getElementPosition(target);
						TABLE_PLAYER_REVIVETIMER[player]=setTimer(function(player,target)
							if(isElement(target)and isLoggedin(target))then
								triggerClientEvent(target,"Hospital->UI",target,"Destroy");--destroy UI from target
								setCameraTarget(target);
								
								local PlayerTeam=tostring(getElementData(target,"Player->Data->Team"))or "Civilian";
								
								if(PlayerTeam~="Civilian")then
									local rdmSkin=math.random(1,#TEAMS[PlayerTeam].Peds[1]);--get random team skin(gender binded)
									skin=TEAMS[PlayerTeam].Peds[1][rdmSkin];
								else
									skin=getElementData(target,"SkinID");
								end
								
								local dataNameOld=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType("player");
								local id=tonumber(getElementData(target,dataNameOld));
								if(id)then--remove old custom ped if player has
									removeElementData(target,dataNameOld);
								end
								local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(skin);
								if(isCustom)then--check custom skin
									local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
									spawnPlayer(target,x,y,z,0,mod.base_id,getElementInterior(target),getElementDimension(target));
									removeElementData(target,dataName);
									setElementData(target,dataName,mod.id);
								else
									spawnPlayer(target,x,y,z,0,skin,getElementInterior(target),getElementDimension(target));
								end
								
								--give saved weapons
								if(TABLE_PLAYER_WEAPON_SAVE_TEMP[target])then
									for weapon,ammo in pairs(TABLE_PLAYER_WEAPON_SAVE_TEMP[target])do
										giveWeapon(target,tonumber(weapon),tonumber(ammo));
									end
									TABLE_PLAYER_WEAPON_SAVE_TEMP[target]=nil;
								end
								
								setElementHealth(target,100);
								setElementData(target,"Hunger",100);
								setElementData(target,"Hospitaltime",0);
								
								setPedAnimation(target);
								toggleAllControls(target,true);
								setElementFrozen(target,false);
								setPedHeadless(target,false);
								
								if(isElement(TABLE_PLAYER_DEATH_PICKUP[getPlayerName(target)]))then
									destroyElement(TABLE_PLAYER_DEATH_PICKUP[getPlayerName(target)]);
									TABLE_PLAYER_DEATH_PICKUP[getPlayerName(target)]=nil;
								end
								if(isElement(TABLE_PLAYER_DEATH_BLIP[getPlayerName(target)]))then
									destroyElement(TABLE_PLAYER_DEATH_BLIP[getPlayerName(target)]);
									TABLE_PLAYER_DEATH_BLIP[getPlayerName(target)]=nil;
								end
							end
						end,1500,1,player,target)
					end
				end
			end
		end
	end
end)


addEventHandler("Admin->Player->Kick",root,function(tPlayer,reason)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Kick==true)then
			local target=getPlayerFromName(tPlayer);
			local reason=tostring(stringTextWithAllParameters(reason));
			if(target and isElement(target)and isLoggedin(target)and reason and type(reason)=="string")then
				if(tonumber(getElementData(client,"AdminLevel"))<tonumber(getElementData(target,"AdminLevel")))then
					return triggerClientEvent(client,"Infobox->UI",client,"error","You cant kick higher admins!");
				end
				
				if(#reason>=3)then
					kickPlayer(target,client,tostring(reason).." (kicked!)");
				else
					triggerClientEvent(client,"Infobox->UI",client,"error","Enter a reason with more than 3 characters!");
				end
			end
		end
	end
end)


addEventHandler("Admin->Player->Ban",root,function(typ,tPlayer,reason,timee)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(typ and typ=="temp")then
			if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.BanTemp==true)then
				local target=getPlayerFromName(tPlayer);
				local reason=tostring(stringTextWithAllParameters(reason));
				local timeee=tonumber(timee);
				if(target and isElement(target)and isLoggedin(target)and reason and type(reason)=="string" and timeee and type(timeee)=="number")then
					if(tonumber(getElementData(client,"AdminLevel"))<tonumber(getElementData(target,"AdminLevel")))then
						return triggerClientEvent(client,"Infobox->UI",client,"error","You cant ban a higher admins!");
					end
					
					if(#reason>=3 and timeee and tonumber(timeee)>0)then
						banPlayerTime(getPlayerName(target),tonumber(timeee),getPlayerName(client),reason);
						triggerClientEvent(client,"Infobox->UI",client,"success","'"..getPlayerName(target).."' banned successfully\nfor "..timeee.."h!");
					else
						triggerClientEvent(client,"Infobox->UI",client,"error","Enter a reason with more than 3 characters!\nEnter a time higher than 0");
					end
				else
					local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Accounts","Username",tPlayer),-1);
					if(#result==1)then--check database table existing
						if(#reason>=3)then
							local sec=getSecTime(timeee);
							dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","Player_Bans","AdminName","TargetName","TargetSerial","Reason","Time",getPlayerName(client),tPlayer,result[1]["Serial"],tostring(reason),tonumber(sec));
							triggerClientEvent(client,"Infobox->UI",client,"success","'"..tPlayer.."' banned successfully\nfor "..timeee.."h!");
						else
							triggerClientEvent(client,"Infobox->UI",client,"error","Enter a reason with more than 3 characters!");
						end
					else
						triggerClientEvent(client,"Infobox->UI",client,"error","This player doesnt exist! (offline ban)");
					end
				end
			end
		elseif(typ and typ=="perm")then
			if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.BanPerm==true)then
				local target=getPlayerFromName(tPlayer);
				local reason=tostring(stringTextWithAllParameters(reason));
				if(target and isElement(target)and isLoggedin(target)and reason and type(reason)=="string")then
					if(tonumber(getElementData(client,"AdminLevel"))<tonumber(getElementData(target,"AdminLevel")))then
						return triggerClientEvent(client,"Infobox->UI",client,"error","You cant ban a higher admins!");
					end
					
					local targetSerial=getPlayerSerial(target);
					if(#reason>=3)then
						local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Bans","TargetSerial",targetSerial),-1);
						if(#result==0)then
							dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","Player_Bans","AdminName","TargetName","TargetSerial","Reason","Time",getPlayerName(client),getPlayerName(target),targetSerial,reason,"0");
							triggerClientEvent(client,"Infobox->UI",client,"success","'"..getPlayerName(target).."' banned successfully!");
							kickPlayer(target,client,tostring(reason).." (banned!)");
						end
					else
						triggerClientEvent(client,"Infobox->UI",client,"error","Enter a reason with more than 3 characters!");
					end
				else
					local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Accounts","Username",tPlayer),-1);
					if(#result==1)then--check database table existing
						if(#reason>=3)then
							dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","Player_Bans","AdminName","TargetName","TargetSerial","Reason","Time",getPlayerName(client),tPlayer,result[1]["Serial"],tostring(reason),"0");
							triggerClientEvent(client,"Infobox->UI",client,"success","'"..tPlayer.."' banned successfully!");
						else
							triggerClientEvent(client,"Infobox->UI",client,"error","Enter a reason with more than 3 characters!");
						end
					else
						triggerClientEvent(client,"Infobox->UI",client,"error","This player doesnt exist! (offline ban)");
					end
				end
			end
		end
	end
end)

addEventHandler("Admin->Player->UnBan",root,function(tSerial)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Unban==true)then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Bans","TargetSerial",tSerial),-1);
			if(#result==1)then--check database table existing
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","Player_Bans","TargetSerial",tSerial);
				triggerClientEvent(client,"Infobox->UI",client,"success","Player successfully unbanned!");
			else
				triggerClientEvent(client,"Infobox->UI",client,"error","This player isnt banned!");
			end
		end
	end
end)

addEventHandler("Admin->Player->Goto",root,function(tPlayer)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Goto==true)then
			local target=getPlayerFromName(tPlayer);
			if(target and isElement(target)and isLoggedin(target))then
				local x,y,z=getElementPosition(target);
				local int=getElementInterior(target);
				local dim=getElementDimension(target);
				if(isPedInVehicle(client))then
					local veh=getPedOccupiedVehicle(client);
					if(veh and isElement(veh))then
						setElementPosition(veh,x,y,z);
						setElementInterior(veh,int);
						setElementDimension(veh,dim);
					end
				else
					if(x and y and z and int and dim)then
						setElementPosition(client,x,y+1.5,z+1);
						setElementInterior(client,int);
						setElementDimension(client,dim);
					end
				end
				triggerClientEvent(client,"Infobox->UI",client,"info","Teleported to player "..getPlayerName(target).."!");
			end
		end
	end
end)

addEventHandler("Admin->Player->Gethere",root,function(tPlayer)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Gethere==true)then
			local target=getPlayerFromName(tPlayer);
			if(target and isElement(target)and isLoggedin(target))then
				local x,y,z=getElementPosition(client);
				local int=getElementInterior(client);
				local dim=getElementDimension(client);
				if(isPedInVehicle(target))then
					local veh=getPedOccupiedVehicle(target);
					if(veh and isElement(veh))then
						setElementPosition(veh,x,y,z);
						setElementInterior(veh,int);
						setElementDimension(veh,dim);
					end
				else
					if(x and y and z and int and dim)then
						setElementPosition(target,x,y+1.5,z+1);
						setElementInterior(target,int);
						setElementDimension(target,dim);
					end
				end
				triggerClientEvent(client,"Infobox->UI",client,"info","Teleported player "..getPlayerName(target).." to you!");
			end
		end
	end
end)

addEventHandler("Admin->Player->Freeze",root,function(tPlayer)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Freeze==true)then
			local target=getPlayerFromName(tPlayer);
			if(target and isElement(target)and isLoggedin(target))then
				local x,y,z=getElementPosition(client);
				local int=getElementInterior(client);
				local dim=getElementDimension(client);
				if(isPedInVehicle(target))then
					local veh=getPedOccupiedVehicle(target);
					if(veh and isElement(veh))then
						if(not(isElementFrozen(veh)))then
							setElementFrozen(target,true);
							setElementFrozen(veh,true);
							triggerClientEvent(client,"Infobox->UI",client,"info","Freezed player "..getPlayerName(target).."!");
						else
							setElementFrozen(target,false);
							setElementFrozen(veh,false);
							triggerClientEvent(client,"Infobox->UI",client,"info","Unfreezed player "..getPlayerName(target).."!");
						end
					end
				else
					if(x and y and z and int and dim)then
						if(not(isElementFrozen(target)))then
							setElementFrozen(target,true);
							triggerClientEvent(client,"Infobox->UI",client,"info","Freezed player "..getPlayerName(target).."!");
						else
							setElementFrozen(target,false);
							toggleAllControls(target,true);
							triggerClientEvent(client,"Infobox->UI",client,"info","Unfreezed player "..getPlayerName(target).."!");
						end
					end
				end
			end
		end
	end
end)

addEventHandler("Admin->Player->RepairVeh",root,function(tPlayer)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.RepairVeh==true)then
			local target=getPlayerFromName(tPlayer);
			if(target and isElement(target)and isLoggedin(target))then
				local x,y,z=getElementPosition(client);
				local int=getElementInterior(client);
				local dim=getElementDimension(client);
				if(isPedInVehicle(target))then
					local veh=getPedOccupiedVehicle(target);
					if(veh and isElement(veh))then
						fixVehicle(veh);
						triggerClientEvent(client,"Infobox->UI",client,"info","Repaired vehicle from "..getPlayerName(target).."!");
					end
				end
			end
		end
	end
end)

addEventHandler("Admin->ClearChat",root,function(tPlayer)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.ClearChat==true)then
			for i=1,500 do
				outputChatBox(" ",root);
			end
			clearChatBox(root);
			triggerClientEvent(client,"Infobox->UI",client,"info","Chat cleared global!");
		end
	end
end)


addEventHandler("Admin->Give",root,function(typ,amount,tPlayer)
	if(client and isElement(client)and isLoggedin(client))then
		if(not(isLoggedin(client)))then
			return;
		end
		if(typ=="Coins")then
			if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.GiveItemCoins==true)then
				assert(type(typ)=="string","Bad argument @ Admin:Admin->Give #1");
				assert(type(amount)=="number","Bad argument @ Admin:Admin->Give #2");
				if(typ and type(typ)=="string" and amount and type(amount)=="number")then
					local target=getPlayerFromName(tPlayer);
					if(target and isElement(target)and isLoggedin(target))then
						setElementData(target,"Coins",tonumber(getElementData(target,"Coins"))+tonumber(amount));
						triggerClientEvent(client,"Infobox->UI",client,"info","You gave "..getPlayerName(target).." x"..amount.." Coins");
						triggerClientEvent(target,"Infobox->UI",target,"info","You got x"..amount.." Coins from "..getPlayerName(client).."");
					end
				end
			end
		else
			if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.GiveItem==true)then
				assert(type(typ)=="string","Bad argument @ Admin:Admin->Give #1");
				assert(type(amount)=="number","Bad argument @ Admin:Admin->Give #2");
				if(typ and type(typ)=="string" and amount and type(amount)=="number")then
					local target=getPlayerFromName(tPlayer);
					if(target and isElement(target)and isLoggedin(target))then
						if(typ=="Money")then
							setElementData(target,"Money",tonumber(getElementData(target,"Money"))+tonumber(amount));
							triggerClientEvent(client,"Infobox->UI",client,"info","You gave "..getPlayerName(target).." "..CURRENCY..amount.."");
							triggerClientEvent(target,"Infobox->UI",target,"info","You got "..CURRENCY..amount.." from "..getPlayerName(client).."");
						end
					end
				end
			end
		end
	end
end)

addEventHandler("Admin->SetServerPassword",root,function(password)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.SetPW==true)then
			assert(type(password)=="string","Bad argument @ Admin:Admin->SetServerPassword #1");
			if(password and type(password)=="string")then
				if(#password>0)then
					setServerPassword(tostring(password));
					triggerClientEvent(client,"Infobox->UI",client,"info","Password has been set to '"..password.."'!");
				else
					setServerPassword("");
					triggerClientEvent(client,"Infobox->UI",client,"info","Password has been resetted!");
				end
			end
		end
	end
end)
addEventHandler("Admin->Player->Kick->All",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Kickall==true)then
			for _,v in ipairs(getElementsByType("player"))do
				kickPlayer(v,"Server","");
			end
		end
	end
end)

addEventHandler("Admin->GenerateCodes",root,function(typ,amount)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.Generatecodes==true)then
			assert(type(typ)=="string","Bad argument @ Admin:Admin->GenerateCodes #1");
			assert(type(amount)=="number","Bad argument @ Admin:Admin->GenerateCodes #2");
			if(typ and type(typ)=="string" and amount and type(amount)=="number")then
				local rdm1=math.random(1000,999999);
				local rdm2=math.random(1000,999999);
				local rdm3=math.random(1000,999999);
				local code=rdm1.."-"..rdm2.."-"..rdm3;
				
				dbExec(DB.HANDLER,"INSERT INTO ?? (Code,Typ,Amount,Used) VALUES (?,?,?,?)","Redeemcodes",code,typ,amount,0);
				outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."CODE#ffffff] "..code.."",client,0,0,0,true);
			end
		end
	end
end)

addEventHandler("Admin->ClearAdlist",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		if(ADMIN_LEVELS[tonumber(getElementData(client,"AdminLevel"))].Permissions.ADlistClear==true)then
			dbExec(DB.HANDLER,"TRUNCATE TABLE ??","ADlist");
			triggerClientEvent(client,"Infobox->UI",client,"info","AD list cleared!");
		end
	end
end)



function banPlayerTime(pname,time,admin,reason)
	local player=getPlayerFromName(pname);
	
	if(pname)then
		local sec=getTBanSecTime(time);
		local serial=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Serial","Player_Accounts","Username",pname),-1)[1]["Serial"];
		
		if(serial)then
			dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","Player_Bans","AdminName","TargetName","TargetSerial","Reason","Time",admin,pname,serial,reason,sec);
			
			if(isElement(player))then
				kickPlayer(player,"You got banned for "..time.." hours by "..admin.."! (Reason: "..reason..")");
			end
			return true;
		end
	end
	return false
end

addEventHandler("Trigger->AdminUI->Bans",root,function(typ,name)
	if(client and isElement(client)and isLoggedin(client))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ??","Player_Bans"),-1);
		local Table={};
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Time"]~=0 and(v["Time"]-getTBanSecTime(0))<=0)then
					Time="Expired";
				else
					local var=math.floor(((v["Time"]-getTBanSecTime(0))/60)*100)/100;
					if(var>=0)then
						Time=var.."h left";
					else
						Time="Perm";
					end
				end
				if(typ=="All")then
					table.insert(Table,{v["AdminName"],v["TargetName"],v["TargetSerial"],v["Reason"],Time});
				elseif(typ=="Specific")then
					if(string.find(string.upper(v["TargetName"]),string.upper(name),1,true))then
						table.insert(Table,{v["AdminName"],v["TargetName"],v["TargetSerial"],v["Reason"],Time});
					end
				end
			end
			triggerClientEvent(client,"Show->AdminUI->Bans",client,Table);
		else
			outputDebugString("Failed to load 'Player_Bans' database table!",1);
		end
	end
end)

addEventHandler("Trigger->AdminUI->ADs",root,function()
	if(client and isElement(client)and isLoggedin(client))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ??","ADlist"),-1);
		local Table={};
		if(#result>=1)then
			for _,v in pairs(result)do
				table.insert(Table,{v["Username"],v["Message"]});
			end
			triggerClientEvent(client,"Show->AdminUI->ADs",client,Table);
		else
			outputDebugString("Failed to load 'ADlist' database table!",1);
		end
	end
end)