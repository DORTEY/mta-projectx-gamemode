addRemoteEvents{"Tuning->UI"};--addEvent


local MUSIC=nil;
local SOUND=nil;

addEventHandler("Tuning->UI",root,function(typ)
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
		
		if(not(isElement(MUSIC)))then
			local rdm=math.random(1,4);
			MUSIC=playSound(":"..RESOURCE_NAME.."/Files/Audio/Vehicle/Tuningshop/"..rdm..".mp3",true)
			setSoundVolume(MUSIC,0.5);
			setSoundEffectEnabled(MUSIC,"reverb",true);
		end
		
		showCursor(true);
		showChat(false);
		
		GUI.Window["UI->Element->Tuning"]=dgsCreateWindow(10,GLOBALscreenY/2-520/2,400,520,"Tuning menu",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window["UI->Element->Tuning"],false);
		dgsWindowSetMovable(GUI.Window["UI->Element->Tuning"],false);
		dgsSetProperty(GUI.Window["UI->Element->Tuning"],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(365,-35,35,35,"×",false,GUI.Window["UI->Element->Tuning"],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
		
		GUI.Blurbox[1]=dgsCreateBlurBox(400,520);
		GUI.Blurbox[2]=dgsCreateImage(10,GLOBALscreenY/2-520/2,400,520,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window["UI->Element->Tuning"],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		dgsCreateLabel(100,5,200,20,loc("UI->Shop->Tuning->Title"),false,GUI.Window["UI->Element->Tuning"],tocolor(255,255,255),1.2,1.2,_,_,_,"center",_);
		
		GUI.Tabpanel[1]=dgsCreateTabPanel(10,30,380,445,false,GUI.Window["UI->Element->Tuning"],GUI.Settings.Height,_,tocolor(0,0,0,180));
		
		GUI.Radio[1]=dgsCreateRadioButton(300,10,11,11,"On",false,GUI.Tabpanel[1]);
		GUI.Radio[2]=dgsCreateRadioButton(340,10,11,11,"Off",false,GUI.Tabpanel[1]);
		
		addEventHandler("onDgsRadioButtonChange",GUI.Radio[1],function()
			if(isElement(MUSIC))then
				setSoundVolume(MUSIC,0.5);
			end
		end,false)
		addEventHandler("onDgsRadioButtonChange",GUI.Radio[2],function()
			if(isElement(MUSIC))then
				setSoundVolume(MUSIC,0);
			end
		end,false)
		
		dgsRadioButtonSetSelected(GUI.Radio[1],true);
		
		--normal tunings
		GUI.Tab[1]=dgsCreateTab("Normal Tunings",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Grid[1]=dgsCreateGridList(10,10,130,350,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		local tuningCategory=dgsGridListAddColumn(GUI.Grid[1],"Category",1);
		
		local model=getElementData(getPedOccupiedVehicle(localPlayer),"Veh->Data->VehID");
		for i,v in pairs(TUNING["Categorys"][model])do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,tuningCategory,v,false,false);
		end
		
		GUI.Grid[2]=dgsCreateGridList(150,10,220,350,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
		dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
		local tuningID=dgsGridListAddColumn(GUI.Grid[2],"ID",0);--0.25
		local tuningPart=dgsGridListAddColumn(GUI.Grid[2],"Part",0.61);
		local tuningPrice=dgsGridListAddColumn(GUI.Grid[2],"Price",0.31);
		
		
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		dgsGridListSetSortEnabled(GUI.Grid[2],false);
		dgsSetProperty(GUI.Grid[1],"rowHeight",30);
		dgsSetProperty(GUI.Grid[2],"rowHeight",30);
		
		GUI.Button["Buy->Tuningpart"]=dgsCreateButton(10,370,175,30,loc("UI->Tuning->Buy->BTN"),false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button["Remove->Tuningpart"]=dgsCreateButton(195,370,175,30,loc("UI->Tuning->Rem->BTN"),false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		--exclusive tunings
		GUI.Tab[2]=dgsCreateTab("Custom Tunings",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Grid[3]=dgsCreateGridList(10,10,130,350,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[3]=dgsGridListGetScrollBar(GUI.Grid[3]);
		dgsSetProperty(GUI.Scroll[3],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[3],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[3],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[3],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[3],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[3],"scrollBarThick",0);
		local tuningCategory=dgsGridListAddColumn(GUI.Grid[3],"Category",1);
		
		local model=getElementData(getPedOccupiedVehicle(localPlayer),"Veh->Data->VehID");
		if(not(VEHICLE_TYPES.BIKES[model]))then
			for i,v in pairs(TUNING_CUSTOM["Categorys"][model])do
				local row=dgsGridListAddRow(GUI.Grid[3]);
				dgsGridListSetItemText(GUI.Grid[3],row,tuningCategory,v,false,false);
			end
		end
		
		GUI.Grid[4]=dgsCreateGridList(150,10,220,350,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[4]=dgsGridListGetScrollBar(GUI.Grid[4]);
		dgsSetProperty(GUI.Scroll[4],"troughColor",tocolor(0,0,0,140));
		dgsSetProperty(GUI.Scroll[4],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[4],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[4],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[4],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[4],"scrollBarThick",0);
		local CtuningID=dgsGridListAddColumn(GUI.Grid[4],"ID",0);--0.25
		local CtuningPart=dgsGridListAddColumn(GUI.Grid[4],"Part",0.61);
		local CtuningPrice=dgsGridListAddColumn(GUI.Grid[4],"Price",0.31);
		
		
		dgsGridListSetSortEnabled(GUI.Grid[3],false);
		dgsGridListSetSortEnabled(GUI.Grid[4],false);
		dgsSetProperty(GUI.Grid[3],"rowHeight",30);
		dgsSetProperty(GUI.Grid[4],"rowHeight",30);
		
		GUI.Button["Buy->cTuningpart"]=dgsCreateButton(10,370,175,30,"Buy selected tuning",false,GUI.Tab[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		
		
		addEventHandler("onDgsMouseClick",GUI.Grid[4],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[4]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[4],dgsGridListGetSelectedItem(GUI.Grid[4]),1);
						local clicked2=dgsGridListGetItemText(GUI.Grid[3],dgsGridListGetSelectedItem(GUI.Grid[3]),1);
						if(clicked~="")then
							if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
								destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
							end
							if(string.find(clicked2,"Horns"))then
								if(isElement(SOUND))then
									destroyElement(SOUND);
									SOUND=nil;
								end
								if(clicked~=0)then
									SOUND=playSound(":"..RESOURCE_NAME.."/Files/Audio/Vehicle/Horns/"..tostring(clicked)..".mp3",false);
								end
							else
								triggerServerEvent("TuningPart->ShowRemoveAdd",localPlayer,"Show",tostring(clicked2),tostring(clicked));
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Grid[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[3]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[3],dgsGridListGetSelectedItem(GUI.Grid[3]),1);
						if(clicked~="" and clicked~=nil)then
							if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
								destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
							end
							dgsGridListClear(GUI.Grid[4]);
							local model=getElementData(getPedOccupiedVehicle(localPlayer),"Veh->Data->VehID");
							for _,v in pairs(TUNING_CUSTOM["TuningParts"][clicked])do
								if(isCustomTuningpartAvailable(model,v))then
									local row=dgsGridListAddRow(GUI.Grid[4]);
									if(string.find(v,"pj_"))then
										dgsGridListSetItemText(GUI.Grid[4],row,CtuningID,v:gsub("pj_",""),false,false);
									end
									if(string.find(v,"li_"))then
										dgsGridListSetItemText(GUI.Grid[4],row,CtuningID,v:gsub("li_",""),false,false);
									end
									if(string.find(v,"h_"))then
										dgsGridListSetItemText(GUI.Grid[4],row,CtuningID,v:gsub("h_",""),false,false);
									end
									if(string.find(v,"eng_"))then
										dgsGridListSetItemText(GUI.Grid[4],row,CtuningID,v:gsub("eng_",""),false,false);
									end
									if(string.find(v,"nplate_"))then
										dgsGridListSetItemText(GUI.Grid[4],row,CtuningID,v:gsub("nplate_",""),false,false);
									end
									if(string.find(v,"drive_"))then
										dgsGridListSetItemText(GUI.Grid[4],row,CtuningID,v:gsub("drive_",""),false,false);
									end
									dgsGridListSetItemText(GUI.Grid[4],row,CtuningPart,TUNING_CUSTOM["TuningNames"][v],false,false);
									dgsGridListSetItemText(GUI.Grid[4],row,CtuningPrice,CURRENCY.." "..TUNING_CUSTOM["TuningPrices"][v],false,false);
								end
							end
						end
					else
						dgsGridListClear(GUI.Grid[4]);
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button["Buy->cTuningpart"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[4]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[4],dgsGridListGetSelectedItem(GUI.Grid[4]),1);
						local clicked2=dgsGridListGetItemText(GUI.Grid[3],dgsGridListGetSelectedItem(GUI.Grid[3]),1);
						if(clicked~="")then
							local item=dgsGridListGetSelectedItem(GUI.Grid[4]);
							if(item>0)then
								triggerServerEvent("TuningPart->ShowRemoveAdd",localPlayer,"Add",clicked2,clicked);
							end
						end
					end
				end
			end,
		false)
		
		
		
		
		addEventHandler("onDgsMouseClick",GUI.Grid[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
						if(clicked~="")then
							if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
								destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
							end
							if(tonumber(clicked)==0 or tonumber(clicked)==1 or tonumber(clicked)==2)then
								triggerServerEvent("TuningPart->ShowRemoveAdd",localPlayer,"Show",_,tonumber(clicked));
							else
								triggerServerEvent("Tuning->Load",localPlayer,getPedOccupiedVehicle(localPlayer));
								triggerServerEvent("TuningPart->ShowRemoveAdd",localPlayer,"Show",_,tonumber(clicked));
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Grid[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						if(clicked~="" and clicked~=nil)then
							if(clicked=="Bodycolor")then--vehicle body color
								if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
									destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
								end
								GUI.Window["UI->Element->Tuning->Color"]=dgsCreateWindow(GLOBALscreenX/2-300/2,0,300,440,"Colorpicker",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
								dgsWindowSetSizable(GUI.Window["UI->Element->Tuning->Color"],false);
								dgsSetProperty(GUI.Window["UI->Element->Tuning->Color"],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
								GUI.Button["Close->Color"]=dgsCreateButton(265,-35,35,35,"×",false,GUI.Window["UI->Element->Tuning->Color"],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
								
								ColorPicker=dgsCreateColorPicker("HSVRing",10,10,280,285,false,GUI.Window["UI->Element->Tuning->Color"]);
								
								local ColorR,ColorG,ColorB=dgsColorPickerGetColor(ColorPicker,"RGB");
								GUI.Label["RGB"]=dgsCreateLabel(50,302,200,20,"R: 255 G: 255 B: 255",false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255),1.2,1.2,_,_,_,"center",_);
								
								GUI.Edit[1]=dgsCreateEdit(10,325,83,30,255,false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
								GUI.Edit[2]=dgsCreateEdit(108,325,83,30,255,false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
								GUI.Edit[3]=dgsCreateEdit(204,325,83,30,255,false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
								
								GUI.Button["Buy->Color->Body"]=dgsCreateButton(10,365,280,30,"Buy vehicle color "..CURRENCY..TUNING["TuningPrices"]["Bodycolor"],false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
								
								dgsEditSetMaxLength(GUI.Edit[1],3);
								dgsEditSetMaxLength(GUI.Edit[2],3);
								dgsEditSetMaxLength(GUI.Edit[3],3);
								
								addEventHandler("onDgsTextChange",GUI.Edit[3],function()
									local amount=tonumber(dgsGetText(GUI.Edit[1]))or 0;
									local amount2=tonumber(dgsGetText(GUI.Edit[2]))or 0;
									local amount3=tonumber(dgsGetText(GUI.Edit[3]))or 0;
									if(amount3~="" and isOnlyNumber(amount3))then
										dgsColorPickerSetColor(ColorPicker,amount,amount2,amount3);
									end
								end,false)
								addEventHandler("onDgsTextChange",GUI.Edit[2],function()
									local amount=tonumber(dgsGetText(GUI.Edit[1]))or 0;
									local amount2=tonumber(dgsGetText(GUI.Edit[2]))or 0;
									local amount3=tonumber(dgsGetText(GUI.Edit[3]))or 0;
									if(amount2~="" and isOnlyNumber(amount2))then
										dgsColorPickerSetColor(ColorPicker,amount,amount2,amount3);
									end
								end,false)
								addEventHandler("onDgsTextChange",GUI.Edit[1],function()
									local amount=tonumber(dgsGetText(GUI.Edit[1]))or 0;
									local amount2=tonumber(dgsGetText(GUI.Edit[2]))or 0;
									local amount3=tonumber(dgsGetText(GUI.Edit[3]))or 0;
									if(amount~="" and isOnlyNumber(amount))then
										dgsColorPickerSetColor(ColorPicker,amount,amount2,amount3);
									end
								end,false)
								
								addEventHandler("onDgsColorPickerChange",ColorPicker,function()
									if(isElement(ColorPicker)and isElement(GUI.Window["UI->Element->Tuning->Color"]))then
										local veh=getPedOccupiedVehicle(localPlayer);
										if(veh and isElement(veh))then
											local ColorR,ColorG,ColorB=dgsColorPickerGetColor(ColorPicker,"RGB");
											setVehicleColor(veh,ColorR,ColorG,ColorB,ColorR,ColorG,ColorB);
											dgsSetText(GUI.Label["RGB"],"R: "..ColorR.." G: "..ColorG.." B: "..ColorB.."");
										end
									end
								end)
								addEventHandler("onDgsMouseClick",GUI.Button["Buy->Color->Body"],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local ColorR,ColorG,ColorB=dgsColorPickerGetColor(ColorPicker,"RGB");
											triggerServerEvent("TuningPart->Color",localPlayer,"Bodycolor",ColorR,ColorG,ColorB);
										end
									end,
								false)
								
								addEventHandler("onDgsMouseClick",GUI.Button["Close->Color"],
									function(btn,state)
										if(btn=="left" and state=="down")then
											if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
												destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
											end
										end
									end,
								false)
							elseif(clicked=="Lightcolor")then--vehicle light color
								if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
									destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
								end
								GUI.Window["UI->Element->Tuning->Color"]=dgsCreateWindow(GLOBALscreenX/2-300/2,0,300,440,"Colorpicker",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
								dgsWindowSetSizable(GUI.Window["UI->Element->Tuning->Color"],false);
								dgsSetProperty(GUI.Window["UI->Element->Tuning->Color"],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
								GUI.Button["Close->Color"]=dgsCreateButton(265,-35,35,35,"×",false,GUI.Window["UI->Element->Tuning->Color"],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
								
								ColorPicker=dgsCreateColorPicker("HSVRing",10,10,280,285,false,GUI.Window["UI->Element->Tuning->Color"]);
								
								local ColorR,ColorG,ColorB=dgsColorPickerGetColor(ColorPicker,"RGB");
								GUI.Label["RGB"]=dgsCreateLabel(50,302,200,20,"R: "..ColorR.." G: "..ColorG.." B: "..ColorB.."",false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255),1.2,1.2,_,_,_,"center",_);
								
								GUI.Edit[1]=dgsCreateEdit(10,325,83,30,255,false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
								GUI.Edit[2]=dgsCreateEdit(108,325,83,30,255,false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
								GUI.Edit[3]=dgsCreateEdit(204,325,83,30,255,false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
								
								GUI.Button["Buy->Color->Light"]=dgsCreateButton(10,365,280,30,"Buy vehicle color "..CURRENCY..TUNING["TuningPrices"]["Lightcolor"],false,GUI.Window["UI->Element->Tuning->Color"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
								
								dgsEditSetMaxLength(GUI.Edit[1],3);
								dgsEditSetMaxLength(GUI.Edit[2],3);
								dgsEditSetMaxLength(GUI.Edit[3],3);
								
								addEventHandler("onDgsTextChange",GUI.Edit[3],function()
									local amount=tonumber(dgsGetText(GUI.Edit[1]))or 0;
									local amount2=tonumber(dgsGetText(GUI.Edit[2]))or 0;
									local amount3=tonumber(dgsGetText(GUI.Edit[3]))or 0;
									if(amount3~="" and isOnlyNumber(amount3))then
										dgsColorPickerSetColor(ColorPicker,amount,amount2,amount3);
									end
								end,false)
								addEventHandler("onDgsTextChange",GUI.Edit[2],function()
									local amount=tonumber(dgsGetText(GUI.Edit[1]))or 0;
									local amount2=tonumber(dgsGetText(GUI.Edit[2]))or 0;
									local amount3=tonumber(dgsGetText(GUI.Edit[3]))or 0;
									if(amount2~="" and isOnlyNumber(amount2))then
										dgsColorPickerSetColor(ColorPicker,amount,amount2,amount3);
									end
								end,false)
								addEventHandler("onDgsTextChange",GUI.Edit[1],function()
									local amount=tonumber(dgsGetText(GUI.Edit[1]))or 0;
									local amount2=tonumber(dgsGetText(GUI.Edit[2]))or 0;
									local amount3=tonumber(dgsGetText(GUI.Edit[3]))or 0;
									if(amount~="" and isOnlyNumber(amount))then
										dgsColorPickerSetColor(ColorPicker,amount,amount2,amount3);
									end
								end,false)
								
								addEventHandler("onDgsColorPickerChange",ColorPicker,function()
									if(isElement(ColorPicker)and isElement(GUI.Window["UI->Element->Tuning->Color"]))then
										local veh=getPedOccupiedVehicle(localPlayer);
										if(veh and isElement(veh))then
											local ColorR,ColorG,ColorB=dgsColorPickerGetColor(ColorPicker,"RGB");
											setVehicleHeadLightColor(veh,ColorR,ColorG,ColorB,ColorR,ColorG,ColorB);
											dgsSetText(GUI.Label["RGB"],"R: "..ColorR.." G: "..ColorG.." B: "..ColorB.."");
										end
									end
								end)
								addEventHandler("onDgsMouseClick",GUI.Button["Buy->Color->Light"],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local ColorR,ColorG,ColorB=dgsColorPickerGetColor(ColorPicker,"RGB");
											triggerServerEvent("TuningPart->Color",localPlayer,"Lightcolor",ColorR,ColorG,ColorB);
										end
									end,
								false)
								
								addEventHandler("onDgsMouseClick",GUI.Button["Close->Color"],
									function(btn,state)
										if(btn=="left" and state=="down")then
											if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
												destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
											end
										end
									end,
								false)
							else--other tunings
								if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
									destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
								end
								dgsGridListClear(GUI.Grid[2]);
								local model=getElementData(getPedOccupiedVehicle(localPlayer),"Veh->Data->VehID");
								for _,v in pairs(TUNING["TuningParts"][clicked])do
									if(isTuningpartAvailable(model,v))then
										local row=dgsGridListAddRow(GUI.Grid[2]);
										dgsGridListSetItemText(GUI.Grid[2],row,tuningID,v,false,false);
										dgsGridListSetItemText(GUI.Grid[2],row,tuningPart,TUNING["TuningNames"][v],false,false);
										dgsGridListSetItemText(GUI.Grid[2],row,tuningPrice,CURRENCY.." "..TUNING["TuningPrices"][v],false,false);
									end
								end
							end
						end
					else
						dgsGridListClear(GUI.Grid[2]);
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button["Remove->Tuningpart"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
						if(clicked~="")then
							triggerServerEvent("TuningPart->ShowRemoveAdd",localPlayer,"Remove",_,tonumber(clicked));
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button["Buy->Tuningpart"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
						if(clicked~="")then
							local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
							if(item>0)then
								triggerServerEvent("TuningPart->ShowRemoveAdd",localPlayer,"Add",_,tonumber(clicked));
							end
						end
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="down")then
					triggerServerEvent("Spawn->Tuning->Out",localPlayer);
				end
			end,
		false)
	elseif(typ=="Close")then
		showCursor(false);
		showChat(true);
		if(isElement(GUI.Window["UI->Element->Tuning"]))then
			if(isElement(GUI.Blurbox[1]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window["UI->Element->Tuning"]);
				dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window["UI->Element->Tuning"]);
			end
			destroyElement(GUI.Window["UI->Element->Tuning"]);
		end
		if(isElement(GUI.Window["UI->Element->Tuning->Color"]))then
			destroyElement(GUI.Window["UI->Element->Tuning->Color"]);
		end
		if(isElement(MUSIC))then
			destroyElement(MUSIC);
			MUSIC=nil;
		end
	end
end)



function isTuningpartAvailable(model,id)
	local state=false;
	local TABLE=TUNING["TuningAvailable"][model]or nil;
	if(TABLE)then
		for _,v in pairs(TABLE)do
			if(v==tonumber(id))then
				state=true;
				break
			end
		end
	end
	return state;
end

function isCustomTuningpartAvailable(model,id)
	local state=false;
	local TABLE=TUNING_CUSTOM["TuningAvailable"][model]or nil;
	if(TABLE)then
		for _,v in pairs(TABLE)do
			if(v==id)then
				state=true;
				break
			end
		end
	end
	return state;
end