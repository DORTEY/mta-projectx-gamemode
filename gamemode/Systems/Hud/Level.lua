addRemoteEvents{"Trigger->Levelbar"};--addEvent


local TIMER=nil;
local ExpText=nil;

local function draw(expgot)
	if(not(isLoggedin()))then
		return;
	end
	if(ExpText)then--clear text when existing
		ExpText=nil;
	end
	if(expgot and expgot~="n")then
		ExpText=expgot;
	else
		ExpText=nil;
	end
	
	removeEventHandler("onClientRender",root,drawLevelbar);
	addEventHandler("onClientRender",root,drawLevelbar);
	if(isTimer(TIMER))then
		killTimer(TIMER);
		TIMER=nil;
	end
	TIMER=setTimer(function()
		removeEventHandler("onClientRender",root,drawLevelbar);
	end,15*1000,1)
end
bindKey("N","DOWN",draw)
addEventHandler("Trigger->Levelbar",root,draw)


function drawLevelbar()
	if(not(isLoggedin()))then
		return;
	end
	
	local Level=tonumber(getElementData(localPlayer,"OverallLVL"))or 0;
	local EXP=tonumber(getElementData(localPlayer,"OverallEXP"))or 0;
	local expAmount=322/LEVEL.EXPforNextLevelUP[Level]*EXP;
	
	dxDrawImage(730*Gsx,10*Gsy,45*Gsx,45*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Level/Main.png",0.0,0.0,0.0,tocolor(0,120,220,255),false);
	DxDrawBorderedText(Level,-80*Gsx,20*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.75*Gsx,"default-bold","center",_,_,_,false,_,_);
	dxDrawImage(1135*Gsx,10*Gsy,45*Gsx,45*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Level/Main.png",0.0,0.0,0.0,tocolor(0,120,220,255),false);
	DxDrawBorderedText(Level+1,730*Gsx,20*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.75*Gsx,"default-bold","center",_,_,_,false,_,_);
	
	dxDrawRectangle(790*Gsx,20*Gsy,330*Gsx,25*Gsy,tocolor(0,0,0,120),false);
	dxDrawRectangle(794*Gsx,24*Gsy,expAmount*Gsx,16.5*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],200),false);
	dxDrawText(EXP.." / "..LEVEL.EXPforNextLevelUP[Level],320*Gsx,24*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.25*Gsx,"default-bold","center",_,_,_,false,_,_);
	if(ExpText)then
		dxDrawText("+"..ExpText,320*Gsx,45*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.15*Gsx,"default-bold","center",_,_,_,false,_,_);
	end
end