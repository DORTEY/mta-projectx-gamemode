addRemoteEvents{"Bloodscreen->UI","Hospital->UI","Teleport->UI","Phonecell->Sound"};--addEvent


--damage stuff
local bloodAlpha=0;
addEventHandler("Bloodscreen->UI",root,function(amount)
	BLOODSCREEN=amount;
	if(BLOODSCREEN~=1)then
		bloodAlpha=255;
	end
end)

addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	
	if(bloodAlpha>0)then
		dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,":"..RESOURCE_NAME.."/Files/Images/Damage/Bloodscreen_"..BLOODSCREEN..".png",0,0,0,tocolor(255,255,255,bloodAlpha));
		bloodAlpha=math.max(0,bloodAlpha-3);
	end
end)

addEventHandler("onClientPlayerDamage",root,function(attacker,weapon,bodypart,loss)
	if(attacker and weapon and bodypart and loss)then
		if(attacker==localPlayer)then
			if(WeaponDamage[weapon])then
				local HITSOUND=tonumber(getElementData(localPlayer,"Hitsound"))or 1;
				if(HITSOUND~=1)then
					if(source~=lp)then
						local sound=playSound(":"..RESOURCE_NAME.."/Files/Audio/Hitsounds/"..HITSOUND..".mp3");
						setSoundVolume(sound,0.5);
					end
				end
				--todo hitglocke
				cancelEvent();
				triggerServerEvent("Trigger->Damage",source,source,weapon,bodypart,loss);
			end
		elseif(source==localPlayer)then
			if(WeaponDamage[weapon])then
				cancelEvent();
			end
		end
	end
end)

