--credits: n0pe
local MarkerTable={};

function createMarkerC(x,y,z,int,dim,image,uimage,size,func)
	local pickup={x=x,y=y,z=z,int=int,dim=dim,image=image,uimage=uimage,size=size,func=func};
	if(uimage)then
		uimage=":"..RESOURCE_NAME.."/Files/Images/Markers/"..uimage..".png";
	else
		uimage=":"..RESOURCE_NAME.."/Files/Images/Transparent.png";
	end
	
	local colShape=createColSphere(x,y,z,size);
	if(colShape)then
		setElementID(colShape,"cMarker");
		setElementData(colShape,"cMarker.image",image);
		setElementData(colShape,"cMarker.uimage",uimage);
		setElementData(colShape,"cMarker.positions",{x,y,z});
		setElementData(colShape,"cMarker.dim",dim);
		
		addEventHandler("onColShapeHit",colShape,eventCustomPickup);
		
		pickup.colshape=colShape;
		MarkerTable[tostring(colShape)]=pickup;
	end
end

function eventCustomPickup(player)
    if(getElementID(source)=="cMarker" and getElementType(player)=="player")then
		MarkerTable[tostring(source)].func(player);
    end
end