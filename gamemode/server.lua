--global tables
DEFAULTSPAWNPOS={1719,-1949.2,13.5,0,0,0};--x,y,z,rot,int,dim
TABLE_PLAYER_PAYDAY_TIMER={};
TABLE_PLAYER_PAYDAY_ACTIVITY={};
TABLE_PLAYER_HUNGER_TIMER={};
TABLE_PLAYER_WANTED_TIMER={};
TABLE_PLAYER_WEAPON_SAVE_TEMP={};
TABLE_PLAYER_STICK_HITS={};

TABLE_VEHICLES={};--all vehicles spawn inside this table
TABLE_VEHICLES_USER={};--all user vehicles
TABLE_VEHICLES_JOB={};--all user job vehicles
TABLE_VEHICLE_RESPAWNTIMER={};--vehicle timer after lefting a vehicle
TABLE_VEHICLE_PAYNSPRAY_TIMER={};--player pay 'n' spray timer

JOB_OBJECT_1={};--tables for jobs
JOB_OBJECT_2={};

TABLE_PLAYER_BLIPS={};

TABLE_PLAYER_DEATH_BLIP={};
TABLE_PLAYER_DEATH_PICKUP={};
TABLE_PLAYER_REVIVETIMER={};
TABLE_PLAYER_ITEMUSETIMER={};


--global timers
VEHICLE_RESPAWNTIME_BLOW=5*60*1000;
VEHICLE_RESPAWNTIME=5*60*1000;
VEHICLE_REPAIRTIME=4*1000;


--global variables
REVIVE_MONEY=2000;
HOSPITAL_WAITTIME=6;--in seconds 6 (6 seconds)
HOSPITAL_WAITTIME_MEDIC_ONLINE=60;--in seconds 60 (1 minutes)
HOSPITAL_WAITTIME_MEDIC_ONLINE_VIP=30;--in seconds 30 (30 seconds)

WANTED_TIME_DEATH=1;--1 wanted = 1 minute | 6 wanteds = 6 minutes
WANTED_TIME_DEATH_EARN_MONEY=2000;--for each wanted
WANTED_TIME_DEATH_EARN_EXP=55;--for each wanted
WANTED_AMOUNT_BLIP=2;--wanted amount to become a red blip


ElementInventories={--inventory tables
	["player"]={},
};


JailPositions={
	{1581.8,-1663,12.2},
	{1572,-1663,12.2},
	{1581.4,-1659.1,12.2},
	{1572.5,-1658.8,12.2},
	{1581.7,-1655.1,12.2},
	{1572.4,-1655,12.2},
	{1581.8,-1651.1,12.2},
	{1571.8,-1650.8,12.2},
};


--set stuff after script re/start
local function setStartStuff()
	setGameType(SERVER_NAME_SHORT.." v"..SERVER_VERSION);
	setMapName(SERVER_NAME_SHORT.." v"..SERVER_VERSION);
	setFPSLimit(62);
	setServerPassword("");
	
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			setClickedState(v,false);
			setElementData(v,"Player->Data->Loggedin",0);
		end
	end
	
	local time=getRealTime();
	local hour=time.hour;
	local minute=time.minute;
	local weekday=time.weekday;
	
	setTime(hour,minute);
	setMinuteDuration(60*1000);
end
addEventHandler("onResourceStart",resourceRoot,setStartStuff)
setTimer(setStartStuff,2*1000,1)

