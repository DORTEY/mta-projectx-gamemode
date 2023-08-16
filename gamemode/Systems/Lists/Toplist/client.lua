addRemoteEvents{"Toplist->UI","Show->ToplistUI->Kills","Show->ToplistUI->Playtime"};--addEvent


addEventHandler("Toplist->UI",root,function(typ)
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
		
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-480/2,GLOBALscreenY/2-480/2,480,480,"Toplists",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(445,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
		
		GUI.Blurbox[1]=dgsCreateBlurBox(480,480);
		GUI.Blurbox[2]=dgsCreateImage(GLOBALscreenX/2-480/2,GLOBALscreenY/2-480/2,480,480,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		GUI.Tabpanel[1]=dgsCreateTabPanel(10,10,460,425,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
		
		--kills
		GUI.Tab[1]=dgsCreateTab("Kills",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		
		GUI.Grid[1]=dgsCreateGridList(10,10,440,370,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		listKillsName=dgsGridListAddColumn(GUI.Grid[1],"Name",0.65);
		listKillsAmount=dgsGridListAddColumn(GUI.Grid[1],"Amount",0.35);
		
		--playtime
		GUI.Tab[2]=dgsCreateTab("Playtime",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		
		GUI.Grid[2]=dgsCreateGridList(10,10,440,370,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
		dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
		
		listPlaytimeName=dgsGridListAddColumn(GUI.Grid[2],"Name",0.65);
		listPlaytimeAmount=dgsGridListAddColumn(GUI.Grid[2],"Amount",0.35);
		
		
		
		
		triggerServerEvent("Trigger->ToplistUI->Items",localPlayer,"Kills");
		triggerServerEvent("Trigger->ToplistUI->Items",localPlayer,"Playtime");
		
		
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		dgsGridListSetSortEnabled(GUI.Grid[2],false);
		dgsSetProperty(GUI.Grid[1],"rowHeight",35);
		dgsSetProperty(GUI.Grid[2],"rowHeight",35);
		
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


addEventHandler("Show->ToplistUI->Kills",root,function(typ,tbl)
	dgsGridListClear(GUI.Grid[1]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[1]);
		dgsGridListSetItemText(GUI.Grid[1],row,listKillsName,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,listKillsAmount,v[2],false,false);
	end
end)

addEventHandler("Show->ToplistUI->Playtime",root,function(typ,tbl)
	dgsGridListClear(GUI.Grid[2]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[2]);
		dgsGridListSetItemText(GUI.Grid[2],row,listPlaytimeName,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[2],row,listPlaytimeAmount,v[2],false,false);
	end
end)