addEventHandler("Teleport->UI",root,function(typ)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(getElementDimension(localPlayer)>0)then
		return;
	end
	if(getElementInterior(localPlayer)>0)then
		return;
	end
	
	if(typ=="Open")then
		if(isClickedState(localPlayer)==true)then
			return;
		end
		
		setUIdatas("set","cursor",true);
		
		GUI.Window[1]=dgsCreateWindow(10,GLOBALscreenY/2-480/2,300,480,"Teleport menu",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(265,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
		
		GUI.Blurbox[1]=dgsCreateBlurBox(300,480);
		GUI.Blurbox[2]=dgsCreateImage(10,GLOBALscreenY/2-480/2,300,480,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		GUI.Grid[1]=dgsCreateGridList(10,10,280,380,false,GUI.Window[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		local locationName=dgsGridListAddColumn(GUI.Grid[1],"Location",1);
		
		for _,v in pairs(TELEPORTS["Panel"])do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,locationName,v[1],false,false);
		end
		
		
		GUI.Button[1]=dgsCreateButton(10,400,280,35,"Teleport",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		dgsSetProperty(GUI.Grid[1],"rowHeight",35);
		
		
		addEventHandler("onDgsMouseDoubleClick",GUI.Grid[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						if(clicked and clicked~="")then
							triggerServerEvent("Teleport->Location",localPlayer,tostring(clicked));
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						if(clicked and clicked~="")then
							triggerServerEvent("Teleport->Location",localPlayer,tostring(clicked));
						end
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="down")then
					setUIdatas("rem","cursor",true);
				end
			end,
		false)
	elseif(typ=="Close")then
		if(isClickedState(localPlayer)==true)then
			setUIdatas("rem","cursor",true);
		end
	end
end)




addEventHandler("onClientPedDamage",root,function()--cancel ped damage
	if(getElementData(source,"Ped->Data->Immortal"))then
		cancelEvent();
	end
end)


--ped names
addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(isPlayerMapVisible(localPlayer)==true)then
		return;
	end
	
	for _,v in pairs(getElementsByType("ped"))do
		if(getElementDimension(localPlayer)==getElementDimension(v)and getElementInterior(localPlayer)==getElementInterior(v))then
			if(getElementData(v,"Ped->Data->Name"))then--check ped has name
				local px,py,pz=getPedBonePosition(v,8);
				local x,y,z=getPedBonePosition(localPlayer,8);
				
				if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=8 and isLineOfSightClear(px,py,pz,x,y,z,true,false,false,true,false))then
					local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true);
					if(sx and sy)then
						dxDrawText(getElementData(v,"Ped->Data->Description")or " ",sx,sy-40,sx,sy,tocolor(255,255,255,255),1.3,"default","center","center");
						dxDrawText(getElementData(v,"Ped->Data->Name"):gsub("_"," ")or "",sx,sy,sx,sy,tocolor(0,80,200,255),1.8,"default","center","center");
					end
				end
			end
		end
	end
end)


addEventHandler("Hospital->UI",root,function(typ,time)
	if(typ=="create")then
		local x,y,z=getElementPosition(localPlayer);
		local deathsound=playSound(":"..RESOURCE_NAME.."/Files/Audio/Wasted.mp3",false);
		setSoundVolume(deathsound,1.0);
		
		if(isTimer(HospitalStartTimer))then
			killTimer(HospitalStartTimer);
			HospitalStartTimer=nil;
		end
		--destroy UI if open
		if(isElement(GUI.Window[1]))then
			dgsCloseWindow(GUI.Window[1]);
			setUIdatas("rem","cursor",true);
		end
		if(isElement(GUI.Window[2]))then
			dgsCloseWindow(GUI.Window[2]);
			setUIdatas("rem","cursor",true);
		end
		if(isElement(GUI.Window[3]))then
			dgsCloseWindow(GUI.Window[3]);
			setUIdatas("rem","cursor",true);
		end
		
		
		HospitalStartTimer=setTimer(function()
			showChat(false);
			setClickedState(localPlayer,false);
			setCameraMatrix(x,y,z+8,x,y,z);--6
			
			if(isPedInVehicle(localPlayer))then
				removePedFromVehicle(localPlayer);
			end
			
			GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,20,400,200,"Hospital",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
			dgsWindowSetSizable(GUI.Window[1],false);
			dgsWindowSetMovable(GUI.Window[1],false);
			
			GUI.Label[1]=dgsCreateLabel(150,5,100,60,loc("UI->DeathScreen"):format(time),false,GUI.Window[1],_,_,_,_,_,_,"center",_)
			dgsSetProperty(GUI.Label[1],"textSize",{1.5,1.5})
			
			
			HospitalTimer=setTimer(function()
				time=time-1;
				triggerServerEvent("Hospital->Time",localPlayer,"update",1);--update hospital time serverside
				dgsSetText(GUI.Label[1],loc("UI->DeathScreen"):format(time));
				if(time==0)then
					setUIdatas("rem","cursor",true);
					showChat(true);
					
					triggerServerEvent("Hospital->Respawn",localPlayer);--respawn player to the hospital
					triggerServerEvent("Hospital->Time",localPlayer,"set",0);
					
					--destroy timers
					if(isTimer(HospitalTimer))then
						killTimer(HospitalTimer);
						HospitalTimer=nil;
					end
					if(isTimer(HospitalStartTimer))then
						killTimer(HospitalStartTimer);
						HospitalStartTimer=nil;
					end
				end
			end,1000,time)
			--destroy timer if time is up
			if(isTimer(HospitalStartTimer))then
				killTimer(HospitalStartTimer);
				HospitalStartTimer=nil;
			end
		end,7200,1)
	elseif(typ=="Destroy")then
		--destroy timers
		if(isTimer(HospitalTimer))then
			killTimer(HospitalTimer);
			HospitalTimer=nil;
		end
		if(isTimer(HospitalStartTimer))then
			killTimer(HospitalStartTimer);
			HospitalStartTimer=nil;
		end
		if(isElement(GUI.Window[1]))then
			setUIdatas("rem","cursor",true);
		end
		showChat(true);
	end
end)



--custom cursor
addEventHandler("onClientRender",root,function()
	if(isCursorShowing()and isConsoleActive()==false and isMainMenuActive()==false and isMTAWindowFocused())then
		local sX,sY,wX,wY,wZ=getCursorPosition();
		dxDrawImage((sX*GLOBALscreenX),(sY*GLOBALscreenY),32,32,":"..RESOURCE_NAME.."/Files/Images/Cursor.png",0,0,0,tocolor(255,255,255),true);
		setCursorAlpha(0);
	elseif(not(isMTAWindowFocused()))then
		setCursorAlpha(255);
	end
end)
addEventHandler("onClientResourceStop",resourceRoot,function()
	if(getCursorAlpha()<100)then
		setCursorAlpha(255);
	end
end)


--show mouse cursor
function getCursor()
	if(not(isLoggedin()))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	
	showCursor(not(isCursorShowing()));
end



--weather
addEvent("Sync->WeatherTime",true)
addEventHandler("Sync->WeatherTime",root,function(ID,hour,minute)
	if(ID)then
		setWeather(tonumber(ID));
		setTime(hour,minute);
	end
end)


--phonecell
local PHONECELL_SOUND=nil;
local PHONECELL_SOUND_2=nil;
addEventHandler("Phonecell->Sound",root,function(typ,x,y,z)
	if(typ=="Create")then
		if(x and y and z)then
			PHONECELL_SOUND=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Phonecell.mp3",x,y,z,true);
			setSoundMaxDistance(PHONECELL_SOUND,tonumber(50));
			setSoundVolume(PHONECELL_SOUND,0.6);
		end
	elseif(typ=="Create2")then
		if(x and y and z)then
			PHONECELL_SOUND_2=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Phonecell2.mp3",x,y,z,false);
			setSoundMaxDistance(PHONECELL_SOUND_2,tonumber(35));
			setSoundVolume(PHONECELL_SOUND_2,0.6);
		end
	elseif(typ=="Destroy")then
		if(isElement(PHONECELL_SOUND))then
			destroyElement(PHONECELL_SOUND);
			PHONECELL_SOUND=nil;
		end
		if(isElement(PHONECELL_SOUND_2))then
			destroyElement(PHONECELL_SOUND_2);
			PHONECELL_SOUND_2=nil;
		end
	end
end)