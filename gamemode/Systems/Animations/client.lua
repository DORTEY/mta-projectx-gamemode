local AnimationSounds={};
local AnimationTimer={};
addEvent("Sync->Animation",true)
addEventHandler("Sync->Animation",root,function(player,animation,duration)
	if(animation)then
		setPedAnimation(player,unpack(animation));
	else
		setPedAnimation(player);
	end
	
	if(duration and duration~=-1)then
		if(isTimer(AnimationTimer[player]))then
			killTimer(AnimationTimer[player]);
			AnimationTimer[player]=nil;
		end
		AnimationTimer[player]=setTimer(function(player)
			if(isElement(AnimationSounds[player]))then
				destroyElement(AnimationSounds[player]);
				AnimationSounds[player]=nil;
			end
			setPedAnimation(player);
		end,duration,1,player)
	end
end)
addEvent("Create->Animation->Sound",true)
addEventHandler("Create->Animation->Sound",root,function(player,typ,x,y,z,sound,duration)
	if(isElement(AnimationSounds[player]))then
		destroyElement(AnimationSounds[player]);
		AnimationSounds[player]=nil;
	end
	
	if(typ=="create")then
		AnimationSounds[player]=playSound3D(":"..getResourceName(getThisResource()).."/Files/Audio/Animations/"..sound..".mp3",x,y,z,true);
		setSoundMaxDistance(AnimationSounds[player],tonumber(15));
		setSoundVolume(AnimationSounds[player],0.4);
		setElementDimension(AnimationSounds[player],getElementDimension(player));
		setElementInterior(AnimationSounds[player],getElementInterior(player));
		
		if(duration and duration~=-1)then
			if(isTimer(AnimationTimer[player]))then
				killTimer(AnimationTimer[player]);
				AnimationTimer[player]=nil;
			end
			AnimationTimer[player]=setTimer(function(player)
				if(isElement(AnimationSounds[player]))then
					destroyElement(AnimationSounds[player]);
					AnimationSounds[player]=nil;
				end
			end,duration,1,player)
		end
	end
end)



local animationTables={
	["General"]={
		"Hands up",
		"Hands up 2",
		"Wave",
		"Cross arms",
		"Fuck you",
		"Fuck you 2",
		"Laugh",
		"Hide",
		"Show something",
		"Piss",
		"Deal",
		"Lying down 1",
		"Lying down 2",
		"Lying down 3",
		"Sit down (Male)",
		"Sit down (Female)",
		"---------------------------------",
		"Fortnite (Come here)",
		"Fortnite (Infinity)",
	},
	["Dances"]={
		"Dancing clapping 1",
		"Dancing clapping 2",
		"Dancing oriental",
		"Dancing chill",
		"Dancing rhythmic",
		"Dancing wild",
		"Dancing hiphop",
		"Dancing sexy",
		"Dancing slutty",
		"Dancing strip 1",
		"Dancing strip 2",
	},
	["18+"]={
		"Sex top",
		"Sex bottom",
		"Masturbate",
		"Slap that ass",
	},
	["Donor"]={
		"Fortnite (Orange Justice)",
		"Fortnite (Smooth Moves)",
		"Fortnite (Eagle)",
		"Fortnite (Electro Shuffle)",
		"Fortnite (Dance Moves)",
		"Fortnite (Bel-Air)",
		"Fortnite (Hype)",
		"Fortnite (Floss)",
		"Fortnite (Take the L)",
		"Fortnite (Best Mate)",
		"Fortnite (Groove)",
	}
};


local animationListTable_Idle={
	"Idle 1",
	"Idle 2",
	"Idle 3",
	"Idle (Armed)",
};

