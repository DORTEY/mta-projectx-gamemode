addRemoteEvents{"Show->AdminUI->Bans","Show->AdminUI->ADs"};--addEvent


addCommandHandler("pos",function()
	if(not(isLoggedin()))then
		return;
	end
	if(tonumber(getElementData(localPlayer,"AdminLevel"))<4)then
		return;
	end
	
	local x,y,z=getElementPosition(localPlayer)
	local xr,yr,zr=getElementRotation(localPlayer)
	outputChatBox("Your Position: "..x..", " ..y..", " ..z,239,100,0,true)
	outputChatBox("Your Rotation: "..xr..", " ..yr..", " ..zr,239,100,0,true)
	
	setClipboard(x..","..y..","..z)
end)

addCommandHandler("dev",function()
	if(not(isLoggedin()))then
		return;
	end
	if(tonumber(getElementData(localPlayer,"AdminLevel"))<4)then
		return;
	end
	local boolean=not getDevelopmentMode();
	setDevelopmentMode(boolean);
end)



bindKey("F10","down",function()
	if(not(isLoggedin()))then
		return;
	end
	if(tonumber(getElementData(localPlayer,"AdminLevel"))<1)then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	
	setUIdatas("set","cursor",true);
	dgsSetInputMode("no_binds");
	dgsSetInputMode("no_binds_when_editing");
	if(isElement(GUI.Window[1]))then
		destroyElement(GUI.Window[1]);
		setUIdatas("rem","cursor",true);
	end
	GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-650/2,GLOBALscreenY/2-480/2,650,480,"Admin menu",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
	dgsWindowSetSizable(GUI.Window[1],false);
	dgsWindowSetMovable(GUI.Window[1],false);
	dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
	GUI.Button["Close"]=dgsCreateButton(615,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
	
	GUI.Blurbox[1]=dgsCreateBlurBox(650,480);
	GUI.Blurbox[2]=dgsCreateImage(GLOBALscreenX/2-650/2,GLOBALscreenY/2-480/2,650,480,GUI.Blurbox[1],false);
	dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
	dgsSetLayer(GUI.Blurbox[2],"bottom");
	
	GUI.Tabpanel[1]=dgsCreateTabPanel(10,10,630,425,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
	--players
	GUI.Tab[1]=dgsCreateTab("Players",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Edit["Search->Player"]=dgsCreateEdit(10,10,160,30,"",false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	GUI.Grid[1]=dgsCreateGridList(10,50,160,330,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
	dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
	
	local players=dgsGridListAddColumn(GUI.Grid[1],"Player",1);
	
	for _,v in ipairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,players,getPlayerName(v),false,false);
		end
	end
	
	GUI.Button["Kick->Player"]=dgsCreateButton(180,10,140,30,"Kick player",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Ban->Temp->Player"]=dgsCreateButton(330,10,140,30,"Ban player (temp)",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Ban->Perm->Player"]=dgsCreateButton(480,10,140,30,"Ban player (perm)",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Goto->Player"]=dgsCreateButton(180,50,140,30,"Goto player",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Gethere->Player"]=dgsCreateButton(330,50,140,30,"Gethere player",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Freeze->Player"]=dgsCreateButton(480,50,140,30,"Freeze player",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Repair->PlayerVeh"]=dgsCreateButton(180,90,140,30,"Repair vehicle",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Clear->Chat"]=dgsCreateButton(330,90,140,30,"Clear chat",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Give->Player->Coins"]=dgsCreateButton(180,170,140,30,"Give coins",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Give->Player->Money"]=dgsCreateButton(330,170,140,30,"Give money",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	
	
	GUI.Edit[1]=dgsCreateEdit(180,345,215,35,"",false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	GUI.Edit[2]=dgsCreateEdit(405,345,215,35,"",false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	GUI.Edit[3]=dgsCreateEdit(180,300,215,35,"",false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	
	--banlist
	GUI.Tab[2]=dgsCreateTab("Banlist",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Grid[2]=dgsCreateGridList(10,10,610,330,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
	dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
	
	banlist_BannedBy=dgsGridListAddColumn(GUI.Grid[2],"Admin",0.25);
	banlist_TargetName=dgsGridListAddColumn(GUI.Grid[2],"Player",0.25);
	banlist_TargetSerial=dgsGridListAddColumn(GUI.Grid[2],"Serial",0);
	banlist_Reason=dgsGridListAddColumn(GUI.Grid[2],"Reason",0.33);
	banlist_Time=dgsGridListAddColumn(GUI.Grid[2],"Time",0.2);
	
	GUI.Edit["Search->Player->Banlist"]=dgsCreateEdit(10,350,140,30,"",false,GUI.Tab[2],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	
	GUI.Button["Unban->Player"]=dgsCreateButton(160,350,140,30,"Unban player",false,GUI.Tab[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	
	--ad list
	GUI.Tab[3]=dgsCreateTab("AD list",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Grid[3]=dgsCreateGridList(10,10,610,330,false,GUI.Tab[3],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[3]=dgsGridListGetScrollBar(GUI.Grid[3]);
	dgsSetProperty(GUI.Scroll[3],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[3],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[3],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[3],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[3],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[3],"scrollBarThick",0);
	
	adlist_TargetName=dgsGridListAddColumn(GUI.Grid[3],"Player",0.22);
	adlist_TargetMessage=dgsGridListAddColumn(GUI.Grid[3],"Message",0.75);
	
	GUI.Button["ADlist->Clear"]=dgsCreateButton(10,350,140,30,"Clear list",false,GUI.Tab[3],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	
	--server
	GUI.Tab[4]=dgsCreateTab("Server",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Button["Password->Server"]=dgsCreateButton(10,10,140,30,"Set Password",false,GUI.Tab[4],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["Kick->Player->All"]=dgsCreateButton(160,10,140,30,"Kick all",false,GUI.Tab[4],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	GUI.Button["GenerateCode"]=dgsCreateButton(310,10,140,30,"Generate Code",false,GUI.Tab[4],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	
	
	GUI.Edit[30]=dgsCreateEdit(10,340,200,40,"",false,GUI.Tab[4],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	
	--events
	GUI.Tab[5]=dgsCreateTab("Events",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Grid[5]=dgsCreateGridList(10,10,160,370,false,GUI.Tab[5],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[5]=dgsGridListGetScrollBar(GUI.Grid[5]);
	dgsSetProperty(GUI.Scroll[5],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[5],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[5],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[5],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[5],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[5],"scrollBarThick",0);
	
	
	local eventID=dgsGridListAddColumn(GUI.Grid[5],"",0);
	local eventName=dgsGridListAddColumn(GUI.Grid[5],"Event",1);
	
	for i,v in ipairs(EVENTS)do
		local row=dgsGridListAddRow(GUI.Grid[5]);
		dgsGridListSetItemText(GUI.Grid[5],row,eventID,i,false,false);
		dgsGridListSetItemText(GUI.Grid[5],row,eventName,EVENTS[i].Name,false,false);
	end
	
	GUI.Button["Event->Start"]=dgsCreateButton(180,10,140,30,"Start/Stop",false,GUI.Tab[5],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	
	
	
	
	triggerServerEvent("Trigger->AdminUI->Bans",localPlayer,"All");
	triggerServerEvent("Trigger->AdminUI->ADs",localPlayer);
	
	dgsSetProperty(GUI.Grid[1],"rowHeight",30);
	dgsSetProperty(GUI.Grid[2],"rowHeight",30);
	dgsSetProperty(GUI.Grid[3],"rowHeight",30);
	dgsSetProperty(GUI.Grid[5],"rowHeight",30);
	dgsGridListSetSortEnabled(GUI.Grid[1],false);
	dgsGridListSetSortEnabled(GUI.Grid[2],false);
	dgsGridListSetSortEnabled(GUI.Grid[3],false);
	dgsGridListSetSortEnabled(GUI.Grid[5],false);
	dgsSetProperty(GUI.Edit[1],"placeHolder","Reason");
	dgsSetProperty(GUI.Edit[2],"placeHolder","Time/Amount");
	dgsSetProperty(GUI.Edit[3],"placeHolder","Player name (offline bans)");
	dgsSetProperty(GUI.Edit["Search->Player"],"placeHolder","Player name");
	dgsSetProperty(GUI.Edit["Search->Player->Banlist"],"placeHolder","Player name");
	
	addEventHandler("onDgsTextChange",GUI.Edit["Search->Player"],function()
		dgsGridListClear(GUI.Grid[1]);
		local text=dgsGetText(GUI.Edit["Search->Player"]);
		if(text=="")then
			for _,v in ipairs(getElementsByType("player"))do
				if(isLoggedin(v))then
					local row=dgsGridListAddRow(GUI.Grid[1]);
					dgsGridListSetItemText(GUI.Grid[1],row,players,getPlayerName(v),false,false);
				end
			end
		else
			for _,v in ipairs(getElementsByType("player"))do
				if(string.find(string.upper(getPlayerName(v)),string.upper(text),1,true))then
					if(isLoggedin(v))then
						local row=dgsGridListAddRow(GUI.Grid[1]);
						dgsGridListSetItemText(GUI.Grid[1],row,players,getPlayerName(v),false,false);
					end
				end
			end
		end
	end,false)
	
	addEventHandler("onDgsTextChange",GUI.Edit["Search->Player->Banlist"],function()
		dgsGridListClear(GUI.Grid[2]);
		local text=dgsGetText(GUI.Edit["Search->Player->Banlist"]);
		if(text=="")then
			triggerServerEvent("Trigger->AdminUI->Bans",localPlayer,"All");
		else
			triggerServerEvent("Trigger->AdminUI->Bans",localPlayer,"Specific",text);
		end
	end,false)
	
	
	
	--permission check
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Kick==true)then--kick
		dgsSetEnabled(GUI.Button["Kick->Player"],true);
		dgsSetProperty(GUI.Button["Kick->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Kick->Player"],false);
		dgsSetProperty(GUI.Button["Kick->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.BanTemp==true)then--temp ban
		dgsSetEnabled(GUI.Button["Ban->Temp->Player"],true);
		dgsSetProperty(GUI.Button["Ban->Temp->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Ban->Temp->Player"],false);
		dgsSetProperty(GUI.Button["Ban->Temp->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.BanPerm==true)then--perm ban
		dgsSetEnabled(GUI.Button["Ban->Perm->Player"],true);
		dgsSetProperty(GUI.Button["Ban->Perm->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Ban->Perm->Player"],false);
		dgsSetProperty(GUI.Button["Ban->Perm->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Goto==true)then--goto
		dgsSetEnabled(GUI.Button["Goto->Player"],true);
		dgsSetProperty(GUI.Button["Goto->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Goto->Player"],false);
		dgsSetProperty(GUI.Button["Goto->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Gethere==true)then--get here
		dgsSetEnabled(GUI.Button["Gethere->Player"],true);
		dgsSetProperty(GUI.Button["Gethere->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Gethere->Player"],false);
		dgsSetProperty(GUI.Button["Gethere->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Freeze==true)then--freeze
		dgsSetEnabled(GUI.Button["Freeze->Player"],true);
		dgsSetProperty(GUI.Button["Freeze->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Freeze->Player"],false);
		dgsSetProperty(GUI.Button["Freeze->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.RepairVeh==true)then--repair veh
		dgsSetEnabled(GUI.Button["Repair->PlayerVeh"],true);
		dgsSetProperty(GUI.Button["Repair->PlayerVeh"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Repair->PlayerVeh"],false);
		dgsSetProperty(GUI.Button["Repair->PlayerVeh"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.ClearChat==true)then--clear chat
		dgsSetEnabled(GUI.Button["Clear->Chat"],true);
		dgsSetProperty(GUI.Button["Clear->Chat"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Clear->Chat"],false);
		dgsSetProperty(GUI.Button["Clear->Chat"],"disabledColor",tocolor(150,0,0,200));
	end
	
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.GiveItem==true)then--givem item
		dgsSetEnabled(GUI.Button["Give->Player->Money"],true);
		dgsSetProperty(GUI.Button["Give->Player->Money"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Give->Player->Money"],false);
		dgsSetProperty(GUI.Button["Give->Player->Money"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.GiveItemCoins==true)then--givem coins
		dgsSetEnabled(GUI.Button["Give->Player->Coins"],true);
		dgsSetProperty(GUI.Button["Give->Player->Coins"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Give->Player->Coins"],false);
		dgsSetProperty(GUI.Button["Give->Player->Coins"],"disabledColor",tocolor(150,0,0,200));
	end
	
	
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Unban==true)then--unban
		dgsSetEnabled(GUI.Button["Unban->Player"],true);
		dgsSetProperty(GUI.Button["Unban->Player"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Unban->Player"],false);
		dgsSetProperty(GUI.Button["Unban->Player"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.BanlistSee==true)then
		dgsSetEnabled(GUI.Tab[2],true);
		dgsSetProperty(GUI.Tab[2],"tabColor",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Tab[2],false);
		dgsSetProperty(GUI.Tab[2],"tabColor",{tocolor(150,0,0,200),tocolor(180,0,0,200),tocolor(100,0,0,200)});
	end
	
	
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.ADlistSee==true)then
		dgsSetEnabled(GUI.Tab[3],true);
		dgsSetProperty(GUI.Tab[3],"tabColor",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Tab[3],false);
		dgsSetProperty(GUI.Tab[3],"tabColor",{tocolor(150,0,0,200),tocolor(180,0,0,200),tocolor(100,0,0,200)});
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.ADlistClear==true)then--adlist clear
		dgsSetEnabled(GUI.Button["ADlist->Clear"],true);
		dgsSetProperty(GUI.Button["ADlist->Clear"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["ADlist->Clear"],false);
		dgsSetProperty(GUI.Button["ADlist->Clear"],"disabledColor",tocolor(150,0,0,200));
	end
	
	
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.ServerSee==true)then
		dgsSetEnabled(GUI.Tab[4],true);
		dgsSetProperty(GUI.Tab[4],"tabColor",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Tab[4],false);
		dgsSetProperty(GUI.Tab[4],"tabColor",{tocolor(150,0,0,200),tocolor(180,0,0,200),tocolor(100,0,0,200)});
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.SetPW==true)then--set server pw
		dgsSetEnabled(GUI.Button["Password->Server"],true);
		dgsSetProperty(GUI.Button["Password->Server"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Password->Server"],false);
		dgsSetProperty(GUI.Button["Password->Server"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Kickall==true)then--kick all
		dgsSetEnabled(GUI.Button["Kick->Player->All"],true);
		dgsSetProperty(GUI.Button["Kick->Player->All"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Kick->Player->All"],false);
		dgsSetProperty(GUI.Button["Kick->Player->All"],"disabledColor",tocolor(150,0,0,200));
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Generatecodes==true)then--generate redeem codes
		dgsSetEnabled(GUI.Button["GenerateCode"],true);
		dgsSetProperty(GUI.Button["GenerateCode"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["GenerateCode"],false);
		dgsSetProperty(GUI.Button["GenerateCode"],"disabledColor",tocolor(150,0,0,200));
	end
	
	
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.EventsSee==true)then
		dgsSetEnabled(GUI.Tab[5],true);
		dgsSetProperty(GUI.Tab[5],"tabColor",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Tab[5],false);
		dgsSetProperty(GUI.Tab[5],"tabColor",{tocolor(150,0,0,200),tocolor(180,0,0,200),tocolor(100,0,0,200)});
	end
	if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.EventStart==true)then--start event
		dgsSetEnabled(GUI.Button["Event->Start"],true);
		dgsSetProperty(GUI.Button["Event->Start"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
	else
		dgsSetEnabled(GUI.Button["Event->Start"],false);
		dgsSetProperty(GUI.Button["Event->Start"],"disabledColor",tocolor(150,0,0,200));
	end
	
	addEventHandler("onDgsMouseClick",GUI.Button["Event->Start"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[5]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[5],dgsGridListGetSelectedItem(GUI.Grid[5]),1);
					if(clicked~="")then
						triggerServerEvent("Admin->EventStart",localPlayer,tonumber(clicked));
					end
				end
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",GUI.Button["GenerateCode"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				if(not(isElement(GUI.Window[2])))then
					GUI.Window[2]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,"",false,tocolor(255,255,255),10,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
					dgsWindowSetSizable(GUI.Window[2],false);
					dgsSetProperty(GUI.Window[2],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
					
					GUI.Blurbox[3]=dgsCreateBlurBox(300,300);
					GUI.Blurbox[4]=dgsCreateImage(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,GUI.Blurbox[3],false);
					dgsAttachElements(GUI.Blurbox[4],GUI.Window[2],0,0,1,1,true,true);
					dgsSetLayer(GUI.Blurbox[4],"bottom");
					
					GUI.Radio[1]=dgsCreateRadioButton(20,20,13,13,"Premium",false,GUI.Window[2],tocolor(255,255,255),_,_);
					
					GUI.Edit["GenerateCode->Amount"]=dgsCreateEdit(10,210,280,30,"",false,GUI.Window[2],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
					
					GUI.Button["GenerateCode->Done"]=dgsCreateButton(10,250,280,30,"Generate",false,GUI.Window[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
					
					
					dgsRadioButtonSetSelected(GUI.Radio[1],true);
					dgsSetProperty(GUI.Edit["GenerateCode->Amount"],"placeHolder","Amount");
					
					if(ADMIN_LEVELS[tonumber(getElementData(localPlayer,"AdminLevel"))].Permissions.Generatecodes==true)then--generate redeem codes
						dgsSetEnabled(GUI.Button["GenerateCode->Done"],true);
						dgsSetProperty(GUI.Button["GenerateCode->Done"],"color",{tocolor(0,150,0,200),tocolor(0,180,0,200),tocolor(0,100,0,200)});
					else
						dgsSetEnabled(GUI.Button["GenerateCode->Done"],false);
						dgsSetProperty(GUI.Button["GenerateCode->Done"],"disabledColor",tocolor(150,0,0,200));
					end
					
					
					addEventHandler("onDgsMouseClick",GUI.Button["GenerateCode->Done"],
						function(btn,state)
							if(btn=="left" and state=="up")then
								local amount=dgsGetText(GUI.Edit["GenerateCode->Amount"])or 0;
								if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
									if(dgsRadioButtonGetSelected(GUI.Radio[1])==true)then
										typ="Premium";
									end
									triggerServerEvent("Admin->GenerateCodes",localPlayer,tostring(typ),tonumber(amount));
								end
							end
						end,
					false)
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Kick->Player->All"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				triggerServerEvent("Admin->Player->Kick->All",localPlayer);
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Password->Server"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local text=dgsGetText(GUI.Edit[30])or "";
				if(text)then
					triggerServerEvent("Admin->SetServerPassword",localPlayer,tostring(text));
				end
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",GUI.Button["ADlist->Clear"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				triggerServerEvent("Admin->ClearAdlist",localPlayer);
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",GUI.Button["Unban->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),3);
					if(clicked~="")then
						triggerServerEvent("Admin->Player->UnBan",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",GUI.Button["Give->Player->Money"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						local amount=dgsGetText(GUI.Edit[2])or 0;
						if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
							triggerServerEvent("Admin->Give",localPlayer,"Money",tonumber(amount),clicked);
						end
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Give->Player->Coins"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						local amount=dgsGetText(GUI.Edit[2])or 0;
						if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
							triggerServerEvent("Admin->Give",localPlayer,"Coins",tonumber(amount),clicked);
						end
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Clear->Chat"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				triggerServerEvent("Admin->ClearChat",localPlayer);
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Repair->PlayerVeh"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						triggerServerEvent("Admin->Player->RepairVeh",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Freeze->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						triggerServerEvent("Admin->Player->Freeze",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Gethere->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						triggerServerEvent("Admin->Player->Gethere",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Goto->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						triggerServerEvent("Admin->Player->Goto",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Ban->Perm->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						local reason=dgsGetText(GUI.Edit[1])or "";
						if(reason)then
							triggerServerEvent("Admin->Player->Ban",localPlayer,"perm",clicked,reason);
						end
					end
				else
					local reason=dgsGetText(GUI.Edit[1])or "";
					if(reason)then
						local targetName=dgsGetText(GUI.Edit[3])or "";
						if(targetName~=nil and targetName~="" and #targetName>0)then
							triggerServerEvent("Admin->Player->Ban",localPlayer,"perm",targetName,reason);
						end
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Ban->Temp->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						local reason=dgsGetText(GUI.Edit[1])or "";
						local timee=dgsGetText(GUI.Edit[2])or 0;
						if(reason and timee)then
							triggerServerEvent("Admin->Player->Ban",localPlayer,"temp",clicked,reason,tonumber(timee));
						end
					end
				else
					local reason=dgsGetText(GUI.Edit[1])or "";
					local timee=dgsGetText(GUI.Edit[2])or 0;
					if(reason and timee)then
						local targetName=dgsGetText(GUI.Edit[3])or "";
						if(targetName~=nil and targetName~="" and #targetName>0)then
							triggerServerEvent("Admin->Player->Ban",localPlayer,"temp",targetName,reason,tonumber(timee));
						end
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",GUI.Button["Kick->Player"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						local reason=dgsGetText(GUI.Edit[1])or "";
						if(reason)then
							triggerServerEvent("Admin->Player->Kick",localPlayer,clicked,reason);
						end
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
end)


addEventHandler("Show->AdminUI->Bans",root,function(tbl)
	dgsGridListClear(GUI.Grid[2]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[2]);
		dgsGridListSetItemText(GUI.Grid[2],row,banlist_BannedBy,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[2],row,banlist_TargetName,v[2],false,false);
		dgsGridListSetItemText(GUI.Grid[2],row,banlist_TargetSerial,v[3],false,false);
		dgsGridListSetItemText(GUI.Grid[2],row,banlist_Reason,v[4],false,false);
		dgsGridListSetItemText(GUI.Grid[2],row,banlist_Time,v[5],false,false);
	end
end)

addEventHandler("Show->AdminUI->ADs",root,function(tbl)
	dgsGridListClear(GUI.Grid[3]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[3]);
		dgsGridListSetItemText(GUI.Grid[3],row,adlist_TargetName,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[3],row,adlist_TargetMessage,v[2],false,false);
	end
end)