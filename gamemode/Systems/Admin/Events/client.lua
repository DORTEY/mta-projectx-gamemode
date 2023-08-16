addRemoteEvents{"Trigger->Timerbar->Event"};--addEvent


local ConvertTimeTimer=nil;

addEventHandler("Trigger->Timerbar->Event",root,function(typ,typ2,time)
	if(isTimer(ConvertTimeTimer))then
		killTimer(ConvertTimeTimer);
		ConvertTimeTimer=nil;
		removeEventHandler("onClientRender",root,dxDrawConvertTimer)
	end
	
	if(typ=="start")then
		removeEventHandler("onClientRender",root,dxDrawConvertTimer)
		addEventHandler("onClientRender",root,dxDrawConvertTimer)
		
		if(typ2=="Fivetowers")then
			ConvertTimeText="Fivetowers event starts in...";
		else
			ConvertTimeText"starts in...";
		end
		
		ConvertTimeTime=time;
		
		ConvertTimeTimer=setTimer(function()
			ConvertTimeTime=ConvertTimeTime-1;
			if(ConvertTimeTime==0)then
				removeEventHandler("onClientRender",root,dxDrawConvertTimer)
				if(isTimer(ConvertTimeTimer))then
					killTimer(ConvertTimeTimer);
					ConvertTimeTimer=nil;
					removeEventHandler("onClientRender",root,dxDrawConvertTimer)
				end
			end
		end,1000,ConvertTimeTime)
	end
end)

function dxDrawConvertTimer()
	dxDrawRectangle(790*Gsx,30*Gsy,330*Gsx,130*Gsy,tocolor(0,0,0,150),false);--BG
	dxDrawRectangle(810*Gsx,75*Gsy,290*Gsx,65*Gsy,GUI.Color.BG,false);--Time BG
	
	dxDrawText(ConvertTimeText,1710*Gsx,85*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,255),1.5*Gsx,"default-bold","center","center",_,_,false,_,_);
	dxDrawText(covertTime(ConvertTimeTime),1710*Gsx,183*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,255),4*Gsx,"default-bold","center","center",_,_,false,_,_);
end



function covertTime(seconds)
	local minutes=math.floor(seconds/60);
	local seconds=seconds-minutes*60;
	
	if(minutes<10)then
		minutes="0"..minutes;
	end
	if(seconds<10)then
		seconds="0"..seconds;
	end
	
	return minutes..":"..seconds;
end





local STATUS=false;
addEventHandler("onClientPreRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	local x,y,z=getElementPosition(localPlayer);
	if(not(STATUS))then
		if(getElementData(localPlayer,"Player->Data->EventID"))then
			if(getElementData(localPlayer,"Player->Data->EventID")==2)then
				if(z<25)then
					triggerServerEvent("Event->TeleportBack",localPlayer);
					STATUS=true;
				end
			end
		else
			STATUS=false;
		end
	end
end)