--job npc peds
local TABLE={--id, x,y,z,rot, int,dim, pedData, name, description, hasblip?,blipName,blipID,blipR,blipG,blipB
	{260, 2298.7,-1132.7,26.9,107, 0,0, "Ped->Data->Job->Miner","Bethany_Taylor","Miner Job", true,"Miner (Job)",12,150,90,50},
	{198, -63.0,76.1,3.1,250, 0,0, "Ped->Data->Job->Farmer","Bethany_Taylor","Farmer Job", true,"Farmer (Job)",11,255,255,255},
	{153, 2098.4,-2050.6,13.5,274, 0,0, "Ped->Data->Job->Garbage","Bethany_Taylor","Garbage Job", true,"Garbage (Job)",16,90,90,90},
};

addEventHandler("onResourceStart",resourceRoot,function()
	local BLIPS={};
	for i,v in pairs(TABLE)do
		if(#TABLE>0)then
			TABLE[i]=createPed(v[1],v[2],v[3],v[4],v[5],true);
			setElementDimension(TABLE[i],v[6]);
			setElementInterior(TABLE[i],v[7]);
			setElementFrozen(TABLE[i],true);
			
			setElementData(TABLE[i],v[8],true);
			setElementData(TABLE[i],"Ped->Data->Immortal",true);
			
			if(v[9])then
				setElementData(TABLE[i],"Ped->Data->Name",v[9]);
			end
			if(v[10])then
				setElementData(TABLE[i],"Ped->Data->Description",v[10]);
			end
			if(v[11])then
				BLIPS[i]=createBlip(v[2],v[3],v[4],v[13],20,v[14],v[15],v[16],255,100);
				setElementData(BLIPS[i],"tooltipText",v[12]);
			end
		end
	end
end)