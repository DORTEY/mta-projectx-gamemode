local Table={--garageID, x,y,z,type,size
	{19, -1904.3,285.5,40.1,"cylinder",4},--SF Downtown
	{36, 1976.6,2162.4,10.2,"cylinder",4},--LV Redsands East
	{41, -99.8,1118.4,19.3,"cylinder",4},--Fort Carson
	{8, 2062.8,-1831.5,12.5,"cylinder",4},--LS Idlewood
	{47, 720.2,-455.8,16.3,"cylinder",4},--LS Dillomore
	{11, 1024.9,-1023.7,31.1,"cylinder",4},--LS Temple
	{12, 487.3,-1741.6,10.2,"cylinder",4},--LS Beach
	{40, -1420.6,2583.6,55.8,"cylinder",4},--LV El Quebrados
	{27, -2425.6,1019.6,49.4,"cylinder",4},--SF Juniper
	{24, -1786.9,1214.8,24.1,"cylinder",4},--SF downtown
	{nil, 1445.0,-1780.6,12.6,"cylinder",3.5},--LS Commerce
	{nil, 2515.0,-1468.2,23.0,"cylinder",3.5},--LS East LS
	{nil, 2544.8,115.6,25.4,"cylinder",3.5},--Palomino Creek
	{nil, 92.7,-165.1,1.6,"cylinder",3.5},--Blueberry Acres
	{nil, 386.6,2537.7,15.5,"cylinder",3.5},--Verdant Meadows
	{nil, 2006.0,2311.0,9.8,"cylinder",3.5},--Redsands East
};
addEventHandler("onResourceStart",resourceRoot,function()
	local TableCols={};
	local TableBlips={};
	for i,v in pairs(Table)do
		TableCols[i]=createMarker(v[2],v[3],v[4],v[5],v[6],200,0,0,100);
		TableBlips[i]=createBlip(v[2],v[3],v[4],10,20,255,255,255,255,100);
		if(TableCols[i]and v[1])then
			setGarageOpen(v[1],true);--open the garages if they've
		end
		setElementData(TableBlips[i],"tooltipText","Pay 'n' Spray");
		
		addEventHandler("onMarkerHit",TableCols[i],enterPayNspray);
	end
end)

local PLAYER_PAYNSPRAY_VEHICLE={};--table for player vehicles if they die/quit
function enterPayNspray(elem)
	if(elem and isElement(elem)and getElementType(elem)=="vehicle")then
		local player=getVehicleOccupant(elem,0);--get vehicle driver seat player
		if(player and isElement(player)and isLoggedin(player))then
			if(getElementDimension(source)==getElementDimension(player))then
				if(getElementHealth(getPedOccupiedVehicle(player))<1000)then
					local price=1000-getElementHealth(getPedOccupiedVehicle(player));
					if(tonumber(getElementData(player,"Money"))>=tonumber(price*PRICE_PAYNSPRAY))then--check money from player
						toggleAllControls(player,false);
						setElementFrozen(player,true);
						setElementFrozen(elem,true);
						
						PLAYER_PAYNSPRAY_VEHICLE[player]=elem;--set vehicle element to player
						
						TABLE_VEHICLE_PAYNSPRAY_TIMER[player]=setTimer(function(player,source)
							playSoundFrontEnd(player,46);
							toggleAllControls(player,true);
							setElementFrozen(player,false);
							setElementFrozen(elem,false);
							fixVehicle(elem);
							setElementData(player,"Money",tonumber(getElementData(player,"Money"))-tonumber(price*PRICE_PAYNSPRAY));
							triggerClientEvent(player,"Infobox->UI",player,"money",loc(player,"Vehicle->Repair->PNS"):format(CURRENCY,price*PRICE_PAYNSPRAY));
							
							TABLE_VEHICLE_PAYNSPRAY_TIMER[player]=nil;
						end,VEHICLE_REPAIRTIME,1,player,source)
					else
						triggerClientEvent(player,"Infobox->UI",player,"error",loc(player,"NotEnoughMoney"):format(CURRENCY,price*PRICE_PAYNSPRAY));
					end
				end
			end
		end
	end
end


local function destroyElementsAfterQuitDead(player)
	if(isTimer(TABLE_VEHICLE_PAYNSPRAY_TIMER[source]))then
		killTimer(TABLE_VEHICLE_PAYNSPRAY_TIMER[source]);
		TABLE_VEHICLE_PAYNSPRAY_TIMER[source]=nil;
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)