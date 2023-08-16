addRemoteEvents{"Trigger->ToplistUI->Items"};--addEvent


addEventHandler("Trigger->ToplistUI->Items",root,function(typ)
	if(client and isElement(client)and isLoggedin(client))then
		if(typ=="Kills")then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? ORDER BY Kills DESC LIMIT 10","Player_Stats"),-1);
			local Table={};
			if(#result>=1)then
				for _,v in pairs(result)do
					if(tonumber(v["Kills"])>0)then
						table.insert(Table,{v["Username"],tonumber(v["Kills"])});
					end
				end
				triggerClientEvent(client,"Show->ToplistUI->Kills",client,"Kills",Table);
			end
		end
		if(typ=="Playtime")then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? ORDER BY PlayTime DESC LIMIT 10","Player_Stats"),-1);
			local Table2={};
			if(#result>=1)then
				for _,v in pairs(result)do
					if(math.floor(v["PlayTime"])>=60)then
						table.insert(Table2,{v["Username"],math.floor(v["PlayTime"]/60).."h"});
					end
				end
				triggerClientEvent(client,"Show->ToplistUI->Playtime",client,"Playtime",Table2);
			end
		end
	end
end)


function openToplistUI(player)
	if(not(isLoggedin(player)))then
		return;
	end
	
	triggerClientEvent(player,"Toplist->UI",player,"Open");
end