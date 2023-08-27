addCommandHandler("jp",function(player,cmd)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(not(getElementData(player,"Player->Data->Premium")))then
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
		if(isPedInVehicle(player))then
			return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"Vehicle->LeaveBefore"));
		end
		
		setPedWearingJetpack(player,not isPedWearingJetpack(player));
	end
end)





addCommandHandler("redeem",function(player,cmd,code)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(code and type(code)=="string")then
			local codee=tostring(stringTextWithAllParameters(code));
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Redeemcodes","Code",string.lower(code)),-1);
			if(#result==1)then--check database table existing
				if(result[1]["Used"]==1)then
					return triggerClientEvent(player,"Infobox->UI",player,"error","This code has already been used!");
				end
				local PlayerName=getPlayerName(player);
				
				if(result[1]["Typ"]=="Premium")then
					local resultCheckPremium=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","Player_Premium","Username",PlayerName),-1);
					if(#resultCheckPremium==0)then
						dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Time) VALUES ('"..PlayerName.."','"..getSecTime(result[1]["Amount"]).."')","Player_Premium");
						checkPremium(player);
						
						dbExec(DB.HANDLER,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Redeemcodes","Used",1,"Username",PlayerName,"Code",string.lower(code));
						triggerClientEvent(player,"Infobox->UI",player,"success","Code successfully used!");
					else
						triggerClientEvent(player,"Infobox->UI",player,"error","You already have an active VIP status!");
					end
				end
			else
				triggerClientEvent(player,"Infobox->UI",player,"error","Invalid code!");
			end
		end
	end
end)

local PlayerGotInfo={};
function checkPremium(player)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Time","Player_Premium","Username",getPlayerName(player)),-1);
	if(#result==1)then
		for i=1,#result do
			if(result[i]["Time"]~=0 and result[i]["Time"]-getSecTime(0)<=0)then
				removeElementData(player,"Player->Data->Premium");
				outputChatBox(loc(player,"PremiumExpired"),player,200,0,0);
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","Player_Premium","Username",getPlayerName(player));
			else
				if(PlayerGotInfo[player]~=true)then
					PlayerGotInfo[player]=true;
					setElementData(player,"Player->Data->Premium",1);
					local var=math.floor(((result[i]["Time"]-getSecTime(0))/60)*100)/100;
					if(var>=0)then
						outputChatBox(loc(player,"PremiumStatus"):format(math.floor(var)),player,0,200,0);
					end
				end
			end
		end
	end
end