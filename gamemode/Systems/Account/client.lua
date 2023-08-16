addRemoteEvents{"RegisterLogin->UI"};--addEvent


local RenderStatus=false;
local RenderAlpha=0;
addEventHandler("onClientResourceStart_Custom",resourceRoot,function()
	triggerServerEvent("Trigger->RegisterLogin->UI",localPlayer,"Login");
end)


addEventHandler("RegisterLogin->UI",root,function(typ)
	if(typ=="Register")then
		if(GLOBALscreenX<1920 and GLOBALscreenY<1080)then
			if(RenderStatus==true and RenderAlpha~=0)then
				RenderStatus=false;
			else
				RenderStatus=false;
				removeEventHandler("onClientRender",root,renderSmallResolutionUI);
				addEventHandler("onClientRender",root,renderSmallResolutionUI);
			end
		end
		setLoginRegisterStuff();
		setUIdatas("set","cursor");
		
		GUI.Window["UI->Element->Register"]=dgsCreateWindow(0*Gsx,0*Gsy,350*Gsx,1080*Gsy,"",false,tocolor(255,255,255),0,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window["UI->Element->Register"],false);
		dgsWindowSetMovable(GUI.Window["UI->Element->Register"],false);
		dgsSetProperty(GUI.Window["UI->Element->Register"],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		
		GUI.Blurbox[1]=dgsCreateBlurBox(350*Gsx,1080*Gsy);
		GUI.Blurbox[2]=dgsCreateImage(0*Gsx,0*Gsy,350*Gsx,1080*Gsy,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window["UI->Element->Register"],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		--logo
		dgsCreateImage(120*Gsx,10*Gsy,100*Gsx,100*Gsy,":"..RESOURCE_NAME.."/Files/Images/Logo.png",false,GUI.Window["UI->Element->Register"]);
		
		--username
		dgsCreateImage(5*Gsx,145*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/RegisterLogin/User.png",false,GUI.Window["UI->Element->Register"]);
		GUI.Label[1]=dgsCreateLabel(60*Gsx,125*Gsy,100*Gsx,25*Gsy,loc("UI->Register->Name")..":",false,GUI.Window["UI->Element->Register"]);
		GUI.Edit[1]=dgsCreateEdit(60*Gsx,145*Gsy,250*Gsx,40*Gsy,"",false,GUI.Window["UI->Element->Register"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
		dgsCreateImage(60*Gsx,185*Gsy,250*Gsx,2*Gsy,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Window["UI->Element->Register"],GUI.Color.Edit.Line);
		
		--password
		dgsCreateImage(5*Gsx,225*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/RegisterLogin/Password.png",false,GUI.Window["UI->Element->Register"]);
		GUI.Label[2]=dgsCreateLabel(60*Gsx,205*Gsy,100*Gsx,25*Gsy,loc("UI->Register->Pass")..":",false,GUI.Window["UI->Element->Register"]);
		GUI.Edit[2]=dgsCreateEdit(60*Gsx,225*Gsy,250*Gsx,40*Gsy,"",false,GUI.Window["UI->Element->Register"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
		dgsCreateImage(60*Gsx,265*Gsy,250*Gsx,2*Gsy,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Window["UI->Element->Register"],GUI.Color.Edit.Line);
		
		--gender
		GUI.Label[3]=dgsCreateLabel(60*Gsx,305*Gsy,100,20,loc("UI->Register->Gender")..":",false,GUI.Window["UI->Element->Register"]);
		GUI.Radio[1]=dgsCreateRadioButton(60*Gsx,330*Gsy,11,11,loc("UI->Register->GenderM"),false,GUI.Window["UI->Element->Register"]);
		GUI.Radio[2]=dgsCreateRadioButton(60*Gsx,350*Gsy,11,11,loc("UI->Register->GenderF"),false,GUI.Window["UI->Element->Register"]);
		
		
		--||bottom
		GUI.Image[999]=dgsCreateImage(0*Gsx,1050*Gsy,350*Gsx,30*Gsy,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Window["UI->Element->Register"],GUI.Color.Edit.Line);
		dgsSetEnabled(GUI.Image[999],false);
		dgsCreateLabel(30*Gsx,1055*Gsy,100*Gsx,25*Gsy,SERVER_COPYRIGHT,false,GUI.Window["UI->Element->Register"],_,1.4,1.4);
		
		--select language
		GUI.Image[1]=dgsCreateImage(10*Gsx,975*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/DE.png",false,GUI.Window["UI->Element->Register"]);
		GUI.Image[2]=dgsCreateImage(180*Gsx,975*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/EN.png",false,GUI.Window["UI->Element->Register"]);
		GUI.Image[3]=dgsCreateImage(10*Gsx,895*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/TR.png",false,GUI.Window["UI->Element->Register"]);
		GUI.Image[4]=dgsCreateImage(180*Gsx,895*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/RU.png",false,GUI.Window["UI->Element->Register"]);
		
		--login btn
		GUI.Button[2]=dgsCreateButton(50*Gsx,750*Gsy,250*Gsx,40*Gsy,loc("UI->Login->Button"),false,GUI.Window["UI->Element->Register"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		--register btn
		GUI.Button[1]=dgsCreateButton(50*Gsx,700*Gsy,250*Gsx,40*Gsy,loc("UI->Register->Button"),false,GUI.Window["UI->Element->Register"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		
		
		--some small events
		addEventHandler("onDgsMouseClick",GUI.Image[4],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"RU");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"TR");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"EN");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"DE");
				end
			end,
		false)
		
		addEventHandler("onDgsMouseEnter",GUI.Edit[1],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[1],"bgColor",GUI.Color.Edit.BG_Hover);
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Edit[1],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[1],"bgColor",GUI.Color.Edit.BG);
				end
			end,
		false)
		addEventHandler("onDgsMouseEnter",GUI.Edit[2],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[2],"bgColor",GUI.Color.Edit.BG_Hover);
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Edit[2],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[2],"bgColor",GUI.Color.Edit.BG);
				end
			end,
		false)
		
		
		--set some ui element datas
		dgsEditSetMasked(GUI.Edit[2],true);
		dgsEditSetMaxLength(GUI.Edit[1],15);
		dgsRadioButtonSetSelected(GUI.Radio[1],true);
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					triggerServerEvent("Trigger->RegisterLogin->UI",localPlayer,"Login");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local username=tostring(dgsGetText(GUI.Edit[1]))or "";
					local password=tostring(dgsGetText(GUI.Edit[2]))or "";
					
					if(username~="" and type(username)=="string" and #username>=3 and #username<=15)then
						if(password~="" and type(password)=="string" and #password>=4)then
							if(dgsRadioButtonGetSelected(GUI.Radio[1])==true)then
								gender="Male";
							elseif(dgsRadioButtonGetSelected(GUI.Radio[2])==true)then
								gender="Female";
							end
							local language=getElementData(localPlayer,"Language")or "EN";
							
							triggerServerEvent("Account->Register",localPlayer,username,password,gender,language);
						else
							triggerEvent("Infobox->UI",localPlayer,"error",loc("UI->Register->MSG->PasswordNotLongEnough"));
						end
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc("UI->Register->MSG->UsernameNotLongEnough"));
					end
				end
			end,
		false)
		
	elseif(typ=="Login")then
		if(GLOBALscreenX<1920 and GLOBALscreenY<1080)then
			if(RenderStatus==true and RenderAlpha~=0)then
				RenderStatus=false;
			else
				RenderStatus=false;
				removeEventHandler("onClientRender",root,renderSmallResolutionUI);
				addEventHandler("onClientRender",root,renderSmallResolutionUI);
			end
		end
		setLoginRegisterStuff();
		setUIdatas("set","cursor");
		
		GUI.Window["UI->Element->Login"]=dgsCreateWindow(0*Gsx,0*Gsy,350*Gsx,1080*Gsy,"",false,tocolor(255,255,255),0,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window["UI->Element->Login"],false);
		dgsWindowSetMovable(GUI.Window["UI->Element->Login"],false);
		dgsSetProperty(GUI.Window["UI->Element->Login"],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		
		GUI.Blurbox[1]=dgsCreateBlurBox(350*Gsx,1080*Gsy);
		GUI.Blurbox[2]=dgsCreateImage(0*Gsx,0*Gsy,350*Gsx,1080*Gsy,GUI.Blurbox[1],false);
		dgsAttachElements(GUI.Blurbox[2],GUI.Window["UI->Element->Login"],0,0,1,1,true,true);
		dgsSetLayer(GUI.Blurbox[2],"bottom");
		
		--logo
		dgsCreateImage(120*Gsx,10*Gsy,100*Gsx,100*Gsy,":"..RESOURCE_NAME.."/Files/Images/Logo.png",false,GUI.Window["UI->Element->Login"]);
		
		
		
		--username
		dgsCreateImage(5*Gsx,145*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/RegisterLogin/User.png",false,GUI.Window["UI->Element->Login"]);
		GUI.Label[1]=dgsCreateLabel(60*Gsx,125*Gsy,100*Gsx,25*Gsy,loc("UI->Login->Name")..":",false,GUI.Window["UI->Element->Login"]);
		GUI.Edit[1]=dgsCreateEdit(60*Gsx,145*Gsy,250*Gsx,40*Gsy,"",false,GUI.Window["UI->Element->Login"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
		dgsCreateImage(60*Gsx,185*Gsy,250*Gsx,2*Gsy,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Window["UI->Element->Login"],GUI.Color.Edit.Line);
		
		--password
		dgsCreateImage(5*Gsx,225*Gsy,40*Gsx,40*Gsy,":"..RESOURCE_NAME.."/Files/Images/RegisterLogin/Password.png",false,GUI.Window["UI->Element->Login"]);
		GUI.Label[2]=dgsCreateLabel(60*Gsx,205*Gsy,100*Gsx,25*Gsy,loc("UI->Login->Pass")..":",false,GUI.Window["UI->Element->Login"]);
		GUI.Edit[2]=dgsCreateEdit(60*Gsx,225*Gsy,250*Gsx,40*Gsy,"",false,GUI.Window["UI->Element->Login"],tocolor(255,255,255,255),1.3,1.3,_,GUI.Color.Edit.BG);
		dgsCreateImage(60*Gsx,265*Gsy,250*Gsx,2*Gsy,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Window["UI->Element->Login"],GUI.Color.Edit.Line);
		
		--autologin
		GUI.Radio[1]=dgsCreateCheckBox(60*Gsx,320*Gsy,15*Gsx,15*Gsy,loc("UI->Login->SaveName"),false,false,GUI.Window["UI->Element->Login"],tocolor(255,255,255),1.2,1.2);
		GUI.Radio[2]=dgsCreateCheckBox(60*Gsx,360*Gsy,15*Gsx,15*Gsy,loc("UI->Login->SavePW"),false,false,GUI.Window["UI->Element->Login"],tocolor(255,255,255),1.2,1.2);
		
		
		--||bottom
		GUI.Image[999]=dgsCreateImage(0*Gsx,1050*Gsy,350*Gsx,30*Gsy,":"..RESOURCE_NAME.."/Files/Images/Pixel.png",false,GUI.Window["UI->Element->Login"],GUI.Color.Edit.Line);
		dgsSetEnabled(GUI.Image[999],false);
		dgsCreateLabel(30*Gsx,1055*Gsy,100*Gsx,25*Gsy,SERVER_COPYRIGHT,false,GUI.Window["UI->Element->Login"],_,1.4,1.4);
		
		--select language
		GUI.Image[1]=dgsCreateImage(10*Gsx,975*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/DE.png",false,GUI.Window["UI->Element->Login"]);
		GUI.Image[2]=dgsCreateImage(180*Gsx,975*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/EN.png",false,GUI.Window["UI->Element->Login"]);
		GUI.Image[3]=dgsCreateImage(10*Gsx,895*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/TR.png",false,GUI.Window["UI->Element->Login"]);
		GUI.Image[4]=dgsCreateImage(180*Gsx,895*Gsy,150*Gsx,60*Gsy,":"..RESOURCE_NAME.."/Files/Images/Language/RU.png",false,GUI.Window["UI->Element->Login"]);
		
		--login btn
		GUI.Button[1]=dgsCreateButton(50*Gsx,700*Gsy,250*Gsx,40*Gsy,loc("UI->Login->Button"),false,GUI.Window["UI->Element->Login"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		--register btn
		GUI.Button[2]=dgsCreateButton(50*Gsx,750*Gsy,250*Gsx,40*Gsy,loc("UI->Register->Button"),false,GUI.Window["UI->Element->Login"],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		
		
		
		--some small events
		if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/username.txt"))then
			local pwFile=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
			username=tostring(fileRead(pwFile,fileGetSize(pwFile)));
			fileClose(pwFile);
			
			dgsCheckBoxSetSelected(GUI.Radio[1],true);
			dgsSetText(GUI.Edit[1],username);
		else
			dgsCheckBoxSetSelected(GUI.Radio[1],false);
		end
		if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
			--local pwFile=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
			--password=tostring(fileRead(pwFile,fileGetSize(pwFile)));
			--fileClose(pwFile);
			--
			--dgsCheckBoxSetSelected(GUI.Radio[2],true);
			--dgsSetText(GUI.Edit[2],password);
			local pwFile=fileOpen(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
			local password=tostring(fileRead(pwFile,fileGetSize(pwFile)));
			local getUnhashPassword=teaDecode(password,"KIDJFKFSJIFISJFUHAZZFAF");
			
			dgsSetText(GUI.Edit[2],getUnhashPassword);
			fileClose(pwFile);
			dgsCheckBoxSetSelected(GUI.Radio[2],true);
		else
			dgsCheckBoxSetSelected(GUI.Radio[2],false);
		end
		addEventHandler("onDgsMouseEnter",GUI.Image[4],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[4],"color",tocolor(150,150,150,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Image[4],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[4],"color",tocolor(255,255,255,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseEnter",GUI.Image[3],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[3],"color",tocolor(150,150,150,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Image[3],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[3],"color",tocolor(255,255,255,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseEnter",GUI.Image[2],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[2],"color",tocolor(150,150,150,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Image[2],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[2],"color",tocolor(255,255,255,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseEnter",GUI.Image[1],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[1],"color",tocolor(150,150,150,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Image[1],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Image[1],"color",tocolor(255,255,255,255));
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[4],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"RU");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"TR");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"EN");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Image[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("Language->Change",localPlayer,"DE");
				end
			end,
		false)
		
		addEventHandler("onDgsMouseEnter",GUI.Edit[2],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[2],"bgColor",GUI.Color.Edit.BG_Hover);
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Edit[2],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[2],"bgColor",GUI.Color.Edit.BG);
				end
			end,
		false)
		addEventHandler("onDgsMouseEnter",GUI.Edit[1],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[1],"bgColor",GUI.Color.Edit.BG_Hover);
				end
			end,
		false)
		addEventHandler("onDgsMouseLeave",GUI.Edit[1],
			function(x,y)
				if(x and y)then
					dgsSetProperty(GUI.Edit[1],"bgColor",GUI.Color.Edit.BG);
				end
			end,
		false)
		
		
		--set some ui element datas
		dgsEditSetMasked(GUI.Edit[2],true);
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					triggerServerEvent("Trigger->RegisterLogin->UI",localPlayer,"Register");
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local username=tostring(dgsGetText(GUI.Edit[1]))or "";
					local password=tostring(dgsGetText(GUI.Edit[2]))or "";
					
					if(username~="" and type(username)=="string" and password~="" and type(password)=="string")then
						triggerServerEvent("Account->Login",localPlayer,username,password);
					end
				end
			end,
		false)
		
	elseif(typ=="Switch")then
		if(isElement(GUI.Window["UI->Element->Register"]))then
			if(isElement(GUI.Blurbox[1]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window["UI->Element->Register"]);
				dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window["UI->Element->Register"]);
			end
			destroyElement(GUI.Window["UI->Element->Register"]);
		end
		if(isElement(GUI.Window["UI->Element->Login"]))then
			if(isElement(GUI.Blurbox[1]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window["UI->Element->Login"]);
				dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window["UI->Element->Login"]);
			end
			destroyElement(GUI.Window["UI->Element->Login"]);
		end
	elseif(typ=="Destroy")then--destroy UI after register/login
		if(isElement(GUI.Window["UI->Element->Login"]))then
			if(dgsCheckBoxGetSelected(GUI.Radio[1])==true)then
				if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/username.txt"))then
					fileDelete(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
				end
				
				local pwFile=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
				fileWrite(pwFile,dgsGetText(GUI.Edit[1]));
				fileClose(pwFile);
			else
				if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/username.txt"))then
					fileDelete(":"..RESOURCE_NAME.."/ClientFiles/username.txt");
				end
			end
			if(dgsCheckBoxGetSelected(GUI.Radio[2])==true)then
				--if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
				--	fileDelete(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
				--end
				--
				--local pwFile=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
				--fileWrite(pwFile,dgsGetText(GUI.Edit[2]));
				--fileClose(pwFile);
				if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
					fileDelete(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
				end
				
				local pwFile=fileCreate(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
				local getHashPassword=teaEncode(dgsGetText(GUI.Edit[2]),"KIDJFKFSJIFISJFUHAZZFAF");
				fileWrite(pwFile,getHashPassword);
				fileClose(pwFile);
			else
				if(fileExists(":"..RESOURCE_NAME.."/ClientFiles/password.txt"))then
					fileDelete(":"..RESOURCE_NAME.."/ClientFiles/password.txt");
				end
			end
		end
		
		if(isElement(GUI.Window["UI->Element->Register"]))then
			if(isElement(GUI.Blurbox[1]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window["UI->Element->Register"]);
				dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window["UI->Element->Register"]);
			end
			destroyElement(GUI.Window["UI->Element->Register"]);
		end
		if(isElement(GUI.Window["UI->Element->Login"]))then
			if(isElement(GUI.Blurbox[1]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window["UI->Element->Login"]);
				dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window["UI->Element->Login"]);
			end
			destroyElement(GUI.Window["UI->Element->Login"]);
		end
		showChat(true);
		setUIdatas("rem","cursor",true);
		RenderStatus=true;
		
		--bind some keys to funcs
		bindKey("M","DOWN",getCursor);
	elseif(typ=="Update")then
		if(isElement(GUI.Window["UI->Element->Register"]))then
			dgsSetText(GUI.Label[1],loc("UI->Register->Name")..":");--username text
			dgsSetText(GUI.Label[2],loc("UI->Register->Pass")..":");--password text
			dgsSetText(GUI.Label[3],loc("UI->Register->Gender")..":");--gender select text
			dgsSetText(GUI.Radio[1],loc("UI->Register->GenderM"));--gender male text
			dgsSetText(GUI.Radio[2],loc("UI->Register->GenderF"));--gender female text
			dgsSetText(GUI.Button[1],loc("UI->Register->Button"));--register btn text
		elseif(isElement(GUI.Window["UI->Element->Login"]))then
			dgsSetText(GUI.Label[1],loc("UI->Login->Name")..":");--password text
			dgsSetText(GUI.Label[2],loc("UI->Login->Pass")..":");--password text
			dgsSetText(GUI.Button[1],loc("UI->Login->Button"));--login btn text
			dgsSetText(GUI.Radio[1],loc("UI->Login->SaveName"));--login save name? text
			dgsSetText(GUI.Radio[2],loc("UI->Login->SavePW"));--login save pw? text
		end
	end
end)





function setLoginRegisterStuff()
	dgsSetInputMode("no_binds");
	dgsSetInputMode("no_binds_when_editing");
	dgsSetRenderSetting("postGUI",false);
	showChat(false);
	fadeCamera(true);
	
	setCameraMatrix(1468.9,-919.3,100.2, 1468.4,-918.4,99.9);
	setElementDimension(localPlayer,0);
	setElementInterior(localPlayer,0);
	setElementPosition(localPlayer,0,0,-20);
	setElementFrozen(localPlayer,true);
end

function renderSmallResolutionUI()
	if(RenderAlpha<1 and RenderStatus==false)then
		RenderAlpha=RenderAlpha+0.01;
	elseif(RenderAlpha>0 and RenderStatus==true)then
		RenderAlpha=RenderAlpha-0.01;
	elseif(RenderAlpha==0 and RenderStatus==true)then
		removeEventHandler("onClientRender",root,renderSmallResolutionUI)
		RenderStatus=false;
	end
	
	dxDrawRectangle(1620*Gsx,300*Gsy,300*Gsx,100*Gsy,tocolor(180,0,0,140*RenderAlpha),false);
	dxDrawText("SMALL RESOLUTION!",3510*Gsx,310*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*RenderAlpha),1.70*Gsx,"default-bold","center",_,_,_,false,_,_);
	dxDrawText("You're playing on a small resolution!\nSome UI's might be not correct!",3510*Gsx,350*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*RenderAlpha),1.15*Gsx,"default-bold","center");
end