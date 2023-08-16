addRemoteEvents{"Trigger->Savezone"};--addEvent


local ALPHA=0;
local RENDER_STATUS=false;

function drawSavezone()
	if(ALPHA<1 and RENDER_STATUS==false)then
		ALPHA=ALPHA+0.01;
	elseif(ALPHA>0 and RENDER_STATUS==true)then
		ALPHA=ALPHA-0.01;
	elseif(ALPHA==0 and RENDER_STATUS==true)then
		removeEventHandler("onClientRender",root,drawSavezone)
		RENDER_STATUS=false;
	end
	
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isMainMenuActive())then
		return;
	end
	if(RadarStatus)then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	dxDrawRectangle(0*Gsx,380*Gsy,300*Gsx,100*Gsy,tocolor(180,0,0,140*ALPHA),false);--bg
	
	dxDrawRectangle(0*Gsx,380*Gsy,25*Gsx,4*Gsy,tocolor(200,200,200,255*ALPHA),false);--top left corner
	dxDrawRectangle(0*Gsx,380*Gsy,4*Gsx,25*Gsy,tocolor(200,200,200,255*ALPHA),false);--top left corner
	dxDrawRectangle(300*Gsx,380*Gsy,-25*Gsx,4*Gsy,tocolor(200,200,200,255*ALPHA),false);--top right corner
	dxDrawRectangle(300*Gsx,380*Gsy,-4*Gsx,25*Gsy,tocolor(200,200,200,255*ALPHA),false);--top right corner
	dxDrawRectangle(0*Gsx,480*Gsy,25*Gsx,-4*Gsy,tocolor(200,200,200,255*ALPHA),false);--bottom left corner
	dxDrawRectangle(0*Gsx,480*Gsy,4*Gsx,-25*Gsy,tocolor(200,200,200,255*ALPHA),false);--bottom left corner
	dxDrawRectangle(300*Gsx,480*Gsy,-25*Gsx,-4*Gsy,tocolor(200,200,200,255*ALPHA),false);--bottom right corner
	dxDrawRectangle(300*Gsx,480*Gsy,-4*Gsx,-25*Gsy,tocolor(200,200,200,255*ALPHA),false);--bottom right corner
	
	dxDrawText("No-Dm-Zone",260*Gsx,390*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*ALPHA),1.70*Gsx,"default-bold","center",_,_,_,false,_,_);
	dxDrawText(loc("NoDMText"),260*Gsx,430*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*ALPHA),1.15*Gsx,"default-bold","center");
end

addEventHandler("Trigger->Savezone",root,function(typ)
	if(typ=="Open")then
		if(RENDER_STATUS==true and ALPHA~=0)then
			RENDER_STATUS=false;
		else
			RENDER_STATUS=false;
			removeEventHandler("onClientRender",root,drawSavezone);
			addEventHandler("onClientRender",root,drawSavezone);
		end
	elseif(typ=="Close")then
		RENDER_STATUS=true;
	end
end)