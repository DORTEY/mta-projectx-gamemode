addRemoteEvents{"Inventory->UI","Inventory->UI->Refresh"};--addEvent


local InventoryText="";
local InventoryText2="";
local InventoryScroll=0;
local InventoryTbl={};--check them also serverside

local InventorySlots={
	{710,450,60,60},
	{780,450,60,60},
	{850,450,60,60},
	{920,450,60,60},
	{990,450,60,60},
	{1060,450,60,60},
	{1130,450,60,60},
};

local UseAbleItemsTooltip={
	["Bread"]=true,
	["Donut"]=true,
	["Milk"]=true,
	["Water"]=true,
	["Bandage"]=true,
	["Medikit"]=true,
	["Armor"]=true,
}

addEventHandler("Inventory->UI",root,function(typ,inventoryItems)
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
		
		local sound=playSound(":"..RESOURCE_NAME.."/Files/Audio/UI/Open.mp3");
		setSoundVolume(sound,0.7);
		
		setUIdatas("set","cursor");
		bindKey("mouse_wheel_down","down",scrollDown);
		bindKey("mouse_wheel_up","down",scrollUp);
		fillInventoryWithItems(inventoryItems);
		addEventHandler("onClientRender",root,drawInventory);--draw inventory
		addEventHandler("onClientDoubleClick",root,InventoryClick);--add clickable item event
	elseif(typ=="Close")then
		local sound=playSound(":"..RESOURCE_NAME.."/Files/Audio/UI/Close.mp3");
		setSoundVolume(sound,0.7);
		
		setUIdatas("rem","cursor",true);
		removeEventHandler("onClientRender",root,drawInventory);--destroy inventory draw
		removeEventHandler("onClientDoubleClick",root,InventoryClick);--remove clickable item event
		
		InventoryText="";
		InventoryText2="";
	end
end)


