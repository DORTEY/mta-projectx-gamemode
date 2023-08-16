RadarStatus=false;
HORNS={};

--load DGS library
loadstring(exports.dgs:dgsImportFunction())();

--client ui resolution
GLOBALscreenX,GLOBALscreenY=guiGetScreenSize();
Gsx=GLOBALscreenX/1920;
Gsy=GLOBALscreenY/1080;

--set some stuff
setOcclusionsEnabled(false);--disable map glitches if something is custom mapped
setAmbientSoundEnabled("general",false);
setAmbientSoundEnabled("gunfire",false);--disable default gtasa gunfire from npc's
engineSetAsynchronousLoading(true,true);
setPedTargetingMarkerEnabled(false);--disable right click marker above target ped/player


--UI tables
GUI={
	--empty/new tables
	Window={},--window
	Button={},--button
	Edit={},--editbox
	Memo={},--memo editbox
	Label={},--text
	Image={},--images
	Radio={},--radiobox
	Tabpanel={},--tab panel
	Tab={},--tab panel elem
	Grid={},--gridlist
	Scroll={},--gridlist scrollbar
	Combo={},--combobox
	Browser={},--web browser
	Blurbox={},--window blur box
	
	--ui bar settings
	Settings={
		Height=35,
		TextSize=1.3,
	},
	
	--ui element colors
	Color={
		Bar=tocolor(0,150,220,180),
		BG=tocolor(10,10,10,180),
		
		Button={
			Green1=tocolor(0,150,0,200),
			Green2=tocolor(0,180,0,200),
			Green3=tocolor(0,100,0,200),
			
			Red1=tocolor(150,0,0,200),
			Red2=tocolor(180,0,0,200),
			Red3=tocolor(100,0,0,200),
			
			Yellow1=tocolor(145,145,0,200),
			Yellow2=tocolor(185,185,0,200),
			Yellow3=tocolor(120,120,0,200),
			
			Grey1=tocolor(50,50,50,200),
			Grey2=tocolor(90,90,90,200),
			Grey3=tocolor(20,20,20,200),
		},
		Edit={
			BG=tocolor(40,40,40,120),
			BG_Hover=tocolor(20,20,20,120),
			Line=tocolor(0,150,255,255),
		},
		Grid={
			Bar=tocolor(0,150,255,180),
			BG=tocolor(0,0,0,145),
			
			Row1=tocolor(30,30,30,160),
			Row2=tocolor(65,65,65,160),
			Row3=tocolor(10,10,10,160),
			
			Scroll1=tocolor(0,150,255,255),
			Scroll2=tocolor(0,130,255,255),
			Scroll3=tocolor(0,100,255,255),
		},
	},
};




