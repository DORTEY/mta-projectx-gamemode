addRemoteEvents{"Vehicle->UI","Show->VehicleUI->Items","Vehicle->PlayHorn","Vehicle->StopHorn"};--addEvent


addEventHandler("Vehicle->UI",root,function(typ)
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
		
		setUIdatas("set","cursor");
		
		GUI.Window[1]=dgsCreateWindow(10,GLOBALscreenY/2-480/2,300,480,"Vehicle menu",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		
		GUI.Blurbox[1]=dgsCreateBlurBox(300,480);
		GUI.Blurbox[2]=dgsCreateImage(10,GLOBALscreenY/2-480/2,300,480,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		GUI.Grid[1]=dgsCreateGridList(10,10,280,335,false,GUI.Window[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		vID=dgsGridListAddColumn(GUI.Grid[1],"",0);
		vehID=dgsGridListAddColumn(GUI.Grid[1],"ID",0.2);
		vehName=dgsGridListAddColumn(GUI.Grid[1],"Vehicle",0.50);
		vehHealth=dgsGridListAddColumn(GUI.Grid[1],"HP",0.17);
		
		
		GUI.Button[1]=dgsCreateButton(10,355,130,35,"Spawn",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button[2]=dgsCreateButton(155,355,130,35,"Despawn",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button[3]=dgsCreateButton(10,400,130,35,"Sell Vehicle",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button[4]=dgsCreateButton(155,400,130,35,"Despawn all",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		triggerServerEvent("Trigger->VehicleUI->Items",localPlayer);
		
		
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		dgsSetProperty(GUI.Grid[1],"rowHeight",35);
		
		
		addEventHandler("onDgsMouseDoubleClick",GUI.Grid[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						if(clicked and clicked~="")then
							triggerServerEvent("Spawn->Vehicle",localPlayer,tonumber(clicked));
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[4],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Despawn->Vehicle",localPlayer,"All");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						local clicked2=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),2);
						if(not(VEHICLE.NotSellAble[tonumber(clicked2)]))then
							if(clicked and clicked~="")then
								if(not(isElement(GUI.Window[2])))then
									GUI.Window[2]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,"Vehicle sell",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
									dgsWindowSetSizable(GUI.Window[2],false);
									dgsWindowSetMovable(GUI.Window[2],false);
									dgsSetProperty(GUI.Window[2],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
									
									GUI.Blurbox[3]=dgsCreateBlurBox(300,300);
									GUI.Blurbox[4]=dgsCreateImage(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,GUI.Blurbox[3],false);
									dgsAttachElements(GUI.Blurbox[4],GUI.Window[2],0,0,1,1,true,true);
									dgsSetLayer(GUI.Blurbox[4],"bottom");
									
									if(VEHICLE.NAMES[tonumber(clicked2)])then
										Carname=VEHICLE.NAMES[tonumber(clicked2)];
									else
										Carname=getVehicleNameFromModel(tonumber(clicked2));
									end
									
									dgsCreateLabel(10,10,100,20,"Are you sure that you want to sell your\n"..Carname.." for "..CURRENCY..VEHICLE.PRICES[tonumber(clicked2)]/100*VEHICLE.SellPercent.."?\nthats 80% of the original price.",false,GUI.Window[2],tocolor(255,255,255,255),1.2,1.2);
									
									GUI.Button["BTN->Sell"]=dgsCreateButton(10,175,280,35,"Sell it",false,GUI.Window[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
									GUI.Button["BTN->Decline"]=dgsCreateButton(10,220,280,35,"Decline",false,GUI.Window[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Red1,GUI.Color.Button.Red2,GUI.Color.Button.Red3,true);
									
									addEventHandler("onDgsMouseClick",GUI.Button["BTN->Decline"],
										function(btn,state)
											if(btn=="left" and state=="down")then
												if(isElement(GUI.Blurbox[3]))then
													dgsAttachToAutoDestroy(GUI.Blurbox[3],GUI.Window[2]);
													dgsAttachToAutoDestroy(GUI.Blurbox[4],GUI.Window[2]);
												end
												if(isElement(GUI.Window[2]))then
													destroyElement(GUI.Window[2]);
												end
											end
										end,
									false)
									addEventHandler("onDgsMouseClick",GUI.Button["BTN->Sell"],
										function(btn,state)
											if(btn=="left" and state=="up")then
												local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
												if(item>0)then
													local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
													local clicked2=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),2);
													if(clicked and clicked~="")then
														triggerServerEvent("Sell->Vehicle",localPlayer,tonumber(clicked));
														if(isElement(GUI.Blurbox[3]))then
															dgsAttachToAutoDestroy(GUI.Blurbox[3],GUI.Window[2]);
															dgsAttachToAutoDestroy(GUI.Blurbox[4],GUI.Window[2]);
														end
														if(isElement(GUI.Window[2]))then
															destroyElement(GUI.Window[2]);
														end
														triggerServerEvent("Trigger->VehicleUI->Items",localPlayer);
													end
												end
											end
										end,
									false)
								end
							end
						else
							triggerEvent("Infobox->UI",localPlayer,"error","You cant sell this vehicle!");
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						if(clicked and clicked~="")then
							triggerServerEvent("Despawn->Vehicle",localPlayer,"Selected",tonumber(clicked));
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
							triggerServerEvent("Spawn->Vehicle",localPlayer,tonumber(clicked));
						end
					end
				end
			end,
		false)
	elseif(typ=="Close")then
		if(isClickedState(localPlayer)==true)then
			setUIdatas("rem","cursor",true);
		end
	end
end)

addEventHandler("Show->VehicleUI->Items",root,function(tbl)
	dgsGridListClear(GUI.Grid[1]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[1]);
		
		if(v[4]>750)then
			dgsGridListSetItemColor(GUI.Grid[1],row,vehHealth,0,150,0,255);
		elseif(v[4]<350)then
			dgsGridListSetItemColor(GUI.Grid[1],row,vehHealth,180,0,0,255);
		elseif(v[4]<450)then
			dgsGridListSetItemColor(GUI.Grid[1],row,vehHealth,150,40,0,255);
		elseif(v[4]<750)then
			dgsGridListSetItemColor(GUI.Grid[1],row,vehHealth,150,150,0,255);
		end
		
		dgsGridListSetItemText(GUI.Grid[1],row,vID,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehID,v[2],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehName,v[3],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,vehHealth,v[4],false,false);
	end
end)




addEventHandler("onClientVehicleStartEnter",root,function(player,seat)
	if(player==localPlayer and seat==0)then
		if(getElementData(source,"Veh->Data->Typ")=="Team")then
			if(getElementData(source,"Veh->Data->Owner")~=getElementData(localPlayer,"Player->Data->Team"))then
				triggerEvent("Infobox->UI",localPlayer,"error",loc("Vehicle->NoPerms"):format(getElementData(source,"Veh->Data->Owner")));
				cancelEvent();
			end
		end
		if(isVehicleLocked(source)==true)then
			triggerEvent("Infobox->UI",localPlayer,"error","This vehicle is locked!");
			cancelEvent();
		end
	end
end)


local function updateWheelScale(veh)
	if(veh and isElement(veh))then
		if(getElementData(veh,"Veh->Data->VehID")==80000)then
			setVehicleWheelScale(veh,0.8);
		end
	end
end
addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle")then
		updateWheelScale(source);
	end
end)



addEventHandler("Vehicle->PlayHorn",root,function(player)
	if(player and isElement(player))then
		if(isPedInVehicle(player))then
			local veh=getPedOccupiedVehicle(player,0);
			if(veh and isElement(veh))then
				local HORN=tonumber(getElementData(veh,"Veh->Data->Horn"))or nil;
				if(HORN and HORN>0)then
					if(not(isElement(HORNS[veh])))then
						local x,y,z=getElementPosition(veh);
						HORNS[veh]=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/Vehicle/Horns/"..tostring(HORN)..".mp3",x,y,z,true);
						setSoundMinDistance(HORNS[veh],0);
						setSoundMaxDistance(HORNS[veh],35);
						attachElements(HORNS[veh],veh);
					end
				end
			end
		end
	end
end)
addEventHandler("Vehicle->StopHorn",root,function(veh)
	if(veh)then
		if(isElement(HORNS[veh]))then
			destroyElement(HORNS[veh]);
			HORNS[veh]=nil;
		end
	end
end)