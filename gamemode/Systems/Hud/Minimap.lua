addRemoteEvents{"Update->Minimap"};--addEvent


local getRadarRadius=function()
	return 150;
end

local getVectorRotation=function(x,y,x1,y1)
    local rot=6.2831853071796-math.atan2(x1-x,y1-y)%6.2831853071796;
    return -rot;
end

local getRotation=function()
    local x,y,_,rx,ry=getCameraMatrix();
    local result=getVectorRotation(x,y,rx,ry);
	
    return result;
end

local isColliding=function(x1,y1,w1,h1,x2,y2,w2,h2)
    local horizontal=(x1<x2)~=(x1+w1<x2)or(x1>x2)~=(x1>x2+w2);
    local vertical=(y1<y2)~=(y1+h1<y2)or(y1>y2)~=(y1>y2+h2);
	
    return(horizontal and vertical);
end

local getPointFromDistanceRotation=function(x,y,distance,angel)
    local x1=math.cos(math.rad(90-angel))*distance;
    local y1=math.sin(math.rad(90-angel))*distance;
    return x+x1,y+y1;
end



setMinimapSettings=function()
    RADAR_TARGET_MAP=dxCreateRenderTarget(380*Gsx*2,380*Gsx*2,true);
    RADAR_TARGET_RENDER=dxCreateRenderTarget(380*Gsx*3,380*Gsx*3,true);
	RADAR_IMAGE=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Images/Radar/Maps/"..tonumber(getElementData(localPlayer,"Radar"))..".png");
end

addEventHandler("Update->Minimap",root,function()
	setMinimapSettings();
end)