--render key backspace
function renderBackspaceKey()
	dxDrawRectangle(1665*Gsx,1025*Gsy,240*Gsx,45*Gsy,tocolor(0,0,0,160),false);
	dxDrawText(loc("Close->UI"),1675*Gsx,1037*Gsy,100*Gsx,10*Gsy,tocolor(255,255,255,255),1.50*Gsx,"default-bold","left",_,_,_,false,_,_);
	dxDrawImage(1800*Gsx,1030*Gsy,150*Gsx,35*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Backspace.png",0,0,0,tocolor(255,255,255,255),false);
end

--set/remove ui elements & or cursor
function setUIdatas(typ,typ2,typ3)
	if(typ=="set")then
		if(typ2=="cursor")then
			showCursor(true);
			setClickedState(localPlayer,true);
		end
		if(typ3 and typ3==true)then
			removeEventHandler("onClientRender",root,renderBackspaceKey);
			addEventHandler("onClientRender",root,renderBackspaceKey);
			local function closeUI()
				if(isElement(GUI.Blurbox[1]))then
					dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window[1]);
					dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window[1]);
				end
				if(isElement(GUI.Blurbox[3]))then
					dgsAttachToAutoDestroy(GUI.Blurbox[3],GUI.Window[2]);
					dgsAttachToAutoDestroy(GUI.Blurbox[4],GUI.Window[2]);
				end
				if(isElement(GUI.Window[1]))then
					destroyElement(GUI.Window[1]);
					removeEventHandler("onClientRender",root,renderBackspaceKey);
				end
				if(isElement(GUI.Window[2]))then
					destroyElement(GUI.Window[2]);
					removeEventHandler("onClientRender",root,renderBackspaceKey);
				end
				if(isElement(GUI.Window[3]))then
					destroyElement(GUI.Window[3]);
					removeEventHandler("onClientRender",root,renderBackspaceKey);
				end
				if(isElement(GUI.Window[4]))then
					destroyElement(GUI.Window[4]);
					removeEventHandler("onClientRender",root,renderBackspaceKey);
				end
				
				showChat(true);
				setUIdatas("rem","cursor");
				unbindKey("backspace","down",function()
					closeUI();
				end)
			end
			bindKey("backspace","down",closeUI);
		else
			unbindKey("backspace","down",function()
				closeUI();
			end)
		end
	elseif(typ=="rem")then
		if(typ2=="cursor")then
			showCursor(false);
			setTimer(function()
				setClickedState(localPlayer,false);
			end,150,1)
			removeEventHandler("onClientRender",root,renderBackspaceKey);
		end
		if(typ3 and typ3==true)then
			if(isElement(GUI.Blurbox[1]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[1],GUI.Window[1]);
				dgsAttachToAutoDestroy(GUI.Blurbox[2],GUI.Window[1]);
			end
			if(isElement(GUI.Blurbox[3]))then
				dgsAttachToAutoDestroy(GUI.Blurbox[3],GUI.Window[2]);
				dgsAttachToAutoDestroy(GUI.Blurbox[4],GUI.Window[2]);
			end
			if(isElement(GUI.Window[1]))then
				destroyElement(GUI.Window[1]);
			end
			if(isElement(GUI.Window[2]))then
				destroyElement(GUI.Window[2]);
			end
			if(isElement(GUI.Window[3]))then
				destroyElement(GUI.Window[3]);
			end
			if(isElement(GUI.Window[4]))then
				destroyElement(GUI.Window[4]);
			end
		end
	end
end



--check only number
local OnlyNumbersTable={"a","b","c","d","e","f","g","h","i","j","k","l","m","o","p","y","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","O","P","Q","R","S","T","U","V","W","X","Y","Z","ä","ü","ö","Ä","Ü","Ö"," ",",","#","'","+","*","~",":",";","=","}","?","\\","{","&","/","§","\"","!","°","@","|","`","´","-","+"};
function isOnlyNumber(text)
	local counter=0;
	for _,v in ipairs(OnlyNumbersTable)do
		if(string.find(text,v))then
			counter=counter+1;
			break;
		end
	end
	if(counter>=1)then
		triggerEvent("Infobox->UI",localPlayer,"error",loc("OnlyNumber"));
		return false;
	else
		return true;
	end
end


addEventHandler("onClientResourceStart",resourceRoot,function()--disable gtasa ped voice
	for _,v in ipairs(getElementsByType("player"))do
		setPedVoice(v,"PED_TYPE_DISABLED");
	end
end)

addEventHandler("onClientResourceStart",resourceRoot,function()--break objects
	for _,v in pairs(getElementsByType("object"))do
		if(getElementModel(v)==2942)then--atm
			setObjectBreakable(v,false);
		end
	end
end)


function isPedAiming(thePedToCheck)
	if(isElement(thePedToCheck))then
		if(getElementType(thePedToCheck)=="player" or getElementType(thePedToCheck)=="ped")then
			if(getPedTask(thePedToCheck,"secondary",0)=="TASK_SIMPLE_USE_GUN")then
				return true;
			end
		end
	end
	return false;
end


--useful functions
function DxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end

function dxDrawBorder(x, y, w, h, size, color, postGUI)
    size = size or 2
    dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI)
    dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI)
    dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI)
    dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI)
end

function isCursorOnElement( posX, posY, width, height )
	if isCursorShowing( ) then
		local mouseX, mouseY = getCursorPosition( )
		local clientW, clientH = guiGetScreenSize( )
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
			return true
		end
	end
	return false
end