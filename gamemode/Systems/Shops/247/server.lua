local Markers={--x,y,z,type,size,r,g,b,a,int,dim, typ
	{-26.9,-89.7,1002.5,"cylinder",1.3,255,255,255,180,18,1, "247"},
	{-26.9,-89.7,1002.5,"cylinder",1.3,255,255,255,180,18,2, "247"},
	{-26.9,-89.7,1002.5,"cylinder",1.3,255,255,255,180,18,3, "247"},
	{-26.9,-89.7,1002.5,"cylinder",1.3,255,255,255,180,18,4, "247"},
	{1012.2,-927.0,41.3,"cylinder",1.3,255,255,255,180,0,0, "247"},
	{1917.8,-1767.9,12.5,"cylinder",1.3,255,255,255,180,0,0, "247"},
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
						triggerClientEvent(elem,"Shop->247->UI",elem,"Open",v[12]);
					end
				end
			end
		end)
		addEventHandler("onMarkerLeave",Markers[i],function(elem,dim)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(not(isPedInVehicle(elem))and isLoggedin(elem)and dim)then
					if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
						triggerClientEvent(elem,"Shop->247->UI",elem,"Close");
					end
				end
			end
		end)
	end
end)