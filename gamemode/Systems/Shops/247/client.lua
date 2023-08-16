addRemoteEvents{"Shop->247->UI"};--addEvent


addEventHandler("Shop->247->UI",root,function(typ,typ2)
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
		--set UI stuff
		setUIdatas("set","cursor",true);
		
		GUI.Window[1]=dgsCreateWindow(10,GLOBALscreenY/2-600/2,400,600,SHOPS[typ2].Name,false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(365,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
		
		GUI.Tabpanel[1]=dgsCreateTabPanel(10,30,380,525,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
		
		--food/drinks
		GUI.Tab[1]=dgsCreateTab("Food/Drinks",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Grid[1]=dgsCreateGridList(10,10,360,365,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		local itemName=dgsGridListAddColumn(GUI.Grid[1],"Item",0.5);
		local itemPrice=dgsGridListAddColumn(GUI.Grid[1],loc("UI->Shop->Price"),0.5);
		
		for _,v in pairs(SHOPS[typ2].ItemsFD)do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,itemName,v[1],false,false);
			dgsGridListSetItemText(GUI.Grid[1],row,itemPrice,CURRENCY.." "..v[2],false,false);
		end
		
		GUI.Edit[1]=dgsCreateEdit(10,385,360,40,5,false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,425,360,2,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Tab[1],GUI.Color.Edit.Line);
		
		GUI.Button[1]=dgsCreateButton(10,440,360,40,loc("UI->Shop->Item->BTN"),false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		--heal
		GUI.Tab[2]=dgsCreateTab("Heal",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Grid[2]=dgsCreateGridList(10,10,360,365,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
		dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
		
		local itemName=dgsGridListAddColumn(GUI.Grid[2],"Item",0.5);
		local itemPrice=dgsGridListAddColumn(GUI.Grid[2],loc("UI->Shop->Price"),0.5);
		
		for _,v in pairs(SHOPS[typ2].ItemsHeal)do
			local row=dgsGridListAddRow(GUI.Grid[2]);
			dgsGridListSetItemText(GUI.Grid[2],row,itemName,v[1],false,false);
			dgsGridListSetItemText(GUI.Grid[2],row,itemPrice,CURRENCY.." "..v[2],false,false);
		end
		
		GUI.Edit[2]=dgsCreateEdit(10,385,360,40,5,false,GUI.Tab[2],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,425,360,2,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Tab[2],GUI.Color.Edit.Line);
		
		GUI.Button[2]=dgsCreateButton(10,440,360,40,loc("UI->Shop->Item->BTN"),false,GUI.Tab[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
						if(clicked~="")then
							local amount=dgsGetText(GUI.Edit[2]);
							if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
								triggerServerEvent("Shop->Buy->Item",localPlayer,tostring(clicked),math.floor(amount));
							end
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
							local amount=dgsGetText(GUI.Edit[1])or 1;
							if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
								triggerServerEvent("Shop->Buy->Item",localPlayer,tostring(clicked),math.floor(amount));
							end
						end
					end
				end
			end,
		false)
		
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