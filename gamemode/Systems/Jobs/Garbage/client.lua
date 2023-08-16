addRemoteEvents{"Job->Garbage->UI","Job->Create->Garbage->Stuff","Job->Destroy->Garbage->Stuff"};--addEvent


local JOB_BLIPS={};
local JOB_OBJECTS={};

local JOB_MARKER=nil;
local JOB_MARKERS={};
local POSITIONS={
	[0]={
		[1]={1930.9,-2045.3,12.5},
		[2]={1890.7,-2043.3,12.5},
		[3]={1867.9,-2032.7,12.5},
		[4]={1829.9,-2015.5,12.5},
		[5]={1846.9,-1975.2,12.5},
		[6]={1954.3,-1966.0,12.6},
		[7]={1968.7,-2043.8,12.5},
		[8]={1923.9,-2059.9,12.5},
		[9]={1830.0,-2073.0,12.5},
		[10]={1934.0,-2159.2,12.5},
		[11]={1879.3,-2158.9,12.5},
		[12]={1786.9,-2108.4,12.3},
		[13]={1743.6,-2115.3,12.4},
		[14]={1920.8,-1966.0,12.5},
		[15]={1847.8,-1946.2,12.5},
		[16]={1916.3,-1946.1,12.5},
		[17]={1941.0,-1924.8,12.5},
		[18]={1881.1,-1924.7,12.5},
		[19]={1830.5,-1924.8,12.5},
		[20]={1810.0,-1885.9,12.4},
		[21]={1772.4,-1920.2,12.5},
		[22]={1765.5,-1945.2,12.5},
		[23]={1698.3,-1944.9,12.5},
	},
	[1]={
		[1]={2434.7,-1274.9,23.4},
		[2]={2436.5,-1289.2,23.7},
		[3]={2434.9,-1303.3,23.8},
		[4]={2435.1,-1320.6,23.8},
		[5]={2440.5,-1338.7,23.1},
		[6]={2440.8,-1357.0,23.0},
		[7]={2468.2,-1375.4,27.8},
		[8]={2476.4,-1366.9,27.8},
		[9]={2487.2,-1390.8,27.8},
		[10]={2473.1,-1390.9,27.8},
		[11]={2487.2,-1409.7,27.8},
		[12]={2495.4,-1399.6,27.8},
		[13]={2495.3,-1375.3,27.8},
		[14]={2468.7,-1295.4,28.9},
		[15]={2467.7,-1278.4,28.9},
		[16]={2493.3,-1240.2,36.5},
		[17]={2472.9,-1240.0,31.2},
		[18]={2386.5,-1279.6,23.6},
		[19]={2386.0,-1328.0,23.6},
		[20]={2388.0,-1346.3,23.6},
		[21]={2381.3,-1366.3,23.0},
		[22]={2476.2,-1409.1,27.8},
		[23]={2495.4,-1423.3,27.8},
	},
};
local MarkerPositions=nil;
local TrashObjects={
	[1]={849},
	[2]={854},
	[3]={851},
};

local JOB_PLAYER_ELEMENT_MARKER=nil;
local JOB_PLAYER_ELEMENT_OBJECT=nil;

