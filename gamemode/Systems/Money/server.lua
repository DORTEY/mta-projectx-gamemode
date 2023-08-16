addRemoteEvents{"ATM->Change->Value"};--addEvent


local TableATM={};

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in pairs(getElementsByType("object"))do
		if(getElementModel(v)==2942)then
			local x,y,z=getElementPosition(v);
			TableATM[i]=createColSphere(x,y,z,1.2);
			
			addEventHandler("onColShapeHit",TableATM[i],function(elem)
				if(elem and isElement(elem)and getElementType(elem)=="player")then
					if(not(isPedInVehicle(elem)))then
						if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
							triggerClientEvent(elem,"ATM->UI",elem,source,"Open");
						end
					end
				end
			end)
			addEventHandler("onColShapeLeave",TableATM[i],function(elem)
				if(elem and isElement(elem)and getElementType(elem)=="player")then
					triggerClientEvent(elem,"ATM->UI",elem,_,"Close");
				end
			end)
		end
	end
end)




addEventHandler("ATM->Change->Value",root,function(typ,amount)
	if(isElement(client)and isLoggedin(client))then
		assert(type(amount)=="number","Bad argument @ Money:ATM->Change->Value #1");
		assert(type(typ)=="string","Bad argument @ Money:ATM->Change->Value #2");
		if(typ and type(typ)=="string" and amount and type(amount)=="number")then
			if(typ=="Deposit")then
				if(getElementData(client,"Money")>=tonumber(amount))then
					setElementData(client,"Money",tonumber(getElementData(client,"Money"))-tonumber(amount));
					setElementData(client,"Bankmoney",tonumber(getElementData(client,"Bankmoney"))+tonumber(amount));
					
					triggerClientEvent(client,"ATM->UI",client,_,"Refresh");
				else
					triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,amount));
				end
			elseif(typ=="Withdraw")then
				if(getElementData(client,"Bankmoney")>=tonumber(amount))then
					setElementData(client,"Money",tonumber(getElementData(client,"Money"))+tonumber(amount));
					setElementData(client,"Bankmoney",tonumber(getElementData(client,"Bankmoney"))-tonumber(amount));
					
					triggerClientEvent(client,"ATM->UI",client,_,"Refresh");
				else
					triggerClientEvent(client,"Infobox->UI",client,"error",loc(client,"NotEnoughMoney"):format(CURRENCY,amount));
				end
			end
		end
	end
end)