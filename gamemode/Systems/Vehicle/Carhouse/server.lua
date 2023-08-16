addRemoteEvents{"Buy->Vehicle","Trigger->VehicleCarhouseUI->Items"};--addEvent


local Markers={
	--x,y,z,type,size,r,g,b,a,int,dim
	{2131.8,-1151,23.1,"cylinder",1.3,255,255,255,180,0,0, "User"},--CAS
	{545.7,-1292.7,16.2,"cylinder",1.3,255,255,255,180,0,0, "User"},--Grotti
	{-1663.4,1208.6,6.2,"cylinder",1.3,255,255,255,180,0,0, "User"},--Ottos
	{1559.9,-1635.1,12.5,"cylinder",1.3,255,255,255,180,0,0, "SAPD"},
	{2039.1,-1410.3,12.5,"cylinder",1.3,255,255,255,180,0,0, "SAMD"},
	{1158.0,-1197.7,30.7,"cylinder",1.3,255,255,255,180,0,0, "FIB"},
};

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(Markers)do
		Markers[i]=createMarker(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]);
		
		setElementInterior(Markers[i],v[10]);
		setElementDimension(Markers[i],v[11]);
		
		addEventHandler("onMarkerHit",Markers[i],function(elem,dim)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(not(isPedInVehicle(elem))and isLoggedin(elem)and dim)then
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						triggerClientEvent(elem,"Vehicle->Carhouse->UI",elem,"Open",v[12]);
					end
				end
			end
		end)
		
		addEventHandler("onMarkerLeave",Markers[i],function(elem,dim)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				triggerClientEvent(elem,"Vehicle->Carhouse->UI",elem,"Close");
			end
		end)
	end
end)

addEventHandler("Buy->Vehicle",root,function(vehID,typ)
	if(client and isElement(client)and isLoggedin(client))then
		if(vehID and type(vehID)=="number")then
			if(tonumber(getElementData(client,"Money"))<VEHICLE.PRICES[vehID])then
				return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,VEHICLE.PRICES[vehID]));
			end
			if(tonumber(getElementData(client,"OverallLVL"))<VEHICLE.LEVEL[vehID])then
				return triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughLevel"):format(VEHICLE.LEVEL[vehID]));
			end
			
			local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(vehID);
			if(isCustom)then--check custom vehicle
				dbExec(DB.HANDLER,"INSERT INTO Vehicles (Username,VehID,Health,Typ) VALUES ('"..getPlayerName(client).."','".. mod.id .."','1000','"..typ.."')");
			else
				dbExec(DB.HANDLER,"INSERT INTO Vehicles (Username,VehID,Health,Typ) VALUES ('"..getPlayerName(client).."','"..vehID.."','1000','"..typ.."')");
			end
			
			setElementData(client,"Money",tonumber(getElementData(client,"Money"))-tonumber(VEHICLE.PRICES[vehID]));
			triggerClientEvent(client,"Infobox->UI",client,"success","Vehicle successfully bought!\nCheck F2",8);
			
			addPlayerAchievment(client,"FirstVehicle");
		end
	end
end)




addEventHandler("Trigger->VehicleCarhouseUI->Items",root,function(typ)
	if(client and isElement(client)and isLoggedin(client))then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? ORDER BY SortID ASC","Vehicles_Carhouse"),-1);
		local Table={};
		if(#result>=1)then
			for _,v in pairs(result)do
				if(VEHICLE.NAMES[v["VehID"]])then
					Carname=VEHICLE.NAMES[v["VehID"]];
				else
					Carname=getVehicleNameFromModel(v["VehID"]);
				end
				if(v["Typ"]==typ)then
					table.insert(Table,{v["VehID"],VEHICLE.PRICES[v["VehID"]],VEHICLE.LEVEL[v["VehID"]],Carname,v["MaxSpeed"]});
				end
			end
			triggerClientEvent(client,"Show->VehicleCarhouseUI->Items",client,Table);
		end
	end
end)