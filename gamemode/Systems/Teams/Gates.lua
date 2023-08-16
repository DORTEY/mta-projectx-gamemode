local Table={--objID,x,y,z,rotX,rotY,rotZ, moveX,moveY,moveZ,moveRotX,moveRotY,moveRotZ, moveBackX,moveBackY,moveBackZ, range, required team, required team display name
	{3055,1588.5,-1638.3,14.6,0,0,0, 1588.5,-1638.3,16.5,90,0,0 ,-90,0,0, 6, "SAPD","S.A.P.D"},--SAPD
	{16773,1149.4,-1201.2,22.8,0,0,0, 1140.5,-1201.2,22.8,0,0,0 ,0,0,0, 6, "FIB","F.I.B"},--FIB
	{2990,2000.9,-1370.9,11.5,0,0,0, 2000.9,-1370.9,15.9,0,0,0 ,0,0,0, 6, "SAMD","S.A.M.D"},--SAMD
	
	{2949,2496.15,-1691.6,13.78,0,0,270, 2497.4,-1691.6,13.78,0,0,0 ,0,0,0, 2.2, "Grove","Grove Street Families"},--Grove Main
	{2949,2488.64,-1699.29,13.78,0,0,0, 2488.64,-1697.99,13.78,0,0,0 ,0,0,0, 2.2, "Grove","Grove Street Families"},--Grove Second
	{2949,2488.64,-1710.29,13.78,0,0,0, 2488.64,-1708.99,13.78,0,0,0 ,0,0,0, 2.2, "Grove","Grove Street Families"},--Grove Thirt
};

local TableObjects={};
local TableObjectsDatas={};
local TableObjectsStatus={};
addEventHandler("onResourceStart",resourceRoot,function()
	local TableCols={};
	for i,v in pairs(Table)do
		TableCols[i]=createColSphere(v[2],v[3],v[4],v[17]);--create a invisible area
		TableObjects[TableCols[i]]=createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7]);--create gate object
		TableObjectsDatas[TableCols[i]]={v[2],v[3],v[4],v[5],v[6],v[7], v[8],v[9],v[10],v[11],v[12],v[13], v[14],v[15],v[16], v[18],v[19]};--put object and col pos in table
		TableObjectsStatus[TableCols[i]]=false;
		
		addEventHandler("onColShapeHit",TableCols[i],moveTeamGate);
	end
end)


function moveTeamGate(elem)
	if(elem and isElement(elem))then
		if(getElementType(elem)=="vehicle")then
			hitElem=getVehicleOccupant(elem,0);--get vehicle driver seat player
		elseif(getElementType(elem)=="player")then
			hitElem=elem;
		end
		if(hitElem and isElement(hitElem))then
			if(not(TableObjectsStatus[source]))then
				if(TableObjectsDatas[source][16])then
					if(getElementData(hitElem,"Player->Data->Team")~=TableObjectsDatas[source][16])then
						return triggerClientEvent(hitElem,"Infobox->UI",hitElem,"error",loc(hitElem,"NotInRightTeam"):format(TableObjectsDatas[source][17]));
					end
					TableObjectsStatus[source]=true;
					
					setTimer(function(source)
						moveObject(TableObjects[source],2000,TableObjectsDatas[source][1],TableObjectsDatas[source][2],TableObjectsDatas[source][3],TableObjectsDatas[source][13],TableObjectsDatas[source][14],TableObjectsDatas[source][15]);
					end,4000,1,source);
					setTimer(function(source)
						TableObjectsStatus[source]=false;
					end,6000,1,source);
					moveObject(TableObjects[source],2000,TableObjectsDatas[source][7],TableObjectsDatas[source][8],TableObjectsDatas[source][9],TableObjectsDatas[source][10],TableObjectsDatas[source][11],TableObjectsDatas[source][12]);
				elseif(not TableObjectsDatas[source][16])then--everyone
					TableObjectsStatus[source]=true;
					
					setTimer(function(source)
						moveObject(TableObjects[source],2000,TableObjectsDatas[source][1],TableObjectsDatas[source][2],TableObjectsDatas[source][3],TableObjectsDatas[source][13],TableObjectsDatas[source][14],TableObjectsDatas[source][15]);
					end,4000,1,source);
					setTimer(function(source)
						TableObjectsStatus[source]=false;
					end,6000,1,source);
					moveObject(TableObjects[source],2000,TableObjectsDatas[source][7],TableObjectsDatas[source][8],TableObjectsDatas[source][9],TableObjectsDatas[source][10],TableObjectsDatas[source][11],TableObjectsDatas[source][12]);
				end
			end
		end
	end
end