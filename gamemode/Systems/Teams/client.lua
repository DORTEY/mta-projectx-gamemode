addRemoteEvents{"TeamSelect->UI"};--addEvent


addEventHandler("TeamSelect->UI",root,function(typ,typ2)
	if(typ=="Open")then
		if(typ2)then
			typ2="Switch";
			setUIdatas("set","cursor",true);
		else
			setUIdatas("set","cursor");
		end
		
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-380/2,400,380,loc("UI->TeamSelect->Header"),false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		
		dgsCreateLabel(20,10,100,10,TEAMS["Civilian"].Name.." ("..getTeamMembersOnline("Civilian")..")",false,GUI.Window[1],tocolor(TEAMS["Civilian"].RGB[1],TEAMS["Civilian"].RGB[2],TEAMS["Civilian"].RGB[3]),1.4,1.4,_,_,_,"center");--Civilian
		GUI.Image[1]=dgsCreateImage(20,40,100,100,":"..RESOURCE_NAME.."/Files/Images/Teams/Civilian.png",false,GUI.Window[1]);
		dgsCreateLabel(150,10,100,10,TEAMS["SAPD"].Name.." ("..getTeamMembersOnline("SAPD").."/"..getTeamMembersLimit("SAPD")..")",false,GUI.Window[1],tocolor(TEAMS["SAPD"].RGB[1],TEAMS["SAPD"].RGB[2],TEAMS["SAPD"].RGB[3]),1.4,1.4,_,_,_,"center");--SAPD
		GUI.Image[2]=dgsCreateImage(150,40,100,100,":"..RESOURCE_NAME.."/Files/Images/Teams/SAPD.png",false,GUI.Window[1]);
		dgsCreateLabel(280,10,100,10,TEAMS["FIB"].Name.." ("..getTeamMembersOnline("FIB").."/"..getTeamMembersLimit("FIB")..")",false,GUI.Window[1],tocolor(TEAMS["FIB"].RGB[1],TEAMS["FIB"].RGB[2],TEAMS["FIB"].RGB[3]),1.4,1.4,_,_,_,"center");--FIB
		GUI.Image[3]=dgsCreateImage(280,40,100,100,":"..RESOURCE_NAME.."/Files/Images/Teams/FIB.png",false,GUI.Window[1]);
		
		dgsCreateLabel(20,150,100,10,TEAMS["SAMD"].Name.." ("..getTeamMembersOnline("SAMD").."/"..getTeamMembersLimit("SAMD")..")",false,GUI.Window[1],tocolor(TEAMS["SAMD"].RGB[1],TEAMS["SAMD"].RGB[2],TEAMS["SAMD"].RGB[3]),1.4,1.4,_,_,_,"center");--Grove
		GUI.Image[4]=dgsCreateImage(20,180,100,100,":"..RESOURCE_NAME.."/Files/Images/Teams/SAMD.png",false,GUI.Window[1]);
		dgsCreateLabel(150,150,100,10,TEAMS["Grove"].Name.." ("..getTeamMembersOnline("Grove").."/"..getTeamMembersLimit("Grove")..")",false,GUI.Window[1],tocolor(TEAMS["Grove"].RGB[1],TEAMS["Grove"].RGB[2],TEAMS["Grove"].RGB[3]),1.4,1.4,_,_,_,"center");--Grove
		GUI.Image[5]=dgsCreateImage(150,180,100,100,":"..RESOURCE_NAME.."/Files/Images/Teams/Grove.png",false,GUI.Window[1]);
		dgsCreateLabel(280,150,100,10,TEAMS["Ballas"].Name.." ("..getTeamMembersOnline("Ballas").."/"..getTeamMembersLimit("Ballas")..")",false,GUI.Window[1],tocolor(TEAMS["Ballas"].RGB[1],TEAMS["Ballas"].RGB[2],TEAMS["Ballas"].RGB[3]),1.4,1.4,_,_,_,"center");--Grove
		GUI.Image[6]=dgsCreateImage(280,180,100,100,":"..RESOURCE_NAME.."/Files/Images/Teams/Ballas.png",false,GUI.Window[1]);
		
		GUI.Button[1]=dgsCreateButton(10,305,380,30,loc("UI->TeamSelect->Info->BTN"),false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(not(isElement(GUI.Window[2])))then
						GUI.Window[2]=dgsCreateWindow(GLOBALscreenX/2-500/2-550,GLOBALscreenY/2-380/2,500,380,loc("UI->TeamSelect->Info->BTN"),false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
						dgsWindowSetSizable(GUI.Window[2],false);
						dgsWindowSetMovable(GUI.Window[2],false);
						dgsSetProperty(GUI.Window[2],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
						
						dgsCreateLabel(200,10,100,10,loc("UI->TeamSelect->Info->Text"),false,GUI.Window[2],tocolor(255,255,255),1.4,1.4,_,_,_,"center");
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Image[6],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(getTeamMembersOnline("Ballas")<getTeamMembersLimit("Ballas"))then
						triggerServerEvent("Team->Change",localPlayer,"Ballas");
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc("TeamSelect->Full"));
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[5],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(getTeamMembersOnline("Grove")<getTeamMembersLimit("Grove"))then
						triggerServerEvent("Team->Change",localPlayer,"Grove");
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc("TeamSelect->Full"));
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[4],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(getTeamMembersOnline("SAMD")<getTeamMembersLimit("SAMD"))then
						triggerServerEvent("Team->Change",localPlayer,"SAMD");
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc("TeamSelect->Full"));
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[3],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(getTeamMembersOnline("FIB")<getTeamMembersLimit("FIB"))then
						triggerServerEvent("Team->Change",localPlayer,"FIB");
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc("TeamSelect->Full"));
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					if(getTeamMembersOnline("SAPD")<getTeamMembersLimit("SAPD"))then
						triggerServerEvent("Team->Change",localPlayer,"SAPD");
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc("TeamSelect->Full"));
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					triggerServerEvent("Team->Change",localPlayer,"Civilian");
				end
			end,
		false)
	elseif(typ=="Destroy")then
		showChat(true);
		setUIdatas("rem","cursor",true);
	end
end)