addRemoteEvents{"Trigger->Userpanel->Achievements","Get->Achievement->Infos"};--addEvent


addEventHandler("Trigger->Userpanel->Achievements",root,function()
	if(client and isElement(client)and getElementType(client)=="player")then
		if(isLoggedin(client))then
			local Table={};
			for i,v in pairs(ACHIEVEMENTS["Panel"])do
				local sql=getMySQLData("Player_Achievements","Username",getPlayerName(client),i);
				table.insert(Table,{v[1],sql,v[2]});
			end
			triggerClientEvent(client,"Show->Userpanel->Achievements",client,Table);
		end
	end
end)

addEventHandler("Get->Achievement->Infos",root,function(clicked)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(isLoggedin(client))then
			local pname=getPlayerName(client);
			local json=fromJSON(getMySQLData("Player_Achievements","Username",pname,"Items"))or '{}';
			if(ACHIEVEMENTS["Description"][clicked])then
				triggerClientEvent(client,"Show->Achievement->Infos",client,json[clicked],ACHIEVEMENTS["Description"][clicked][1],CURRENCY..ACHIEVEMENTS["Description"][clicked].Reward[1].." | x"..ACHIEVEMENTS["Description"][clicked].Reward[2].." EXP");
			else
				triggerClientEvent(client,"Show->Achievement->Infos",client,json[clicked],"N/A","0");
			end
		end
	end
end)


function addPlayerAchievment(player,achievment)
	if(isElement(player)and isLoggedin(player))then
		local pname=getPlayerName(player);
		
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM Player_Achievements WHERE ??=?","Username",pname),-1);
		if(#result==1)then--check database table existing
			local json=fromJSON(getMySQLData("Player_Achievements","Username",pname,"Items"));
			if(not(json[achievment]))then
				setElementData(player,"Money",tonumber(getElementData(player,"Money"))+ACHIEVEMENTS["Description"][achievment].Reward[1]);
				setElementData(player,"OverallEXP",tonumber(getElementData(player,"OverallEXP"))+ACHIEVEMENTS["Description"][achievment].Reward[2]);
				updateLevel(player,"Overall",tonumber(ACHIEVEMENTS["Description"][achievment].Reward[2]));
				
				triggerClientEvent(player,"Trigger->Achievement",player,ACHIEVEMENTS["Description"][achievment].DisplayText,ACHIEVEMENTS["Description"][achievment].Reward[1],ACHIEVEMENTS["Description"][achievment].Reward[2]);
				
				json[achievment]=true;
				dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Achievements","Items",toJSON(json),"Username",pname);
				return true;
			else
				return false;
			end
		else
			return false;
		end
	end
end