function drawInventory()
	dxDrawRectangle(700*Gsx,400*Gsy,500*Gsx,270*Gsy,tocolor(0,0,0,140),false);--background
	dxDrawText(InventoryText,900*Gsx,810*Gsy,1000*Gsx,20*Gsy,tocolor(255,255,255,255),1.20*Gsx,"default-bold","center","center",false,false,false,false,false);
	dxDrawText(InventoryText2,900*Gsx,1295*Gsy,1000*Gsx,20*Gsy,tocolor(255,255,255,255),1.20*Gsx,"default-bold","center","center",false,false,false,false,false);
	
	dxDrawRectangle(700*Gsx,400*Gsy,25*Gsx,4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top left corner
	dxDrawRectangle(700*Gsx,400*Gsy,4*Gsx,25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top left corner
	dxDrawRectangle(1200*Gsx,400*Gsy,-25*Gsx,4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top right corner
	dxDrawRectangle(1200*Gsx,400*Gsy,-4*Gsx,25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--top right corner
	dxDrawRectangle(700*Gsx,670*Gsy,25*Gsx,-4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom left corner
	dxDrawRectangle(700*Gsx,670*Gsy,4*Gsx,-25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom left corner
	dxDrawRectangle(1200*Gsx,670*Gsy,-25*Gsx,-4*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom right corner
	dxDrawRectangle(1200*Gsx,670*Gsy,-4*Gsx,-25*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],255),false);--bottom right corner
	
	for i=0,2 do--3 lines
		local coord=450+(i*66);
		dxDrawRectangle(710*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
		dxDrawRectangle(780*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
		dxDrawRectangle(850*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
		dxDrawRectangle(920*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
		dxDrawRectangle(990*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
		dxDrawRectangle(1060*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
		dxDrawRectangle(1130*Gsx,coord*Gsy,60*Gsx,60*Gsy,tocolor(255,255,255,140),false);
	end
	
	for i=1+InventoryScroll,7+InventoryScroll do
		if(InventoryTbl[i])then
			local tbl=InventoryTbl[i];
			dxDrawImage(tbl[3],tbl[4],tbl[5],tbl[6],"Files/Images/Inventory/"..tbl[1]..".png",0,0,0,tocolor(255,255,255,255),false);
			if(isCursorOnElement(tbl[3],tbl[4],tbl[5],tbl[6]))then
				--dxDrawRectangle(tbl[3],tbl[4],tbl[5],tbl[6],tocolor(120,120,120,200),false);
				InventoryText=loc("Item->Name->"..tbl[1]).." ("..math.floor(tbl[2]).."x)";
				if(UseAbleItemsTooltip[tbl[1]])then
					InventoryText2="Double LMB - Use item";
				else
					InventoryText2="";
				end
			end
		end
	end
	for i=8+InventoryScroll,14+InventoryScroll do
		if(InventoryTbl[i])then
			local tbl=InventoryTbl[i];
			dxDrawImage(tbl[3],tbl[4]+66*Gsy,tbl[5],tbl[6],"Files/Images/Inventory/"..tbl[1]..".png",0,0,0,tocolor(255,255,255,255),false);
			if(isCursorOnElement(tbl[3],tbl[4]+66*Gsy,tbl[5],tbl[6]))then
				--dxDrawRectangle(tbl[3],tbl[4]+66*Gsy,tbl[5],tbl[6],tocolor(120,120,120,200),false);
				InventoryText=loc("Item->Name->"..tbl[1]).." ("..math.floor(tbl[2]).."x)";
				if(UseAbleItemsTooltip[tbl[1]])then
					InventoryText2="Double LMB - Use item";
				else
					InventoryText2="";
				end
			end
		end
	end
	for i=15+InventoryScroll,21+InventoryScroll do
		if(InventoryTbl[i])then
			local tbl=InventoryTbl[i];
			dxDrawImage(tbl[3],tbl[4]+66*Gsy,tbl[5],tbl[6],"Files/Images/Inventory/"..tbl[1]..".png",0,0,0,tocolor(255,255,255,255),false);
			if(isCursorOnElement(tbl[3],tbl[4]+66*Gsy,tbl[5],tbl[6]))then
				--dxDrawRectangle(tbl[3],tbl[4]+66*Gsy,tbl[5],tbl[6],tocolor(120,120,120,200),false);
				InventoryText=loc("Item->Name->"..tbl[1]).." ("..math.floor(tbl[2]).."x)";
				if(UseAbleItemsTooltip[tbl[1]])then
					InventoryText2="Double LMB - Use item";
				else
					InventoryText2="";
				end
			end
		end
	end
end

function fillInventoryWithItems(items)
	local counter=0;
	local distance=0;
	InventoryScroll=0;
	
	InventoryTbl={};
	for item,value in pairs(items)do
		if(value>0)then
			if(counter>=7)then
				counter=0;
			end
			counter=counter+1;
			
			local tbl=InventorySlots[counter];
			table.insert(InventoryTbl,{
				item,
				value,
				tbl[1]*Gsx,
				(tbl[2]+distance*66)*Gsy,
				tbl[3]*Gsx,
				tbl[4]*Gsy
			});
		end
	end
end
addEventHandler("Inventory->UI->Refresh",root,fillInventoryWithItems)


function InventoryClick(button)
	if(button=="left")then
		for i=1+InventoryScroll,7+InventoryScroll do
			if(InventoryTbl[i])then
				local tbl=InventoryTbl[i];
				if(isCursorOnElement(tbl[3],tbl[4],tbl[5],tbl[6]))then
					triggerServerEvent("Inventory->Use",localPlayer,tbl[1]);
				end
			end
		end
		
		for i=8+InventoryScroll,14+InventoryScroll do
			if(InventoryTbl[i])then
				local tbl=InventoryTbl[i];
				if(isCursorOnElement(tbl[3],tbl[4]+60*(GLOBALscreenY/900),tbl[5],tbl[6]))then
					triggerServerEvent("Inventory->Use",localPlayer,tbl[1]);
				end
			end
		end
		
		for i=15+InventoryScroll,21+InventoryScroll do
			if(InventoryTbl[i])then
				local tbl=InventoryTbl[i];
				if(isCursorOnElement(tbl[3],tbl[4]+60*(GLOBALscreenY/900),tbl[5],tbl[6]))then
					triggerServerEvent("Inventory->Use",localPlayer,tbl[1]);
				end
			end
		end
	end
end

function scrollDown()
	if(InventoryScroll+21<#InventoryTbl)then
		InventoryScroll=InventoryScroll+7;
	end
end
function scrollUp()
	if(InventoryScroll>0)then
		InventoryScroll=InventoryScroll-7;
	end
end


addEventHandler("onClientPlayerWasted",root,function(player)
	if(player==localPlayer)then
		--todo
	end
end)