addRemoteEvents{"Play->Sound->3D","Play->Sound->Job"};--addEvent


local TABLE={};


addEventHandler("Play->Sound->3D",root,function(sound,x,y,z,volume,distance)
	if(TABLE[sound]~=nil and isElement(TABLE[sound]))then
		stopSound(TABLE[sound]);
		TABLE[sound]=nil;
	end
	
	if(volume==nil)then
		volume=0.5;
	end
	
	TABLE[sound]=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/"..sound..".mp3",x,y,z,false);
	setSoundVolume(TABLE[sound],volume);
	setSoundMaxDistance(TABLE[sound],distance);
end)



addEventHandler("Play->Sound->Job",root,function(player,typ,x,y,z,loop,sound,volume)
	if(typ and typ=="play")then
		if(fileExists(":"..RESOURCE_NAME.."/Files/Audio/"..sound..".mp3"))then
			if(TABLE[player]~=nil and isElement(TABLE[player]))then
				destroyElement(TABLE[player]);
				TABLE[player]=nil;
			end
			if(loop==nil)then
				loop=false;
			end
			if(volume==nil)then
				volume=0.5;
			end
			
			if(x and y and z)then
				TABLE[player]=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/"..sound..".mp3",x,y,z,loop);
				attachElements(TABLE[player],player);
			else
				TABLE[player]=playSound(":"..RESOURCE_NAME.."/Files/Audio/"..sound..".mp3",loop);
			end
			setSoundVolume(TABLE[player],volume);
			setElementDimension(TABLE[player],getElementDimension(player));
		else
			outputChatBox("Restart your MTA Client, because a File is Missing!",200,0,0);
		end
	elseif(typ=="stop")then
		if(TABLE[player]~=nil and isElement(TABLE[player]))then
			destroyElement(TABLE[player]);
			TABLE[player]=nil;
		end
	end
end)