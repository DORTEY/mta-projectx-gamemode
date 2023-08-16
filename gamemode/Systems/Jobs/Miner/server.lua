local Positions={--x,y,z,range
	{3819.2,506.8,68.3,3},
	{3835.4,510.6,73.0,4},
};
local MinePlayerCount={};
local MinePlayerTimer={};
local MineRewardRDM={};
local MineRewardRDM2={};
local MineObject={};

addEventHandler("onResourceStart",resourceRoot,function()
	local Col={};
	for i,v in pairs(Positions)do
		Col[i]=createColSphere(v[1],v[2],v[3],v[4]);
		setElementDimension(Col[i],4000);
		
		addEventHandler("onColShapeHit",Col[i],function(elem,dim)
			if(getElementType(elem)=="player" and dim)then
				if(isPedDead(elem))then
					return;
				end
				if(isPedInVehicle(elem))then
					return;
				end
				if(getElementData(elem,"Player->Data->Job")~="Miner")then
					return;
				end
				bindKey(elem,"MOUSE1","down",minePickaxe);
				toggleControl(elem,"fire",false);
				giveWeapon(elem,6,1,true);
			end
		end)
		
		addEventHandler("onColShapeLeave",Col[i],function(elem,dim)
			if(getElementType(elem)=="player" and dim)then
				unbindKey(elem,"MOUSE1","down",minePickaxe);
				toggleControl(elem,"fire",true);
				
				if(MinePlayerCount[elem])then
					MinePlayerCount[elem]=nil;
					triggerClientEvent(elem,"Job->Mine->Progress->UI",elem);
				end
				takeWeapon(elem,6);
			end
		end)
	end
end)

function minePickaxe(player)
	if(player and isElement(player)and getElementType(player)=="player")then
		if(isLoggedin(player)and(not client or client==player))then
			if(not(isTimer(MinePlayerTimer[player])))then
				if(isPedDead(player))then
					return;
				end
				if(isPedInVehicle(player))then
					return;
				end
				if(getElementData(player,"Player->Data->Job")~="Miner")then
					return;
				end
				if(getPedWeapon(player)~=6)then
					return;
				end
				setElementFrozen(player,true);
				setPedAnimation(player,"BASEBALL","Bat_1");
				
				local x,y,z=getElementPosition(player);
				triggerClientEvent(root,"Play->Sound->Job",root,player,"play",x,y,z,false,"Pickaxe",0.6);
				
				MinePlayerTimer[player]=setTimer(function(player)
					if(not(MinePlayerCount[player]))then
						MinePlayerCount[player]=0;
					end
					MinePlayerCount[player]=MinePlayerCount[player]+1;
					
					triggerClientEvent(player,"Job->Mine->Progress->UI",player,"create",MinePlayerCount[player]);
					
					if(MinePlayerCount[player]>=JOBS["Miner"].MaxCount)then
						MinePlayerCount[player]=0;
						triggerClientEvent(player,"Job->Mine->Progress->UI",player);
						
						MineRewardRDM[player]=math.random(1,200);
						
						if(MineRewardRDM[player]>0 and MineRewardRDM[player]<=80)then
							local rdm=math.random(6,10);
							addInventory(player,"Stone",rdm);
							triggerClientEvent(player,"Infobox->UI",player,"info",loc(player,"Job->GotItem"):format(rdm,loc(player,"Item->Name->Stone")));
						elseif(MineRewardRDM[player]>80 and MineRewardRDM[player]<=130)then
							local rdm=math.random(3,6);
							addInventory(player,"OreBronze",rdm);
							triggerClientEvent(player,"Infobox->UI",player,"info",loc(player,"Job->GotItem"):format(rdm,loc(player,"Item->Name->OreBronze")));
						elseif(MineRewardRDM[player]>130 and MineRewardRDM[player]<=170)then
							local rdm=math.random(2,5);
							addInventory(player,"OreIron",rdm);
							triggerClientEvent(player,"Infobox->UI",player,"info",loc(player,"Job->GotItem"):format(rdm,loc(player,"Item->Name->OreIron")));
							
							setElementData(player,"OverallEXP",tonumber(getElementData(player,"OverallEXP"))+3);
							updateLevel(player,"Overall",tonumber(3));
						elseif(MineRewardRDM[player]>170 and MineRewardRDM[player]<=200)then
							local rdm=math.random(1,2);
							addInventory(player,"OreGold",rdm);
							triggerClientEvent(player,"Infobox->UI",player,"info",loc(player,"Job->GotItem"):format(rdm,loc(player,"Item->Name->OreGold")));
							
							setElementData(player,"OverallEXP",tonumber(getElementData(player,"OverallEXP"))+8);
							updateLevel(player,"Overall",tonumber(3));
						end
					end
					
					setElementFrozen(player,false);
					setPedAnimation(player);
					
					setElementPosition(player,x,y,z);
				end,1*1000,1,player)
			end
		end
	end
end










--gate
local Table={--objID,x,y,z,rotX,rotY,rotZ, moveX,moveY,moveZ,moveRotX,moveRotY,moveRotZ, moveBackX,moveBackY,moveBackZ, range
	{3095,3826.4,482.9,57.1,0,0,0, 3826.4,482.9,65.2,0,0,0 ,0,0,0, 7},
};

local TableObjects={};
local TableObjectsDatas={};
local TableObjectsStatus={};
addEventHandler("onResourceStart",resourceRoot,function()
	local TableCols={};
	for i,v in pairs(Table)do
		if(v[1]==3095)then
			TableCols[i]=createColSphere(v[2],v[3],v[4]+6,v[17]);--create a invisible area
		else
			TableCols[i]=createColSphere(v[2],v[3],v[4],v[17]);--create a invisible area
		end
		TableObjects[TableCols[i]]=createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7]);--create gate object
		TableObjectsDatas[TableCols[i]]={v[2],v[3],v[4],v[5],v[6],v[7], v[8],v[9],v[10],v[11],v[12],v[13], v[14],v[15],v[16], v[18],v[19]};--put object and col pos in table
		TableObjectsStatus[TableCols[i]]=false;
		setElementDimension(TableCols[i],4000);
		setElementDimension(TableObjects[TableCols[i]],4000);
		
		addEventHandler("onColShapeHit",TableCols[i],moveMineGate);
	end
end)


function moveMineGate(elem)
	if(elem and isElement(elem))then
		if(getElementType(elem)=="vehicle")then
			player=getVehicleOccupant(elem,0);
		elseif(getElementType(elem)=="player")then
			player=elem;
		end
		if(not(TableObjectsStatus[source]))then
			TableObjectsStatus[source]=true;
			
			setTimer(function(source)
				moveObject(TableObjects[source],5*1000,TableObjectsDatas[source][1],TableObjectsDatas[source][2],TableObjectsDatas[source][3],TableObjectsDatas[source][13],TableObjectsDatas[source][14],TableObjectsDatas[source][15]);
			end,8*1000,1,source);
			setTimer(function(source)
				TableObjectsStatus[source]=false;
			end,10*1000,1,source);
			moveObject(TableObjects[source],5*1000,TableObjectsDatas[source][7],TableObjectsDatas[source][8],TableObjectsDatas[source][9],TableObjectsDatas[source][10],TableObjectsDatas[source][11],TableObjectsDatas[source][12]);
		end
	end
end