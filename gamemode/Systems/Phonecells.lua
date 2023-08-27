local PHONECELL_STATUS=nil;
local POSITIONS={--x,y,z
	{1368,-1151.4,22.7},
	{1318.9,-1159.8,22.7},
	{1818.7,-1271.8,12.5},
	{2114.7,-1719.6,12.4},
	{1901.9,-1944.3,12.4},
	{1722.5,-1720.8,12.5},
	{339.5,-1398.8,14.4},
	{547.4,-1499.3,14.5},
	{523.9,-1516.4,14.6},
	{355.4,-1365.1,14.4},
	{248.4,-1448.7,13.6},
};
PHONECELL_POSITION={};
local PHONECELL_PLAYER_OBJECT={};
local PHONECELL_PLAYER_TIMER={};

local function interactPhonecell(elem)
	if(elem and isElement(elem)and getElementType(elem)=="player")then
		if(not(isLoggedin(elem)))then
			return;
		end
		if(not(isElement(PHONECELL_COL)))then
			return;
		end
		if(PHONECELL_STATUS)then
			return;
		end
		
		--reset stuff
		destroyElement(PHONECELL_COL);
		PHONECELL_COL=nil;
		PHONECELL_STATUS=true;
		PHONECELL_POSITION={};
		
		local x,y,z=getElementPosition(elem);--get player pos
		
		setElementFrozen(elem,true);
		toggleAllControls(elem,false);
		setPedAnimation(elem,"ped","PHONE_IN",0,false);
		
		if(isKeyBound(elem,"X","down",interactPhonecell))then
			unbindKey(elem,"X","down",interactPhonecell);
		end
		
		if(not(isElement(PHONECELL_PLAYER_OBJECT[elem])))then
			if(elem and isElement(elem)and isLoggedin(elem))then
				PHONECELL_PLAYER_OBJECT[elem]=createObject(330,0,0,0);
				attachElementToBone(PHONECELL_PLAYER_OBJECT[elem],elem,12,-0.05,0.02,0.02,20,-90,-10);
			end
		end
		
		--destroy sound
		for _,v in pairs(getElementsByType("player"))do
			if(isElement(v)and isLoggedin(v))then
				triggerClientEvent(v,"Phonecell->Sound",v,"Destroy");
				triggerClientEvent(v,"Phonecell->Sound",v,"Create2",x,y,z);
			end
		end
		
		--give reward
		PHONECELL_PLAYER_TIMER[elem]=setTimer(function(elem)
			if(elem and isElement(elem)and getElementType(elem)=="player")then
				if(isLoggedin(elem))then
					local rdm=math.random(500,4000);
					if(isElement(PHONECELL_PLAYER_OBJECT[elem]))then
						destroyElement(PHONECELL_PLAYER_OBJECT[elem]);
						PHONECELL_PLAYER_OBJECT[elem]=nil;
					end
					setElementFrozen(elem,false);
					toggleAllControls(elem,true);
					setPedAnimation(elem,"ped","PHONE_OUT",1000,false);
					setElementData(elem,"Money",tonumber(getElementData(elem,"Money"))+tonumber(rdm));
					addPlayerAchievment(elem,"HappyPhone");
					
					outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."PHONECELL#ffffff] "..loc(elem,"Phonecell->Reward"):format(CURRENCY,rdm).."",elem,255,255,255,true);
				end
			end
		end,7*1000,1,elem);
		
		--generate new phonecell
		setTimer(function()
			createRandomPhonecell();
			PHONECELL_STATUS=nil;
		end,10*60*1000,1);
	end
end

function createRandomPhonecell()
	local rdm=math.random(1,#POSITIONS);
	local TABLE=POSITIONS[rdm];
	
	PHONECELL_COL=createColSphere(TABLE[1],TABLE[2],TABLE[3],3);
	PHONECELL_POSITION={TABLE[1],TABLE[2],TABLE[3]};
	
	for _,v in pairs(getElementsByType("player"))do
		if(isElement(v)and isLoggedin(v))then
			triggerClientEvent(v,"Phonecell->Sound",v,"Create",PHONECELL_POSITION[1],PHONECELL_POSITION[2],PHONECELL_POSITION[3]);
		end
	end
	
	addEventHandler("onColShapeHit",PHONECELL_COL,function(elem,dim)
		if(getElementType(elem)=="player" and dim)then
			if(isPedDead(elem))then
				return;
			end
			if(isPedInVehicle(elem))then
				return;
			end
			if(getElementInterior(elem)==getElementInterior(source)and getElementDimension(elem)==getElementDimension(source))then
				if(not isKeyBound(elem,"X","down",interactPhonecell))then
					bindKey(elem,"X","down",interactPhonecell);
				end
				outputChatBox("#ffffff[#"..SRV_COLORS.HEX.."PHONECELL#ffffff] "..loc(elem,"Phonecell->Info").."",elem,255,255,255,true);
			end
		end
	end)
	
	addEventHandler("onColShapeLeave",PHONECELL_COL,function(elem,dim)
		if(getElementType(elem)=="player" and dim)then
			if(isKeyBound(elem,"X","down",interactPhonecell))then
				unbindKey(elem,"X","down",interactPhonecell);
			end
		end
	end)
end
addEventHandler("onResourceStart",resourceRoot,createRandomPhonecell)



addEventHandler("onPlayerQuit",root,function()
	if(isTimer(PHONECELL_PLAYER_TIMER[source]))then
		killTimer(PHONECELL_PLAYER_TIMER[source]);
		PHONECELL_PLAYER_TIMER[source]=nil;
	end
end)