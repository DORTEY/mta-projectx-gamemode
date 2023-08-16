local CHAT_RADIUS=15;
local BANNED_WORDS={
	"cit","c i t","join on","come on","discord.gg","https://","ffs.gg","destiny","ccd","ccdplanet"
};


addEventHandler("onPlayerPrivateMessage",root,function()
    cancelEvent();--cancel default private chat
end)


addEventHandler("onPlayerChat",root,function(msg,typ)
	cancelEvent();--cancel default chat
	if(typ==0)then
		if(not(isLoggedin(source)))then
			return;
		end
		if(isPedDead(source))then
			return;
		end
		if(#msg<2)then
			return; --todo at least 2 characters
		end
		
		local pX,pY,pZ=getElementPosition(source);--player pos
		local pInt=getElementInterior(source);--player int
		local pDim=getElementDimension(source);--player dim
		local pName=getPlayerName(source);--player name
		
		
		for _,v in ipairs(BANNED_WORDS)do
			if(msg:lower():find(v,1,true))then
				sendDiscordMessage("Chat->AD","```(Local) "..pName..": "..msg.." ["..v.."]```");
				dbExec(DB.HANDLER,"INSERT INTO ?? (??,??) VALUES (?,?)","ADlist","Username","Message",pName,"(Local) "..msg.." ["..v.."]");
			end
		end
		
		sendDiscordMessage("Chat->Local","```(Local) "..pName..": "..msg.."```");
		
		
		for _,v in ipairs(getElementsByType("player"))do
			if(isElement(v)and isLoggedin(v))then
				local tX,tY,tZ=getElementPosition(v);--target pos
				local tInt=getElementInterior(v);--target int
				local tDim=getElementDimension(v);--target dim
				
				if(pInt==tInt and pDim==tDim)then--check same dim and int
					if(getDistanceBetweenPoints3D(pX,pY,pZ,tX,tY,tZ)<=CHAT_RADIUS)then--get players in same range
						outputChatBox("#ffffff(Local) "..pName..": "..msg,v,0,0,0,true);
						triggerClientEvent(v,"Chat->Bubble",source,msg);
					end
				end
			end
		end
	end
end)



addCommandHandler("Team",function(player,cmd,...)
	if(player and isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(isPedDead(player))then
			return;
		end
		local msg=stringTextWithAllParameters(...);
		local pName=getPlayerName(player);--player name
		
		if(#msg<2)then
			return; --todo at least 2 characters
		end
		
		
		for _,v in ipairs(BANNED_WORDS)do
			if(msg:lower():find(v,1,true))then
				sendDiscordMessage("Chat->AD","```(Team) "..pName..": "..msg.." ["..v.."]```");
				dbExec(DB.HANDLER,"INSERT INTO ?? (??,??) VALUES (?,?)","ADlist","Username","Message",pName,"(Team) "..msg.." ["..v.."]");
			end
		end
		
		sendDiscordMessage("Chat->Team","```(Team) "..pName..": "..msg.."```");
		
		
		for _,v in ipairs(getElementsByType("player"))do
			if(isElement(v)and isLoggedin(v))then
				if(getElementData(v,"Player->Data->Team")==getElementData(player,"Player->Data->Team"))then
					if(tostring(getElementData(player,"Player->Data->Team"))=="Civilian")then
						outputChatBox("#969600(Team) "..pName.."#ffffff: "..msg,v,0,0,0,true);
					else
						outputChatBox(TEAMS[tostring(getElementData(player,"Player->Data->Team"))].HEX.."(Team) "..pName.."#ffffff: "..msg,v,0,0,0,true);
					end
				end
			end
		end
	end
end)


function globalChat(player,cmd,...)
	if(player and isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(isPedDead(player))then
			return;
		end
		local msg=stringTextWithAllParameters(...);
		local pName=getPlayerName(player);--player name
		
		if(#msg<2)then
			return; --todo at least 2 characters
		end
		
		
		for _,v in ipairs(BANNED_WORDS)do
			if(msg:lower():find(v,1,true))then
				sendDiscordMessage("Chat->AD","```(GLOBAL) "..pName..": "..msg.." ["..v.."]```");
				dbExec(DB.HANDLER,"INSERT INTO ?? (??,??) VALUES (?,?)","ADlist","Username","Message",pName,"(GLOBAL) "..msg.." ["..v.."]");
			end
		end
		
		sendDiscordMessage("Chat->Global","```(GLOBAL) "..pName..": "..msg.."```");
		
		outputChatBox("#ffffff(GLOBAL) "..pName.."#ffffff: "..msg,root,0,0,0,true);
	end
end
addCommandHandler("main",globalChat)
addCommandHandler("global",globalChat)

addCommandHandler("o",function(player,cmd,...)
	if(player and isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(isPedDead(player))then
			return;
		end
		local msg=stringTextWithAllParameters(...);
		local pName=getPlayerName(player);--player name
		
		if(ADMIN_LEVELS[tonumber(getElementData(player,"AdminLevel"))].Permissions.ChatWorldwide==true)then
			outputChatBox(ADMIN_LEVELS[tonumber(getElementData(player,"AdminLevel"))].HEX.."(STAFF) "..pName.."#ffffff: "..msg,root,0,0,0,true);
		end
	end
end)

addCommandHandler("event",function(player,cmd,...)
	if(player and isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(isPedDead(player))then
			return;
		end
		local msg=stringTextWithAllParameters(...);
		local pName=getPlayerName(player);--player name
		
		if(EVENTS.STARTET_EVENT)then
			if(ADMIN_LEVELS[tonumber(getElementData(player,"AdminLevel"))].Permissions.ChatEvent==true)then
				outputChatBox(ADMIN_LEVELS[tonumber(getElementData(player,"AdminLevel"))].HEX.."(EVENT) "..pName.."#ffffff: "..msg,root,0,0,0,true);
			end
		end
	end
end)