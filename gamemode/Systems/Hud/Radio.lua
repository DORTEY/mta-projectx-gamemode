local TABLE_STATIONS={
	{name="I Love Radio [GER]",url="http://www.iloveradio.de/iloveradio.m3u"},
	{name="I Love 2 Dance [GER]",url="http://stream01.iloveradio.de/iloveradio2.mp3"},
	{name="Türkiyem FM [TR]",url="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://87.98.217.63:23764/listen.pls?sid=1&t=.m3u"},
	{name="Turkrap FM [TR]",url="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://95.173.188.166:9984/listen.pls?sid=1&t=.m3u"},
	{name="Noise.FM [INT]",url="http://noisefm.ru:8000/play_256.m3u"},
	{name="Dubstep.FM [INT]",url="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8040/listen.pls?sid=1&t=.m3u"},
};
local TABLE_SETTINGS={
	SOUND={
		EFFECTS={"compressor","i3dl2reverb"},
		VEHICLE={
			INSIDE={
				RANGE_MIN=5,
				RANGE_MAX=205,
				VOLUME=0.5,
				TABLE={},
			},
			OUTSIDE={
				RANGE_MIN=2,
				RANGE_MAX=23,
				VOLUME=0.9,
			},
		},
	},
};

local RADIO_TIMER=nil;


