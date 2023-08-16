addRemoteEvents{"Update->Radar"};--addEvent


local RADAR_TOGGLE=false;

local RADAR_MAP_WIDTH=6000;
local RADAR_MAP_HEIGHT=6000;
local RADAR_PixelsPerMeter=GLOBALscreenY/6000;

local RADAR_TOPLEFT_WX=-3000;
local RADAR_TOPLEFT_WY=3000;

local x,y=0,0;

local RADAR_TOOLTIP={};


function drawRadar()
	if(not(isLoggedin()))then
		return;
	end
	if(getElementInterior(localPlayer)>0)then
		return;
	end
	if(getElementDimension(localPlayer)>0)then
		return;
	end
	if(isMainMenuActive())then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(getElementData(localPlayer,"Jailtime")>0)then
		return;
	end
	
	local RADAR=tonumber(getElementData(localPlayer,"Radar"))or 1;
	
	if(RADAR_TOGGLE)then
		hSize=RADAR_PixelsPerMeter*RADAR_MAP_WIDTH*1;
		vSize=RADAR_PixelsPerMeter*RADAR_MAP_HEIGHT*1;
		
		x=GLOBALscreenX/2-hSize/2*1;
		y=GLOBALscreenY/2-vSize/2*1;
		
		--dxDrawImage(x,y,hSize,vSize,RADAR_IMAGE,0,0,0,tocolor(255,255,255,getPlayerMapOpacity()),false);
		dxDrawImage(x,y,hSize,vSize,":"..RESOURCE_NAME.."/Files/Images/Radar/Maps/"..RADAR..".png",0,0,0,tocolor(255,255,255,getPlayerMapOpacity()),false);
		
		--draw player arrow
		local playerX,playerY,_=getElementPosition(localPlayer);
		local playerROT=getPedRotation(localPlayer);
		
		local mapX,mapY=getMapFromWorldPosition(playerX,playerY);
		
		dxDrawImage(mapX-8,mapY-8,18,18,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/Arrow.png",(-playerROT)%360,0,0,normalColor,true);
		
		
		--draw areas
		local radarareas=getElementsByType("radararea");
		if(#radarareas>0)then
			local tick=math.abs(getTickCount()%1000-500);
			local aFactor=tick/500;
			
			for k,v in ipairs(radarareas)do
				local areaX,areaY=getElementPosition(v);
				local areaSX,areaSY=getRadarAreaSize(v);
				local areaR,areaG,areaB,areaA=getRadarAreaColor(v);
				local flashing=isRadarAreaFlashing(v);
				
				if flashing then
					areaA=areaA*aFactor;
				end
				
				local hx1,hy1=getMapFromWorldPosition(areaX,areaY+areaSY);
				local hx2,hy2=getMapFromWorldPosition(areaX+areaSX,areaY);
				local areaMapX=hx2-hx1;
				local areaMapY=hy2-hy1;
				
				dxDrawRectangle(hx1,hy1,areaMapX,areaMapY,tocolor(areaR,areaG,areaB,areaA),false);
			end
		end
		
		--draw blips
		for _,v in ipairs(getElementsByType("blip"))do
			if(not(getElementData(v,"Blip->Data->OnlyMinimap")))then
				local icon=getBlipIcon(v)or 0;
				local blipSize=getBlipSize(v)or 20;
				
				local blipR,blipG,blipB,blipA=getBlipColor(v);
				
				local blipX,blipY,_=getElementPosition(v);
				blipMapX,blipMapY=getMapFromWorldPosition(blipX,blipY);
				
				local halfsize=blipSize/2;
				if(icon==1 and blipX==playerX and blipY==playerY)then
				else
					dxDrawImage(blipMapX-halfsize,blipMapY-halfsize,blipSize,blipSize,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..icon..".png",0,0,0,tocolor(blipR,blipG,blipB,blipA),false);
				end
			end
		end
		
	end
end
addEventHandler("onClientRender",root,drawRadar)

local Hover=nil;
addEventHandler("onClientRender",root,function()--tooltips
	if(RADAR_TOGGLE)then
		for _,v in ipairs(getElementsByType("blip"))do
			local size=getBlipSize(v)or 20;
			
			local blipX,blipY,_=getElementPosition(v);
			xx,yy=getMapFromWorldPosition(blipX,blipY);
			
			local halfsize=size/2;
			
			RADAR_TOOLTIP[v]=getElementData(v,"tooltipText")or nil;
			
			if(RADAR_TOOLTIP[v])then
				local sX,sY,wX,wY,wZ=getCursorPosition();
				if(isCursorOnElement(xx-halfsize,yy-halfsize,size,size)and not Hover)then
					Hover=true;
					dxDrawRectangle((sX*GLOBALscreenX)+20*Gsx,(sY*GLOBALscreenY),(dxGetTextWidth(RADAR_TOOLTIP[v],1.20*Gsx,"default-bold")),20*Gsy,tocolor(0,0,0,120),false);
					dxDrawText(RADAR_TOOLTIP[v],(sX*GLOBALscreenX)+20*Gsx,(sY*GLOBALscreenY),(dxGetTextWidth(RADAR_TOOLTIP[v],1.20*Gsx,"default-bold")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default-bold");
				else
					Hover=nil;
				end
			end
		end
	end
end)

bindKey("F11","UP",function()
	RADAR_TOGGLE=not RADAR_TOGGLE;
	
	if(RADAR_TOGGLE)then
		if(not(isLoggedin()))then
			return;
		end
		if(getElementInterior(localPlayer)>0)then
			return;
		end
		if(getElementDimension(localPlayer)>0)then
			return;
		end
		if(isPedDead(localPlayer))then
			return;
		end
		if(isClickedState(localPlayer)==true)then
			return;
		end
		if(getElementData(localPlayer,"Jailtime")>0)then
			return;
		end
		showChat(false);
		RadarStatus=true;
		Hover=false;
	else
		showChat(true);
		RadarStatus=false;
		Hover=false;
	end
end)

function getMapFromWorldPosition(worldX,worldY)
	local mapX=x+RADAR_PixelsPerMeter*(worldX-RADAR_TOPLEFT_WX);
	local mapY=y+RADAR_PixelsPerMeter*(RADAR_TOPLEFT_WY-worldY);
	
	return mapX,mapY;
end

addEventHandler("onClientPedWasted",root,function(player)
	if(player==localPlayer)then
		if(RADAR_TOGGLE)then
			showChat(true);
			RADAR_TOGGLE=false;
		end
		if(RadarStatus)then
			RadarStatus=false;
		end
	end
end)



--blip legend
local TABLE={
	--{18,"                Allgemeines",ServerStuff.RGB[1],ServerStuff.RGB[2],ServerStuff.RGB[3]},
	{6,"24/7 Shop",255,255,255, 255,255,255},
	{7,"Skin Shop",255,255,255, 255,255,255},
	{7,"Skin Shop (VIP)",255,255,255, 150,150,0},
	{17,"Burgershot",255,255,255, 170,130,95},
	{8,"Vehicle Shop",255,255,255, 255,255,255},
	{9,"Weapon Shop",255,255,255, 255,255,255},
	{10,"Pay 'n' Spray",255,255,255, 255,255,255},
	{11,"Job: Farmer",255,255,255, 255,255,255},
	{12,"Job: Miner",255,255,255, 150,90,50},
	{16,"Job: Garbage",255,255,255, 90,90,90},
	{13,"Jeweler",255,255,255, 255,255,255},
	{14,"Teleporter",255,255,255, 240,90,255},
	{15,"Tuningshop",255,255,255, 90,90,90},
}

addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(getElementInterior(localPlayer)>0)then
		return;
	end
	if(getElementDimension(localPlayer)>0)then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(getElementData(localPlayer,"Jailtime")>0)then
		return;
	end
	
	if(RadarStatus==true)then
		for i,v in ipairs(TABLE)do
			local i=i-1;
			
			dxDrawRectangle(1690*Gsx,(i*26)*Gsy,230*Gsx,26*Gsy,tocolor(0,0,0,150),false);
			dxDrawImage(1695*Gsx,(i*26)*Gsy,23*Gsx,23*Gsy,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..v[1]..".png",0,0,0,tocolor(v[6],v[7],v[8],255),false);
			dxDrawText(v[2],1722*Gsx,(i*26)*Gsy,1430*Gsx,26+(i*26)*Gsy,tocolor(v[3],v[4],v[5],255),1.20*Gsx,"default-bold","left","center",_,_,_,_,_);
		end
	end
end)