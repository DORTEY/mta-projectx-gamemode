local Settings={
	DisabledHudComponents={
		"ammo",
		"armour",
		"clock",
		"health",
		"money",
		"weapon",
		"wanted",
		"area_name",
		"vehicle_name",
		"breath",
		"radar",
		"radio",
	},
	NoAmmoWeapons={
		[0]=true,
		[1]=true,
		[2]=true,
		[3]=true,
		[4]=true,
		[5]=true,
		[6]=true,
		[7]=true,
		[8]=true,
	},
};
local i=0;

addEventHandler("onClientPreRender",root,function(msSinceLastFrame)
	if(isLoggedin())then
		local now=getTickCount();
		if(now>=FPStick)then
			FPS=(1/msSinceLastFrame)*1000;
			FPStick=now+1000;
		end
	end
end)

addEventHandler("onClientRender",root,function()
	--disable default GTASA huds etc
	setRadioChannel(0);
	toggleControl("radar",false);
	for i=1,#Settings.DisabledHudComponents do
		setPlayerHudComponentVisible(Settings.DisabledHudComponents[i],false);
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
	if(not(getElementData(localPlayer,"Player->Data->Team")))then
		return;
	end
	if(RadarStatus)then
		return;
	end
	
	--variables
	local AdminLVL=tonumber(getElementData(localPlayer,"AdminLevel"))or 0;
	local WantedLVL=tonumber(getElementData(localPlayer,"Wanteds"))or 0;
	local Job=getElementData(localPlayer,"Player->Data->Job")or nil;
	local WeaponID=tonumber(getPedWeapon(localPlayer))or 0;
	local Health=math.floor(getElementHealth(localPlayer))or 0;
	local Armor=math.floor(getPedArmor(localPlayer))or 0;
	local Oxygen=math.floor(getPedOxygenLevel(localPlayer));
	local Hunger=tonumber(getElementData(localPlayer,"Hunger"))or 0;
	
	--display text on bottom
	dxDrawText(SERVER_NAME.." v"..SERVER_VERSION.." | FPS: "..getCurrentFPS().." | Ping: "..getPlayerPing(localPlayer),0,GLOBALscreenY-14,GLOBALscreenX,GLOBALscreenY,tocolor(255,255,255,255),1,"default");
	
	if(tonumber(getElementData(localPlayer,"HUD"))==1)then
		local healthAmount=177/100*Health;
		local armorAmount=177/100*Armor;
		local hungerAmount=177/100*Hunger;
		local oxygenAmount=177/1000*Oxygen;
		
		--weapon
		if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Weapons/"..tonumber(WeaponID)..".png"))then
			dxDrawImage(1755*Gsx,20*Gsy,130*Gsx,130*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Weapons/"..tonumber(WeaponID)..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);
		end
		--weapon ammo
		if(not(Settings.NoAmmoWeapons[WeaponID]))then
			DxDrawBorderedText(getPedAmmoInClip(localPlayer).." | "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer),2045*Gsx,150*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.50*Gsx,"default-bold","center",_,_,_,false,_,_);
		end
		
		--job
		if(Job~=nil)then
			DxDrawBorderedText(JOBS[Job].Name,2050*Gsx,5*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.25*Gsx,"default-bold","center",_,_,_,false,_,_);
		end
		
		--adminlvl
		if(AdminLVL>0)then
			DxDrawBorderedText(ADMIN_LEVELS[AdminLVL].Name,1340*Gsx,5*Gsy,1588*Gsx,30*Gsy,tocolor(ADMIN_LEVELS[AdminLVL].RGB[1],ADMIN_LEVELS[AdminLVL].RGB[2],ADMIN_LEVELS[AdminLVL].RGB[3],255),1.25*Gsx,"default-bold","center",_,_,_,false,_,_);
		end
		
		--health
		dxDrawRectangle(1540*Gsx,35*Gsy,186*Gsx,23*Gsy,tocolor(0,0,0,150),false);
		dxDrawRectangle(1544*Gsx,39*Gsy,177*Gsx,15*Gsy,tocolor(90,10,15,150),false);
		dxDrawRectangle(1544*Gsx,39*Gsy,healthAmount*Gsx,15*Gsy,tocolor(255,40,49,150),false);
		
		if(isElementInWater(localPlayer)or Oxygen<700)then--oxygen
			dxDrawRectangle(1540*Gsx,65*Gsy,186*Gsx,23*Gsy,tocolor(0,0,0,150),false);
			dxDrawRectangle(1544*Gsx,69*Gsy,177*Gsx,15*Gsy,tocolor(0,110,180,150),false);
			dxDrawRectangle(1544*Gsx,69*Gsy,oxygenAmount*Gsx,15*Gsy,tocolor(0,150,230,150),false);
		else--armor
			dxDrawRectangle(1540*Gsx,65*Gsy,186*Gsx,23*Gsy,tocolor(0,0,0,150),false);
			dxDrawRectangle(1544*Gsx,69*Gsy,177*Gsx,15*Gsy,tocolor(110,110,110,150),false);
			dxDrawRectangle(1544*Gsx,69*Gsy,armorAmount*Gsx,15*Gsy,tocolor(255,255,255,150),false);
		end
		
		--hunger
		dxDrawRectangle(1540*Gsx,95*Gsy,186*Gsx,23*Gsy,tocolor(0,0,0,150),false);
		dxDrawRectangle(1544*Gsx,99*Gsy,177*Gsx,15*Gsy,tocolor(20,100,45,150),false);
		dxDrawRectangle(1544*Gsx,99*Gsy,hungerAmount*Gsx,15*Gsy,tocolor(95,255,90,150),false);
		
		--money
		DxDrawBorderedText(CURRENCY..convertNumber(getElementData(localPlayer,"Money")),1540*Gsx,140*Gsy,180*Gsx,20*Gsy,tocolor(0,90,20,255),1.70*Gsx,"pricedown","left",_,_,_,false,_,_);
		
		--team
		if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Teams/"..getElementData(localPlayer,"Player->Data->Team")..".png"))then
			dxDrawImage(1420*Gsx,30*Gsy,80*Gsx,80*Gsy,":"..RESOURCE_NAME.."/Files/Images/Teams/"..getElementData(localPlayer,"Player->Data->Team")..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);
		end
		
		--wanteds
		if(WantedLVL>=1)then
			local wantedYY=0;
			for i=0,5 do
				dxDrawImage(1550*Gsx+wantedYY+5*Gsx,220*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Wanted.png",0,0,0,tocolor(0,0,0,140),false);
				wantedYY=wantedYY+55*Gsx;
			end
			
			local wantedY=0;
			for i=1,WantedLVL do
				dxDrawImage(1550*Gsx+wantedY+5*Gsx,220*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Wanted.png",0,0,0,tocolor(240,240,0,255),false);
				wantedY=wantedY+55*Gsx;
			end
		end
		
	elseif(tonumber(getElementData(localPlayer,"HUD"))==2)then
		i=i+1;
		local healthAmount=270/100*Health;
		local armorAmount=270/100*Armor;
		local hungerAmount=270/100*Hunger;
		local oxygenAmount=270/1000*Oxygen;
		
		--job
		if(Job~=nil)then
			DxDrawBorderedText(JOBS[Job].Name,1550*Gsx,5*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.25*Gsx,"default-bold","center",_,_,_,false,_,_);
			
			--weapon
			if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Weapons/"..tonumber(WeaponID)..".png"))then
				dxDrawImage(1530*Gsx,25*Gsy,80*Gsx,80*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Weapons/"..tonumber(WeaponID)..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);
			end
			--weapon ammo
			if(not(Settings.NoAmmoWeapons[WeaponID]))then
				DxDrawBorderedText(getPedAmmoInClip(localPlayer).." | "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer),1550*Gsx,105*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.20*Gsx,"default-bold","center",_,_,_,false,_,_);
			end
			
			--team
			if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Teams/"..getElementData(localPlayer,"Player->Data->Team")..".png"))then
				dxDrawImage(1430*Gsx,25*Gsy,80*Gsx,80*Gsy,":"..RESOURCE_NAME.."/Files/Images/Teams/"..getElementData(localPlayer,"Player->Data->Team")..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);
			end
		else
			--weapon
			if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Weapons/"..tonumber(WeaponID)..".png"))then
				dxDrawImage(1530*Gsx,5*Gsy,80*Gsx,80*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Weapons/"..tonumber(WeaponID)..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);
			end
			--weapon ammo
			if(not(Settings.NoAmmoWeapons[WeaponID]))then
				DxDrawBorderedText(getPedAmmoInClip(localPlayer).." | "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer),1550*Gsx,90*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.20*Gsx,"default-bold","center",_,_,_,false,_,_);
			end
			
			--team
			if(fileExists(":"..RESOURCE_NAME.."/Files/Images/Teams/"..getElementData(localPlayer,"Player->Data->Team")..".png"))then
				dxDrawImage(1430*Gsx,5*Gsy,80*Gsx,80*Gsy,":"..RESOURCE_NAME.."/Files/Images/Teams/"..getElementData(localPlayer,"Player->Data->Team")..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);
			end
		end
		
		--main
		dxDrawRectangle(1625*Gsx,6*Gsy,280*Gsx,25*Gsy,tocolor(0,0,0,120),false);
		dxDrawImage(1629*Gsx,10.7*Gsy,15*Gsx,15*Gsy,":"..RESOURCE_NAME.."/Files/Images/Logo.png",0,0,0,tocolor(255,255,255,180),false);
		dxDrawText(getPlayerName(localPlayer),1655*Gsx,5*Gsy,180*Gsx,20*Gsy,tocolor(255,255,255,255),0.30*Gsx,FONT_SPEEDO,"left",_,_,_,false,_,_);
		
		--health
		dxDrawRectangle(1625*Gsx,40*Gsy,280*Gsx,25*Gsy,tocolor(0,0,0,120),false);
		dxDrawRectangle(1629*Gsx,44.7*Gsy,270*Gsx,15*Gsy,tocolor(150,0,0,120),false);
		dxSetRenderTarget();
		dxDrawImageSection(1629*Gsx,44.7*Gsy,healthAmount*Gsx,15*Gsy,i*Gsy,0,1.55*healthAmount*Gsx,10,":"..RESOURCE_NAME.."/Files/Images/Hud/Bars/Health.png");
		
		if(isElementInWater(localPlayer)or Oxygen<700)then--oxygen
			dxDrawRectangle(1625*Gsx,74*Gsy,280*Gsx,25*Gsy,tocolor(0,0,0,120),false);
			dxDrawRectangle(1629*Gsx,78.7*Gsy,270*Gsx,15*Gsy,tocolor(0,120,180,120),false);
			dxSetRenderTarget();
			dxDrawImageSection(1629*Gsx,78.7*Gsy,oxygenAmount*Gsx,15*Gsy,i*Gsy,0,1.55*oxygenAmount*Gsx,10,":"..RESOURCE_NAME.."/Files/Images/Hud/Bars/Oxygen.png");
		else
			dxDrawRectangle(1625*Gsx,74*Gsy,280*Gsx,25*Gsy,tocolor(0,0,0,120),false);
			dxDrawRectangle(1629*Gsx,78.7*Gsy,270*Gsx,15*Gsy,tocolor(0,120,180,120),false);
			dxSetRenderTarget();
			dxDrawImageSection(1629*Gsx,78.7*Gsy,armorAmount*Gsx,15*Gsy,i*Gsy,0,1.55*armorAmount*Gsx,10,":"..RESOURCE_NAME.."/Files/Images/Hud/Bars/Armor.png");
		end
		
		--hunger
		dxDrawRectangle(1625*Gsx,108*Gsy,280*Gsx,25*Gsy,tocolor(0,0,0,120),false);
		dxDrawRectangle(1629*Gsx,112.7*Gsy,270*Gsx,15*Gsy,tocolor(0,150,60,120),false);
		dxSetRenderTarget();
		dxDrawImageSection(1629*Gsx,112.7*Gsy,hungerAmount*Gsx,15*Gsy,i*Gsy,0,1.55*hungerAmount*Gsx,10,":"..RESOURCE_NAME.."/Files/Images/Hud/Bars/Hunger.png");
		
		--money
		dxDrawRectangle(1625*Gsx,142*Gsy,280*Gsx,25*Gsy,tocolor(0,0,0,120),false);
		DxDrawBorderedText(CURRENCY..convertNumber(getElementData(localPlayer,"Money")),1635*Gsx,141*Gsy,180*Gsx,20*Gsy,tocolor(255,255,255,255),0.90*Gsx,"pricedown","left",_,_,_,false,_,_);
		
		--wanteds
		if(WantedLVL>=1)then
			local wantedYY=0;
			for i=0,5 do
				dxDrawImage(1615*Gsx+wantedYY+5*Gsx,180*Gsy,35*Gsx,35*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Wanted.png",0,0,0,tocolor(0,0,0,140),false);
				wantedYY=wantedYY+48*Gsx;
			end
			
			local wantedY=0;
			for i=1,WantedLVL do
				dxDrawImage(1615*Gsx+wantedY+5*Gsx,180*Gsy,35*Gsx,35*Gsy,":"..RESOURCE_NAME.."/Files/Images/Hud/Icons/Wanted.png",0,0,0,tocolor(240,240,0,255),false);
				wantedY=wantedY+48*Gsx;
			end
		end
	end
end)





--other funcs
FPS=0;
FPStick=0;
function getCurrentFPS()
    return math.floor(FPS);
end