--server restart
setTimer(function()
	local time=getRealTime();
	
	if(not(DEVMODE)and not(BETAMODE))then
		if(time.hour==06 and time.minute==01)then
			if(DEVMODE==false)then
				sendDiscordMessage("Restart","WARNING: Serverrestart done!");
			end
		elseif(time.hour==06 and time.minute==00)then
			restartResource(resource);
			setServerPassword("");
		elseif(time.hour==04 and time.minute==59)then
			dbExec(DB.HANDLER,"TRUNCATE TABLE ??","Player_Cases");
			outputChatBox("WARNING: Serverrestart in 1 Minute!",root,200,0,0);
			if(DEVMODE==false)then
				sendDiscordMessage("Restart","WARNING: Serverrestart in 1 Minute!");
			end
			setServerPassword(math.random(1000,99999))
		elseif(time.hour==04 and time.minute==58)then
			outputChatBox("WARNING: Serverrestart in 2 Minutes!",root,200,0,0);
			outputChatBox("WARNING: No need to disconnect! Everything will be saved!",root,200,0,0);
			if(DEVMODE==false)then
				sendDiscordMessage("Restart","WARNING: Serverrestart in 2 Minutes!");
			end
		elseif(time.hour==04 and time.minute==55)then
			outputChatBox("WARNING: Serverrestart in 5 Minutes!",root,200,0,0);
			outputChatBox("WARNING: No need to disconnect! Everything will be saved!",root,200,0,0);
			if(DEVMODE==false)then
				sendDiscordMessage("Restart","WARNING: Serverrestart in 5 Minutes!");
			end
		elseif(time.hour==04 and time.minute==50)then
			outputChatBox("WARNING: Serverrestart in 10 Minutes!",root,200,0,0);
			outputChatBox("WARNING: No need to disconnect! Everything will be saved!",root,200,0,0);
			if(DEVMODE==false)then
				sendDiscordMessage("Restart","WARNING: Serverrestart in 10 Minutes!");
			end
		end
	end
end,60*1000,0)


--teleport player
function fadeElementPosition(player,x,y,z,rot,int,dim,frozen)
	if(isElement(player)and isLoggedin(player)and getElementType(player)=="player")then
		if(x and y and z and int and dim and rot)then
			if(frozen==true)then
				setElementFrozen(player,true);
				setTimer(setElementFrozen,1000,1,player,false);
			end
			
			setElementPosition(player,x,y,z);
			setElementInterior(player,int);
			setElementDimension(player,dim);
			setElementRotation(player,0,0,rot);
		end
	end
end

--1 message to a string
function stringTextWithAllParameters(...)
	local tbl={...};
	return table.concat(tbl," ")
end


--
addEventHandler("onPlayerJoin",root,function()
	local rdm=math.random(100000,999999);
	setPlayerName(source,"GUEST-"..rdm);--set random name when player join
	
	setElementData(source,"Player->Data->Loggedin",0);
end)

addEventHandler("onResourceStop",resourceRoot,function()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			savePlayerDatas(v);
			setClickedState(v,false);
			setElementData(v,"Player->Data->Loggedin",0);
			removeElementData(v,"Player->Data->Robbing");
			removeElementData(v,"Player->Data->EventID");
			removeElementData(v,"Player->Data->ID");
			removeElementData(v,"Player->Data->Premium");
			
			local rdm=math.random(100000,999999);
			setPlayerName(v,"GUEST-"..rdm);--set random name when script stops/restarts
		end
	end
	dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","Player_Accounts","LoggedinDB",0,"LoggedinDB",1);
	
	if(DB.HANDLER)then
		destroyElement(DB.HANDLER);
		DB.HANDLER=nil;
	end
end)


function getCurrentDate()
	local time=getRealTime();
	local year=time.year+1900;
	local month=time.month+1;
	local day=time.monthday;
	local hour=time.hour;
	local minute=time.minute;
	
	if(day<10)then
		day="0"..day;
	end
	if(month<10)then
		month="0"..month;
	end
	if(year<10)then
		year="0"..year;
	end
	if(hour<10)then
		hour="0"..hour;
	end
	if(minute<10)then
		minute="0"..minute;
	end
	
	return month.."/"..day.."/"..year.." - "..hour..":"..minute;
end

--get timestamp hours
function getSecTime(duration)
	local time=getRealTime();
	local year=time.year+1900;
	local month=time.month+1;
	local day=time.monthday;
	local hour=time.hour;
	local minute=time.minute;
	
	
	if(not duration)then
		duration=0;
	end
	local total=year*365*24*60+day*24*60+(hour+duration)*60+minute;
	return total;
end

function getTBanSecTime(duration)
	return getSecTime(duration);
end