addRemoteEvents{"Teleport->Location"};--addEvent


local Markers={
	--x,y,z,rot,int,dim, markerimg,markergimg,size, tpX,tpY,tpZ,tpROT,tpINT,tpDIM, required data,required team,required team display name
	--skin
	{2244.5,-1664.9,15.4,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/Shop.png","Ground",0.6, 227.4,-7.6,1002.2,90,5,20},--in1
	{479.8,-1538.3,19.3,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/Shop.png","Ground",0.6, 227.4,-7.6,1002.2,90,5,21},--in2
	{2112.9,-1211.8,23.9,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/Shop.png","Ground",0.6, 227.4,-7.6,1002.2,90,5,22},--in3
	
	{227.2,-8.9,1002,180,5,20, ":"..RESOURCE_NAME.."/Files/Images/Markers/Out.png","Ground",0.5, 2245,-1663.7,15.5,340,0,0},--out1
	{227.2,-8.9,1002,180,5,21, ":"..RESOURCE_NAME.."/Files/Images/Markers/Out.png","Ground",0.5, 480.9,-1537.8,19.4,296,0,0},--out2
	{227.2,-8.9,1002,180,5,22, ":"..RESOURCE_NAME.."/Files/Images/Markers/Out.png","Ground",0.5, 2112.8,-1212.8,23.9,180,0,0},--out3
	
	
	--lspd
	{1581.6,-1681.1,16.2,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 1525.8,-1678,5.9,270,0,0, "Team","SAPD","S.A.P.D"},--in1
	{1524.6,-1678,6,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 1580,-1681.1,16.2,90,0,0, "Team","SAPD","S.A.P.D"},--out1
	--fib
	{1178.4,-1181.2,33.7,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 1178.6,-1179.4,44.2,90,0,0, "Team","FIB","F.I.B"},--in1
	{1178.4,-1181.2,44.2,0,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 1178.3,-1178.2,33.7,90,0,0, "Team","FIB","F.I.B"},--out1
	
	{1178.4,-1179.8,33.7,0,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/Out.png","Ground",0.5, 1183.1,-1180.6,20.1,90,0,0, "Team","FIB","F.I.B"},--in2
	{1185.2,-1180.5,20,0,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 1178.3,-1178.2,33.7,90,0,0, "Team","FIB","F.I.B"},--in2
	--hospital
	{2034.1,-1402.2,17,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 246.4,109,1003.2,0,10,666},--in1
	{246.4,107.6,1003.2,180,10,666, ":"..RESOURCE_NAME.."/Files/Images/Markers/Out.png","Ground",0.5, 2034.2,-1404,17,180,0,0},--out1
	
	{214.3,118.9,1003.2,180,10,666, ":"..RESOURCE_NAME.."/Files/Images/Markers/Out.png","Ground",0.5, 2033.5,-1315.8,8.6,180,0,0, "Team","SAMD","S.A.M.D"},--in2
	{2033.5,-1314.3,8.7,180,0,0, ":"..RESOURCE_NAME.."/Files/Images/Markers/In.png","Ground",0.5, 215.5,118.9,1003.2,270,10,666, "Team","SAMD","S.A.M.D"},--out2
};

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(Markers)do
		local function teleport(player)
			if(player and isElement(player)and isLoggedin(player))then
				if(not isPedInVehicle(player))then
					if(getElementInterior(player)==v[5]and getElementDimension(player)==v[6])then
						if(v[16]and v[16]=="Team" and v[17]and v[18]and tostring(getElementData(player,"Player->Data->Team"))~=tostring(v[17]))then
							return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotInRightTeam"):format(v[18]));
						elseif(v[16]and v[16]=="Job" and v[17]and v[18]and tostring(getElementData(player,"Player->Data->Job"))~=tostring(v[17]))then
							return triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotInRightJob"):format(v[18]));
						else
							fadeElementPosition(player,v[10],v[11],v[12],v[13],v[14],v[15],true);
							syncWeatherTime(player);
						end
					end
				end
			end
		end
		
		Markers[i]=createMarkerC(v[1],v[2],v[3],v[5],v[6],v[7],v[8],v[9],teleport);
	end
end)



local MarkerTP2={--x,y,z,type,size,r,g,b,a,int,dim outx,outy,outz,outrx,int,dim, required data,required team,required team display name
	--24/7 +1.3
	{1352.4,-1758.8,14.2,"arrow",1.2,255,255,255,180,0,0, -31,-90.6,1003.5,0,18,1},--in1
	{1315.4,-898,40.2,"arrow",1.2,255,255,255,180,0,0, -31,-90.6,1003.5,0,18,2},--in2
	{171.9,-200.8,2.4,"arrow",1.2,255,255,255,180,0,0, -31,-90.6,1003.5,0,18,3},--in3
	
	{-31,-91.9,1004.2,"arrow",1.2,255,255,255,180,18,1, 1352.4,-1756.8,13.8,0,0,0},--out1
	{-31,-91.9,1004.2,"arrow",1.2,255,255,255,180,18,2, 1315.4,-899.4,39.8,0,0,0},--out2
	{-31,-91.9,1004.2,"arrow",1.2,255,255,255,180,18,3, 173.2,-202.2,1.6,222,0,0},--out3
	
	
	--mine
	{2297.3,-1130.0,27.4,"arrow",1.2,220,220,0,180,0,0, 3795.7,476.5,58.6,170,0,4000, "Job","Miner","Miner"},--in1
	
	{3795.8,473.8,58.8,"arrow",1.2,220,220,0,180,0,4000, 2294.1,-1124.9,26.8,115,0,0},--out1
	
	
	--ballas
	{2233.1,-1159.8,26.6,"arrow",1.2,255,255,255,180,0,0, 2215.6,-1150.5,1025.8,270,15,50, "Team","Ballas","Rollin Heights Ballas"},--in1
	
	{2214.6,-1150.5,1026.5,"arrow",1.2,255,255,255,180,15,50, 2231.8,-1159.8,25.9,90,0,0},--out1
};

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(MarkerTP2)do
		MarkerTP2[i]=createMarker(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]);
		
		setElementInterior(MarkerTP2[i],v[10]);
		setElementDimension(MarkerTP2[i],v[11]);
		
		addEventHandler("onMarkerHit",MarkerTP2[i],function(elem)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(not(isPedInVehicle(elem)))then
					if(v[18]and v[18]=="Team" and v[19]and v[20]and tostring(getElementData(elem,"Player->Data->Team"))~=v[19])then
						return triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"NotInRightTeam"):format(v[20]));
					elseif(v[18]and v[18]=="Job" and v[19]and v[20]and tostring(getElementData(elem,"Player->Data->Job"))~=v[19])then
						return triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"NotInRightJob"):format(v[20]));
					else
						if(getElementInterior(elem)==v[10] and getElementDimension(elem)==v[11])then
							fadeElementPosition(elem,v[12],v[13],v[14],v[15],v[16],v[17],true);
							syncWeatherTime(elem);
						end
					end
				end
			end
		end)
	end
