addRemoteEvents{"ATM->UI"};--addEvent


addEventHandler("ATM->UI",root,function(obj,typ)
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
		dgsSetInputMode("no_binds");
		dgsSetInputMode("no_binds_when_editing");
		dgsSetRenderSetting("postGUI",false);
		
		local x,y,z=getElementPosition(obj);--get atm position
		local ATMname=getZoneName(x,y,z,false);--get atm position name
		
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-450/2,GLOBALscreenY/2-400/2,450,400,"ATM - "..ATMname,false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(415,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
		
		GUI.Tabpanel[1]=dgsCreateTabPanel(10,20,430,335,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
		
		--Deposit
		GUI.Tab[1]=dgsCreateTab(loc("UI->ATM->Tab->Deposit"),GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Image[1]=dgsCreateImage(10,10,410,170,":"..RESOURCE_NAME.."/Files/Images/ATM/Banner.png",false,GUI.Tab[1]);--bg image
		GUI.Label[1]=dgsCreateLabel(115,10,200,20,loc("UI->ATM->Balance")..": "..CURRENCY..convertNumber(math.floor(getElementData(localPlayer,"Bankmoney"))),false,GUI.Tab[1],_,1.4,1.4,_,_,_,"center",_);
		GUI.Edit[1]=dgsCreateEdit(10,195,410,40,100,false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,235,410,2,":"..getResourceName(getThisResource()).."/Files/Images/Pixel.png",false,GUI.Tab[1],GUI.Color.Edit.Line);
		GUI.Button["Deposit"]=dgsCreateButton(10,250,410,40,loc("UI->ATM->BTN->Deposit"),false,GUI.Tab[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button["Deposit"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local amount=dgsGetText(GUI.Edit[1])or 0;
					if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
						triggerServerEvent("ATM->Change->Value",localPlayer,"Deposit",tonumber(amount));
					end
				end
			end,
		false)
		--Withdraw
		GUI.Tab[2]=dgsCreateTab(loc("UI->ATM->Tab->Withdraw"),GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255));
		GUI.Image[2]=dgsCreateImage(10,10,410,170,":"..RESOURCE_NAME.."/Files/Images/ATM/Banner.png",false,GUI.Tab[2]);--bg image
		GUI.Label[2]=dgsCreateLabel(115,10,200,20,loc("UI->ATM->Balance")..": "..CURRENCY..convertNumber(math.floor(getElementData(localPlayer,"Bankmoney"))),false,GUI.Tab[2],_,1.4,1.4,_,_,_,"center",_);
		GUI.Edit[2]=dgsCreateEdit(10,195,410,40,100,false,GUI.Tab[2],tocolor(255,255,255,255),_,_,_,GUI.Color.Edit.BG);
		dgsCreateImage(10,235,410,2,":"..getResourceName(getThisResource()).."/Files/Images/Pixel.png",false,GUI.Tab[2],GUI.Color.Edit.Line);
		GUI.Button["Withdraw"]=dgsCreateButton(10,250,410,40,loc("UI->ATM->BTN->Withdraw"),false,GUI.Tab[2],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		addEventHandler("onDgsMouseClick",GUI.Button["Withdraw"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local amount=dgsGetText(GUI.Edit[2])or 0;
					if(amount~=nil and amount~="" and isOnlyNumber(amount)and #amount>0)then
						triggerServerEvent("ATM->Change->Value",localPlayer,"Withdraw",tonumber(amount));
					end
				end
			end,
		false)
		
		
		dgsSetEnabled(GUI.Image[1],false);
		dgsSetEnabled(GUI.Image[2],false);
		
		addEventHandler("onDgsMouseClick",GUI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="down")then
					setUIdatas("rem","cursor",true);
				end
			end,
		false)
	elseif(typ=="Refresh")then
		if(isClickedState(localPlayer)==true)then
			dgsSetText(GUI.Label[1],loc("UI->ATM->Balance")..": "..CURRENCY..convertNumber(math.floor(getElementData(localPlayer,"Bankmoney"))));
			dgsSetText(GUI.Label[2],loc("UI->ATM->Balance")..": "..CURRENCY..convertNumber(math.floor(getElementData(localPlayer,"Bankmoney"))));
		end
	elseif(typ=="Close")then
		if(isClickedState(localPlayer)==true)then
			setUIdatas("rem","cursor",true);
		end
	end
end)