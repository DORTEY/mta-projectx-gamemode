addRemoteEvents{"Trigger->Timerbar"};--addEvent


local TIMER=nil;
local TimerStart=nil;
local TimerEnd=nil;

local function draw(time)
	if(not(isLoggedin()))then
		return;
	end
	
	TimerStart=time;
	TimerEnd=time;
	
	removeEventHandler("onClientRender",root,drawTimerbar);
	addEventHandler("onClientRender",root,drawTimerbar);
	if(isTimer(TIMER))then
		killTimer(TIMER);
		TIMER=nil;
	end
	TIMER=setTimer(function()
		TimerStart=TimerStart-1;
		if(TimerStart==0)then
			removeEventHandler("onClientRender",root,drawTimerbar);
			killTimer(TIMER);
			TIMER=nil;
		end
	end,1000,TimerStart)
end
addEventHandler("Trigger->Timerbar",root,draw)


function drawTimerbar()
	if(not(isLoggedin()))then
		return;
	end
	
	local minutes,seconds=convertTime(TimerStart*1000);
	
	if(minutes<10)then
		minutes="0"..minutes;
	end
	if(seconds<10)then
		seconds="0"..seconds;
	end
	
	dxDrawRectangle(700*Gsx,1000*Gsy,500*Gsx,40*Gsy,tocolor(0,0,0,120),false);
	dxDrawRectangle(705*Gsx,1005*Gsy,(TimerEnd+1-TimerStart)/TimerEnd*490*Gsx,30*Gsy,tocolor(SRV_COLORS.RGB[1],SRV_COLORS.RGB[2],SRV_COLORS.RGB[3],200),false);
	dxDrawText(minutes..":"..seconds,310*Gsx,1010*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.45*Gsx,"default-bold","center",_,_,_,false,_,_);
end

function convertTime(ms)
    local min=math.floor(ms/60000);
    local sec=math.floor((ms/1000)%60);
    return min,sec;
end

addEventHandler("onClientPlayerWasted",localPlayer,function()
	if(isTimer(TIMER))then
		killTimer(TIMER);
		TIMER=nil;
		removeEventHandler("onClientRender",root,drawTimerbar);
	end
end)
