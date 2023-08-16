addRemoteEvents{"Show->Userpanel->Achievements","Show->Achievement->Infos","Locate->ATMs","Case->Show->Reward"};--addEvent


local SOUND=nil;

bindKey("U","DOWN",function()
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
	
	GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,"Userpanel",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
	dgsWindowSetSizable(GUI.Window[1],false);
	dgsWindowSetMovable(GUI.Window[1],false);
	dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
	GUI.Button["Close"]=dgsCreateButton(665,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
	
	GUI.Blurbox[1]=dgsCreateBlurBox(700,500);
	GUI.Blurbox[2]=dgsCreateImage(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,GUI.Blurbox[1],false);
	dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
	dgsSetLayer(GUI.Blurbox[2],"bottom");
	
	GUI.Tabpanel[1]=dgsCreateTabPanel(10,10,680,445,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
	
	--general
	--GUI.Tab["Tab->General"]=dgsCreateTab("General",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	--achievements
	GUI.Tab["Tab->Achievements"]=dgsCreateTab("Achievements",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Grid[1]=dgsCreateGridList(10,10,300,390,false,GUI.Tab["Tab->Achievements"],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
	dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
	
	achievementID=dgsGridListAddColumn(GUI.Grid[1],"ID",0);
	achievementName=dgsGridListAddColumn(GUI.Grid[1],"Name",0.42);
	achievementDesc=dgsGridListAddColumn(GUI.Grid[1],"Infos",0.55);
	
	GUI.Label[1]=dgsCreateLabel(340,20,100,40,"Achievement:",false,GUI.Tab["Tab->Achievements"],tocolor(255,255,255,255),1.2,1.2);
	GUI.Image[1]=dgsCreateImage(375,60,240,240,"Files/Images/Achievement/NotReached.png",false,GUI.Tab["Tab->Achievements"]);
	GUI.Label[2]=dgsCreateLabel(445,320,100,40,"...",false,GUI.Tab["Tab->Achievements"],tocolor(255,255,255,255),1.2,1.2,_,_,_,"center");
	GUI.Label[3]=dgsCreateLabel(445,370,100,40,"...",false,GUI.Tab["Tab->Achievements"],tocolor(255,255,255,255),1.2,1.2,_,_,_,"center");
	
	addEventHandler("onDgsMouseClick",GUI.Grid[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),2);
					if(clicked~="" and clicked~=nil)then
						triggerServerEvent("Get->Achievement->Infos",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	
	
	--levels
	GUI.Tab["Tab->Levels"]=dgsCreateTab("Levels",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	local OverallLVL=tonumber(getElementData(localPlayer,"OverallLVL"))or 0;
	local OverallEXP=tonumber(getElementData(localPlayer,"OverallEXP"))or 0;
	local expAmountOverall=100/LEVEL.EXPforNextLevelUP[OverallLVL]*OverallEXP;
	
	local FarmerLVL=tonumber(getElementData(localPlayer,"FarmerLVL"))or 0;
	local FarmerEXP=tonumber(getElementData(localPlayer,"FarmerEXP"))or 0;
	local expAmountFarmer=100/JOBS["Farmer"].LevelsEXP[FarmerLVL]*FarmerEXP;
	
	local GarbageLVL=tonumber(getElementData(localPlayer,"GarbageLVL"))or 0;
	local GarbageEXP=tonumber(getElementData(localPlayer,"GarbageEXP"))or 0;
	local expAmountGarbage=100/JOBS["Garbage"].LevelsEXP[GarbageLVL]*GarbageEXP;
	
	GUI.Radio[1]=dgsCreateProgressBar(10,10,660,30,false,GUI.Tab["Tab->Levels"],nil,tocolor(0,0,0,120),nil,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],180));
	dgsProgressBarSetProgress(GUI.Radio[1],expAmountOverall);
	dgsCreateLabel(290,15,100,40,"Overall - "..OverallLVL.." | "..OverallEXP.."/"..LEVEL.EXPforNextLevelUP[OverallLVL],false,GUI.Tab["Tab->Levels"],tocolor(255,255,255,255),1.2,1.2,_,_,_,"center");
	
	GUI.Radio[2]=dgsCreateProgressBar(10,50,325,30,false,GUI.Tab["Tab->Levels"],nil,tocolor(0,0,0,120),nil,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],180));
	dgsProgressBarSetProgress(GUI.Radio[2],expAmountFarmer);
	dgsCreateLabel(120,55,100,40,"Farmer - "..FarmerLVL.." | "..FarmerEXP.."/"..JOBS["Farmer"].LevelsEXP[FarmerLVL],false,GUI.Tab["Tab->Levels"],tocolor(255,255,255,255),1.2,1.2,_,_,_,"center");
	
	GUI.Radio[3]=dgsCreateProgressBar(345,50,325,30,false,GUI.Tab["Tab->Levels"],nil,tocolor(0,0,0,120),nil,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],180));
	dgsProgressBarSetProgress(GUI.Radio[3],expAmountGarbage);
	dgsCreateLabel(470,55,100,40,"Garbage - "..GarbageLVL.." | "..GarbageEXP.."/"..JOBS["Garbage"].LevelsEXP[GarbageLVL],false,GUI.Tab["Tab->Levels"],tocolor(255,255,255,255),1.2,1.2,_,_,_,"center");
	
	
	--settings
	GUI.Tab["Tab->Settings"]=dgsCreateTab("Settings",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Grid[2]=dgsCreateGridList(10,10,300,390,false,GUI.Tab["Tab->Settings"],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
	dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
	
	local gridlist=dgsGridListAddColumn(GUI.Grid[2],"Settings",1);
	local grid1=dgsGridListAddRow(GUI.Grid[2],"Hud");
	local grid2=dgsGridListAddRow(GUI.Grid[2],"Blips");
	local gridEffects=dgsGridListAddRow(GUI.Grid[2],"Effects");
	local gridSounds=dgsGridListAddRow(GUI.Grid[2],"Sounds");
	local gridTextures=dgsGridListAddRow(GUI.Grid[2],"Textures/Shaders");
	
	dgsGridListSetItemText(GUI.Grid[2],grid1,gridlist,"Hud");
	dgsGridListSetItemText(GUI.Grid[2],grid2,gridlist,"Blips");
	dgsGridListSetItemText(GUI.Grid[2],gridEffects,gridlist,"Effects");
	dgsGridListSetItemText(GUI.Grid[2],gridSounds,gridlist,"Sounds");
	dgsGridListSetItemText(GUI.Grid[2],gridTextures,gridlist,"Textures/Shaders");
	
	
	triggerServerEvent("Trigger->Userpanel->Achievements",localPlayer);
	
	
	addEventHandler("onDgsMouseClick",GUI.Grid[2],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
				if(item>0)then
					if(item==grid1)then
						destroyOldUserpanelItems();
						GUI.Combo[1]=dgsCreateComboBox(320,10,170,35,"Select Hud",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[1],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[1],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[1],"Hud 1");
						dgsComboBoxAddItem(GUI.Combo[1],"Hud 2");
						
						GUI.Combo[2]=dgsCreateComboBox(500,10,170,35,"Select Radar",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200))
						dgsSetProperty(GUI.Combo[2],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3})
						dgsSetProperty(GUI.Combo[2],"itemTextColor",tocolor(255,255,255))
						dgsComboBoxAddItem(GUI.Combo[2],"Radar 1 (GTA:V)");
						dgsComboBoxAddItem(GUI.Combo[2],"Radar 2 (GTA:SA HQ)");
						
						GUI.Combo[3]=dgsCreateComboBox(320,60,170,35,"Select Speedo",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[3],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[3],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[3],"Speedo 1 (eXo)");
						dgsComboBoxAddItem(GUI.Combo[3],"Speedo 2 (Visual)");
						
						GUI.Button[1]=dgsCreateButton(320,370,345,30,"Apply selected settings",false,GUI.Tab["Tab->Settings"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
						
						addEventHandler("onDgsMouseClick",GUI.Button[1],
							function(btn,state)
								if(btn=="left" and state=="down")then
									local amount=dgsComboBoxGetSelectedItem(GUI.Combo[1]);
									if(tonumber(amount)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"Hud",tonumber(amount));
									end
									local amount2=dgsComboBoxGetSelectedItem(GUI.Combo[2]);
									if(tonumber(amount2)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"Radar",tonumber(amount2));
									end
									local amount3=dgsComboBoxGetSelectedItem(GUI.Combo[3]);
									if(tonumber(amount3)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"Speedo",tonumber(amount3));
									end
								end
							end,
						false)
					elseif(item==grid2)then
						destroyOldUserpanelItems();
						GUI.Combo[1]=dgsCreateComboBox(320,10,170,35,"ATM blips",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[1],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[1],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[1],"Off");
						dgsComboBoxAddItem(GUI.Combo[1],"On");
						
						GUI.Button[1]=dgsCreateButton(320,370,345,30,"Apply selected settings",false,GUI.Tab["Tab->Settings"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
						
						addEventHandler("onDgsMouseClick",GUI.Button[1],
							function(btn,state)
								if(btn=="left" and state=="down")then
									local amount=dgsComboBoxGetSelectedItem(GUI.Combo[1]);
									if(tonumber(amount)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"BlipsATM",tonumber(amount));
									end
								end
							end,
						false)
					elseif(item==gridEffects)then
						destroyOldUserpanelItems();
						GUI.Combo[1]=dgsCreateComboBox(320,10,170,35,"Vehicle Blur",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[1],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[1],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[1],"Blur Off");
						dgsComboBoxAddItem(GUI.Combo[1],"Blur On");
						
						GUI.Combo[2]=dgsCreateComboBox(500,10,170,35,"Bloodscreen",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[2],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[2],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[2],"Bloodscreen Off");
						dgsComboBoxAddItem(GUI.Combo[2],"Bloodscreen 1");
						dgsComboBoxAddItem(GUI.Combo[2],"Bloodscreen 2");
						dgsComboBoxAddItem(GUI.Combo[2],"Bloodscreen 3");
						
						
						GUI.Button[1]=dgsCreateButton(320,370,345,30,"Apply selected settings",false,GUI.Tab["Tab->Settings"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
						
						addEventHandler("onDgsMouseClick",GUI.Button[1],
							function(btn,state)
								if(btn=="left" and state=="down")then
									local amount=dgsComboBoxGetSelectedItem(GUI.Combo[1]);
									if(tonumber(amount)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"VehBlur",tonumber(amount));
									end
									local amount2=dgsComboBoxGetSelectedItem(GUI.Combo[2]);
									if(tonumber(amount2)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"Bloodscreen",tonumber(amount2));
									end
								end
							end,
						false)
						
						addEventHandler("onDgsComboBoxSelect",GUI.Combo[2],
							function(btn,state)
								local amount=dgsComboBoxGetSelectedItem(GUI.Combo[2]);
								if(tonumber(amount)~=1)then
									triggerEvent("Bloodscreen->UI",localPlayer,tonumber(amount));
								end
							end,
						false)
					elseif(item==gridSounds)then
						destroyOldUserpanelItems();
						GUI.Combo[1]=dgsCreateComboBox(320,10,170,35,"Select Hitsound",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[1],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[1],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[1],"Sound Off");
						dgsComboBoxAddItem(GUI.Combo[1],"Sound 1");
						dgsComboBoxAddItem(GUI.Combo[1],"Sound 2");
						dgsComboBoxAddItem(GUI.Combo[1],"Sound 3");
						dgsComboBoxAddItem(GUI.Combo[1],"Sound 4");
						
						
						GUI.Button[1]=dgsCreateButton(320,370,345,30,"Apply selected settings",false,GUI.Tab["Tab->Settings"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
						
						addEventHandler("onDgsMouseClick",GUI.Button[1],
							function(btn,state)
								if(btn=="left" and state=="down")then
									local amount=dgsComboBoxGetSelectedItem(GUI.Combo[1]);
									if(tonumber(amount)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"Hitsound",tonumber(amount));
									end
								end
							end,
						false)
						
						addEventHandler("onDgsComboBoxSelect",GUI.Combo[1],
							function(btn,state)
								local amount=dgsComboBoxGetSelectedItem(GUI.Combo[1]);
								if(tonumber(amount)~=1)then
									SOUND=playSound(":"..RESOURCE_NAME.."/Files/Audio/Hitsounds/"..amount..".mp3");
								end
							end,
						false)
					elseif(item==gridTextures)then
						destroyOldUserpanelItems();
						GUI.Combo[1]=dgsCreateComboBox(320,10,170,35,"Vehicle Textures",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[1],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[1],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[1],"Disable");
						dgsComboBoxAddItem(GUI.Combo[1],"Enable");
						
						GUI.Combo[2]=dgsCreateComboBox(500,10,170,35,"Skybox Textures",false,GUI.Tab["Tab->Settings"],35,tocolor(255,255,255,255),1.3,1.3,nil,nil,nil,tocolor(0,0,0,160),tocolor(40,40,40,200),tocolor(0,0,0,200));
						dgsSetProperty(GUI.Combo[2],"itemColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
						dgsSetProperty(GUI.Combo[2],"itemTextColor",tocolor(255,255,255));
						dgsComboBoxAddItem(GUI.Combo[2],"Disable");
						dgsComboBoxAddItem(GUI.Combo[2],"Enable");
						
						
						GUI.Button[1]=dgsCreateButton(320,370,345,30,"Apply selected settings",false,GUI.Tab["Tab->Settings"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
						
						addEventHandler("onDgsMouseClick",GUI.Button[1],
							function(btn,state)
								if(btn=="left" and state=="down")then
									local amount=dgsComboBoxGetSelectedItem(GUI.Combo[1]);
									if(tonumber(amount)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"LoadVehTextures",tonumber(amount));
									end
									local amount2=dgsComboBoxGetSelectedItem(GUI.Combo[2]);
									if(tonumber(amount2)>=1)then
										triggerServerEvent("Change->Userpanel->Settings",localPlayer,"LoadSkyboxTextures",tonumber(amount2));
									end
								end
							end,
						false)
					end
				end
			end
		end,
	false)
	
	--cases
	GUI.Tab["Tab->Cases"]=dgsCreateTab("Daily cases (beta)",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
	
	GUI.Image["Case"]=dgsCreateImage(220,15,240,240,"Files/Images/Case.png",false,GUI.Tab["Tab->Cases"],tocolor(255,255,255,180));
	
	GUI.Label["Case"]=dgsCreateLabel(290,290,100,40,"",false,GUI.Tab["Tab->Cases"],_,_,_,_,_,_,"center",_);
	GUI.Button["Case"]=dgsCreateButton(15,355,650,40,"Open daily case",false,GUI.Tab["Tab->Cases"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
	
	addEventHandler("onDgsMouseClick",GUI.Button["Case"],
		function(btn,state)
			if(btn=="left" and state=="down")then
				triggerServerEvent("Case->Opening",localPlayer);
			end
		end,
	false)
	
	
	
	dgsGridListSetSortEnabled(GUI.Grid[1],false);
	dgsGridListSetSortEnabled(GUI.Grid[2],false);
	dgsSetProperty(GUI.Grid[1],"rowHeight",30);
	dgsSetProperty(GUI.Grid[2],"rowHeight",30);
	dgsSetProperty(GUI.Label["Case"],"textSize",{1.3,1.3});
	
	addEventHandler("onDgsMouseClick",GUI.Button["Close"],
		function(btn,state)
			if(btn=="left" and state=="down")then
				setUIdatas("rem","cursor",true);
			end
		end,
	false)
end)

addEventHandler("Show->Achievement->Infos",root,function(reached,desc,reward)
	if(not(reached))then
		dgsImageSetImage(GUI.Image[1],"Files/Images/Achievement/NotReached.png");
		dgsSetText(GUI.Label[1],"Achievement: Not Reached!");
		dgsSetText(GUI.Label[2],desc);
		dgsSetText(GUI.Label[3],"Reward: "..reward);
	elseif(reached)then
		dgsImageSetImage(GUI.Image[1],"Files/Images/Achievement/Reached.png");
		dgsSetText(GUI.Label[1],"Achievement: Reached!");
		dgsSetText(GUI.Label[2],desc);
		dgsSetText(GUI.Label[3],"Reward: "..reward);
	end
end)
addEventHandler("Show->Userpanel->Achievements",root,function(tbl)
	dgsGridListClear(GUI.Grid[1]);
	if(#tbl>=1)then
		for i,v in ipairs(tbl)do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,achievementID,i,false,false);
			dgsGridListSetItemText(GUI.Grid[1],row,achievementName,v[1],false,false);
			dgsGridListSetItemText(GUI.Grid[1],row,achievementDesc,v[3],false,false);
		end
	end
end)


addEventHandler("Case->Show->Reward",root,function(reward)
	dgsSetText(GUI.Label["Case"],reward);
end)



function destroyOldUserpanelItems()
	if(isElement(GUI.Combo[1]))then
		destroyElement(GUI.Combo[1]);
	end
	if(isElement(GUI.Combo[2]))then
		destroyElement(GUI.Combo[2]);
	end
	if(isElement(GUI.Combo[3]))then
		destroyElement(GUI.Combo[3]);
	end
	if(isElement(GUI.Combo[4]))then
		destroyElement(GUI.Combo[4]);
	end
	if(isElement(GUI.Combo[5]))then
		destroyElement(GUI.Combo[5]);
	end
	if(isElement(GUI.Combo[6]))then
		destroyElement(GUI.Combo[6]);
	end
	if(isElement(GUI.Combo[7]))then
		destroyElement(GUI.Combo[7]);
	end
	
	if(isElement(GUI.Button[1]))then
		destroyElement(GUI.Button[1]);
	end
	if(isElement(GUI.Button[2]))then
		destroyElement(GUI.Button[2]);
	end
	if(isElement(GUI.Button[3]))then
		destroyElement(GUI.Button[3]);
	end
	
	if(isElement(GUI.Edit[1]))then
		destroyElement(GUI.Edit[1]);
	end
end



local ATMBlip={};
addEventHandler("Locate->ATMs",root,function(status)
	if(status==2)then--on
		for i,v in pairs(getElementsByType("object"))do
			if(getElementModel(v)==2942)then
				if(getElementDimension(v)==0 and getElementInterior(v)==0)then
					local x,y,z=getElementPosition(v);
					ATMBlip[i]=createBlip(x,y,z,1,10,0,0,0,255,0,250);
					setElementData(ATMBlip[i],"Blip->Data->OnlyMinimap",true);
				end
			end
		end
	elseif(status==1)then--off
		for i,v in ipairs(getElementsByType("object"))do 
			if(getElementModel(v)==2942)then
				if(getElementDimension(v)==0 and getElementInterior(v)==0)then
					if(isElement(ATMBlip[i]))then
						destroyElement(ATMBlip[i]);
						ATMBlip[i]=nil;
					end
				end
			end
		end
	end
end)