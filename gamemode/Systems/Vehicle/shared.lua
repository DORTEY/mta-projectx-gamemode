--tables
PRICE_PAYNSPRAY=10;

VEHICLE_TYPES={
	BIKES={
		[581]=true,
		[462]=true,
		[521]=true,
		[463]=true,
		[522]=true,
		[461]=true,
		[448]=true,
		[468]=true,
		[586]=true,
	},
	SAPD={
		[596]=true,
		[597]=true,
		[599]=true,
	},
	FIB={
		[490]=true,
		[528]=true,
	},
};


VEHICLE={
	PRICES={
		--bikes
		[581]=15000,--bf-400
		[468]=28000,--sanchez
		[521]=65000,--fcr-900
		[461]=350000,--pcj-600
		[522]=850000,--nrg-500
		--cars
		[604]=5000,--glendale damaged
		[549]=10000,--tampa
		[589]=20000,--club
		[533]=20000,--feltzer
		[492]=20000,--greenwood
		[565]=40000,--flash
		[562]=70000,--elegy
		[561]=120000,--stratum
		[480]=500000,--comet
		[85000]=720000,--comet 2
		[560]=500000,--sultan
		[85001]=500000,--sultan 2
		[415]=700000,--cheetah
		[451]=1200000,--turismo
		[411]=1500000,--infernus
		
		--sapd
		[596]=10000,--police ls
		[597]=10000,--police sf
		[599]=10000,--police ranger
		[490]=10000,--FBI ranger
		[528]=10000,--FBI truck
		
		--samd
		[416]=10000,
	},--165 pcj
	LEVEL={
		[581]=0,--bf-400
		[468]=3,--sanchez
		[521]=8,--fcr-900
		[461]=14,--pcj-600
		[522]=25,--nrg-500
		--cars
		[604]=0,--glendale damaged
		[549]=0,--tampa
		[589]=2,--club
		[533]=2,--feltzer
		[492]=0,--greenwood
		[565]=6,--flash
		[562]=8,--elegy
		[561]=10,--stratum
		[480]=12,--comet
		[85000]=17,--comet 2
		[560]=15,--sultan
		[85001]=16,--sultan 2
		[415]=18,--cheetah
		[451]=21,--turismo
		[411]=32,--infernus
		
		--sapd
		[596]=0,--police ls
		[597]=0,--police sf
		[599]=7,--police ranger
		[490]=3,--FBI ranger
		[528]=15,--FBI truck
		
		--samd
		[416]=0,
	},
	NAMES={
		[549]="Declasse Tampa",
		[589]="BF Club",
		[533]="Benefactor Feltzer",
		[492]="Bravado Greenwood",
		[565]="Vapid Flash",
		[562]="Annis Elegy",
		[561]="Zirconium Stratum",
		[480]="Pfister Comet",
		[85000]="Pfister Comet XLR8",
		[560]="Karin Sultan",
		[85001]="Karin Sultan Hatchback",
		[415]="Grotti Cheetah",
		[451]="Grotti Turismo",
		[411]="Pegassi Infernus",
	},
	NotSellAble={
		[495]=true,
	},
	
	SellPercent=80,
};


--speed funcs
function getElementSpeed(theElement,unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function setElementSpeed(element,unit,speed)
    local unit=unit or 0;
    local speed=tonumber(speed)or 0;
    local acSpeed=getElementSpeed(element,unit);
    if(acSpeed)then
        local diff=speed/acSpeed;
        if(diff~=diff)then
			return false;
		end
        local x,y,z=getElementVelocity(element);
		
        return setElementVelocity(element,x*diff,y*diff,z*diff);
    end
    return false;
end