function drawMinimap()
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
	if(RadarStatus)then
		return;
	end
	if(getElementData(localPlayer,"Jailtime")>0)then
		return;
	end
	
	if(RADAR_IMAGE and RADAR_TARGET_RENDER)then
		dxSetTextureEdge(RADAR_IMAGE,"border",tocolor(50,75,100,255));
		dxDrawBorder(20*Gsx,810*Gsy,380*Gsx,250*Gsy,3,tocolor(0,0,0,150));
		
		playerX,playerY,playerZ=getElementPosition(localPlayer);
		
		local playerRotation=getElementRotation(localPlayer);
		local rx,ry,rz=getElementRotation(localPlayer);
		local camX,camY,camZ=getElementRotation(getCamera());
		local playerMapX,playerMapY=(3000+playerX)/6000*3072,(3000-playerY)/6000*3072;
		local streamDistance,pRotation=getRadarRadius(),getRotation();
		local mapRadius=streamDistance/6000*3072*6;
		local mapX,mapY,mapWidth,mapHeight=playerMapX-mapRadius,playerMapY-mapRadius,mapRadius*2,mapRadius*2;
		
		
		dxSetRenderTarget(RADAR_TARGET_MAP,true);
		dxDrawRectangle(0,0,380*Gsx*2,380*Gsx*2,tocolor(50,75,100,255),false);
		dxDrawImageSection(0,0,380*Gsx*2,380*Gsx*2,mapX,mapY,mapWidth,mapHeight,RADAR_IMAGE,0,0,0,tocolor(255,255,255,255),false);
	
		for _,v in ipairs(getElementsByType("radararea"))do
			local areaX,areaY=getElementPosition(v);
			local areaWidth,areaHeight=getRadarAreaSize(v);
			local areaMapX,areaMapY,areaMapWidth,areaMapHeight=(3000+areaX)/6000*3072,(3000-areaY)/6000*3072,areaWidth/6000*3072,-(areaHeight/6000*3072);
			if(isColliding(playerMapX-mapRadius,playerMapY-mapRadius,mapRadius*2,mapRadius*2,areaMapX,areaMapY,areaMapWidth,areaMapHeight))then
				local areaR,areaG,areaB,areaA=getRadarAreaColor(v);
				if(isRadarAreaFlashing(v))then
					areaA=areaA*math.abs(getTickCount()%1000-500)/500;
				end
				local mapRatio=380*Gsx*2/(mapRadius*2);
				local areaMapX,areaMapY,areaMapWidth,areaMapHeight=(areaMapX-(playerMapX-mapRadius))*mapRatio,(areaMapY-(playerMapY-mapRadius))*mapRatio,areaMapWidth*mapRatio,areaMapHeight*mapRatio;
				dxSetBlendMode("modulate_add");
				dxDrawRectangle(areaMapX,areaMapY,areaMapWidth,areaMapHeight,tocolor(areaR,areaG,areaB,areaA),false);
				dxSetBlendMode("blend");
			end
		end
		
		dxSetRenderTarget(RADAR_TARGET_RENDER,true);
		dxDrawImage(380*Gsx/2,380*Gsx/2,380*Gsx*2,380*Gsx*2,RADAR_TARGET_MAP,math.deg(-pRotation),0,0,tocolor(255,255,255,255),false);
		
		table.sort(getElementsByType("blip"),function(b1,b2)
			return getBlipOrdering(b1)<getBlipOrdering(b2);
		end)
		
		for _,v in ipairs(getElementsByType("blip"))do
			local blipX,blipY,blipZ=getElementPosition(v);
			if(localPlayer~=getElementAttachedTo(v)and getElementInterior(localPlayer)==getElementInterior(v)and getElementDimension(localPlayer)==getElementDimension(v))then
				local blipDistance=getDistanceBetweenPoints2D(blipX,blipY,playerX,playerY);
				local maxDist=getBlipVisibleDistance(v);
				if(blipDistance<=maxDist)then
					local blipRotation=math.deg(-getVectorRotation(playerX,playerY,blipX,blipY)-(-pRotation))-180;
					local blipRadius=math.min((blipDistance/(streamDistance*6))*380*Gsx,380*Gsx);
					local distanceX,distanceY=getPointFromDistanceRotation(0,0,blipRadius,blipRotation);
					local bid=getBlipIcon(v);
					local blipX,blipY=380*Gsx*1.5+(distanceX-(20/2)),380*Gsx*1.5+(distanceY-(20/2));
					local blipSize=getBlipSize(v)or 20;
					
					bR,bG,bB=getBlipColor(v);
					
					dxSetBlendMode("modulate_add");
					if(bid==0)then
						if(playerZ and blipZ)then
							if(math.abs(playerZ-blipZ)>3)then
								IMAGE=blipZ>playerZ and "0_up" or "0_down";
							else
								IMAGE="0";
							end
							dxDrawImage(blipX,blipY,blipSize+2,blipSize+2,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..IMAGE..".png",0,0,0,tocolor(bR,bG,bB,255),false);
						end
					else
						dxDrawImage(blipX,blipY,blipSize+2,blipSize+2,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/"..bid..".png",0,0,0,tocolor(bR,bG,bB,255),false);
					end
					dxSetBlendMode("blend");
				end
			end
		end
		
		--draw player arrow
		dxSetRenderTarget();
		dxDrawImageSection(20*Gsx,810*Gsy,380*Gsx,250*Gsy,380*Gsx/2+(380*Gsx*2/2)-(380*Gsx/2),380*Gsx/2+(380*Gsx*2/2)-(250*Gsy/2),380*Gsx,250*Gsy,RADAR_TARGET_RENDER,0,-90,0,tocolor(255,255,255,255));
		dxDrawImage((20*Gsx+(380*Gsx/2))-10,(810*Gsy+(250*Gsy/2))-10,20,20,":"..RESOURCE_NAME.."/Files/Images/Radar/Blips/Arrow.png",camZ-rz,0,0);
		
		--draw zone zone
		dxDrawRectangle(20*Gsx,810*Gsy,380*Gsx,12.5+10,tocolor(0,0,0,140));
		dxDrawText(getZoneName(playerX,playerY,playerZ).." - "..getZoneName(playerX,playerY,playerZ,true),20*Gsx+5,(810*Gsy-250*Gsy+17.5),20*Gsx+5+380*Gsx-10,810*Gsy+250*Gsy,tocolor(255,255,255,255),1,"sans","center","center",true,false,false,true,true);
		
		
		dxDrawRectangle(15*Gsx,805*Gsy,25*Gsx,4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top left corner
		dxDrawRectangle(15*Gsx,805*Gsy,4*Gsx,25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top left corner
		dxDrawRectangle(405*Gsx,805*Gsy,-25*Gsx,4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top right corner
		dxDrawRectangle(405*Gsx,805*Gsy,-4*Gsx,25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top right corner
		dxDrawRectangle(15*Gsx,1065*Gsy,25*Gsx,-4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom left corner
		dxDrawRectangle(15*Gsx,1065*Gsy,4*Gsx,-25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom left corner
		dxDrawRectangle(405*Gsx,1065*Gsy,-25*Gsx,-4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom right corner
		dxDrawRectangle(405*Gsx,1065*Gsy,-4*Gsx,-25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom right corner
	end
end
addEventHandler("onClientRender",root,drawMinimap)