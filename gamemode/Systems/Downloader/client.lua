addEvent("downloadClientsidedFiles",true)
addEvent("encrytFiles",true)
addEvent("onClientResourceStart_Custom",false)


local DOWNLOADER_PATHS={};
local DOWNLOADER_COUNT=0;
local DOWNLOADER_AMOUNT=0;
local DOWNLOADER_BACKGROUND=math.random(1,3);
local DOWNLOADER_TICK_START=0;



local function drawFilesLoad()
	showChat(false);
	setWeather(0);
	dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,":"..RESOURCE_NAME.."/Files/Images/Downloader/"..DOWNLOADER_BACKGROUND..".png",0.0,0.0,0.0,tocolor(255,255,255,255),false);--bg
	dxDrawRectangle(0,0,GLOBALscreenX,GLOBALscreenY,tocolor(0,0,0,120),false);--bg
	dxDrawImage(60*Gsx,830*Gsy,250*Gsx,200*Gsy,":"..RESOURCE_NAME.."/Files/Images/Downloader/Logo.png",0,0,0,tocolor(255,255,255,255));
	
	DxDrawBorderedText("Project X",1720*Gsx,200*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.70*Gsx,"pricedown","center",_,_,_,false,_,_);
	DxDrawBorderedText("Cops",795*Gsx,250*Gsy,200*Gsx,20*Gsy,tocolor(0,150,220,255),1.60*Gsx,"pricedown","left",_,_,_,false,_,_);
	DxDrawBorderedText("and",895*Gsx,250*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.60*Gsx,"pricedown","left",_,_,_,false,_,_);
	DxDrawBorderedText("Robbers",975*Gsx,250*Gsy,200*Gsx,20*Gsy,tocolor(170,0,0,255),1.60*Gsx,"pricedown","left",_,_,_,false,_,_);
	
	dxDrawRectangle(810*Gsx,950*Gsy,300*Gsx,45*Gsy,tocolor(0,0,0,140),false);--bg progress
	
	if(DOWNLOADER_COUNT>0)then
		dxDrawRectangle(810*Gsx,950*Gsy,DOWNLOADER_COUNT*300/DOWNLOADER_AMOUNT*Gsx,45*Gsy,tocolor(0,150,220,140),false);
	end
	
	dxDrawRectangle(810*Gsx,950*Gsy,15*Gsx,3*Gsy,tocolor(170,0,0,255),false);--top left corner
	dxDrawRectangle(810*Gsx,950*Gsy,3*Gsx,15*Gsy,tocolor(170,0,0,255),false);--top left corner
	dxDrawRectangle(1110*Gsx,950*Gsy,-15*Gsx,3*Gsy,tocolor(0,150,220,255),false);--top right corner
	dxDrawRectangle(1110*Gsx,950*Gsy,-3*Gsx,15*Gsy,tocolor(0,150,220,255),false);--top right corner
	dxDrawRectangle(810*Gsx,995*Gsy,15*Gsx,-3*Gsy,tocolor(0,150,220,255),false);--bottom left corner
	dxDrawRectangle(810*Gsx,995*Gsy,3*Gsx,-15*Gsy,tocolor(0,150,220,255),false);--bottom left corner
	dxDrawRectangle(1110*Gsx,995*Gsy,-15*Gsx,-3*Gsy,tocolor(170,0,0,255),false);--bottom right corner
	dxDrawRectangle(1110*Gsx,995*Gsy,-3*Gsx,-15*Gsy,tocolor(170,0,0,255),false);--bottom right corner
	
	dxDrawImage(1820*Gsx,990*Gsy,50*Gsx,50*Gsy,":"..RESOURCE_NAME.."/Files/Images/Downloader/Loading.png",0-100*((DOWNLOADER_TICK_START-getTickCount()-3000)/1000),0,0,tocolor(255,255,255,255));
	dxDrawText("Downloading Files ("..DOWNLOADER_COUNT.."/"..DOWNLOADER_AMOUNT..")",1720*Gsx,960*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.60*Gsx,"default-bold","center",_,_,_,false,_,_);
end


local function antiCStackOverflow(filename)
	if(not(downloadFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT])))then
		outputDebugString(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
		loadNextClientsidedFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
	end
end


function loadNextClientsidedFile(fileName,success)
	if(fileName==DOWNLOADER_PATHS[DOWNLOADER_COUNT])then
		if(DOWNLOADER_PATHS[DOWNLOADER_COUNT+1])then
			DOWNLOADER_COUNT=DOWNLOADER_COUNT+1;
			if(DOWNLOADER_COUNT%150==0)then
				setTimer(antiCStackOverflow,50,1);
			else
				if(not(downloadFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT])))then
					outputDebugString(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
					loadNextClientsidedFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
				end
			end
		else
			removeEventHandler("onClientFileDownloadComplete",root,loadNextClientsidedFile)
			removeEventHandler("onClientRender",root,drawFilesLoad)
			triggerEvent("onClientResourceStart_Custom",resourceRoot,getResourceName(resource))
		end
	end
end

addEventHandler("downloadClientsidedFiles",root,function(filepathsarray)
	DOWNLOADER_AMOUNT=#filepathsarray;
	for i=1,DOWNLOADER_AMOUNT do
		DOWNLOADER_PATHS[i]=filepathsarray[i];
	end
	addEventHandler("onClientFileDownloadComplete",root,loadNextClientsidedFile);
	DOWNLOADER_COUNT=DOWNLOADER_COUNT+1;
	DOWNLOADER_TICK_START=getTickCount();
	
	if(not(downloadFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT])))then
		outputDebugString(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
		loadNextClientsidedFile(DOWNLOADER_PATHS[DOWNLOADER_COUNT]);
	end
end)


addEventHandler("onClientResourceStart",resourceRoot,function()
	addEventHandler("onClientRender",root,drawFilesLoad)
	triggerServerEvent("clientResourceLoaded_Custom",localPlayer);
end)