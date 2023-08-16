addRemoteEvents{"Job->Mine->Progress->UI","Job->Mine->UI"};--addEvent


local Count=0;

addEventHandler("Job->Mine->Progress->UI",root,function(typ,amount)
	if(isLoggedin())then
		removeEventHandler("onClientRender",root,drawMineDisplay);
		if(typ=="create")then
			Count=amount;
			
			if(Count>=JOBS["Miner"].MaxCount)then
				removeEventHandler("onClientRender",root,drawMineDisplay);
			end
			addEventHandler("onClientRender",root,drawMineDisplay);
		else
			removeEventHandler("onClientRender",root,drawMineDisplay);
		end
	end
end)

function drawMineDisplay()
	if(isLoggedin())then
		if(isPlayerMapVisible(localPlayer)==false)then
			if(not(isPedDead(localPlayer)))then
				local x,y,z=getElementPosition(localPlayer);
				local sx,sy=getScreenFromWorldPosition(x,y,z,1000,true);
				
				dxDrawRectangle(sx-70,sy-155,137,20,tocolor(0,0,0,150),false);
				dxDrawRectangle(sx-70,sy-155,(20*Count),20,tocolor(220,60,0,255),false);
				dxDrawText(Count.."/"..JOBS["Miner"].MaxCount,sx-15,sy-153,100,20,tocolor(255,255,255,255),1.2,"sans");
			end
		end
	end
end



addEventHandler("Job->Mine->UI",root,function(typ)
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
		
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,"Miner Job",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(465,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
		
		GUI.Tabpanel[1]=dgsCreateTabPanel(10,10,480,445,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
		--main ui
		GUI.Tab[1]=dgsCreateTab("Main",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		
		--skin selection
		GUI.Grid[1]=dgsCreateGridList(390,10,80,285,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		local pedID=dgsGridListAddColumn(GUI.Grid[1],"ID",1);
		
		for i,v in pairs(JOBS["Miner"].Peds[1])do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,pedID,v,false,false);
		end
		
		
		GUI.Button[1]=dgsCreateButton(10,310,460,40,"Join Job",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button[2]=dgsCreateButton(10,360,460,40,"Leave Job",false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Red1,GUI.Color.Button.Red2,GUI.Color.Button.Red3,true);
		
		--sell stuff
		GUI.Tab[2]=dgsCreateTab(loc("Job->UI->Tab->SellItems"),GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Tabpanel[2]=dgsCreateTabPanel(10,10,460,390,false,GUI.Tab[2],GUI.Settings.Height,_,tocolor(0,0,0,180));
		--stone
		GUI.Tab["UI->Sell->Stone"]=dgsCreateTab(loc("Item->Name->Stone"),GUI.Tabpanel[2],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Edit["UI->Sell->Stone->Edit"]=dgsCreateEdit(10,250,440,40,50,false,GUI.Tab["UI->Sell->Stone"],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,290,440,2,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Tab["UI->Sell->Stone"],GUI.Color.Edit.Line);
		
		GUI.Button["UI->Sell->Stone->BTN"]=dgsCreateButton(10,305,440,40,loc("Job->UI->Sell->BTN").." "..loc("Item->Name->Stone"),false,GUI.Tab["UI->Sell->Stone"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button["UI->Sell->Stone->BTN"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local amount=dgsGetText(GUI.Edit["UI->Sell->Stone->Edit"])or 1;
					if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
						triggerServerEvent("Job->SellItem",localPlayer,"Stone",tonumber(amount));
					end
				end
			end,
		false)
		--bronze
		GUI.Tab["UI->Sell->Bronze"]=dgsCreateTab(loc("Item->Name->OreBronze"),GUI.Tabpanel[2],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Edit["UI->Sell->Bronze->Edit"]=dgsCreateEdit(10,250,440,40,50,false,GUI.Tab["UI->Sell->Bronze"],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,290,440,2,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Tab["UI->Sell->Bronze"],GUI.Color.Edit.Line);
		
		GUI.Button["UI->Sell->Bronze->BTN"]=dgsCreateButton(10,305,440,40,loc("Job->UI->Sell->BTN").." "..loc("Item->Name->OreBronze"),false,GUI.Tab["UI->Sell->Bronze"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button["UI->Sell->Bronze->BTN"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local amount=dgsGetText(GUI.Edit["UI->Sell->Bronze->Edit"])or 1;
					if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
						triggerServerEvent("Job->SellItem",localPlayer,"OreBronze",tonumber(amount));
					end
				end
			end,
		false)
		
		--iron
		GUI.Tab["UI->Sell->Iron"]=dgsCreateTab(loc("Item->Name->OreIron"),GUI.Tabpanel[2],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Edit["UI->Sell->Iron->Edit"]=dgsCreateEdit(10,250,440,40,50,false,GUI.Tab["UI->Sell->Iron"],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,290,440,2,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Tab["UI->Sell->Iron"],GUI.Color.Edit.Line);
		
		GUI.Button["UI->Sell->Iron->BTN"]=dgsCreateButton(10,305,440,40,loc("Job->UI->Sell->BTN").." "..loc("Item->Name->OreIron"),false,GUI.Tab["UI->Sell->Iron"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button["UI->Sell->Iron->BTN"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local amount=dgsGetText(GUI.Edit["UI->Sell->Iron->Edit"])or 1;
					if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
						triggerServerEvent("Job->SellItem",localPlayer,"OreIron",tonumber(amount));
					end
				end
			end,
		false)
		
		--gold
		GUI.Tab["UI->Sell->Gold"]=dgsCreateTab(loc("Item->Name->OreGold"),GUI.Tabpanel[2],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Edit["UI->Sell->Gold->Edit"]=dgsCreateEdit(10,250,440,40,50,false,GUI.Tab["UI->Sell->Gold"],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,290,440,2,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Tab["UI->Sell->Gold"],GUI.Color.Edit.Line);
		
		GUI.Button["UI->Sell->Gold->BTN"]=dgsCreateButton(10,305,440,40,loc("Job->UI->Sell->BTN").." "..loc("Item->Name->OreGold"),false,GUI.Tab["UI->Sell->Gold"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button["UI->Sell->Gold->BTN"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local amount=dgsGetText(GUI.Edit["UI->Sell->Gold->Edit"])or 1;
					if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
						triggerServerEvent("Job->SellItem",localPlayer,"OreGold",tonumber(amount));
					end
				end
			end,
		false)
		
		
		
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
						triggerServerEvent("Job->Join",localPlayer,"Miner",tonumber(item));
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


addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(getElementData(localPlayer,"Player->Data->Job")~="Miner")then
		return;
	end
	if(getElementDimension(localPlayer)~=4000)then
		return;
	end
	setTime(1,0);
	setWeather(0);
end)