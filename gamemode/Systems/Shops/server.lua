addRemoteEvents{"Shop->Buy->Skin","Shop->Buy->Item", "Shop->Buy->Weapon","Shop->Buy->Ammo"};--addEvent


addEventHandler("Shop->Buy->Skin",root,function(gender,skinID,shopTyp)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		local typOld=getElementData(client,"SkinID");
		if(skinID)then
			if(tonumber(getElementData(client,"Money"))>=tonumber(SHOPS.PedPrices[tostring(gender)][skinID]))then
				local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(typOld);
				if(isCustom)then--check is skin before custom skin
					local dataName2=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
					removeElementData(client,dataName2);
				end
				local isCustom,mod,elementType=exports[RESOURCE_NAME_NEWMODELS]:isCustomModID(skinID);
				if(isCustom)then--check custom skin
					local dataName=exports[RESOURCE_NAME_NEWMODELS]:getDataNameFromType(elementType);
					removeElementData(client,dataName);
					setElementModel(client,mod.base_id);
					setElementData(client,dataName,mod.id);
				end
				setElementModel(client,skinID);
				
				setElementData(client,"SkinID",skinID);
				setElementData(client,"Money",tonumber(getElementData(client,"Money"))-tonumber(SHOPS.PedPrices[getElementData(client,"Gender")][skinID]));
				
				triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"Shop->MSG->Bought->Skin"):format(skinID));
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,SHOPS.PedPrices[getElementData(client,"Gender")][skinID]));
			end
		end
	end
end)

addEventHandler("Shop->Buy->Item",root,function(item,amount)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		assert(type(item)=="string","Bad argument @ Shops:Shop->Buy->Item #1");
		assert(type(amount)=="number","Bad argument @ Shops:Shop->Buy->Item #2");
		if(item and type(item)=="string" and amount and type(amount)=="number" and SHOPS.ItemPrices[item])then
			if(tonumber(getElementData(client,"Money"))>=tonumber(SHOPS.ItemPrices[item])*amount)then
				addInventory(client,item,amount);
				setElementData(client,"Money",tonumber(getElementData(client,"Money"))-tonumber(SHOPS.ItemPrices[item])*amount);
				
				if(getInventoryCount(client,"Bandage")>=20)then
					addPlayerAchievment(client,"20Bandages");
				end
				
				triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"Shop->MSG->Bought->Item"):format(amount,item));
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,SHOPS.ItemPrices[item]*amount));
			end
		end
	end
end)


addEventHandler("Shop->Buy->Weapon",root,function(item)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		assert(type(item)=="string","Bad argument @ Shops:Shop->Buy->Weapon #1");
		if(item and type(SHOPS.WeaponPrices[item])=="table" and type(item)=="string")then
			if(getElementData(client,"OverallLVL")>=SHOPS.WeaponLevel[item])then
				if(getElementData(client,"Money")>=tonumber(SHOPS.WeaponPrices[item][2]))then
					giveWeapon(client,SHOPS.WeaponPrices[item][1],WeaponMaxAmmo[SHOPS.WeaponID[item]],true);
					setElementData(client,"Money",tonumber(getElementData(client,"Money"))-tonumber(SHOPS.WeaponPrices[item][2]));
					
					triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"Shop->MSG->Bought->Item"):format(1,item));
				else
					triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,SHOPS.WeaponPrices[item][2]));
				end
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"Shop->MSG->NotEnoughLevel"):format(SHOPS.WeaponLevel[item]));
			end
		end
	end
end)

addEventHandler("Shop->Buy->Ammo",root,function(item,amount)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		assert(type(item)=="string","Bad argument @ Shops:Shop->Buy->Ammo #1");
		assert(type(amount)=="number","Bad argument @ Shops:Shop->Buy->Ammo #2");
		if(item and type(item)=="string" and amount and type(amount)=="number")then
			if(getElementData(client,"Money")>=tonumber(SHOPS.WeaponAmmoPrices[item])*amount)then
				if(getPedWeapon(client)==SHOPS.WeaponID[item])then
					if(getPedTotalAmmo(client)+amount<10000)then
						giveWeapon(client,SHOPS.WeaponPrices[item][1],WeaponMaxAmmo[SHOPS.WeaponID[item]]*amount,true);
						setElementData(client,"Money",tonumber(getElementData(client,"Money"))-tonumber(SHOPS.WeaponAmmoPrices[item])*amount);
						
						triggerClientEvent(client,"Infobox->UI",client,"money",loc(client,"Shop->MSG->Bought->Item"):format(amount,item.." Ammo"));
					else
						triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"AlreadyEnoughAmmo"));
					end
				else
					triggerClientEvent(client,"Infobox->UI",client,"error","You dont have the selected weapon in your hand!")
				end
			else
				triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,SHOPS.WeaponAmmoPrices[item]*amount));
			end
		end
	end
end)