function createGarbageMarker(typ)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	
	MarkerAmount=0;
	
	if(typ=="Step->1")then--start marker
		JOB_MARKER=createMarker(2104.2,-2037.2,12.5,"cylinder",1.5,220,220,0,100);
		
		JOB_BLIPS[JOB_MARKER]=createBlip(2104.2,-2037.2,12.5,0,20,220,220,0,255,0);
		setElementData(JOB_BLIPS[JOB_MARKER],"tooltipText","Job Mark");
		
		addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
			if(elem==localPlayer and dim)then
				if(not(isPedInVehicle(localPlayer)))then
					triggerServerEvent("Job->Start->Garbage",localPlayer);
					destroyElement(source);
					
					destroyElement(JOB_BLIPS[JOB_MARKER]);
					JOB_BLIPS[JOB_MARKER]=nil;
				end
			end
		end)
	elseif(typ==0 or typ==1 or typ==2)then
		if(not(isElement(JOB_MARKER)))then--unload vehicle
			JOB_MARKER=createMarker(2107.8,-2011.0,12.5,"cylinder",2.5,0,220,0,100);
			
			JOB_BLIPS[JOB_MARKER]=createBlip(2107.8,-2011.0,12.5,0,20,0,220,0,255,0);
			setElementData(JOB_BLIPS[JOB_MARKER],"tooltipText","Unloading point");
			
			addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
				if(elem==localPlayer and dim)then
					if(isPedInVehicle(localPlayer))then
						local veh=getPedOccupiedVehicle(localPlayer);
						if(veh and isElement(veh))then
							if(getElementData(veh,"Veh->Data->VehID")==JOBS["Garbage"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
								triggerServerEvent("Job->GiveReward",localPlayer);
							end
						end
					end
				end
			end)
		end
		
		MarkerPositions=POSITIONS[tonumber(typ)];
		
		for i=1,#MarkerPositions,1 do
			JOB_MARKERS[i]=createMarker(MarkerPositions[i][1],MarkerPositions[i][2],MarkerPositions[i][3],"cylinder",1.5,220,220,0,0);
			setElementDimension(JOB_MARKERS[i],0);
			setElementInterior(JOB_MARKERS[i],0);
			MarkerAmount=i;
			
			JOB_BLIPS[JOB_MARKERS[i]]=createBlip(MarkerPositions[i][1],MarkerPositions[i][2],MarkerPositions[i][3],0,17,220,220,0,255,0);
			setElementData(JOB_BLIPS[JOB_MARKERS[i]],"tooltipText","Job Mark");
			
			if(tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))==0)then
				JOB_OBJECTS[JOB_MARKERS[i]]=createObject(TrashObjects[math.random(1,#TrashObjects)][1],MarkerPositions[i][1],MarkerPositions[i][2],MarkerPositions[i][3]+0.3,0,0,0,true);
				table.insert(JOB_OBJECTS,JOB_OBJECTS[JOB_MARKERS[i]]);
			else
				JOB_OBJECTS[JOB_MARKERS[i]]=createObject(1265,MarkerPositions[i][1],MarkerPositions[i][2],MarkerPositions[i][3]+0.4,0,0,0,true);
			end
			
			addEventHandler("onClientMarkerHit",JOB_MARKERS[i],function(elem,dim)
				if(elem==localPlayer and dim)then
					if(tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))==0)then
						if(isPedInVehicle(localPlayer))then
							local veh=getPedOccupiedVehicle(localPlayer);
							if(veh and isElement(veh))then
								if(getElementData(veh,"Veh->Data->VehID")==JOBS["Garbage"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
									destroyElement(source);
									destroyElement(JOB_BLIPS[source]);
									destroyElement(JOB_OBJECTS[source]);
									
									triggerServerEvent("Job->Garbage->Fill->Vehicle",localPlayer);
								end
							end
						end
					else
						if(not(isPedInVehicle(localPlayer)))then
							JOB_PLAYER_ELEMENT_OBJECT=source;
							bindKey("X","down",pickupTrash);
							triggerEvent("Infobox->UI",localPlayer,"info",loc("Job->Garbage->PickupInfo"));
						else
							triggerEvent("Infobox->UI",localPlayer,"error",loc(client,"Vehicle->LeaveBefore"));
						end
					end
				end
			end)
			addEventHandler("onClientMarkerLeave",JOB_MARKERS[i],function(elem,dim)
				if(elem==localPlayer and dim)then
					if(tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))>0)then
						if(not(isPedInVehicle(localPlayer)))then
							unbindKey("X","down",pickupTrash);
						end
					end
				end
			end)
		end
	end
end
addEventHandler("Job->Create->Garbage->Stuff",root,createGarbageMarker)


addEventHandler("Job->Destroy->Garbage->Stuff",root,function()
	if(not(isLoggedin()))then
		return;
	end
	
	--blips
	if(isElement(JOB_BLIPS[JOB_MARKER]))then
		destroyElement(JOB_BLIPS[JOB_MARKER]);
		JOB_BLIPS[JOB_MARKER]=nil;
	end
	for i=1,#MarkerPositions,1 do
		if(isElement(JOB_BLIPS[JOB_MARKERS[i]]))then
			destroyElement(JOB_BLIPS[JOB_MARKERS[i]]);
			JOB_BLIPS[JOB_MARKERS[i]]=nil;
		end
	end
	
	--marker
	if(isElement(JOB_MARKER))then
		destroyElement(JOB_MARKER);
		JOB_MARKER=nil;
	end
	for i=1,#MarkerPositions,1 do
		if(isElement(JOB_MARKERS[i]))then
			destroyElement(JOB_MARKERS[i]);
			JOB_MARKERS[i]=nil;
		end
	end
	if(isElement(JOB_PLAYER_ELEMENT_MARKER))then
		destroyElement(JOB_PLAYER_ELEMENT_MARKER);
		JOB_PLAYER_ELEMENT_MARKER=nil;
	end
	
	--objects
	for i,v in ipairs(JOB_OBJECTS)do
		table.removevalue(JOB_OBJECTS,i);
		if(isElement(v))then
			destroyElement(v);
		end
	end
	if(isElement(JOB_PLAYER_ELEMENT_OBJECT))then
		destroyElement(JOB_PLAYER_ELEMENT_OBJECT);
		JOB_PLAYER_ELEMENT_OBJECT=nil;
	end
	
	--unbind keys
	unbindKey("X","down",pickupTrash);
	unbindKey("X","down",deliverTrash);
end)


function pickupTrash()
	if(not(isElement(JOB_PLAYER_ELEMENT_MARKER)))then
		destroyElement(JOB_PLAYER_ELEMENT_OBJECT);
		destroyElement(JOB_BLIPS[JOB_PLAYER_ELEMENT_OBJECT]);
		destroyElement(JOB_OBJECTS[JOB_PLAYER_ELEMENT_OBJECT]);
		JOB_PLAYER_ELEMENT_OBJECT=nil;
		
		JOB_PLAYER_ELEMENT_MARKER=createObject(1265,0,0,0);
		attachElementToBone(JOB_PLAYER_ELEMENT_MARKER,localPlayer,12,0,0.02,0.24,0,-200,0);
		setObjectScale(JOB_PLAYER_ELEMENT_MARKER,0.6);
		
		unbindKey("X","down",pickupTrash);
		bindKey("X","down",deliverTrash);
		
		triggerEvent("Infobox->UI",localPlayer,"info",loc("Job->Garbage->DeliverInfo"));
	end
end
function deliverTrash()
	if(isElement(JOB_PLAYER_ELEMENT_MARKER))then
		local veh=GetNearestGarbageVehicle(localPlayer);
		if(veh~=false)then
			if(getElementData(veh,"Veh->Data->VehID")==JOBS["Garbage"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
				if(getElementData(veh,"Veh->Data->Owner")==getPlayerName(localPlayer))then
					table.removevalue(JOB_OBJECTS,JOB_PLAYER_ELEMENT_OBJECT);
					destroyElement(JOB_PLAYER_ELEMENT_MARKER);
					JOB_PLAYER_ELEMENT_MARKER=nil;
					
					unbindKey("X","down",deliverTrash);
					
					triggerServerEvent("Job->Garbage->Fill->Vehicle",localPlayer);
				end
			end
		end
	end
end



addEventHandler("onClientVehicleStartEnter",root,function(player)
	if(player==localPlayer)then
		if(getElementData(source,"Veh->Data->Job"))then
			if(getElementData(source,"Veh->Data->Job->Garbage")==true)then
				if(tostring(getElementData(source,"Veh->Data->Owner"))~=getPlayerName(localPlayer))then
					triggerEvent("Infobox->UI",localPlayer,"error","You cant enter others Job vehicle!");
					cancelEvent();
				end
			end
		end
	end
end)


addEventHandler("Job->Garbage->UI",root,function(typ)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isPedInVehicle(localPlayer))then
		return;
	end
	
	if(typ=="Open")then
		if(isClickedState(localPlayer)==true)then
			return;
		end
		--set UI stuff
		setUIdatas("set","cursor",true);
		dgsSetInputMode("no_binds");
		dgsSetInputMode("no_binds_when_editing");
		
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,"Garbage Job",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(465,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
		
		--skin selection
		GUI.Grid[1]=dgsCreateGridList(410,10,80,285,false,GUI.Window[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		local pedID=dgsGridListAddColumn(GUI.Grid[1],"ID",1);
		
		for i,v in pairs(JOBS["Garbage"].Peds[1])do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,pedID,v,false,false);
		end
		
		
		GUI.Button[1]=dgsCreateButton(10,365,480,40,"Join Job",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button[2]=dgsCreateButton(10,415,480,40,"Leave Job",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Red1,GUI.Color.Button.Red2,GUI.Color.Button.Red3,true);
		
		
		
		dgsSetProperty(GUI.Grid[1],"rowHeight",35);
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					triggerServerEvent("Job->Leave",localPlayer);
					setUIdatas("rem","cursor",true);
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local itemAmount=dgsGridListGetSelectedItem(GUI.Grid[1])
					if(itemAmount>0)then
						local item=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						triggerServerEvent("Job->Join",localPlayer,"Garbage",tonumber(item));
						setUIdatas("rem","cursor",true);
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