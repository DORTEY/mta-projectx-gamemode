--//-----------------------------------------------\\
--||   Project      : Lakeside Roleplay - MTA:SA
--||   Author       : Lorenzo(DorteY)
--\\-----------------------------------------------//


function drawSpeedo()
	if(not(isLoggedin()))then
		return;
	end
	if(not(isPedInVehicle(localPlayer)))then
		return;
	end
	if(isMainMenuActive())then
		return;
	end
	if(RadarStatus==true)then
		return;
	end
	
	local veh=getPedOccupiedVehicle(localPlayer);
	if(veh and isElement(veh))then
		--tables
		local lightColor={};
		local engineColor={};
		--variables
		local VehLightStatus=getVehicleOverrideLights(veh)or 1;
		local lightR,lightG,lightB=getVehicleHeadLightColor(veh);
		local VehEngineStatus=getVehicleEngineState(veh)or false;
		local VehSpeed=getElementSpeed(veh,"km/h")or 0;
		
		
		--draw funcs
		if(tonumber(getElementData(localPlayer,"Speedo"))==1)then--exo
			if(VehEngineStatus==true)then
				engineColor={0,180,0,255};
			else
				engineColor={200,200,40,255};
			end
			
			dxDrawImage(1610*Gsx,780*Gsy,300*Gsx,300*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/eXo/Background.png",0,0,0,tocolor(255,255,255,170),false);
			dxDrawImage(1740*Gsx,980*Gsy,35*Gsx,35*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/eXo/Engine.png",0,0,0,tocolor(engineColor[1],engineColor[2],engineColor[3],engineColor[4]),false);
			dxDrawImage(1610*Gsx,780*Gsy,300*Gsx,300*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/eXo/Needle.png",VehSpeed*270/240,0,0,tocolor(255,255,255,255),false);
			
			if(getPedControlState(localPlayer,"handbrake"))then
				dxDrawImage(1740*Gsx,850*Gsy,35*Gsx,35*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/eXo/Brake.png",0,0,0,tocolor(220,40,0,255),false);
			end
			
			dxDrawText(math.floor(VehSpeed).." km/h",3335*Gsx,890*Gsy,180*Gsx,20*Gsy,tocolor(255,255,255,255),1.25*Gsx,"default-bold","center",_,_,_,false,_,_);
		end
		if(tonumber(getElementData(localPlayer,"Speedo"))==2)then--visual
			if(VehEngineStatus==true)then
				engineColor={180,70,0,255};
			else
				engineColor={255,255,255,255};
			end
			if(VehLightStatus==2)then
				lightColor={lightR,lightG,lightB,255};
			else
				lightColor={255,255,255,255};
			end
			
			dxDrawImage(1625*Gsx,790*Gsy,280*Gsx,280*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/Visual/Background.png",0,0,0,tocolor(255,255,255,225),false);
			
			local npos=0;
			if(VehSpeed>270)then
				npos=270+((getTickCount()%2)-1);
			else
				npos=VehSpeed;
			end
			
			dxDrawImage(1785*Gsx,980*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/Visual/Engine.png",0,0,0,tocolor(engineColor[1],engineColor[2],engineColor[3],engineColor[4]),false);
			dxDrawImage(1845*Gsx,980*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/Visual/Light.png",0,0,0,tocolor(lightColor[1],lightColor[2],lightColor[3],lightColor[4]),false);
			dxDrawImage(1625*Gsx,790*Gsy,280*Gsx,280*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/Visual/Needle.png",npos,0,0,tocolor(255,255,255,255),false);
			
			if(getPedControlState(localPlayer,"handbrake"))then
				dxDrawImage(1745*Gsx,855*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/Speedo/eXo/Brake.png",0,0,0,tocolor(220,40,0,255),false);
			end
			
			dxDrawText(math.floor(VehSpeed).." km/h",3490*Gsx,940*Gsy,180*Gsx,20*Gsy,tocolor(255,255,255,255),0.40*Gsx,FONT_SPEEDO,"center",_,_,_,false,_,_);
		end
	end
end

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==localPlayer)then
		removeEventHandler("onClientRender",root,drawSpeedo)
		addEventHandler("onClientRender",root,drawSpeedo)
	end
end)
addEventHandler("onClientVehicleExit",root,function(player)
	if(player==localPlayer)then
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end)