local WEBHOOKS={
	[1]="https://discord.com/api/webhooks/1121706509106151425/fOfbG9e1gPUTOyBXm78hj0QtiUfPFAWJgMumWAkdeqhoR380OfT7rWtpB7Eqgwc_gvr1",--chat (local)
	[2]="https://discord.com/api/webhooks/1121706957603090522/yDoROti65sAWAmLzSYzbrTa0aIwufk5vWXuSBCD0byuL_-6YwfJG57ICcP1OFrby0BTX",--chat (team)
	[3]="https://discord.com/api/webhooks/1121702357529526364/xa8k6ioYKEKfBbgjM-xNkuBRMydnoNTwlLMDKA69wtEX_YfYtMggYEtgqHEhHxFlQ-ED",--chat ad
	[4]="https://discord.com/api/webhooks/1123982144444833912/BcVUYMRwDBT6Sv7sP_Dh9sasLl2ZIVb0A4BzQqwgeZC4fARA91JS4fh6BF2ga3GAUM0c",--commands used
	[5]="https://discord.com/api/webhooks/1124000067951538307/Peiuo5MBb86zaC-rlrIxO0_rhEthLz2Kep57HrW08ZKFh8Ry2380bmyQPzYzQG0sSHMW",--anticheat
	[6]="https://discord.com/api/webhooks/1124660270778814475/iGQ8zbCCyXDn5VvsFW74cX3nnGvbfZ6BPufqLawsdEpOUCi4B6TglLsiXW6pA8gAh3NB",--chat(global)
	[7]="https://discord.com/api/webhooks/1140135684351479918/l-wV77letTBsqzuUPp4YbIQL0xdyV6puQjzsZFKQorphg41RIyR7W97wmmsrdOhYrrxo",--cases
	[8]="https://discord.com/api/webhooks/1140137001874620429/HRYZm6S2GCGSEyKXecT4XTvEJsStNk-yuK_HcYUQP03xBZA62UbU17AP9qp5yXqTly9Q",--robs
	
	[20]="https://discord.com/api/webhooks/1140133955719405652/_I4MFcMx1v4d8fOCOCbBghj0OeuVPKP69nRcgaqonEgg7aqS73nRVTpmNnCTVBpyGa7K",--daily restart
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