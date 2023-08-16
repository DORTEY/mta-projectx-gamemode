addRemoteEvents{"Language->Change"};--addEvent


function loc(player,var,name)
	local pLang;
	if(not(name))then
		if(player)then
			pLang=getElementData(player,"Language")or "EN";
		else
			pLang="EN";
		end
	else
		pLang=getMySQLData("Player_Accounts","Username",name,"Language");
	end
	if(Language[pLang])then
		if(Language[pLang][var])then
			return Language[pLang][var];
		else
			return var;
		end
	end
end


addEventHandler("Language->Change",root,function(lang)
	if(lang=="DE" or lang=="EN" or lang=="TR" or lang=="RU")then
		setElementData(client,"Language",lang);
		if(not(isLoggedin(client)))then
			triggerClientEvent(client,"RegisterLogin->UI",client,"Update");
		end
	end
end)