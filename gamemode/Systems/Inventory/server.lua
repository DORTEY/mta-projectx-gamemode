addRemoteEvents{"Inventory->Use"};--addEvent


function getInventoryTypFromElement(elem)
	local ret=false;
	if(getElementType(elem)=="player")then
		ret="player";
	end
	
	return ret;
end

function createInventory(elem,data)
	local typ=getInventoryTypFromElement(elem)
	if(typ)then
		if(type(ElementInventories[typ][elem])~="table")then
			ElementInventories[typ][elem]=data;
		end
	end
	
	return false;
end

function addInventory(elem,object,count)
	count=tonumber(count)
	if(not count)then
		count=1;
	end
	local typ=getInventoryTypFromElement(elem);
	if(typ)then
		if(type(ElementInventories[typ][elem])=="table")then
			local old=0
			if(type(ElementInventories[typ][elem][tostring(object)])=="number")then
				old=tonumber(ElementInventories[typ][elem][tostring(object)]);
			end
			
			ElementInventories[typ][elem][tostring(object)]=old+count;
			
			return true;
		end
	end
	return false;
end
function takeInventory(elem,object,count)
	count=tonumber(count);
	if(not count)then
		count=1;
	end
	
	local typ=getInventoryTypFromElement(elem);
	if(typ)then
		if(type(ElementInventories[typ][elem])=="table")then
			local old=0;
			if(type(ElementInventories[typ][elem][tostring(object)])=="number")then
				old=tonumber(ElementInventories[typ][elem][tostring(object)]);
			end
							
			if(old>0)then
				local new=old-count;
				if(new<0)then
					new=0;
				end
				
				ElementInventories[typ][elem][tostring(object)]=new;
				
				return true;
			end
		end
	end
	return false;
end
function getInventoryCount(elem,object)
	local count=0;
	local typ=getInventoryTypFromElement(elem);
	if(typ)then
		if(type(ElementInventories[typ][elem][tostring(object)])=="number")then
			count=tonumber(ElementInventories[typ][elem][tostring(object)]);
		end
	end
	return count;
end





local InventoryStatus={};
function openInventory(player)
	if(isLoggedin(player))then
		if(not(isPedDead(player)))then
			if(not(InventoryStatus[player]))then
				InventoryStatus[player]=true;
				triggerClientEvent(player,"Inventory->UI",player,"Open",ElementInventories["player"][player]);
			else
				InventoryStatus[player]=false;
				triggerClientEvent(player,"Inventory->UI",player,"Close");
			end
		end
	end
end


addEventHandler("Inventory->Use",root,function(item)
	if(client and isElement(client)and isLoggedin(client))then
		if(item and type(item)=="string")then
			if(getInventoryCount(client,item)>0)then
				if(not(isTimer(TABLE_PLAYER_ITEMUSETIMER[client])))then
					if(item=="Bread")then
						if(tonumber(getElementData(client,"Hunger"))==100)then
							return;
						end
						takeInventory(client,item,1);
						
						setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false);
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							setPedAnimation(client);
							setElementData(client,"Hunger",tonumber(getElementData(client,"Hunger"))+17);
							if(tonumber(getElementData(client,"Hunger"))>=100)then
								setElementData(client,"Hunger",100);
							end
						end,1400,1,client)
					elseif(item=="Donut")then
						if(tonumber(getElementData(client,"Hunger"))==100)then
							return;
						end
						takeInventory(client,item,1);
						
						setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false);
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							setPedAnimation(client);
							setElementData(client,"Hunger",tonumber(getElementData(client,"Hunger"))+23);
							if(tonumber(getElementData(client,"Hunger"))>=100)then
								setElementData(client,"Hunger",100);
							end
						end,1400,1,client)
					elseif(item=="Milk")then
						if(tonumber(getElementData(client,"Hunger"))==100)then
							return;
						end
						takeInventory(client,item,1);
						
						setPedAnimation(client,"vending","vend_drink2_p",-1,false,false,false,false);
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							setPedAnimation(client);
							setElementData(client,"Hunger",tonumber(getElementData(client,"Hunger"))+23);
							if(tonumber(getElementData(client,"Hunger"))>=100)then
								setElementData(client,"Hunger",100);
							end
						end,1400,1,client)
					elseif(item=="Water")then
						if(tonumber(getElementData(client,"Hunger"))==100)then
							return;
						end
						takeInventory(client,item,1);
						
						setPedAnimation(client,"vending","vend_drink2_p",-1,false,false,false,false);
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							setPedAnimation(client);
							setElementData(client,"Hunger",tonumber(getElementData(client,"Hunger"))+17);
							if(tonumber(getElementData(client,"Hunger"))>=100)then
								setElementData(client,"Hunger",100);
							end
						end,1400,1,client)
					elseif(item=="Armor")then
						if(getPedArmor(client)==100)then
							return;
						end
						setElementFrozen(client,true);
						setPedAnimation(client,"BOMBER","BOM_Plant_Crouch_In");
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							takeInventory(client,item,1);
							
							killTimer(TABLE_PLAYER_ITEMUSETIMER[client]);
							TABLE_PLAYER_ITEMUSETIMER[client]=nil;
							
							setElementFrozen(client,false);
							setPedAnimation(client);
							setPedArmor(client,100);
						end,1900,1,client)
					elseif(item=="Bandage")then
						if(getElementHealth(client)==100)then
							return;
						end
						setElementFrozen(client,true);
						setPedAnimation(client,"BOMBER","BOM_Plant_Crouch_In");
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							takeInventory(client,item,1);
							
							killTimer(TABLE_PLAYER_ITEMUSETIMER[client]);
							TABLE_PLAYER_ITEMUSETIMER[client]=nil;
							
							setElementFrozen(client,false);
							setPedAnimation(client);
							setElementHealth(client,getElementHealth(client)+25);
						end,1500,1,client)
					elseif(item=="Medikit")then
						if(getElementHealth(client)==100)then
							return;
						end
						setElementFrozen(client,true);
						setPedAnimation(client,"BOMBER","BOM_Plant_Crouch_In");
						TABLE_PLAYER_ITEMUSETIMER[client]=setTimer(function(client)
							takeInventory(client,item,1);
							
							killTimer(TABLE_PLAYER_ITEMUSETIMER[client]);
							TABLE_PLAYER_ITEMUSETIMER[client]=nil;
							
							setElementFrozen(client,false);
							setPedAnimation(client);
							setElementHealth(client,100);
						end,1900,1,client)
					end
				end
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughItemAmount"):format(loc(client,"Item->Name->"..tostring(item))));
			end
			
			triggerClientEvent(client,"Inventory->UI->Refresh",client,ElementInventories["player"][client]);
		end
	end
end)



local function destroyElementsAfterQuitDead(player)
	if(isTimer(TABLE_PLAYER_ITEMUSETIMER[player]))then
		killTimer(TABLE_PLAYER_ITEMUSETIMER[player]);
		TABLE_PLAYER_ITEMUSETIMER[player]=nil;
	end
end
addEventHandler("onPlayerQuit",root,function()
	destroyElementsAfterQuitDead(source);
end)
addEventHandler("onPlayerWasted",root,function()
	destroyElementsAfterQuitDead(source);
end)