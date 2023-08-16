addRemoteEvents{"Infobox->UI"};--addEvent


local INFOBOX_TABLE={};

local INFOBOX_TICK=nil;
local INFOBOX_SOUND=nil;
local INFOBOX_POS=nil;

local INFOBOX_COLORS={
	["error"]={180,0,0},
	["success"]={0,180,0},
	["info"]={0,110,220},
	["money"]={90,90,90},
};


addEventHandler("onClientRender",root,function()
	local INFOBOX_TICK=getTickCount();
	
	if(#INFOBOX_TABLE>5)then--max 5 infoboxes
		table.remove(INFOBOX_TABLE,1);--remove the lowest infobox when limit is reached
	end
	
	if(isClickedState(localPlayer)==true or isElement(GUI.Window["UI->Element->Tuning"])or RadarStatus or isMainMenuActive())then
		INFOBOX_POS=1050;--when UI is open
	else
		INFOBOX_POS=800;--when UI is closed(normal)
	end
	
	for i,v in pairs(INFOBOX_TABLE)do
		dxDrawRectangle(20*Gsx,INFOBOX_POS*Gsy-(i*110),380*Gsx,100*Gsy,tocolor(0,0,0,180),false);--bg
		
		dxDrawRectangle(20*Gsx,INFOBOX_POS*Gsy-(i*110),20*Gsx,3*Gsy,v[3],false);--top left corner
		dxDrawRectangle(20*Gsx,INFOBOX_POS*Gsy-(i*110),3*Gsx,20*Gsy,v[3],false);--top left corner
		dxDrawRectangle(401*Gsx,INFOBOX_POS*Gsy-(i*110),-20*Gsx,3*Gsy,v[3],false);--top right corner
		dxDrawRectangle(401*Gsx,INFOBOX_POS*Gsy-(i*110),-3*Gsx,20*Gsy,v[3],false);--top right corner
		dxDrawRectangle(20*Gsx,INFOBOX_POS*Gsy+100*Gsy-(i*110),20*Gsx,-3*Gsy,v[3],false);--bottom left corner
		dxDrawRectangle(20*Gsx,INFOBOX_POS*Gsy+100*Gsy-(i*110),3*Gsx,-20*Gsy,v[3],false);--bottom left corner
		dxDrawRectangle(401*Gsx,INFOBOX_POS*Gsy+100*Gsy-(i*110),-20*Gsx,-3*Gsy,v[3],false);--bottom right corner
		dxDrawRectangle(401*Gsx,INFOBOX_POS*Gsy+100*Gsy-(i*110),-3*Gsx,-20*Gsy,v[3],false);--bottom right corner
		
		dxDrawText(v[2],240*Gsx,INFOBOX_POS*Gsy+5*Gsy-(i*110),180*Gsx,20*Gsy,tocolor(255,255,255,255),1.50*Gsx,"default","center",_,_,_,false,_,_);--text
		
		if(INFOBOX_TICK>=v[5])then
			v[4]=math.max(v[4]-10,0);
			v[6]=math.max(v[6]-10,0);
		else
			v[6]=math.min(v[6]+10,286);
			v[4]=math.min(v[4]+10,255);
		end
		if(v[4]<=0)then
			table.remove(INFOBOX_TABLE,i);
		end
	end
end)


function dxDrawInfoboxStack(typ,text,time)
	time=time or 7;
	
	if(INFOBOX_COLORS[typ])then
		color=tocolor(INFOBOX_COLORS[typ][1],INFOBOX_COLORS[typ][2],INFOBOX_COLORS[typ][3],180);
		
		if(isElement(INFOBOX_SOUND))then
			destroyElement(INFOBOX_SOUND);
			INFOBOX_SOUND=nil;
		end
		INFOBOX_SOUND=playSound(":"..RESOURCE_NAME.."/Files/Audio/Infobox/"..typ..".mp3");
		setSoundVolume(INFOBOX_SOUND,0.5);
	end
	
	local INFOBOX_TICK=getTickCount();
	table.insert(INFOBOX_TABLE,{typ,text, color, 0,INFOBOX_TICK+1000*time,0});
end
addEventHandler("Infobox->UI",root,dxDrawInfoboxStack)