bindKey("f7","down",function()
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	if(getElementDimension(localPlayer)>0)then
		return;
	end
	if(getElementInterior(localPlayer)>0)then
		return;
	end
	
	setUIdatas("set","cursor",true);
	
	GUI.Window[1]=dgsCreateWindow(10,GLOBALscreenY/2-550/2,450,550,"Animation menu",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
	dgsWindowSetSizable(GUI.Window[1],false);
	dgsWindowSetMovable(GUI.Window[1],false);
	dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
	GUI.Button["Close"]=dgsCreateButton(415,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true);
	
	GUI.Blurbox[1]=dgsCreateBlurBox(450,550);
	GUI.Blurbox[2]=dgsCreateImage(10,GLOBALscreenY/2-550/2,450,550,GUI.Blurbox[1],false);
	dgsAttachElements(GUI.Blurbox[2],GUI.Window[1],0,0,1,1,true,true);
	dgsSetLayer(GUI.Blurbox[2],"bottom");
	
	GUI.Tabpanel[1]=dgsCreateTabPanel(10,50,430,455,false,GUI.Window[1],GUI.Settings.Height,_,tocolor(0,0,0,180));
	--general
	GUI.Tab[1]=dgsCreateTab("General",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
	
	GUI.Grid[1]=dgsCreateGridList(10,10,410,400,false,GUI.Tab[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
	GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
	dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
	
	local anim=dgsGridListAddColumn(GUI.Grid[1],"Animation",1);
	for i,v in pairs(animationTables["General"])do
		local row=dgsGridListAddRow(GUI.Grid[1]);
		dgsGridListSetItemText(GUI.Grid[1],row,anim,animationTables["General"][i],false,false);
	end
	
	addEventHandler("onDgsMouseDoubleClick",GUI.Grid[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[1]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
					if(clicked~="")then
						triggerServerEvent("Play->Animation",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	
	--dances
	GUI.Tab[2]=dgsCreateTab("Dances",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
	
	GUI.Grid[2]=dgsCreateGridList(10,10,410,400,false,GUI.Tab[2],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255))
	GUI.Scroll[2]=dgsGridListGetScrollBar(GUI.Grid[2]);
	dgsSetProperty(GUI.Scroll[2],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[2],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[2],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[2],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[2],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[2],"scrollBarThick",0);
	
	local anim=dgsGridListAddColumn(GUI.Grid[2],"Animation",1);
	for i,v in pairs(animationTables["Dances"])do
		local row=dgsGridListAddRow(GUI.Grid[2]);
		dgsGridListSetItemText(GUI.Grid[2],row,anim,animationTables["Dances"][i],false,false);
	end
	
	addEventHandler("onDgsMouseDoubleClick",GUI.Grid[2],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[2]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[2],dgsGridListGetSelectedItem(GUI.Grid[2]),1);
					if(clicked~="")then
						triggerServerEvent("Play->Animation",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	
	--+18
	GUI.Tab[3]=dgsCreateTab("18+",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
	
	GUI.Grid[3]=dgsCreateGridList(10,10,410,400,false,GUI.Tab[3],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255))
	GUI.Scroll[3]=dgsGridListGetScrollBar(GUI.Grid[3]);
	dgsSetProperty(GUI.Scroll[3],"troughColor",tocolor(0,0,0,200));
	dgsSetProperty(GUI.Scroll[3],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
	dgsSetProperty(GUI.Scroll[3],"scrollArrow",false);
	dgsSetProperty(GUI.Grid[3],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
	dgsSetProperty(GUI.Grid[3],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
	dgsSetProperty(GUI.Grid[3],"scrollBarThick",0);
	
	local anim=dgsGridListAddColumn(GUI.Grid[3],"Animation",1);
	for i,v in pairs(animationTables["18+"])do
		local row=dgsGridListAddRow(GUI.Grid[3]);
		dgsGridListSetItemText(GUI.Grid[3],row,anim,animationTables["18+"][i],false,false);
	end
	
	addEventHandler("onDgsMouseDoubleClick",GUI.Grid[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(GUI.Grid[3]);
				if(item>0)then
					local clicked=dgsGridListGetItemText(GUI.Grid[3],dgsGridListGetSelectedItem(GUI.Grid[3]),1);
					if(clicked~="")then
						triggerServerEvent("Play->Animation",localPlayer,clicked);
					end
				end
			end
		end,
	false)
	
	
	if(getElementData(localPlayer,"Player->Data->Premium")==1)then
		--donor
		GUI.Tab[8]=dgsCreateTab("DONATOR",GUI.Tabpanel[1],1.3,1.3,tocolor(255,255,255),nil,tocolor(0,0,0,140),nil,nil,nil,_,GUI.Color.Bar,GUI.Color.Bar,_,_,tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
		
		GUI.Grid[8]=dgsCreateGridList(10,10,410,400,false,GUI.Tab[8],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255))
		GUI.Scroll[8]=dgsGridListGetScrollBar(GUI.Grid[8]);
		dgsSetProperty(GUI.Scroll[8],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[8],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[8],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[8],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[8],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[8],"scrollBarThick",0);
		
		local anim=dgsGridListAddColumn(GUI.Grid[8],"Animation",1);
		for i,v in pairs(animationTables["Donor"])do
			local row=dgsGridListAddRow(GUI.Grid[8]);
			dgsGridListSetItemText(GUI.Grid[8],row,anim,animationTables["Donor"][i],false,false);
		end
		
		addEventHandler("onDgsMouseDoubleClick",GUI.Grid[8],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(GUI.Grid[8]);
					if(item>0)then
						local clicked=dgsGridListGetItemText(GUI.Grid[8],dgsGridListGetSelectedItem(GUI.Grid[8]),1);
						if(clicked~="")then
							triggerServerEvent("Play->Animation",localPlayer,clicked);
						end
					end
				end
			end,
		false)
	end
	
	
	dgsGridListSetSortEnabled(GUI.Grid[1],false);
	dgsGridListSetSortEnabled(GUI.Grid[2],false);
	dgsGridListSetSortEnabled(GUI.Grid[3],false);
	dgsGridListSetSortEnabled(GUI.Grid[8],false);
	dgsSetProperty(GUI.Grid[1],"rowHeight",35);
	dgsSetProperty(GUI.Grid[2],"rowHeight",35);
	dgsSetProperty(GUI.Grid[3],"rowHeight",35);
	dgsSetProperty(GUI.Grid[8],"rowHeight",35);
	
	addEventHandler("onDgsMouseClick",GUI.Button["Close"],
		function(btn,state)
			if(btn=="left" and state=="down")then
				setUIdatas("rem","cursor",true);
			end
		end,
	false)
end)