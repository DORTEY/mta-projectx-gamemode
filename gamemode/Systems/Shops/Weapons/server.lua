local Markers={--x,y,z,type,size,r,g,b,a,int,dim, team
	{1582.0,-1674.6,15.2,"cylinder",1.3,255,255,255,180,0,0, "SAPD"},--lspd
	{1165.6,-1176.2,43.1,"cylinder",1.3,255,255,255,180,0,0, "FIB"},--fib
	{2499.9,-1711.0,13.7,"cylinder",1.3,255,255,255,180,0,0, "Grove"},--grove
	{2216.3,-1147.3,1024.8,"cylinder",1.3,255,255,255,180,15,50, "Ballas"},--ballas
	
	{1380.8,-1277.2,12.6,"cylinder",1.3,255,255,255,180,0,0},--Ammunation LS
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
						if(v[12]and tostring(getElementData(elem,"Player->Data->Team"))~=tostring(v[12]))then
							return triggerClientEvent(elem,"Infobox->UI",elem,"error",loc(elem,"NotInRightTeam"):format(v[12]));
						end
						triggerClientEvent(elem,"Shop->Weapons->UI",elem,"Open");
					end
				end
			end
		end)
		addEventHandler("onMarkerLeave",Markers[i],function(elem,dim)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(not(isPedInVehicle(elem))and isLoggedin(elem)and dim)then
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						triggerClientEvent(elem,"Shop->Weapons->UI",elem,"Close");
					end
				end
			end
		end)
	end
end)