end)




local MarkerTeleporters={--x,y,z,
	{1686.0,-1945.2,12.5,},--Noobspawn
	{-2107.6,-2277.7,29.6,},--Angelpine
	{1999.5,-1440.2,12.5,},--Hospital (LS)
	{-2638.6,635.5,13.4,},--Hospital (SF)
	{-205.2,1212.3,18.7,},--Fort Carson
	{1570.4,-1635.4,12.5,},--LSPD
	{-1574.3,668.6,6.2,},--SFPD
};

addEventHandler("onResourceStart",resourceRoot,function()
	local TableBlips={};
	for i,v in ipairs(MarkerTeleporters)do
		MarkerTeleporters[i]=createMarker(v[1],v[2],v[3],"cylinder",2.2,240,90,255,120);
		TableBlips[i]=createBlip(v[1],v[2],v[3],14,20,240,90,255,255,100);
		
		setElementInterior(MarkerTeleporters[i],0);
		setElementDimension(MarkerTeleporters[i],0);
		
		setElementData(TableBlips[i],"tooltipText","Teleporter");
		
		addEventHandler("onMarkerHit",MarkerTeleporters[i],function(elem)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(not(isPedInVehicle(elem)))then
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						if(tonumber(getElementData(elem,"Wanteds"))>0)then
							return triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"CantDoThatCuzWanteds"));
						end
						triggerClientEvent(elem,"Teleport->UI",elem,"Open");
					end
				end
			end
		end)
		
		addEventHandler("onMarkerLeave",MarkerTeleporters[i],function(elem)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				triggerClientEvent(elem,"Teleport->UI",elem,"Close");
			end
		end)
	end
end)


addEventHandler("Teleport->Location",root,function(name)
	if(client and isElement(client)and isLoggedin(client))then
		if(tonumber(getElementData(client,"Wanteds"))>0)then
			return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"CantDoThatCuzWanteds"));
		end
		
		if(name and TELEPORTS["Server"][tostring(name)])then
			fadeElementPosition(client,TELEPORTS["Server"][tostring(name)][1],TELEPORTS["Server"][tostring(name)][2],TELEPORTS["Server"][tostring(name)][3],0,0,0,true);
		end
	end
end)