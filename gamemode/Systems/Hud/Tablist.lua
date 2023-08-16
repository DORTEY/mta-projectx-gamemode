local TABLE={
	Width=800,
	Height=600,
	RGBA={10,10,10,160},--bg color
	RGBA2={0,150,255,180},--accent color
	Scroll=0,
	ScrollMax=26,
};
local TablePlayers={};
local TIMER=nil;

local function refreshScoreboard()
	if(not(isLoggedin()))then
		return;
	end
	local i=0;
	TablePlayers={};
	
	for i,v in ipairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			pName=getPlayerName(v);
			pPing=getPlayerPing(v);
			pTime=tonumber(getElementData(v,"PlayTime"))or 0;
			pTeam=tostring(getElementData(v,"Player->Data->Team"));
			pTeamID=TEAMS[tostring(getElementData(v,"Player->Data->Team"))].SortID
			pMoney=CURRENCY..convertNumber(tonumber(getElementData(v,"Money")));
			pLevel=tonumber(getElementData(v,"OverallLVL"));
			pJob=getElementData(v,"Player->Data->Job")or "-";
			
			pTime=math.floor(pTime/60).."h";
		else
			pName="-";
			pPing=0;
			pTime="-";
			pTeam="-";
			pTeamID=20;
			pMoney=0;
			pLevel="-";
			pJob="-";
		end
		TablePlayers[i]={};
		TablePlayers[i].name=pName;
		TablePlayers[i].playtime=pTime;
		TablePlayers[i].team=pTeam;
		TablePlayers[i].teamID=pTeamID;
		TablePlayers[i].level=pLevel;
		TablePlayers[i].pJob=pJob;
		TablePlayers[i].money=pMoney;
		TablePlayers[i].ping=pPing;
		i=i+1;
	end
	if(pTeam and TEAMS[pTeam]and pTeam~="-")then
		table.sort(TablePlayers,function(a,b)
			return a.teamID<b.teamID
		end)
	end
end

local function drawTablist()
	if(not(isLoggedin()))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	
	ID=0;
	dxDrawRectangle(GLOBALscreenX/2-TABLE.Width/2,GLOBALscreenY/2-TABLE.Height/2,TABLE.Width,TABLE.Height,tocolor(TABLE.RGBA[1],TABLE.RGBA[2],TABLE.RGBA[3],TABLE.RGBA[4]),_);
	dxDrawRectangle(GLOBALscreenX/2-TABLE.Width/2,GLOBALscreenY/2-TABLE.Height/2+25,TABLE.Width,2,tocolor(TABLE.RGBA2[1],TABLE.RGBA2[2],TABLE.RGBA2[3],TABLE.RGBA2[4]),_);
	dxDrawRectangle(GLOBALscreenX/2-TABLE.Width/2,GLOBALscreenY/2-TABLE.Height/2+575,TABLE.Width,25,tocolor(TABLE.RGBA2[1],TABLE.RGBA2[2],TABLE.RGBA2[3],TABLE.RGBA2[4]),_);
	dxDrawText("Players online: "..#getElementsByType("player"),GLOBALscreenX/2-TABLE.Width/2+20,GLOBALscreenY/2-TABLE.Height/2+578,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.35,"default-bold","left","top",_,_,false,_,_);
	
	--categories
	dxDrawText("Name",GLOBALscreenX/2-TABLE.Width/2+20,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	dxDrawText("Playtime",GLOBALscreenX/2-TABLE.Width/2+200,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	dxDrawText("Team",GLOBALscreenX/2-TABLE.Width/2+290,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	dxDrawText("Job",GLOBALscreenX/2-TABLE.Width/2+400,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	dxDrawText("Level",GLOBALscreenX/2-TABLE.Width/2+500,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	dxDrawText("Money",GLOBALscreenX/2-TABLE.Width/2+575,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	
	dxDrawText("Ping",GLOBALscreenX/2-TABLE.Width/2+750,GLOBALscreenY/2-TABLE.Height/2+5,TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
	
	
	
	
	for i=0+TABLE.Scroll,TABLE.ScrollMax+TABLE.Scroll do
		if(TablePlayers[i])then
			--colors
			pingR,pingG,pingB=getPingColor(TablePlayers[i].ping);
			if(TablePlayers[i].team~="-")then
				teamR,teamG,teamB=TEAMS[TablePlayers[i].team].RGB[1],TEAMS[TablePlayers[i].team].RGB[2],TEAMS[TablePlayers[i].team].RGB[3];
			else
				teamR,teamG,teamB=255,255,255;
			end
			
			
			dxDrawText(TablePlayers[i].name,GLOBALscreenX/2-TABLE.Width/2+20,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(teamR,teamG,teamB,255),1.10,"default-bold","left","top",_,_,false,_,_);
			dxDrawText(TablePlayers[i].playtime,GLOBALscreenX/2-TABLE.Width/2+200,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
			dxDrawText(TablePlayers[i].team,GLOBALscreenX/2-TABLE.Width/2+290,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(teamR,teamG,teamB,255),1.10,"default-bold","left","top",_,_,false,_,_);
			dxDrawText(TablePlayers[i].pJob,GLOBALscreenX/2-TABLE.Width/2+400,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
			dxDrawText(TablePlayers[i].level,GLOBALscreenX/2-TABLE.Width/2+500,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
			dxDrawText(TablePlayers[i].money,GLOBALscreenX/2-TABLE.Width/2+575,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(255,255,255,255),1.10,"default-bold","left","top",_,_,false,_,_);
			
			dxDrawText(TablePlayers[i].ping,GLOBALscreenX/2-TABLE.Width/2+750,GLOBALscreenY/2-TABLE.Height/2+35+(20*ID),TABLE.Width,TABLE.Height,tocolor(pingR,pingG,pingB,255),1.10,"default-bold","left","top",_,_,false,_,_);
			
			ID=ID+1;
		end
	end
end

function scrollDown()
	if(TABLE.Scroll<=#getElementsByType("player")-TABLE.ScrollMax)then
		TABLE.Scroll=TABLE.Scroll+2;
	end
end

function scrollUp()
	if(TABLE.Scroll<=2)then
		TABLE.Scroll=0;
	else
		TABLE.Scroll=TABLE.Scroll-2;
	end
end


bindKey("TAB","DOWN",function()
	if(not(isLoggedin()))then
		return;
	end
	
	removeEventHandler("onClientRender",root,drawTablist);
	addEventHandler("onClientRender",root,drawTablist);
	
	bindKey("mouse_wheel_down","down",scrollDown);
	bindKey("mouse_wheel_up","down",scrollUp);
	
	if(isTimer(TIMER))then
		killTimer(TIMER);
		TIMER=nil;
	end
	refreshScoreboard();
	TIMER=setTimer(refreshScoreboard,1000,0);
end)

bindKey("TAB","UP",function()
	removeEventHandler("onClientRender",root,drawTablist);
	
	unbindKey("mouse_wheel_down","down",scrollDown);
	unbindKey("mouse_wheel_up","down",scrollUp);
	
	if(isTimer(TIMER))then
		killTimer(TIMER);
		TIMER=nil;
	end
	
	di=0;
end)

function getPingColor(ping)
	if(ping<=80)then
		return 0,200,0;
	elseif(ping<=160)then
		return 200,200,0;
	else
		return 200,0,0;
	end
end