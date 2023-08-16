local TABLE={
	["superman:flying"]=true,
	["AnonAdmin"]=true,
	
	["isChatBoxInputActive"]=true,
	["tooltipText"]=true,
	["ClickedState"]=true,
	["skinID"]=true,
};

local TABLE_VEHICLE={
	["Veh->Data->RadioID"]=true,
}

addEventHandler("onElementDataChange",root,function(nameValue,oldValue,newValue)
	if(client~=nil and getElementType(source)=="player")then 
		if(TABLE[nameValue])then--allow whitelisted datas
			return;
		end
		
		setElementData(source,nameValue,oldValue);
		sendDiscordMessage("Anticheat","```"..getPlayerName(client).." tried to change '"..tostring(nameValue).."' | Old: '"..tostring(oldValue).."' - New: '"..tostring(newValue).."'```");
		sendDiscordMessage("Anticheat","```"..getPlayerName(client).." | Serial: "..getPlayerSerial(client).." - IP: "..getPlayerIP(client).."```");
		
		kickPlayer(client,"Anticheat","Cheating is not allowed! (There is an error? Then report it!)");
	elseif(client~=nil and getElementType(source)=="vehicle")then
		if(TABLE_VEHICLE[nameValue])then--allow whitelisted datas
			return;
		end
		
		setElementData(source,nameValue,oldValue);
		sendDiscordMessage("Anticheat","```Vehicle: "..getPlayerName(client).." tried to change '"..tostring(nameValue).."' | Old: '"..tostring(oldValue).."' - New: '"..tostring(newValue).."'```");
		sendDiscordMessage("Anticheat","```"..getPlayerName(client).." | Serial: "..getPlayerSerial(client).." - IP: "..getPlayerIP(client).."```");
		
		kickPlayer(client,"Anticheat","Cheating is not allowed! (There is an error? Then report it!)");
	end
end)

addCommandHandler("hrun",function(player)
	sendDiscordMessage("Anticheat","```"..getPlayerName(player).." used /hrun. | Serial: "..getPlayerSerial(player).." - IP: "..getPlayerIP(player).."```");
end)
addCommandHandler("crun",function(player)
	sendDiscordMessage("Anticheat","```"..getPlayerName(player).." used /crun. | Serial: "..getPlayerSerial(player).." - IP: "..getPlayerIP(player).."```");
end)
addCommandHandler("srun",function(player)
	sendDiscordMessage("Anticheat","```"..getPlayerName(player).." used /srun. | Serial: "..getPlayerSerial(player).." - IP: "..getPlayerIP(player).."```");
end)




--AC
local ANTICHEAT_CHECK_IDS={
	[5]=true,
	[6]=true,
	[7]=true,
	[11]=true,
	--[12]=true,
	[14]=true,
	[17]=true,
	[33]=true,
	[36]=true,
};
local ANTICHEAT_IDS_REASONS={
	[5]="This server does not allow trainer.",
	[6]="This server does not allow trainer2.",
	[7]="This server does not allow trainer3.",
	[11]="This server does not allow injector/trainer.",
	--[12]="This server does not allow modifying files. Please remove D3D0.dll out of your GTA folder.",
	[14]="This server does not allow virtual machines.",
	[17]="This server does not allow speed/wall hacks.",
	[33]="This server does not allow Net limiter.",
	[36]="This server does not allow Auto Hotkeys.",
};

addEventHandler("onPlayerACInfo",root,function(detectedACList)
	for _,v in ipairs(detectedACList)do
		if(ANTICHEAT_CHECK_IDS[v])then
			sendDiscordMessage("Anticheat","```"..getPlayerName(source).." tried to cheat. Cheat ID: "..v.." | Serial: "..getPlayerSerial(source).." - IP: "..getPlayerIP(source).."```");
			
			kickPlayer(source,"Anticheat",ANTICHEAT_IDS_REASONS[v]);
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
     for _,v in ipairs(getElementsByType("player"))do
         resendPlayerACInfo(v);
     end
end)