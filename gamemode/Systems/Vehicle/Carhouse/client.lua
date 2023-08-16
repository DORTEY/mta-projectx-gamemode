addRemoteEvents{"Vehicle->Carhouse->UI","Show->VehicleCarhouseUI->Items"};--addEvent


local CAM_POSITION={3346.2,-2102.2,1366.4, 3355.7,-2102.2,1364.5};--startX,startY,startZ, spawnX,spawnY,spawnZ
local ELEMENT=nil;
local ELEMENT_ROT_TIMER=nil;


addEventHandler("Vehicle->Carhouse->UI",root,function(typ,typ2)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	
	if(typ=="Open")then
		if(isClickedState(localPlayer)==true)then
			return;
		end
		
		setUIdatas("set","cursor");
		
		GUI.Window[1]=dgsCreateWindow(10,GLOBALscreenY/2-480/2,400,480,"Carhouse",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(365,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
		
		setElementFrozen(localPlayer,true);
		setCameraMatrix(CAM_POSITION[1],CAM_POSITION[2],CAM_POSITION[3], CAM_POSITION[4],CAM_POSITION[5],CAM_POSITION[6]);
		ELEMENT_ROT_TIMER=setTimer(function()
			if(isElement(ELEMENT))then
				local rotX,rotY,rotZ=getElementRotation(ELEMENT);
				setElementRotation(ELEMENT,0,0,rotZ+4);
			end
		end,20,0);
		
		GUI.Blurbox[1]=dgsCreateBlurBox(400,480);
		GUI.Blurbox[2]=dgsCreateImage(10,GLOBALscreenY/2-480/2,400,480,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		GUI.Grid[1]=dgsCreateGridList(10,10,380,380,false,GUI.Window[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		vehID=dgsGridListAddColumn(GUI.Grid[1],"ID",0.14);
		vehName=dgsGridListAddColumn(GUI.Grid[1],"Vehicle",0.45);
		vehPrice=dgsGridListAddColumn(GUI.Grid[1],"Price",0.18);
		vehLevel=dgsGridListAddColumn(GUI.Grid[1],"Level",0.10);
		vehSpeed=dgsGridListAddColumn(GUI.Grid[1],"Speed",0.10);
		
		
		GUI.Button[1]=dgsCreateButton(10,400,380,35,"Buy vehicle",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		triggerServerEvent("Trigger->VehicleCarhouseUI->Items",localPlayer,typ2);
		
		
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		dgsSetProperty(GUI.Grid[1],"rowHeight",35);
		
		
		addEventHandler("onDgsMouseClick",GUI.Grid[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						if(clicked and clicked~="")then
							if(isElement(ELEMENT))then
								destroyElement(ELEMENT);
								ELEMENT=nil;
							end
							
							local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(clicked);
							if(isCustom)then
								ELEMENT=createVehicle(mod.base_id,CAM_POSITION[4],CAM_POSITION[5],CAM_POSITION[6]);
								local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
								setElementData(ELEMENT,dataName,mod.id);
							else
								ELEMENT=createVehicle(clicked,CAM_POSITION[4],CAM_POSITION[5],CAM_POSITION[6]);
							end
							setElementFrozen(ELEMENT,true);
							setVehicleColor(ELEMENT,255,255,255, 255,255,255);
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
							triggerServerEvent("Buy->Vehicle",localPlayer,tonumber(clicked),typ2);
						end
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(isElement(ELEMENT))then
						destroyElement(ELEMENT);
						ELEMENT=nil;
					end
					if(isTimer(ELEMENT_ROT_TIMER))then
						killTimer(ELEMENT_ROT_TIMER);
						ELEMENT_ROT_TIMER=nil;
					end
					setElementFrozen(localPlayer,false);
					setCameraTarget(localPlayer);
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

addEventHandler("Show->VehicleCarhouseUI->Items",root,function(tbl)
	dgsGridListClear(GUI.Grid[1]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[1]);
		dgsGridListSetItemText(GUI.Grid[1],row,vehID,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehName,v[4],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehPrice,v[2],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehLevel,v[3],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehSpeed,v[5],false,false);
	end
end)