addEventHandler("onClientPlayerRadioSwitch",root,function(newID)
	if(not(isPedInVehicle(localPlayer)))then
		return;
	end
	if(getPedOccupiedVehicleSeat(localPlayer)~=0)then
		return;
	end
	if(newID==0)then
		return;
	end
	
	local veh=getPedOccupiedVehicle(localPlayer);
	if(veh and isElement(veh))then
		if(getVehicleType(veh)=="BMX")then
			return;
		end
		
		local radioID=tonumber(getElementData(veh,"Veh->Data->RadioID"))or 0;
		local newID=(newID==1 and 1)or -1;
		
		radioID=radioID+newID;
		
		if(radioID>#TABLE_STATIONS)then
			radioID=0;
		elseif(radioID<0)then
			radioID=#TABLE_STATIONS;
		end
		
		setElementData(veh,"Veh->Data->RadioID",radioID);
	end
end)

addEventHandler("onClientElementDataChange",root,function(key)
	if(getElementType(source)=="vehicle" and key=="Veh->Data->RadioID")then
		startVehicleRadio(source);
		
		if(source==getPedOccupiedVehicle(localPlayer))then
			local radioID=tonumber(getElementData(source,"Veh->Data->RadioID"))or 0;
			
			if(TABLE_STATIONS[radioID])then
				openRadio(tostring(TABLE_STATIONS[radioID].name));
			else
				openRadio("Radio off");
			end
		end
	end
end)



addEventHandler("onClientPlayerVehicleEnter",localPlayer,function(veh,seat)
	if(veh and isElement(veh))then
		if(getVehicleType(veh)=="BMX")then
			return;
		end
		
		local sound=getElementData(veh,"Veh->Data->RadioSound");
		
		startVehicleRadio(veh);
		
		if(sound and isElement(sound))then
			setSoundMinDistance(sound,TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.RANGE_MIN);
			setSoundMaxDistance(sound,TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.RANGE_MAX);
			setSoundVolume(sound,TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.VOLUME);
			
			for _,v in ipairs(TABLE_SETTINGS.SOUND.EFFECTS)do--disable out-of-vehicle effects
				setSoundEffectEnabled(sound,v,false);
			end
			
			for _,v in ipairs(TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.TABLE)do--enable in-vehicle effects
				setSoundEffectEnabled(sound,v,true);
			end
		end
		
		local radioID=tonumber(getElementData(veh,"Veh->Data->RadioID"))or 0;
		if(TABLE_STATIONS[radioID])then
			openRadio(tostring(TABLE_STATIONS[radioID].name));
		else
			openRadio("Radio off");
		end
	end
end)
addEventHandler("onClientPlayerVehicleExit",localPlayer,function(veh)
	if(veh and isElement(veh))then
		local sound=getElementData(veh,"Veh->Data->RadioSound");
		
		if(sound)then
			setSoundMinDistance(sound,TABLE_SETTINGS.SOUND.VEHICLE.OUTSIDE.RANGE_MIN);
			setSoundMaxDistance(sound,TABLE_SETTINGS.SOUND.VEHICLE.OUTSIDE.RANGE_MAX);
			setSoundVolume(sound,TABLE_SETTINGS.SOUND.VEHICLE.OUTSIDE.VOLUME);
			
			for _,v in ipairs(TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.TABLE)do--disable in-vehicle effects
				setSoundEffectEnabled(sound,v,false);
			end
			
			for _,v in ipairs(TABLE_SETTINGS.SOUND.EFFECTS)do--enable out-of-vehicle effects
				setSoundEffectEnabled(sound,v,true);
			end
		end
	end
end)



function startVehicleRadio(veh)
	if(veh and isElement(veh)and getElementType(veh)=="vehicle" and isElementStreamedIn(veh))then
		stopVehicleRadio(veh);
		
		local radioID=tonumber(getElementData(veh,"Veh->Data->RadioID"))or 0;
		local channel=TABLE_STATIONS[radioID];
		
		if(channel)then
			local url=channel.url;
			
			if(url and #url>0)then
				local x,y,z=getElementPosition(veh);
				
				if(isTimer(RADIO_TIMER))then
					killTimer(RADIO_TIMER);
					RADIO_TIMER=nil;
				end
				
				RADIO_TIMER=setTimer(function(veh)
					if(veh and isElement(veh))then
						local sound=playSound3D(url,x,y,z);
						if(sound)then
							setElementData(veh,"Veh->Data->RadioSound",sound,false);
							setElementParent(sound,veh);
							attachElements(sound,veh);
							
							addEventHandler("onClientSoundStream",sound,handleVehicleRadioStream)
							addEventHandler("onClientElementDestroy",sound,handleRadioSoundDestroyed)
						end
					end
				end,250,1,veh)
			end
		end
	end
	return false;
end


function stopVehicleRadio(veh)
	if(veh and isElement(veh)and getElementType(veh)=="vehicle")then
		local sound=getElementData(veh,"Veh->Data->RadioSound");
		
		if(isTimer(RADIO_TIMER))then
			killTimer(RADIO_TIMER);
			RADIO_TIMER=nil;
		end
		
		if(sound and isElement(sound))then
			setElementData(veh,"Veh->Data->RadioSound",false,false);
			
			if(sound and isElement(sound)and getElementParent(sound)==veh)then
				destroyElement(sound);
				
				return true;
			end
		end
	end
	return false;
end




function handleVehicleRadioStream(success)
	local veh=getElementParent(source);
	local sound=getElementData(veh,"Veh->Data->RadioSound");
	
	if(not(success))then
		stopVehicleRadio(veh);
		startVehicleRadio(veh);
	else
		local minDist;
		local maxDist;
		local volume;
		local effects;
		
		if(veh==getPedOccupiedVehicle(localPlayer))then
			minDist=TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.RANGE_MIN;
			maxDist=TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.RANGE_MAX;
			volume=TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.VOLUME;
			effects=TABLE_SETTINGS.SOUND.VEHICLE.INSIDE.TABLE;
		else
			minDist=TABLE_SETTINGS.SOUND.VEHICLE.OUTSIDE.RANGE_MIN;
			maxDist=TABLE_SETTINGS.SOUND.VEHICLE.OUTSIDE.RANGE_MAX;
			volume=TABLE_SETTINGS.SOUND.VEHICLE.OUTSIDE.VOLUME;
			effects=TABLE_SETTINGS.SOUND.EFFECTS;
		end
		
		setSoundMinDistance(source,minDist);
		setSoundMaxDistance(source,maxDist);
		setSoundVolume(source,volume);
		
		for _,v in ipairs(effects)do
			setSoundEffectEnabled(sound,v,true);
		end
	end
end

function handleRadioSoundDestroyed()
	local veh=getElementParent(source);
	
	if(veh and isElement(veh)and getElementData(veh,"Veh->Data->RadioSound")==source)then
		startVehicleRadio(veh);
	end
end




local TIMER=nil;
local RADIO_TEXT=nil;



function openRadio(text)
	if(not(isLoggedin()))then
		return;
	end
	
	if(text and type(text)=="string")then
		RADIO_TEXT=text;
		
		removeEventHandler("onClientRender",root,drawRadio);
		addEventHandler("onClientRender",root,drawRadio);
		if(isTimer(TIMER))then
			killTimer(TIMER);
			TIMER=nil;
		end
		TIMER=setTimer(function()
			removeEventHandler("onClientRender",root,drawRadio);
		end,2*1000,1)
	end
end


function drawRadio()
	if(not(isLoggedin()))then
		return;
	end
	
	dxDrawRectangle(10*Gsx,600*Gsy,300*Gsx,45*Gsy,tocolor(0,0,0,120),false);
	dxDrawText(RADIO_TEXT,140*Gsx,610*Gsy,180*Gsx,20*Gsy,tocolor(255,255,255,255),1.55*Gsx,"default-bold","center",_,_,_,false,_,_);
end