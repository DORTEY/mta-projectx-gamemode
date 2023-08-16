local TABLE={--x,y,hx,hy,int,dim
	{"circle",1399.7,-1841.9,160,100,0,0},--LS Bahnhof
	{"circle",1684,-1962.3,128,77,0,0},--LS Noobspawn
	{"circle",516.9,-1315.1,51,35,0,0},--LS Grotti
};

function createSavezones()
	local ZONES={};
	for i,v in pairs(TABLE)do
		if(v[1]=="circle")then
			ZONES[i]=createColRectangle(v[2],v[3],v[4],v[5]);
		end
		createRadarArea(v[2],v[3],v[4],v[5],0,255,0,60,root);
		setElementInterior(ZONES[i],v[6]);
		setElementDimension(ZONES[i],v[7]);
		
		addEventHandler("onColShapeHit",ZONES[i],function(elem)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(getElementDimension(elem)==getElementDimension(source)and getElementInterior(elem)==getElementInterior(source))then
					setElementData(elem,"Player->Data->Savezone",true);
					triggerClientEvent(elem,"Trigger->Savezone",elem,"Open");
				end
			end
		end)
		
		addEventHandler("onColShapeLeave",ZONES[i],function(elem)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(getElementDimension(elem)==getElementDimension(source))then
					removeElementData(elem,"Player->Data->Savezone");
					triggerClientEvent(elem,"Trigger->Savezone",elem,"Close");
				end
			end
		end)
	end
end
addEventHandler("onResourceStart",resourceRoot,createSavezones)