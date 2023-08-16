local PHONE_STATUS=false;
local PHONE_ASIDE=false;
local PHONE_PAGE=1;
local PHONE_SETTINGS={--x,y,wx,wy
	[0]={--iPhone 6 1
		["Main"]={1580*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["MainAside"]={1460*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["Background"]={1596*Gsx,425*Gsy,268*Gsy,421*Gsy},
		["BackgroundAside"]={1476*Gsx,425*Gsy,270*Gsy,421*Gsy},
		["AppDrawRec"]={1596*Gsx,775*Gsy,268*Gsx,70*Gsy,false},--true = rounded
		["Time"]={3355*Gsx,430*Gsy,100*Gsx,20*Gsy},
		["Home"]={1710*Gsx,855*Gsy,40*Gsy,40*Gsy,"Home"},
		["HomeAside"]={1830*Gsx,615*Gsy,40*Gsy,40*Gsy},
		
		--["Radio"]={1670*Gsx,715*Gsy,50*Gsy,50*Gsy,"Radio"},
		["YT"]={1605*Gsx,715*Gsy,50*Gsy,50*Gsy,"Youtube"},
		["Settings"]={1800*Gsx,785*Gsy,50*Gsy,50*Gsy,"Settings"},
		["Navi"]={1735*Gsx,785*Gsy,50*Gsy,50*Gsy,"Navigator"},
		["Message"]={1670*Gsx,785*Gsy,50*Gsy,50*Gsy,"Message"},
		["Contacts"]={1605*Gsx,785*Gsy,50*Gsy,50*Gsy,"Contacts"},
		
		--gui
		["YoutubeAside"]={1360*Gsx,502*Gsy,465*Gsy,267*Gsy},
	},
	[1]={--iPhone 6 2
		["Main"]={1580*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["MainAside"]={1460*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["Background"]={1596*Gsx,425*Gsy,268*Gsy,421*Gsy},
		["BackgroundAside"]={1476*Gsx,425*Gsy,270*Gsy,421*Gsy},
		["AppDrawRec"]={1596*Gsx,775*Gsy,268*Gsx,70*Gsy,false},--true = rounded
		["Time"]={3355*Gsx,430*Gsy,100*Gsx,20*Gsy},
		["Home"]={1710*Gsx,855*Gsy,40*Gsy,40*Gsy,"Home"},
		["HomeAside"]={1830*Gsx,615*Gsy,40*Gsy,40*Gsy},
		
		--["Radio"]={1670*Gsx,715*Gsy,50*Gsy,50*Gsy,"Radio"},
		["YT"]={1605*Gsx,715*Gsy,50*Gsy,50*Gsy,"Youtube"},
		["Settings"]={1800*Gsx,785*Gsy,50*Gsy,50*Gsy,"Settings"},
		["Navi"]={1735*Gsx,785*Gsy,50*Gsy,50*Gsy,"Navigator"},
		["Message"]={1670*Gsx,785*Gsy,50*Gsy,50*Gsy,"Message"},
		["Contacts"]={1605*Gsx,785*Gsy,50*Gsy,50*Gsy,"Contacts"},
		
		--gui
		["YoutubeAside"]={1360*Gsx,502*Gsy,465*Gsy,267*Gsy},
	},
	[2]={--iPhone 14
		["Main"]={1580*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["MainAside"]={1460*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["Background"]={1596*Gsx,373*Gsy,270*Gsy,525*Gsy},
		["BackgroundAside"]={1474*Gsx,372*Gsy,272*Gsy,525*Gsy},
		["AppDrawRec"]={1605*Gsx,815*Gsy,250*Gsx,70*Gsy,true},--true = rounded
		["Time"]={3185*Gsx,375*Gsy,100*Gsx,20*Gsy},
		["Home"]={1715*Gsx,880*Gsy,35*Gsy,20*Gsy,"Home"},
		["HomeAside"]={1860*Gsx,620*Gsy,20*Gsy,35*Gsy},
		
		--["Radio"]={1680*Gsx,760*Gsy,45*Gsy,45*Gsy,"Radio"},
		["YT"]={1620*Gsx,760*Gsy,45*Gsy,45*Gsy,"Youtube"},
		["Settings"]={1800*Gsx,828*Gsy,45*Gsy,45*Gsy,"Settings"},
		["Navi"]={1740*Gsx,828*Gsy,45*Gsy,45*Gsy,"Navigator"},
		["Message"]={1680*Gsx,828*Gsy,45*Gsy,45*Gsy,"Message"},
		["Contacts"]={1620*Gsx,828*Gsy,45*Gsy,45*Gsy,"Contacts"},
		
		--gui
		["YoutubeAside"]={1360*Gsx,500*Gsy,506*Gsy,268*Gsy},
	},
	[3]={--Samsung S8
		["Main"]={1580*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["MainAside"]={1460*Gsx,360*Gsy,300*Gsy,550*Gsy},
		["Background"]={1592*Gsx,390*Gsy,276*Gsy,500*Gsy},
		["BackgroundAside"]={1474*Gsx,372*Gsy,272*Gsy,525*Gsy},
		["Time"]={3355*Gsx,400*Gsy,100*Gsx,20*Gsy},
		["Home"]={1710*Gsx,882*Gsy,40*Gsy,25*Gsy,"Home"},
		["HomeAside"]={1860*Gsx,620*Gsy,20*Gsy,35*Gsy},
		
		--["Radio"]={1673*Gsx,752*Gsy,50*Gsy,50*Gsy,"Radio"},
		["YT"]={1605*Gsx,752*Gsy,50*Gsy,50*Gsy,"Youtube"},
		["Settings"]={1805*Gsx,820*Gsy,50*Gsy,50*Gsy,"Settings"},
		["Navi"]={1740*Gsx,820*Gsy,50*Gsy,50*Gsy,"Navigator"},
		["Message"]={1673*Gsx,820*Gsy,50*Gsy,50*Gsy,"Message"},
		["Contacts"]={1605*Gsx,820*Gsy,50*Gsy,50*Gsy,"Contacts"},
		
		--gui
		["YoutubeAside"]={1360*Gsx,500*Gsy,502*Gsy,268*Gsy},
	}
};
local PHONE_MARK_TIMER=nil;
local PHONE_MARK_BLIP=nil;

bindKey("B","DOWN",function()
	if(not(isLoggedin()))then
		return;
	end
	if(isClickedState(localPlayer)==true and PHONE_STATUS==false)then
		return;
	end
	
	PHONE_STATUS=not PHONE_STATUS;
	PHONE_ASIDE=false;
	
	if(PHONE_STATUS)then
		setUIdatas("set","cursor");
		
		PHONE_PAGE=1;
		addEventHandler("onClientRender",root,PhoneDraw);
		addEventHandler("onClientClick",root,PhoneClick);
	else
		if(isElement(GUI.Combo[1]))then
			destroyElement(GUI.Combo[1]);
		end
		destroyPhoneUIElements();
		setUIdatas("rem","cursor",true);
		
		removeEventHandler("onClientRender",root,PhoneDraw);
		removeEventHandler("onClientClick",root,PhoneClick);
	end
end)

function PhoneDraw()
	--time
	local time=getRealTime();
	if(time.hour<10)then
		time.hour="0"..time.hour;
	end
	if(time.minute<10)then
		time.minute="0"..time.minute;
	end
	
	local PhoneModel=tonumber(getElementData(localPlayer,"PhoneModel"));
	--phone images
	if(not(PHONE_ASIDE))then
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["Background"][1],PHONE_SETTINGS[PhoneModel]["Background"][2],PHONE_SETTINGS[PhoneModel]["Background"][3],PHONE_SETTINGS[PhoneModel]["Background"][4],"Files/Images/Phone/Backgrounds/"..getElementData(localPlayer,"PhoneBackground")..".png",0,0,0,tocolor(210,210,210,255),false);--bg
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["Main"][1],PHONE_SETTINGS[PhoneModel]["Main"][2],PHONE_SETTINGS[PhoneModel]["Main"][3],PHONE_SETTINGS[PhoneModel]["Main"][4],"Files/Images/Phone/Model/"..PhoneModel..".png",0,0,0,tocolor(255,255,255,255),false);--main
	else
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["BackgroundAside"][1],PHONE_SETTINGS[PhoneModel]["BackgroundAside"][2],PHONE_SETTINGS[PhoneModel]["BackgroundAside"][3],PHONE_SETTINGS[PhoneModel]["BackgroundAside"][4],"Files/Images/Phone/Backgrounds/"..getElementData(localPlayer,"PhoneBackground")..".png",-90,0,0,tocolor(210,210,210,255),false);--bg
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["MainAside"][1],PHONE_SETTINGS[PhoneModel]["MainAside"][2],PHONE_SETTINGS[PhoneModel]["MainAside"][3],PHONE_SETTINGS[PhoneModel]["MainAside"][4],"Files/Images/Phone/Model/"..PhoneModel..".png",-90,0,0,tocolor(255,255,255,255),false);--main
	end
	
	--hover tips
	if(PHONE_PAGE~=1)then
		if(not(PHONE_ASIDE))then
			if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Home"][1],PHONE_SETTINGS[PhoneModel]["Home"][2],PHONE_SETTINGS[PhoneModel]["Home"][3],PHONE_SETTINGS[PhoneModel]["Home"][4]))then--home button
				dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["Home"][1],PHONE_SETTINGS[PhoneModel]["Home"][2]-23,(dxGetTextWidth("Home",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
				dxDrawText(PHONE_SETTINGS[PhoneModel]["Home"][5],PHONE_SETTINGS[PhoneModel]["Home"][1],PHONE_SETTINGS[PhoneModel]["Home"][2]-23,(dxGetTextWidth("Home",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
			end
		end
	end
	--draw main page
	if(PHONE_PAGE==1)then
		dxDrawText(time.hour..":"..time.minute,PHONE_SETTINGS[PhoneModel]["Time"][1],PHONE_SETTINGS[PhoneModel]["Time"][2],PHONE_SETTINGS[PhoneModel]["Time"][3],PHONE_SETTINGS[PhoneModel]["Time"][4],tocolor(255,255,255,255),1.25*Gsx,"default","center",_,_,_,false,_,_);
		
		--bottom apps
		if(PHONE_SETTINGS[PhoneModel]["AppDrawRec"])then--phone bottom apps background
			if(PHONE_SETTINGS[PhoneModel]["AppDrawRec"][5])then
				dxDrawRoundedRectangle(PHONE_SETTINGS[PhoneModel]["AppDrawRec"][1],PHONE_SETTINGS[PhoneModel]["AppDrawRec"][2],PHONE_SETTINGS[PhoneModel]["AppDrawRec"][3],PHONE_SETTINGS[PhoneModel]["AppDrawRec"][4],30,tocolor(0,0,0,90),false);
			else
				dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["AppDrawRec"][1],PHONE_SETTINGS[PhoneModel]["AppDrawRec"][2],PHONE_SETTINGS[PhoneModel]["AppDrawRec"][3],PHONE_SETTINGS[PhoneModel]["AppDrawRec"][4],tocolor(0,0,0,90),false);
			end
		end
		--dxDrawImage(PHONE_SETTINGS[PhoneModel]["Radio"][1],PHONE_SETTINGS[PhoneModel]["Radio"][2],PHONE_SETTINGS[PhoneModel]["Radio"][3],PHONE_SETTINGS[PhoneModel]["Radio"][4],"Files/Images/Phone/Apps/Radio.png",0,0,0,tocolor(255,255,255,255),false);--radio
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["YT"][1],PHONE_SETTINGS[PhoneModel]["YT"][2],PHONE_SETTINGS[PhoneModel]["YT"][3],PHONE_SETTINGS[PhoneModel]["YT"][4],"Files/Images/Phone/Apps/Youtube.png",0,0,0,tocolor(255,255,255,255),false);--youtube
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["Settings"][1],PHONE_SETTINGS[PhoneModel]["Settings"][2],PHONE_SETTINGS[PhoneModel]["Settings"][3],PHONE_SETTINGS[PhoneModel]["Settings"][4],"Files/Images/Phone/Apps/Settings.png",0,0,0,tocolor(255,255,255,255),false);--settings
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["Navi"][1],PHONE_SETTINGS[PhoneModel]["Navi"][2],PHONE_SETTINGS[PhoneModel]["Navi"][3],PHONE_SETTINGS[PhoneModel]["Navi"][4],"Files/Images/Phone/Apps/Navigator.png",0,0,0,tocolor(255,255,255,255),false);--navigator
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["Message"][1],PHONE_SETTINGS[PhoneModel]["Message"][2],PHONE_SETTINGS[PhoneModel]["Message"][3],PHONE_SETTINGS[PhoneModel]["Message"][4],"Files/Images/Phone/Apps/Message.png",0,0,0,tocolor(255,255,255,255),false);--message
		dxDrawImage(PHONE_SETTINGS[PhoneModel]["Contacts"][1],PHONE_SETTINGS[PhoneModel]["Contacts"][2],PHONE_SETTINGS[PhoneModel]["Contacts"][3],PHONE_SETTINGS[PhoneModel]["Contacts"][4],"Files/Images/Phone/Apps/Contacts.png",0,0,0,tocolor(255,255,255,255),false);--contacts
		
		
		--hover tips
		--if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Radio"][1],PHONE_SETTINGS[PhoneModel]["Radio"][2],PHONE_SETTINGS[PhoneModel]["Radio"][3],PHONE_SETTINGS[PhoneModel]["YT"][4]))then--radio
		--	dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["Radio"][1],PHONE_SETTINGS[PhoneModel]["Radio"][2]-23,(dxGetTextWidth("Radio",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
		--	dxDrawText(PHONE_SETTINGS[PhoneModel]["Radio"][5],PHONE_SETTINGS[PhoneModel]["Radio"][1],PHONE_SETTINGS[PhoneModel]["Radio"][2]-23,(dxGetTextWidth("Radio",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
		--end
		if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["YT"][1],PHONE_SETTINGS[PhoneModel]["YT"][2],PHONE_SETTINGS[PhoneModel]["YT"][3],PHONE_SETTINGS[PhoneModel]["YT"][4]))then--youtube
			dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["YT"][1],PHONE_SETTINGS[PhoneModel]["YT"][2]-23,(dxGetTextWidth("Youtube",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
			dxDrawText(PHONE_SETTINGS[PhoneModel]["YT"][5],PHONE_SETTINGS[PhoneModel]["YT"][1],PHONE_SETTINGS[PhoneModel]["YT"][2]-23,(dxGetTextWidth("Youtube",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
		end
		
		if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Settings"][1],PHONE_SETTINGS[PhoneModel]["Settings"][2],PHONE_SETTINGS[PhoneModel]["Settings"][3],PHONE_SETTINGS[PhoneModel]["Settings"][4]))then--settings
			dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["Settings"][1],PHONE_SETTINGS[PhoneModel]["Settings"][2]-23,(dxGetTextWidth("Settings",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
			dxDrawText(PHONE_SETTINGS[PhoneModel]["Settings"][5],PHONE_SETTINGS[PhoneModel]["Settings"][1],PHONE_SETTINGS[PhoneModel]["Settings"][2]-23,(dxGetTextWidth("Settings",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
		end
		
		if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Navi"][1],PHONE_SETTINGS[PhoneModel]["Navi"][2],PHONE_SETTINGS[PhoneModel]["Navi"][3],PHONE_SETTINGS[PhoneModel]["Navi"][4]))then--navigator
			dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["Navi"][1],PHONE_SETTINGS[PhoneModel]["Navi"][2]-23,(dxGetTextWidth("Navigator",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
			dxDrawText(PHONE_SETTINGS[PhoneModel]["Navi"][5],PHONE_SETTINGS[PhoneModel]["Navi"][1],PHONE_SETTINGS[PhoneModel]["Navi"][2]-23,(dxGetTextWidth("Navigator",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
		end
		
		if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Message"][1],PHONE_SETTINGS[PhoneModel]["Message"][2],PHONE_SETTINGS[PhoneModel]["Message"][3],PHONE_SETTINGS[PhoneModel]["Message"][4]))then--message
			dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["Message"][1],PHONE_SETTINGS[PhoneModel]["Message"][2]-23,(dxGetTextWidth("Message",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
			dxDrawText(PHONE_SETTINGS[PhoneModel]["Message"][5],PHONE_SETTINGS[PhoneModel]["Message"][1],PHONE_SETTINGS[PhoneModel]["Message"][2]-23,(dxGetTextWidth("Message",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
		end
		
		if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Contacts"][1],PHONE_SETTINGS[PhoneModel]["Contacts"][2],PHONE_SETTINGS[PhoneModel]["Contacts"][3],PHONE_SETTINGS[PhoneModel]["Contacts"][4]))then--contacts
			dxDrawRectangle(PHONE_SETTINGS[PhoneModel]["Contacts"][1],PHONE_SETTINGS[PhoneModel]["Contacts"][2]-23,(dxGetTextWidth("Contacts",1.20*Gsx,"default")),23*Gsy,tocolor(0,0,0,120),false);
			dxDrawText(PHONE_SETTINGS[PhoneModel]["Contacts"][5],PHONE_SETTINGS[PhoneModel]["Contacts"][1],PHONE_SETTINGS[PhoneModel]["Contacts"][2]-23,(dxGetTextWidth("Contacts",1.20*Gsx,"default")),cursorY,tocolor(255,255,255,255),1.20*Gsx,"default");
		end
	end
end

function PhoneClick(button,state)--click funcs and create stuff
	local PhoneModel=tonumber(getElementData(localPlayer,"PhoneModel"));
	if(button=="left" and state=="down")then
		if(PHONE_PAGE~=1)then
			if(not(PHONE_ASIDE))then
				PHONE_BTN_HOME_POS={PHONE_SETTINGS[PhoneModel]["Home"][1],PHONE_SETTINGS[PhoneModel]["Home"][2],PHONE_SETTINGS[PhoneModel]["Home"][3],PHONE_SETTINGS[PhoneModel]["Home"][4]};
			else
				PHONE_BTN_HOME_POS={PHONE_SETTINGS[PhoneModel]["HomeAside"][1],PHONE_SETTINGS[PhoneModel]["HomeAside"][2],PHONE_SETTINGS[PhoneModel]["HomeAside"][3],PHONE_SETTINGS[PhoneModel]["HomeAside"][4]};
			end
			
			if(isCursorOnElement(PHONE_BTN_HOME_POS[1],PHONE_BTN_HOME_POS[2],PHONE_BTN_HOME_POS[3],PHONE_BTN_HOME_POS[4]))then--back to home
				if(isElement(GUI.Combo[1]))then
					destroyElement(GUI.Combo[1]);
				end
				destroyPhoneUIElements();
				PHONE_PAGE=1;
				PHONE_ASIDE=false;
			end
		end
		
		if(PHONE_PAGE==1)then--check phone site 1 (main)
			if(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Settings"][1],PHONE_SETTINGS[PhoneModel]["Settings"][2],PHONE_SETTINGS[PhoneModel]["Settings"][3],PHONE_SETTINGS[PhoneModel]["Settings"][4]))then--settings
				if(isElement(GUI.Combo[1]))then
					destroyElement(GUI.Combo[1]);
				end
				destroyPhoneUIElements();
				PHONE_PAGE=2;
				
				GUI.Combo[1]=guiCreateComboBox(1610*Gsx,440*Gsy,240*Gsx,300*Gsy,"",false);
				guiComboBoxAddItem(GUI.Combo[1],"Select Background");
				guiComboBoxAddItem(GUI.Combo[1],"Select Model");
				guiComboBoxAddItem(GUI.Combo[1],"Change Account Password");
				
				addEventHandler("onClientGUIComboBoxAccepted",GUI.Combo[1],
					function(btn,state)
						local amount=guiComboBoxGetSelected(GUI.Combo[1]);
						destroyPhoneUIElements();
						if(amount==0)then--phone background
							GUI.Grid[1]=guiCreateGridList(1610*Gsx,470*Gsy,240*Gsx,360*Gsy,false);
							local itemID=guiGridListAddColumn(GUI.Grid[1],"",0.14);
							local itemName=guiGridListAddColumn(GUI.Grid[1],"",0.75);
							
							for _,v in pairs(PHONE_TABLES.BG)do
								local row=guiGridListAddRow(GUI.Grid[1]);
								guiGridListSetItemText(GUI.Grid[1],row,itemID,v[1],false,false);
								guiGridListSetItemText(GUI.Grid[1],row,itemName,v[2],false,false);
							end
							
							addEventHandler("onClientGUIClick",GUI.Grid[1],
								function(btn,state)
									if(btn=="left" and state=="up")then
										local clicked=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),1);
										local clicked2=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),2);
										if(clicked~="" and clicked~=nil)then
											triggerServerEvent("Phone->Settings",localPlayer,"Background",clicked,clicked2);
										end
									end
								end,
							false)
						elseif(amount==1)then--phone model
							GUI.Grid[1]=guiCreateGridList(1610*Gsx,470*Gsy,240*Gsx,360*Gsy,false);
							local itemID=guiGridListAddColumn(GUI.Grid[1],"",0.14);
							local itemName=guiGridListAddColumn(GUI.Grid[1],"",0.75);
							
							for _,v in pairs(PHONE_TABLES.MODEL)do
								local row=guiGridListAddRow(GUI.Grid[1]);
								guiGridListSetItemText(GUI.Grid[1],row,itemID,v[1],false,false);
								guiGridListSetItemText(GUI.Grid[1],row,itemName,v[2],false,false);
							end
							
							addEventHandler("onClientGUIClick",GUI.Grid[1],
								function(btn,state)
									if(btn=="left" and state=="up")then
										local clicked=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),1);
										local clicked2=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),2);
										if(clicked~="" and clicked~=nil)then
											triggerServerEvent("Phone->Settings",localPlayer,"Model",clicked,clicked2);
										end
									end
								end,
							false)
						elseif(amount==2)then--password change
							guiSetInputMode("no_binds");
							guiSetInputMode("no_binds_when_editing");
							
							GUI.Label[1]=guiCreateLabel(1610*Gsx,465*Gsy,200*Gsx,15*Gsy,"Old Password",false);
							GUI.Edit[1]=guiCreateEdit(1610*Gsx,480*Gsy,240*Gsx,30*Gsy,"",false);
							GUI.Label[2]=guiCreateLabel(1610*Gsx,515*Gsy,200*Gsx,15*Gsy,"New Password",false);
							GUI.Edit[2]=guiCreateEdit(1610*Gsx,530*Gsy,240*Gsx,30*Gsy,"",false);
							
							GUI.Button[1]=guiCreateButton(1610*Gsx,570*Gsy,240*Gsx,30*Gsy,"Change password",false);
							
							
							guiEditSetMasked(GUI.Edit[1],true);
							guiEditSetMasked(GUI.Edit[2],true);
							
							addEventHandler("onClientGUIClick",GUI.Button[1],
								function(btn,state)
									if(btn=="left" and state=="up")then
										local passwordOld=tostring(guiGetText(GUI.Edit[1]))or "";
										local passwordNew=tostring(guiGetText(GUI.Edit[2]))or "";
										
										if(passwordNew~="" and type(passwordNew)=="string" and #passwordNew>=4)then
											triggerServerEvent("Account->ChangePW",localPlayer,passwordOld,passwordNew);
										else
											triggerEvent("Infobox->UI",localPlayer,"error",loc("UI->Register->MSG->PasswordNotLongEnough"));
										end
									end
								end,
							false)
						end
					end,
				false)
			elseif(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Navi"][1],PHONE_SETTINGS[PhoneModel]["Navi"][2],PHONE_SETTINGS[PhoneModel]["Navi"][3],PHONE_SETTINGS[PhoneModel]["Navi"][4]))then--navigator
				if(isElement(GUI.Combo[1]))then
					destroyElement(GUI.Combo[1]);
				end
				destroyPhoneUIElements();
				PHONE_PAGE=3;
				
				GUI.Combo[1]=guiCreateComboBox(1610*Gsx,440*Gsy,240*Gsx,300*Gsy,"",false);
				guiComboBoxAddItem(GUI.Combo[1],"State/Gangs");
				guiComboBoxAddItem(GUI.Combo[1],"Jobs");
				
				addEventHandler("onClientGUIComboBoxAccepted",GUI.Combo[1],
					function(btn,state)
						local amount=guiComboBoxGetSelected(GUI.Combo[1]);
						destroyPhoneUIElements();
						if(amount==0)then--state facs
							GUI.Grid[1]=guiCreateGridList(1610*Gsx,470*Gsy,240*Gsx,360*Gsy,false);
							local itemName=guiGridListAddColumn(GUI.Grid[1],"",0.85);
							
							for i,v in pairs(TEAMS)do
								if(i~="Civilian")then--block civilian
									local row=guiGridListAddRow(GUI.Grid[1]);
									guiGridListSetItemText(GUI.Grid[1],row,itemName,i,false,false);
								end
							end
							
							addEventHandler("onClientGUIClick",GUI.Grid[1],
								function(btn,state)
									if(btn=="left" and state=="up")then
										local clicked=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),1);
										if(clicked~="" and clicked~=nil)then
											if(isTimer(PHONE_MARK_TIMER))then--destroy elements if exist already
												killTimer(PHONE_MARK_TIMER);
												PHONE_MARK_TIMER=nil;
											end
											if(isElement(PHONE_MARK_BLIP))then
												destroyElement(PHONE_MARK_BLIP);
												PHONE_MARK_BLIP=nil;
											end
											PHONE_MARK_TIMER=setTimer(function()
												killTimer(PHONE_MARK_TIMER);
												PHONE_MARK_TIMER=nil;
												if(isElement(PHONE_MARK_BLIP))then
													destroyElement(PHONE_MARK_BLIP);
													PHONE_MARK_BLIP=nil;
												end
											end,5*60*1000,1)
											PHONE_MARK_BLIP=createBlip(TEAMS[clicked].BlipPOS[1],TEAMS[clicked].BlipPOS[2],TEAMS[clicked].BlipPOS[3],0,20,0,220,0,255,0);
											setElementData(PHONE_MARK_BLIP,"tooltipText","Faction Mark ("..clicked..")");
										end
									end
								end,
							false)
						elseif(amount==1)then--jobs
							GUI.Grid[1]=guiCreateGridList(1610*Gsx,470*Gsy,240*Gsx,360*Gsy,false);
							local itemName=guiGridListAddColumn(GUI.Grid[1],"",0.85);
							
							for i,v in pairs(JOBS)do
								local row=guiGridListAddRow(GUI.Grid[1]);
								guiGridListSetItemText(GUI.Grid[1],row,itemName,i,false,false);
							end
							
							addEventHandler("onClientGUIClick",GUI.Grid[1],
								function(btn,state)
									if(btn=="left" and state=="up")then
										local clicked=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),1);
										if(clicked~="" and clicked~=nil)then
											if(isTimer(PHONE_MARK_TIMER))then--destroy elements if exist already
												killTimer(PHONE_MARK_TIMER);
												PHONE_MARK_TIMER=nil;
											end
											if(isElement(PHONE_MARK_BLIP))then
												destroyElement(PHONE_MARK_BLIP);
												PHONE_MARK_BLIP=nil;
											end
											PHONE_MARK_TIMER=setTimer(function()
												killTimer(PHONE_MARK_TIMER);
												PHONE_MARK_TIMER=nil;
												if(isElement(PHONE_MARK_BLIP))then
													destroyElement(PHONE_MARK_BLIP);
													PHONE_MARK_BLIP=nil;
												end
											end,5*60*1000,1)
											PHONE_MARK_BLIP=createBlip(JOBS[clicked].BlipPOS[1],JOBS[clicked].BlipPOS[2],JOBS[clicked].BlipPOS[3],0,20,0,220,0,255,0);
											setElementData(PHONE_MARK_BLIP,"tooltipText","Job Mark ("..clicked..")");
										end
									end
								end,
							false)
						end
					end,
				false)
			elseif(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["YT"][1],PHONE_SETTINGS[PhoneModel]["YT"][2],PHONE_SETTINGS[PhoneModel]["YT"][3],PHONE_SETTINGS[PhoneModel]["YT"][4]))then--youtube
				if(isElement(GUI.Combo[1]))then
					destroyElement(GUI.Combo[1]);
				end
				destroyPhoneUIElements();
				PHONE_PAGE=4;
				PHONE_ASIDE=true;
				
				GUI.Browser[1]=guiCreateBrowser(PHONE_SETTINGS[PhoneModel]["YoutubeAside"][1],PHONE_SETTINGS[PhoneModel]["YoutubeAside"][2],PHONE_SETTINGS[PhoneModel]["YoutubeAside"][3],PHONE_SETTINGS[PhoneModel]["YoutubeAside"][4],false,false,false);
				theBrowser=guiGetBrowser(GUI.Browser[1]);
				requestBrowserDomains({"youtube.com/tv",true});
				
				addEventHandler("onClientBrowserCreated",theBrowser,
					function()
						loadBrowserURL(source,"https://youtube.com/tv");
						focusBrowser(source);
						guiSetInputMode("no_binds");
						guiSetInputMode("no_binds_when_editing");
					end,
				false)
			elseif(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Message"][1],PHONE_SETTINGS[PhoneModel]["Message"][2],PHONE_SETTINGS[PhoneModel]["Message"][3],PHONE_SETTINGS[PhoneModel]["Message"][4]))then--message
				if(isElement(GUI.Combo[1]))then
					destroyElement(GUI.Combo[1]);
				end
				destroyPhoneUIElements();
				PHONE_PAGE=5;
				guiSetInputMode("no_binds");
				guiSetInputMode("no_binds_when_editing");
				
				GUI.Grid[1]=guiCreateGridList(1605*Gsx,435*Gsy,245*Gsx,220*Gsy,false);
				contactName=guiGridListAddColumn(GUI.Grid[1],"Name",0.85);
				
				GUI.Memo[1]=guiCreateMemo(1605*Gsx,670*Gsy,245*Gsx,120*Gsy,"",false);
				
				GUI.Button[1]=guiCreateButton(1605*Gsx,800*Gsy,245*Gsx,35*Gsy,"Send Message",false);
				
				local json=fromJSON(getElementData(localPlayer,"Phone_Contacts"))or '{}';
				for k,v in pairs(json)do
					if(v==true)then
						local target=getPlayerFromName(k);
						local row=guiGridListAddRow(GUI.Grid[1]);
						guiGridListSetItemText(GUI.Grid[1],row,contactName,k,false,false);
						
						if(isElement(target))then
							guiGridListSetItemColor(GUI.Grid[1],row,contactName,0,200,0,255);
						else
							guiGridListSetItemColor(GUI.Grid[1],row,contactName,200,0,0,255);
						end
					end
				end
				
				addEventHandler("onClientGUIClick",GUI.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local clicked=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),1);
							if(clicked~="")then
								local text=tostring(guiGetText(GUI.Memo[1]))or "";
								if(text~="" and type(text)=="string" and #text>=3)then
									triggerServerEvent("Phone->Contact",localPlayer,"Message",clicked,text);
								end
							end
						end
					end,
				false)
			elseif(isCursorOnElement(PHONE_SETTINGS[PhoneModel]["Contacts"][1],PHONE_SETTINGS[PhoneModel]["Contacts"][2],PHONE_SETTINGS[PhoneModel]["Contacts"][3],PHONE_SETTINGS[PhoneModel]["Contacts"][4]))then--contacts
				if(isElement(GUI.Combo[1]))then
					destroyElement(GUI.Combo[1]);
				end
				destroyPhoneUIElements();
				PHONE_PAGE=6;
				
				GUI.Grid[1]=guiCreateGridList(1610*Gsx,440*Gsy,240*Gsx,300*Gsy,false);
				contactName=guiGridListAddColumn(GUI.Grid[1],"Name",0.85);
				
				GUI.Edit[1]=guiCreateEdit(1610*Gsx,750*Gsy,240*Gsx,35*Gsy,"",false);
				
				GUI.Button[1]=guiCreateButton(1610*Gsx,795*Gsy,240*Gsx,35*Gsy,"Add/Remove Contact",false);
				
				guiGridListSetSortingEnabled(GUI.Grid[1],false);
				
				local json=fromJSON(getElementData(localPlayer,"Phone_Contacts"))or '{}';
				for k,v in pairs(json)do
					if(v==true)then
						local target=getPlayerFromName(k);
						local row=guiGridListAddRow(GUI.Grid[1]);
						guiGridListSetItemText(GUI.Grid[1],row,contactName,k,false,false);
						
						if(isElement(target))then
							guiGridListSetItemColor(GUI.Grid[1],row,contactName,0,200,0,255);
						else
							guiGridListSetItemColor(GUI.Grid[1],row,contactName,200,0,0,255);
						end
					end
				end
				
				addEventHandler("onClientGUIClick",GUI.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local clicked=guiGridListGetItemText(GUI.Grid[1],guiGridListGetSelectedItem(GUI.Grid[1]),1);
							if(clicked~="")then
								triggerServerEvent("Phone->Contact",localPlayer,"Rem",clicked);
							else
								local pName=tostring(guiGetText(GUI.Edit[1]))or "";
								
								if(pName~="" and type(pName)=="string" and #pName>=4)then
									triggerServerEvent("Phone->Contact",localPlayer,"Add",pName);
								end
							end
						end
					end,
				false)
			end
		end
	end
end


function destroyPhoneUIElements()
	for i=1,5 do
		if(isElement(GUI.Edit[i]))then
			destroyElement(GUI.Edit[i]);
		end
		if(isElement(GUI.Memo[i]))then
			destroyElement(GUI.Memo[i]);
		end
		if(isElement(GUI.Label[i]))then
			destroyElement(GUI.Label[i]);
		end
		
		if(isElement(GUI.Tabpanel[i]))then
			destroyElement(GUI.Tabpanel[i]);
		end
		if(isElement(GUI.Grid[i]))then
			destroyElement(GUI.Grid[i]);
		end
		if(isElement(GUI.Browser[i]))then
			destroyElement(GUI.Browser[i]);
		end
		
		if(isElement(GUI.Button[i]))then
			destroyElement(GUI.Button[i]);
		end
	end
end


addEventHandler("onClientPlayerWasted",root,function(player)
	if(player==localPlayer)then
		if(PHONE_STATUS)then
			PHONE_STATUS=false;
			destroyPhoneUIElements();
			setUIdatas("rem","cursor",true);
			
			removeEventHandler("onClientRender",root,PhoneDraw);
			removeEventHandler("onClientClick",root,PhoneClick);
		end
	end
end)


PHONE_TABLES={
	BG={
		{0,"Nexus 1"},
		{1,"OnePlus 3T"},
		{2,"Xperia X"},
		{3,"iOS 10"},
		{4,"Google Pixle"},
		{5,"Nexus 2"},
		{6,"Nexus 3"},
		{7,"iOS 14"},
		{8,"iOS 14 2"},
	},
	MODEL={
		{0,"iPhone 6 (White)"},
		{1,"iPhone 6 (Black)"},
		{2,"iPhone 14"},
		{3,"Samsung S8"},
	}
};