addRemoteEvents{"Shop->Skin->UI"};--addEvent


local IntPos={--INT x,y,z,rot, camX,camY,camZ, camToX,camToY,camToZ
	[5]={202.2,-4.1,1001.2,270, 205.7,-4.4,1001.4, 203.7,-4.2,1001.2},
};

local ClientPed=nil;
local ClientPedRotateTimer=nil;

addEventHandler("Shop->Skin->UI",root,function(typ,typ2)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedInVehicle(localPlayer))then
		return;
	end
	
	if(typ=="Open")then
		if(isClickedState(localPlayer)==true)then
			return;
		end
		local PlayerInterior=getElementInterior(localPlayer);
		--set UI stuff
		setUIdatas("set","cursor");
		--set/create client stuff
		if(isTimer(ClientPedRotateTimer))then
			killTimer(ClientPedRotateTimer);
			ClientPedRotateTimer=nil;
		end
		ClientPedRotateTimer=setTimer(function()
			local rotX,rotY,rotZ=getElementRotation(ClientPed);
			setElementRotation(ClientPed,0,0,rotZ+5);
		end,60,0);
		bindKey("SPACE","DOWN",bindKeyToggleSkinRotation);
		
		ClientPed=createPed(0,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4]);
		setElementInterior(ClientPed,PlayerInterior);
		setElementDimension(ClientPed,getElementDimension(localPlayer));
		setCameraMatrix(IntPos[PlayerInterior][5],IntPos[PlayerInterior][6],IntPos[PlayerInterior][7],IntPos[PlayerInterior][8],IntPos[PlayerInterior][9],IntPos[PlayerInterior][10]);
		
		GUI.Window[1]=dgsCreateWindow(10,GLOBALscreenY/2-600/2,400,600,SHOPS["Skin->"..typ2].Name,false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(365,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
		
		GUI.Tabpanel[1]=dgsCreateTabPanel(10,30,380,525,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
		
		dgsCreateLabel(100,5,200,20,loc("UI->Shop->Skin->Title"),false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,"center",_);
		if(typ2~="Exclusive")then
			--male
			GUI.Tab[1]=dgsCreateTab("Skins (Male)",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
			GUI.Grid[1]=dgsCreateGridList(10,10,360,420,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
			GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
			dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
			dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
			dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
			dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
			dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
			dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
			
			local skinID_Male=dgsGridListAddColumn(GUI.Grid[1],"ID",0.5);
			local skinPrice_Male=dgsGridListAddColumn(GUI.Grid[1],loc("UI->Shop->Price"),0.5);
			
			for _,v in pairs(SHOPS["Skin->"..typ2].Peds.Category["Normal"]["Male"])do
				local row=dgsGridListAddRow(GUI.Grid[1]);
				dgsGridListSetItemText(GUI.Grid[1],row,skinID_Male,v[1],false,false);
				dgsGridListSetItemText(GUI.Grid[1],row,skinPrice_Male,CURRENCY.." "..v[2],false,false);
			end
			
			GUI.Button[1]=dgsCreateButton(10,440,360,40,loc("UI->Shop->Skin->BTN"),false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true)
			
			--female
			GUI.Tab[2]=dgsCreateTab("Skins (Female)",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
			GUI.Grid[2]=dgsCreateGridList(10,10,360,420,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
			GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
			dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
			dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
			dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
			dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
			dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
			dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
			
			local skinID_Female=dgsGridListAddColumn(GUI.Grid[2],"ID",0.5);
			local skinPrice_Female=dgsGridListAddColumn(GUI.Grid[2],loc("UI->Shop->Price"),0.5);
			
			for _,v in pairs(SHOPS["Skin->"..typ2].Peds.Category["Normal"]["Female"])do
				local row=dgsGridListAddRow(GUI.Grid[2]);
				dgsGridListSetItemText(GUI.Grid[2],row,skinID_Female,v[1],false,false);
				dgsGridListSetItemText(GUI.Grid[2],row,skinPrice_Female,CURRENCY.." "..v[2],false,false);
			end
			
			GUI.Button[2]=dgsCreateButton(10,440,360,40,loc("UI->Shop->Skin->BTN"),false,GUI.Tab[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true)
			
			
			
			addEventHandler("onDgsMouseClick",GUI.Grid[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Grid[2])
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1)
							if(clicked~="")then
								local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(clicked);
								if(isCustom)then
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(mod.base_id,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4])
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
									
									local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
									setElementData(ClientPed,dataName,mod.id);
								else
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(clicked,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4]);
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
								end
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",GUI.Grid[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Grid[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1)
							if(clicked~="")then
								local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(clicked);
								if(isCustom)then
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(mod.base_id,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4])
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
									
									local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
									setElementData(ClientPed,dataName,mod.id);
								else
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(clicked,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4]);
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
								end
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",GUI.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
							if(clicked~="")then
								triggerServerEvent("Shop->Buy->Skin",localPlayer,"Female",tonumber(clicked),typ2);
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
							if(clicked~="")then
								triggerServerEvent("Shop->Buy->Skin",localPlayer,"Male",tonumber(clicked),typ2);
							end
						end
					end
				end,
			false)
			
			dgsGridListSetSortEnabled(GUI.Grid[1],false);
			dgsGridListSetSortEnabled(GUI.Grid[2],false);
			dgsSetProperty(GUI.Grid[1],"rowHeight",35);
			dgsSetProperty(GUI.Grid[2],"rowHeight",35);
		else
			--male
			GUI.Tab[1]=dgsCreateTab("Skins (Male)",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
			GUI.Grid[1]=dgsCreateGridList(10,10,360,420,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
			GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
			dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
			dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
			dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
			dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
			dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
			dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
			
			local skinID_Male=dgsGridListAddColumn(GUI.Grid[1],"ID",0.5);
			local skinPrice_Male=dgsGridListAddColumn(GUI.Grid[1],loc("UI->Shop->Price"),0.5);
			
			for _,v in pairs(SHOPS["Skin->"..typ2].Peds.Category["Normal"]["Male"])do
				local row=dgsGridListAddRow(GUI.Grid[1]);
				dgsGridListSetItemText(GUI.Grid[1],row,skinID_Male,v[1],false,false);
				dgsGridListSetItemText(GUI.Grid[1],row,skinPrice_Male,CURRENCY.." "..v[2],false,false);
			end
			
			GUI.Button[1]=dgsCreateButton(10,440,360,40,loc("UI->Shop->Skin->BTN"),false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true)
			
			--female
			GUI.Tab[2]=dgsCreateTab("Skins (Female)",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
			GUI.Grid[2]=dgsCreateGridList(10,10,360,420,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
			GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
			dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
			dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
			dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
			dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
			dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
			dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
			
			local skinID_Female=dgsGridListAddColumn(GUI.Grid[2],"ID",0.5);
			local skinPrice_Female=dgsGridListAddColumn(GUI.Grid[2],loc("UI->Shop->Price"),0.5);
			
			for _,v in pairs(SHOPS["Skin->"..typ2].Peds.Category["Normal"]["Female"])do
				local row=dgsGridListAddRow(GUI.Grid[2]);
				dgsGridListSetItemText(GUI.Grid[2],row,skinID_Female,v[1],false,false);
				dgsGridListSetItemText(GUI.Grid[2],row,skinPrice_Female,CURRENCY.." "..v[2],false,false);
			end
			
			GUI.Button[2]=dgsCreateButton(10,440,360,40,loc("UI->Shop->Skin->BTN"),false,GUI.Tab[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true)
			
			
			
			addEventHandler("onDgsMouseClick",GUI.Grid[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Grid[2])
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1)
							if(clicked~="")then
								local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(clicked);
								if(isCustom)then
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(mod.base_id,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4])
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
									
									local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
									setElementData(ClientPed,dataName,mod.id);
								else
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(clicked,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4]);
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
								end
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",GUI.Grid[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Grid[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1)
							if(clicked~="")then
								local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(clicked);
								if(isCustom)then
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(mod.base_id,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4])
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
									
									local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
									setElementData(ClientPed,dataName,mod.id);
								else
									if(isElement(ClientPed))then
										destroyElement(ClientPed);
										ClientPed=nil;
									end
									ClientPed=createPed(clicked,IntPos[PlayerInterior][1],IntPos[PlayerInterior][2],IntPos[PlayerInterior][3],IntPos[PlayerInterior][4]);
									setElementInterior(ClientPed,PlayerInterior);
									setElementDimension(ClientPed,getElementDimension(localPlayer));
								end
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",GUI.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
							if(clicked~="")then
								triggerServerEvent("Shop->Buy->Skin",localPlayer,"Female",tonumber(clicked),typ2);
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
							if(clicked~="")then
								triggerServerEvent("Shop->Buy->Skin",localPlayer,"Male",tonumber(clicked),typ2);
							end
						end
					end
				end,
			false)
			
			dgsGridListSetSortEnabled(GUI.Grid[1],false);
			dgsGridListSetSortEnabled(GUI.Grid[2],false);
			dgsSetProperty(GUI.Grid[1],"rowHeight",35);
			dgsSetProperty(GUI.Grid[2],"rowHeight",35);
		end
		
		
		
		
		
		addEventHandler("onDgsMouseClick",GUI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="down")then
					setUIdatas("rem","cursor",true);
					unbindKey("SPACE","down",bindKeyToggleSkinRotation);
					
					setCameraTarget(localPlayer);
					if(isElement(ClientPed))then
						destroyElement(ClientPed);
						ClientPed=nil;
					end
					if(isTimer(ClientPedRotateTimer))then
						killTimer(ClientPedRotateTimer);
						ClientPedRotateTimer=nil;
					end
				end
			end,
		false)
	elseif(typ=="Close")then
		if(isClickedState(localPlayer)==true)then
			setUIdatas("rem","cursor",true);
			unbindKey("SPACE","down",bindKeyToggleSkinRotation);
			
			setCameraTarget(localPlayer);
			if(isElement(ClientPed))then
				destroyElement(ClientPed);
				ClientPed=nil;
			end
			if(isTimer(ClientPedRotateTimer))then
				killTimer(ClientPedRotateTimer);
				ClientPedRotateTimer=nil;
			end
		end
	end
end)




function bindKeyToggleSkinRotation()
	if(isLoggedin())then
		if(isElement(ClientPed))then
			if(not(isTimer(ClientPedRotateTimer)))then
				ClientPedRotateTimer=setTimer(function()
					local rotX,rotY,rotZ=getElementRotation(ClientPed);
					setElementRotation(ClientPed,0,0,rotZ+5);
				end,60,0);
			else
				killTimer(ClientPedRotateTimer);
				ClientPedRotateTimer=nil;
			end
		end
	end
end