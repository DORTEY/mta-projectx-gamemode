addRemoteEvents{"Show->Helpmenu->Items"};--addEvent


bindKey("F1","DOWN",function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	
	setUIdatas("set","cursor",true);
	dgsSetInputMode("no_binds");
	dgsSetInputMode("no_binds_when_editing");
	
	GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,"Help info (English)",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
	dgsWindowSetSizable(GUI.Window[1],false);
	dgsWindowSetMovable(GUI.Window[1],false);
	dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
	GUI.Button["Close"]=dgsCreateButton(665,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
	
	GUI.Blurbox[1]=dgsCreateBlurBox(700,500);
	GUI.Blurbox[2]=dgsCreateImage(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,GUI.Blurbox[1],false);
	dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
	dgsSetLayer(GUI.Blurbox[2],"bottom");
	
	GUI.Edit["Search"]=dgsCreateEdit(10,10,150,30,"",false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
	GUI.Grid[1]=dgsCreateGridList(10,50,150,405,false,GUI.Window[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
	dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
	
	helpCategory=dgsGridListAddColumn(GUI.Grid[1],"Category",1);
	helpText=dgsGridListAddColumn(GUI.Grid[1],"Text",0);
	
	
	triggerServerEvent("Trigger->Helpmenu->Items",localPlayer,"All");
	dgsSetProperty(GUI.Grid[1],"rowHeight",35);
	dgsGridListSetSortEnabled(GUI.Grid[1],false);
	dgsSetProperty(GUI.Edit["Search"],"placeHolder","Search");
	
	addEventHandler("onDgsTextChange",GUI.Edit["Search"],function()
		dgsGridListClear(GUI.Grid[1]);
		local text=dgsGetText(GUI.Edit["Search"]);
		if(text=="")then
			triggerServerEvent("Trigger->Helpmenu->Items",localPlayer,"All");
		else
			triggerServerEvent("Trigger->Helpmenu->Items",localPlayer,"Specific",text);
		end
	end,false)
	
	
	addEventHandler("onDgsMouseClick",GUI.Grid[1],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local Text=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),2);
					if(isElement(GUI.Memo[1]))then
						destroyElement(GUI.Memo[1]);
					end
					GUI.Memo[1]=dgsCreateMemo(170,10,520,445,"",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,tocolor(0,0,0,120));
					dgsSetProperty(GUI.Memo[1],"scrollArrow",false);
					dgsSetProperty(GUI.Memo[1],"scrollBarThick",6);
					
					dgsSetText(GUI.Memo[1],Text);
					dgsMemoSetReadOnly(GUI.Memo[1],true);
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


addEventHandler("Show->Helpmenu->Items",root,function(tbl)
	dgsGridListClear(GUI.Grid[1]);
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(GUI.Grid[1]);
		dgsGridListSetItemText(GUI.Grid[1],row,helpCategory,v[1],false,false);
		dgsGridListSetItemText(GUI.Grid[1],row,helpText,v[2],false,false);
	end
end)