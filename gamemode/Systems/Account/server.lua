addRemoteEvents{"Trigger->RegisterLogin->UI","Account->Register","Account->Login"};--addEvent


local DatabaseTable={
	["Player_Accounts"]={
		"DateRegister","AdminLevel","Gender","SpawnPos","SkinID","Phone_Contacts",
	},
	["Player_Inventory"]={
		"Coins","Money","Bankmoney",
	},
	["Player_Levels"]={
		"OverallLVL","OverallEXP","FarmerLVL","FarmerEXP","GarbageLVL","GarbageEXP",
	},
	["Player_Settings"]={
		"HUD","Radar","Speedo","BlipsATM","Hitsound","VehBlur","Bloodscreen","LoadVehTextures","LoadSkyboxTextures","PhoneBackground","PhoneModel",
	},
	["Player_Stats"]={
		"PlayTime","Hunger","Wanteds","Kills","Deaths",
	},
	["Player_Timer"]={
		"Jailtime","Hospitaltime","TeamChangeDelay","EventDelay",
	},
};


addEventHandler("Trigger->RegisterLogin->UI",root,function(typ)--check player has already an account
	if(typ=="Register")then
		triggerClientEvent(client,"RegisterLogin->UI",client,"Switch");--destroy UI
	end
	if(typ=="Login")then
		triggerClientEvent(client,"RegisterLogin->UI",client,"Switch");--destroy UI
	end
	triggerClientEvent(client,"RegisterLogin->UI",client,typ);
end)


addEventHandler("Account->Register",root,function(username,password,gender,language)--create account and insert datas into database
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			local PlayerSerial=getPlayerSerial(client);
			
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Accounts","Serial",PlayerSerial),-1);
			if(#result==0)then
				local resultNameCheck=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Accounts","Username",string.lower(username)),-1);
				if(#resultNameCheck==0)then
					for _,v in ipairs(NotAllowedNames)do--check not allowed name
						if(string.lower(username):find(v,1,true))then
							triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Register->MSG->NotAllowedName"));
							return false;
						end
					end
					
					for _,v in ipairs(NotAllowedCharacters)do
						if(string.lower(username):find(v,1,true))then
							triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Register->MSG->NotAllowedChars"));
							return false;
						end
					end
					
					local Hashh=md5(hash("sha512",password));--password hash
					setPlayerName(client,username);--set name from client ui
					
					DATE=getCurrentDate();
					
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Serial,Password,DateRegister,DateLastLogin,Gender,SpawnPos,Language) VALUES (?,?,?,?,?,?,?,?)","Player_Accounts",username,PlayerSerial,Hashh,DATE,DATE,gender,toJSON(DEFAULTSPAWNPOS),language);
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username) VALUES (?)","Player_Achievements",username);
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Items) VALUES (?,?)","Player_Inventory",username,'[ { "Water": 4, "Bread": 4 } ]');
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username) VALUES (?)","Player_Levels",username);
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username) VALUES (?)","Player_Settings",username);
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Health,Armor) VALUES (?,?,?)","Player_Stats",username,"100","0");
					dbExec(DB.HANDLER,"INSERT INTO ?? (Username) VALUES (?)","Player_Timer",username);
					if(BETAMODE)then
						dbExec(DB.HANDLER,"INSERT INTO ?? (Username,VehID,Health) VALUES (?,?,?)","Vehicles",username,"495","1000");
					else
						dbExec(DB.HANDLER,"INSERT INTO ?? (Username,VehID,Health) VALUES (?,?,?)","Vehicles",username,"604","1000");
					end
					
					
					setPlayerName(client,username);--set name from client ui
					triggerClientEvent(client,"RegisterLogin->UI",client,"Destroy");--destroy UI
					triggerClientEvent(client,"TeamSelect->UI",client,"Open");--open team select UI
					triggerClientEvent(client,"Infobox->UI",client,"success",loc(client,"Register->MSG->RegisterSuccess"));
					
					setElementDatasAfterRegisterLogin(client,team);--spawn player after register and set datas
				else
					triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Register->MSG->NameAlreadyTaken"));
				end
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Register->MSG->AlreadyAccount"));
			end
		end
	end
