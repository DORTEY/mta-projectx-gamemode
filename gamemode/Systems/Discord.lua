local WEBHOOKS={--discord webhook urls
	[1]="",--chat (local)
	[2]="",--chat (team)
	[3]="",--chat ad
	[4]="",--commands used
	[5]="",--anticheat
	[6]="",--chat(global)
	[7]="",--cases
	[8]="",--robs
	
	[20]="",--daily restart
};

function sendDiscordMessage(typ,msg)
	local data={content=tostring(msg)};
	
	local jsonData=toJSON(data)jsonData=string.sub(jsonData,3,#jsonData-2);
	local sendOptions={headers={["Content-Type"]="application/json"},postData=jsonData};
	
	if(typ=="Chat->Local")then
		fetchRemote(WEBHOOKS[1],sendOptions,callback);
	end
	if(typ=="Chat->Team")then
		fetchRemote(WEBHOOKS[2],sendOptions,callback);
	end
	if(typ=="Chat->AD")then
		fetchRemote(WEBHOOKS[3],sendOptions,callback);
	end
	if(typ=="Command->Used")then
		fetchRemote(WEBHOOKS[4],sendOptions,callback);
	end
	if(typ=="Anticheat")then
		fetchRemote(WEBHOOKS[5],sendOptions,callback);
	end
	if(typ=="Chat->Global")then
		fetchRemote(WEBHOOKS[6],sendOptions,callback);
	end
	if(typ=="Cases")then
		fetchRemote(WEBHOOKS[7],sendOptions,callback);
	end
	if(typ=="Rob")then
		fetchRemote(WEBHOOKS[8],sendOptions,callback);
	end
	
	if(typ=="Restart")then
		fetchRemote(WEBHOOKS[20],sendOptions,callback);
	end
end
function callback(msg)
end