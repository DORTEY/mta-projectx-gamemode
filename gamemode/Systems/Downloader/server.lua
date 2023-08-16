addEvent("clientResourceLoaded_Custom",true)


local DOWNLOADER_PATHS={};
local DOWNLOADER_STATUS={};


addEventHandler("onResourceStart",resourceRoot,function()
	local meta=xmlLoadFile("meta.xml");
	local nodes=xmlNodeGetChildren(meta);
	if(nodes and nodes[1])then
		local j=0;
		for i=1,#nodes do
			if(xmlNodeGetName(nodes[i])=="file")then
				if(xmlNodeGetAttribute(nodes[i],"download")=="false")then
					j=j+1;
					DOWNLOADER_PATHS[j]=xmlNodeGetAttribute(nodes[i],"src");
				end
			end
		end
	end
	xmlUnloadFile(meta);
end)


addEventHandler("clientResourceLoaded_Custom",root,function()
	if(DOWNLOADER_PATHS[1]and not DOWNLOADER_STATUS[client])then
		DOWNLOADER_STATUS[client]=true;
		triggerLatentClientEvent(client,"downloadClientsidedFiles",50000,false,client,DOWNLOADER_PATHS);
	end
end)


addEventHandler("onPlayerQuit",root,function()
	DOWNLOADER_STATUS[source]=nil;
end)