end)
addEventHandler("Account->Login",root,function(username,password)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			local Hashh=md5(hash("sha512",password));--password hash
			local pwResult=dbPoll(dbQuery(DB.HANDLER,"SELECT Password FROM Player_Accounts WHERE ??=?","Username",username),-1);
			local loggedinResult=dbPoll(dbQuery(DB.HANDLER,"SELECT LoggedinDB FROM Player_Accounts WHERE ??=?","Username",username),-1);
			if(pwResult and pwResult[1] and loggedinResult and loggedinResult[1])then
				if(loggedinResult[1]["LoggedinDB"]==0)then
					if(pwResult[1]["Password"]==Hashh)then
						setPlayerName(client,username);--set name from client ui
						triggerClientEvent(client,"RegisterLogin->UI",client,"Destroy");--destroy UI
						triggerClientEvent(client,"Infobox->UI",client,"success",loc(client,"Login->MSG->LoginSuccess"));
						
						setElementDatasAfterRegisterLogin(client,team);--spawn player after register and set datas
					else
						triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Login->MSG->WrongPassword"));
					end
				else
					triggerClientEvent(client,"Infobox->UI",client,"error","This account is already ingame!");
				end
			end
		end
	end
end)




function setElementDatasAfterRegisterLogin(player,team)
	if(not(team))then
		team="Civilian";
	end
	if(player and isElement(player))then
		local pname=getPlayerName(player);--get player name
		
		--set datas from database to element datas
		for i=1,#DatabaseTable["Player_Accounts"]do
			setElementData(player,DatabaseTable["Player_Accounts"][i],getMySQLData("Player_Accounts","Username",pname,DatabaseTable["Player_Accounts"][i]));
		end
		for i=1,#DatabaseTable["Player_Inventory"]do
			setElementData(player,DatabaseTable["Player_Inventory"][i],getMySQLData("Player_Inventory","Username",pname,DatabaseTable["Player_Inventory"][i]));
		end
		for i=1,#DatabaseTable["Player_Levels"]do
			setElementData(player,DatabaseTable["Player_Levels"][i],getMySQLData("Player_Levels","Username",pname,DatabaseTable["Player_Levels"][i]));
		end
		for i=1,#DatabaseTable["Player_Settings"]do
			setElementData(player,DatabaseTable["Player_Settings"][i],getMySQLData("Player_Settings","Username",pname,DatabaseTable["Player_Settings"][i]));
		end
		for i=1,#DatabaseTable["Player_Stats"]do
			setElementData(player,DatabaseTable["Player_Stats"][i],getMySQLData("Player_Stats","Username",pname,DatabaseTable["Player_Stats"][i]));
		end
		for i=1,#DatabaseTable["Player_Timer"]do
			setElementData(player,DatabaseTable["Player_Timer"][i],getMySQLData("Player_Timer","Username",pname,DatabaseTable["Player_Timer"][i]));
		end
		createInventory(player,fromJSON(  getMySQLData("Player_Inventory","Username",pname,"Items")  ));--create inventory json table after reg/login
		dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Accounts","LoggedinDB",1,"Username",pname);
		
		--set other datas
		syncWeatherTime(player);
		setClickedState(player,false);
		checkPremium(player);
		setElementData(player,"Player->Data->AdminDuty",false);
		setElementData(player,"Player->Data->Loggedin",1);
		if(getElementData(player,"Player->Data->Job"))then
			removeElementData(player,"Player->Data->Job");--remove job data if exist
		end
		
		--update last login date
		DATE=getCurrentDate();
		dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Accounts","DateLastLogin",DATE,"Username",pname);
		
		if(tonumber(getElementData(player,"Hospitaltime"))>=1)then
			setCameraTarget(player,player);
			killPed(player);
			triggerClientEvent(player,"Hospital->UI",player,"create",tonumber(getElementData(player,"Hospitaltime")));
		else
			setPedHeadless(player,false);
			spawnPlayerAfterRegisterLogin(player,team);
		end
		
		triggerClientEvent(player,"Textures->Load",player);--load textures after login
		--load some settings
		triggerClientEvent(player,"Locate->ATMs",player,tonumber(getElementData(player,"BlipsATM")));
		if(tonumber(getElementData(player,"VehBlur"))==1)then
			setPlayerBlurLevel(player,0);
		else
			setPlayerBlurLevel(player,36);
		end
		if(tonumber(getElementData(player,"LoadSkyboxTextures"))==2)then
			triggerClientEvent(player,"Textures->Skybox->Load",player);
		end
		
		
		--start player timers
		TABLE_PLAYER_PAYDAY_TIMER[player]=setTimer(function(player)--playtime
			if(player and isElement(player)and isLoggedin(player))then
				setElementData(player,"PlayTime",getElementData(player,"PlayTime")+1);
				
				--timers
				if(tonumber(getElementData(player,"TeamChangeDelay"))>0)then
					setElementData(player,"TeamChangeDelay",tonumber(getElementData(player,"TeamChangeDelay"))-1);
				end
				if(tonumber(getElementData(player,"EventDelay"))>0)then
					setElementData(player,"EventDelay",tonumber(getElementData(player,"EventDelay"))-1);
				end
				
				
				checkPremium(player);
				
				
				if(math.floor(getElementData(player,"PlayTime")/60)==(getElementData(player,"PlayTime")/60))then
					for _,v in ipairs(PLAYTIME_ACTIVITY)do
						if(not(TABLE_PLAYER_PAYDAY_ACTIVITY[player]))then
							if(tonumber(getElementData(player,"Playtime"))==v[1])then
								TABLE_PLAYER_PAYDAY_ACTIVITY[player]=true;
								
								outputChatBox("#ffffff#["..SRV_COLORS.HEX.."ACTIVITY#ffffff] "..loc(player,"GotActivityBonus"):format(CURRENCY..v[2],v[3],v[1]/60),player,255,255,255,true);
								setElementData(player,"Money",tonumber(getElementData(player,"Money"))+v[2]);
								setElementData(player,"OverallEXP",tonumber(getElementData(player,"OverallEXP"))+v[3]);
								updateLevel(player,"Overall",tonumber(v[3]));
							else
								if(TABLE_PLAYER_PAYDAY_ACTIVITY[player])then
									TABLE_PLAYER_PAYDAY_ACTIVITY[player]=nil;
								end
							end
						end
					end
					
					--todo payday
					savePlayerDatas(player);
				end
			end
		end,1*60*1000,0,player);
		
		TABLE_PLAYER_WANTED_TIMER[player]=setTimer(function(player)--wanted lose
			if(player and isElement(player)and isLoggedin(player))then
				if(tonumber(getElementData(player,"Wanteds"))>0)then
					setElementData(player,"Wanteds",tonumber(getElementData(player,"Wanteds"))-1);
				end
			end
		end,20*60*1000,0,player);
		
		if(not(DEVMODE))then
			TABLE_PLAYER_HUNGER_TIMER[player]=setTimer(function(player)--hunger
				if(player and isElement(player)and isLoggedin(player))then
					setElementData(player,"Hunger",tonumber(getElementData(player,"Hunger"))-1);
					if(tonumber(getElementData(player,"Hunger"))<10)then
						setElementHealth(player,getElementHealth(player)-5);
					end
				end
			end,3*60*1000,0,player);
		end
		
		
		
		if(DEVMODE)then
			for i=1,2 do
				outputChatBox("DEV MODE!",player,255,0,0);
			end
		end
		
		--some info texts after register/login
		outputChatBox("#ffffffWelcome to #"..SRV_COLORS.HEX..SERVER_NAME_SHORT.."#ffffff. Press F1 if you need help.",player,0,0,0,true);
	end
