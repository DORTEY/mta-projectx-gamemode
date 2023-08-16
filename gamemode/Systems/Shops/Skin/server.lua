local Markers={--x,y,z,type,size,r,g,b,a,int,dim, typ
	{208.9,-3.9,1000.2,"cylinder",1.3,255,255,255,180,5,20, "Normal"},
	{208.9,-3.9,1000.2,"cylinder",1.3,255,255,255,180,5,21, "Normal"},
	{208.9,-3.9,1000.2,"cylinder",1.3,255,255,255,180,5,22, "Exclusive"},
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
						if(v[12]and v[12]=="Exclusive" and not getElementData(elem,"Player->Data->Premium"))then
							return print("not premium")--todo
						end
						triggerClientEvent(elem,"Shop->Skin->UI",elem,"Open",v[12]);
					end
				end
			end
		end)
		addEventHandler("onMarkerLeave",Markers[i],function(elem,dim)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(not(isPedInVehicle(elem))and isLoggedin(elem)and dim)then
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						triggerClientEvent(elem,"Shop->Skin->UI",elem,"Close");
					end
				end
			end
		end)
	end
end)