local POSITIONS_VEHICLES={
	{4081.6,882.1,82.5,90},
	{4081.6,878.1,82.5,90},
	{4081.6,874.1,82.5,90},
	{4081.6,870.1,82.5,90},
	{4081.6,866.1,82.5,90},
	{4081.6,862.1,82.5,90},
	{4081.6,858.1,82.5,90},
	{4081.6,854.1,82.5,90},
	{4081.6,850.1,82.5,90},
	{4081.6,846.1,82.5,90},
	
	{3947.6,882.1,82.5,-90},
	{3947.6,878.1,82.5,-90},
	{3947.6,874.1,82.5,-90},
	{3947.6,870.1,82.5,-90},
	{3947.6,866.1,82.5,-90},
	{3947.6,862.1,82.5,-90},
	{3947.6,858.1,82.5,-90},
	{3947.6,854.1,82.5,-90},
	{3947.6,850.1,82.5,-90},
	{3947.6,846.1,82.5,-90},
};
local TABLE_VEHICLES_RANDOMCHANGE={
	[1]=533,[2]=545,[3]=517,[4]=440,[5]=528,[6]=470,[7]=433,
	[8]=478,[9]=543,[10]=444,[11]=500,[12]=572,[13]=530,[14]=505,
	[15]=574,[16]=525,[17]=431,[18]=437,[19]=556,[20]=504,[21]=443,
	[22]=414,[23]=456,[24]=407,[25]=601,
};
local EVENT_ELEMENT={};
EVENT_VEHICLE={};--make global

local EVENT_TIMER=nil;


addEventHandler("onResourceStart",resourceRoot,function()
	local Count=0;
	setElementData(root,"Event->Data->PlayerCount",0);
	for i,v in ipairs(POSITIONS_VEHICLES)do
		Count=Count+1;
		EVENT_ELEMENT[i]=createVehicle(549,v[1],v[2],v[3],0,0,v[4],Count);
		
		setElementDimension(EVENT_ELEMENT[i],777);
		setVehicleColor(EVENT_ELEMENT[i],220,90,0,220,90,0);
		
		setElementData(EVENT_ELEMENT[i],"Veh->Data->Owner","Event");
		
		setElementFrozen(EVENT_ELEMENT[i],true);
		setVehicleEngineState(EVENT_ELEMENT[i],false);
		setElementData(EVENT_ELEMENT[i],"Veh->Data->Engine",false);
		setVehicleLocked(EVENT_ELEMENT[i],true);
		EVENT_VEHICLE[EVENT_ELEMENT[i]]=true;
	end
end)

addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		if(EVENT_VEHICLE[veh])then
			respawnVehicle(veh);
			fixVehicle(veh);
			setElementFrozen(veh,true);
			setVehicleLocked(veh,true);
			setVehicleEngineState(veh,false);
			setElementData(veh,"Veh->Data->Engine",false);
			triggerEvent("Event->TeleportBack",source,source);
		end
	end
end)



function startEvent5Towers()
	if(isTimer(EVENT_TIMER))then
		killTimer(EVENT_TIMER);
		EVENT_TIMER=nil;
	end
	--start timer for everyone
	for _,v in ipairs(getElementsByType("player"))do
		triggerClientEvent(v,"Trigger->Timerbar->Event",v,"start","Fivetowers",2*60);--180
	end
	
	for i,v in ipairs(POSITIONS_VEHICLES)do
		respawnVehicle(EVENT_ELEMENT[i]);
		fixVehicle(EVENT_ELEMENT[i]);
		setElementFrozen(EVENT_ELEMENT[i],true);
		setVehicleLocked(EVENT_ELEMENT[i],false);
	end
	
	
	EVENT_TIMER=setTimer(function()
		for i,v in ipairs(POSITIONS_VEHICLES)do--do stuff when event starts
			setElementFrozen(EVENT_ELEMENT[i],false);
			setVehicleLocked(EVENT_ELEMENT[i],true);
			setVehicleEngineState(EVENT_ELEMENT[i],true);
			setElementData(EVENT_ELEMENT[i],"Veh->Data->Engine",true);
		end
		for _,v in ipairs(getElementsByType("player"))do
			if(getElementData(v,"Player->Data->EventID"))then
				outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."EVENT#ffffff] Lets go!",v,0,0,0,true);
			end
		end
		for _,v in ipairs(getElementsByType("vehicle"))do--reset stuff when event starts and vehicle is empty
			if(getElementModel(v)==549 and EVENT_VEHICLE[v]==true)then
				if(getVehicleOccupant(v,0)==false)then
					setElementFrozen(v,true);
					setVehicleLocked(v,true);
					setVehicleEngineState(v,false);
					setElementData(v,"Veh->Data->Engine",false);
				end
			end
		end
		for _,v in ipairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				triggerClientEvent(v,"Trigger->Timerbar->Event",v);
			end
		end
	--end,2*60*1000,1)
	end,30*1000,1)
end

function stopEvent5Towers()
	if(isTimer(EVENT_TIMER))then
		killTimer(EVENT_TIMER);
		EVENT_TIMER=nil;
	end
	--stop timer for everyone
	for _,v in ipairs(getElementsByType("player"))do
		triggerClientEvent(v,"Trigger->Timerbar->Event",v);
	end
	
	--reset
	for _,v in ipairs(getElementsByType("player"))do
		if(getElementData(v,"Player->Data->EventID"))then
			removeElementData(v,"Player->Data->EventID");
		end
	end
	
	for i,v in ipairs(POSITIONS_VEHICLES)do
		respawnVehicle(EVENT_ELEMENT[i]);
		fixVehicle(EVENT_ELEMENT[i]);
		setElementFrozen(EVENT_ELEMENT[i],true);
		setVehicleLocked(EVENT_ELEMENT[i],true);
		setElementData(EVENT_ELEMENT[i],"Veh->Data->Engine",false);
		setVehicleEngineState(EVENT_ELEMENT[i],false);
		setElementModel(EVENT_ELEMENT[i],549);
		setVehicleColor(EVENT_ELEMENT[i],220,90,0,220,90,0);
		
		makeVehicleEmpty(EVENT_ELEMENT[i]);
	end
	
	setElementData(root,"Event->Data->PlayerCount",0);
end









local MarkerCarChange=createMarker(4015.8,862.7,81.2,"cylinder",2.5,255,0,0,100);
setElementDimension(MarkerCarChange,777);

addEventHandler("onMarkerHit",MarkerCarChange,function(elem)
	if(EVENTS.STARTET_EVENT and EVENTS.STARTET_EVENT==2)then
		if(getElementType(elem)=="vehicle")then
			local veh=elem;
			local player=getVehicleOccupant(elem,0)or nil;
			if(player and isElement(player)and getElementType(player)=="player" and isLoggedin(player))then
				if(getElementDimension(player)==getElementDimension(source))then
					if(getElementData(player,"Player->Data->EventID"))then
						if(isPedInVehicle(player)and getPedOccupiedVehicleSeat(player)==0)then
							if(EVENT_VEHICLE[veh])then
								local rdm=TABLE_VEHICLES_RANDOMCHANGE[math.random(1,#TABLE_VEHICLES_RANDOMCHANGE)];
								setElementModel(veh,rdm);
							end
						end
					end
				end
			end
		end
	end
end)