end


--spawn player
function spawnPlayerAfterRegisterLogin(player,team)
	if(player and isElement(player))then
		local pname=getPlayerName(player);
		setCameraTarget(player,player);
		setElementFrozen(player,false);
		
		local x,y,z,rot,int,dim=unpack(fromJSON(getElementData(player,"SpawnPos")));--get spawn pos
		
		local dataNameOld=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType("player");
		local id=tonumber(getElementData(player,dataNameOld));
		if(id)then--remove old custom ped if player has
			removeElementData(player,dataNameOld);
		end
		
		
		setElementData(player,"Player->Data->Team",tostring(team));
		
		if(tostring(team)~="Civilian")then
			local rdmSkin=math.random(1,#TEAMS[team].Peds[1]);--get random team skin(gender binded)
			skin=TEAMS[team].Peds[1][rdmSkin];
		else
			skin=getMySQLData("Player_Accounts","Username",pname,"SkinID");
		end
		
		local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(skin);
		if(isCustom)then--check custom skin
			local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
			setElementModel(player,mod.base_id);
			
			spawnPlayer(player,x,y,z,rot,mod.base_id,int,dim);
			setElementData(player,dataName,mod.id);
		else
			spawnPlayer(player,x,y,z,rot,skin,int,dim);
		end
		createPlayerBlip(player,team);--create player blip on map
		jailCheck(player);
		
		setElementHealth(player,getMySQLData("Player_Stats","Username",pname,"Health"));--set saved health
		setPedArmor(player,getMySQLData("Player_Stats","Username",pname,"Armor"));--set saved armor
		
		--sync phonecells
		if(PHONECELL_POSITION~=nil or PHONECELL_POSITION)then
			triggerClientEvent(player,"Phonecell->Sound",player,"Create",PHONECELL_POSITION[1],PHONECELL_POSITION[2],PHONECELL_POSITION[3]);
		end
		
		--give saved weapons
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Weapons","Player_SavedWeapons","Username",pname),-1);
		if(result and result[1])then
			dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","Player_SavedWeapons","Username",pname);
			for i=1,46 do
				local wstring=gettok(result[1]["Weapons"],i,string.byte("|"));
				if(wstring and #wstring>=1)then
					local weapon=tonumber(gettok(wstring,1,string.byte(",")));
					local ammo=tonumber(gettok(wstring,2,string.byte(",")));
					if(not(WeaponNotSaveAble[weapon]))then
						giveWeapon(player,weapon,ammo);
					end
				end
			end
		end
		if(TEAMS[tostring(team)].Weapon)then
			giveWeapon(player,TEAMS[tostring(team)].Weapon,1);
		end
		
		--bind funcs to keys
		if(not isKeyBound(player,"F2","down",openVehicleUI))then
			bindKey(player,"F2","down",openVehicleUI);
		end
		if(not isKeyBound(player,"F9","down",openToplistUI))then
			bindKey(player,"F9","down",openToplistUI);
		end
		if(not isKeyBound(player,"I","down",openInventory))then
			bindKey(player,"I","down",openInventory);
		end
		if(not isKeyBound(player,"Y","down","chatbox","Team"))then
			bindKey(player,"Y","down","chatbox","Team");
		end
		triggerClientEvent(player,"Update->Minimap",player);
	end
end


--destroy & save datas after leave server
function savePlayerDatas(player)
	if(isLoggedin(player))then
		local pname=getPlayerName(player);--get player name
		
		local x,y,z=getElementPosition(player);--get player pos to save
		local _,_,rot=getElementRotation(player);--get player rotation to save
		local int=getElementInterior(player);--get player interior to save
		local dim=getElementDimension(player);--get player dimension to save
		
		if(not(getElementData(player,"Player->Data->ID"))and not(getElementData(player,"Player->Data->EventID")))then
			setElementData(player,"SpawnPos",toJSON({x,y,z,rot,int,dim}));--set elementdata with a json string to save the position
		end
		
		for i=1,#DatabaseTable["Player_Accounts"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Accounts",DatabaseTable["Player_Accounts"][i],getElementData(player,DatabaseTable["Player_Accounts"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Player_Levels"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Levels",DatabaseTable["Player_Levels"][i],getElementData(player,DatabaseTable["Player_Levels"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Player_Inventory"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Inventory",DatabaseTable["Player_Inventory"][i],getElementData(player,DatabaseTable["Player_Inventory"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Player_Settings"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Settings",DatabaseTable["Player_Settings"][i],getElementData(player,DatabaseTable["Player_Settings"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Player_Stats"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Stats",DatabaseTable["Player_Stats"][i],getElementData(player,DatabaseTable["Player_Stats"][i]),"Username",pname);
		end
		for i=1,#DatabaseTable["Player_Timer"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Timer",DatabaseTable["Player_Timer"][i],getElementData(player,DatabaseTable["Player_Timer"][i]),"Username",pname);
		end
		dbExec(DB.HANDLER,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Player_Stats","Health",math.floor(getElementHealth(player)),"Armor",math.floor(getPedArmor(player)),"Username",pname);
		dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Inventory","Items",toJSON(ElementInventories["player"][player]),"Username",pname);
		
		--save current player weapons
		local curWeaponsForSave="|";
		for i=1,46 do
			local weapon=getPedWeapon(player,i);
			local ammo=getPedTotalAmmo(player,i);
			if(not(WeaponNotSaveAble[weapon]))then
				if(weapon and ammo)then
					if(weapon>=1 and ammo>=1)then
						if(#curWeaponsForSave<=100)then
							curWeaponsForSave=curWeaponsForSave..weapon..","..ammo.."|";
						end
					end
				end
			end
		end
		if(#curWeaponsForSave>=4)then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_SavedWeapons","Username",pname),-1);
			if(#result==0)then
				dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Weapons) VALUES (?,?)","Player_SavedWeapons",pname,curWeaponsForSave);
			end
		end
	end
end

addEventHandler("onPlayerQuit",root,function()
	local pname=getPlayerName(source);
	
	if(isLoggedin(source))then
		
		savePlayerDatas(source);--save player datas
		--destroy timers(tables)
		if(isTimer(TABLE_PLAYER_PAYDAY_TIMER[source]))then
			killTimer(TABLE_PLAYER_PAYDAY_TIMER[source]);
			TABLE_PLAYER_PAYDAY_TIMER[source]=nil;
		end
		if(isTimer(TABLE_PLAYER_HUNGER_TIMER[source]))then
			killTimer(TABLE_PLAYER_HUNGER_TIMER[source]);
			TABLE_PLAYER_HUNGER_TIMER[source]=nil;
		end
		if(isTimer(TABLE_PLAYER_WANTED_TIMER[source]))then
			killTimer(TABLE_PLAYER_WANTED_TIMER[source]);
			TABLE_PLAYER_WANTED_TIMER[source]=nil;
		end
		
		dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Accounts","LoggedinDB",0,"Username",pname);
	end
end)






addEventHandler("onPlayerConnect",root,function(ni,ip,uni,se,ver)
	if(DEVMODE or BETAMODE)then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Whitelist","Serial",se),-1);
		if(#result==1)then--check database table existing
			if(result[1]["Access"]~="Yes")then
				cancelEvent(true,"You're on our Whitelist but without Access!\nDiscord: "..URL_DISCORD.."");
			end
		else
			cancelEvent(true,"You're not on our Whitelist!\nDiscord: "..URL_DISCORD.."");
		end
	end
	
	local result=nil
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Bans","TargetSerial",se),-1);
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["Time"]~=0 and(result[i]["Time"]-getTBanSecTime(0))<=0)then
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","Player_Bans","TargetSerial",se);
			else
				local admin=tostring(result[i]["AdminName"]);
				local reason=tostring(result[i]["Reason"]);
				local var=math.floor(((result[i]["Time"]-getTBanSecTime(0))/60)*100)/100;
				if(var>=0)then
					cancelEvent(true,"You got banned by "..admin.."! Reason: "..reason..", Time: "..var);
				else
					cancelEvent(true,"You got banned permanently by "..admin.."!\nReason: "..reason.."\nYou can appeal a ban on our Discord.\n"..URL_DISCORD);
				end
				return;
			end
		end
	end
end)