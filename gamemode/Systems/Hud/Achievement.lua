addRemoteEvents{"Trigger->Achievement"};--addEvent


local TIMER=nil;
local AchievmentText=nil;
local AchievmentMoney=nil;
local AchievmentEXP=nil;

local function draw(text,money,exp)
	if(not(isLoggedin()))then
		return;
	end
	AchievmentText=text;
	AchievmentMoney=money;
	AchievmentEXP=exp;
	
	if(isClickedState(localPlayer)==false)then
		removeEventHandler("onClientRender",root,drawAchievement);
		addEventHandler("onClientRender",root,drawAchievement);
		if(isTimer(TIMER))then
			killTimer(TIMER);
			TIMER=nil;
		end
		TIMER=setTimer(function()
			removeEventHandler("onClientRender",root,drawAchievement);
		end,15*1000,1)
	else
		outputChatBox("Achievment reached: "..AchievmentText.." - You got "..CURRENCY..AchievmentMoney.." & x"..AchievmentEXP.." EXP.",255,255,255,true);
	end
end
addEventHandler("Trigger->Achievement",root,draw)


function drawAchievement()
	if(not(isLoggedin()))then
		return;
	end
	
	if(isClickedState(localPlayer)==false)then
		dxDrawImage(0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,":"..RESOURCE_NAME.."/Files/Images/Achievement/Bar.png",0,0,0,tocolor(255,255,255,220),false);
        dxDrawText("Achievment reached!!\n"..AchievmentText.."\n+ x"..CURRENCY..AchievmentMoney.."\n+ EXP: "..AchievmentEXP,0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,tocolor(160,0,0,255),1.80,"default","center","center",false,false,false,false,false);
	end
end