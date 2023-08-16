addRemoteEvents{"Phone->Settings","Account->ChangePW","Phone->Contact"};--addEvent


local Spam={};

addEventHandler("Phone->Settings",root,function(typ,amount,name)
	if(isElement(client)and isLoggedin(client))then
		if(not(isTimer(Spam[client])))then
			if(typ=="Background")then
				Spam[client]=setTimer(function(client)end,1000,1,client);
				setElementData(client,"Phone"..typ,amount);
				triggerClientEvent(client,"Infobox->UI",client,"info","Background changed to "..name);
			elseif(typ=="Model")then
				Spam[client]=setTimer(function(client)end,1000,1,client);
				setElementData(client,"Phone"..typ,amount);
				triggerClientEvent(client,"Infobox->UI",client,"info","Model changed to "..name);
			end
		end
	end
end)

addEventHandler("Account->ChangePW",root,function(passwordOld,passwordNew)
	if(isElement(client)and isLoggedin(client))then
		local PlayerSerial=getPlayerSerial(client);
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Accounts","Serial",PlayerSerial),-1);
		if(#result==1)then--check account is existing
			local HashhOld=md5(hash("sha512",passwordOld));--password hash
			local HashhNew=md5(hash("sha512",passwordNew));--password hash
			if(result[1]["Password"]==HashhOld)then
				dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Accounts","Password",HashhNew,"Serial",PlayerSerial);
				
				triggerClientEvent(client,"Infobox->UI",client,"success","Password successfully changed!");
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Login->MSG->WrongPassword"));
			end
		end
	end
end)


addEventHandler("Phone->Contact",root,function(typ,target,msg)
	if(isElement(client)and isLoggedin(client))then
		if(typ)then
			if(typ=="Add")then
				local targetPlayer=getPlayerFromName(target);
				if(target and isElement(targetPlayer)and isLoggedin(targetPlayer))then
					local json=fromJSON(getElementData(client,"Phone_Contacts"))or '{}';
					json[getPlayerName(targetPlayer)]=true;
					setElementData(client,"Phone_Contacts",toJSON(json));
					dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Player_Accounts","Phone_Contacts",toJSON(json),"Username",getPlayerName(client));
				end
			elseif(typ=="Rem")then
				local json=fromJSON(getElementData(client,"Phone_Contacts"));
				if(json[target]and json[target]==true)then
					json[target]=nil;
					setElementData(client,"Phone_Contacts",toJSON(json));
					dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","Player_Accounts","Phone_Contacts",toJSON(json),"Username",getPlayerName(client));
				end
			elseif(typ=="Message")then
				local targetPlayer=getPlayerFromName(target);
				if(target and isElement(targetPlayer)and isLoggedin(targetPlayer))then
					outputChatBox("#ffffffMSG: "..getPlayerName(client).." -> #ffffff"..stringTextWithAllParameters(msg),targetPlayer,0,0,0,true);
					outputChatBox("#ffffffMessage send.",client,0,0,0,true);
				end
			end
		end
	end
end)