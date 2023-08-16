addRemoteEvents{"Chat->Bubble"};--addEvent


local CHAT_BUBBLE_TABLE={};
local CHAT_BUBBLE_RADIUS=20;
local CHAT_BUBBLE_STATUS=0;
local CHAT_BUBBLE_TIME=8500;
local CHAT_BUBBLE_SELFVISIBLE=true;


function chatAddBubble(player,text,tick)
	if(player==localPlayer)then
		CHAT_BUBBLE_STATUS=1;
		setTimer(function()
			CHAT_BUBBLE_STATUS=0;
		end,9000,1)
	end

	table.insert(CHAT_BUBBLE_TABLE,{["player"]=player,["text"]=text,["time"]=tick,["timeEnd"]=tick+2*1000,["alpha"]=0});
end

addEventHandler("Chat->Bubble",root,function(message)
	if(source~=localPlayer)then
		chatAddBubble(source,message,getTickCount());
	elseif(CHAT_BUBBLE_SELFVISIBLE)then
		chatAddBubble(source,message,getTickCount());
	end
end)

addEventHandler("onClientRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	if(#CHAT_BUBBLE_TABLE<1)then
		return;
	end
	
	local tick=getTickCount();
	
	local pX,pY,pZ=getElementPosition(localPlayer);--player pos
	for i,v in ipairs(CHAT_BUBBLE_TABLE)do
		if(isElement(v.player)and not isPedDead(v.player))then
			if(tick-v.time<CHAT_BUBBLE_TIME)then
				if(getDistanceBetweenPoints3D(pX,pY,pZ,getElementPosition(v.player))<CHAT_BUBBLE_RADIUS)then
					v.alpha=v.alpha<200 and v.alpha+5 or v.alpha;
					
					local PbX,PbY,PbZ=getPedBonePosition(v.player,6);
					local sx,sy=getScreenFromWorldPosition(PbX,PbY,PbZ+0.2);
					
					local elapsedTime=tick-v.time;
					local duration=v.timeEnd-v.time;
					local progress=elapsedTime/duration;
					
					if(sx and sy)then
						if(not v.yPos)then
							v.yPos=sy;
						end
						
						local width=dxGetTextWidth(v.text:gsub("#%x%x%x%x%x%x",""),1,"default-bold");
						local yPos=interpolateBetween(v.yPos,0,0,sy-22*i,0,0,progress,progress>1 and "Linear" or "OutElastic");
						
						dxDrawRectangle(sx-width/2-.01*GLOBALscreenX,yPos-.03*GLOBALscreenY,width+.02*GLOBALscreenX,30,tocolor(0,0,0,v.alpha));
						dxDrawText(v.text,sx-width/2,yPos-.02*GLOBALscreenY,width,20,tocolor(255,255,255,v.alpha+50),1,"default-bold","left","top",false,false,false,true);
					end
				end
			else
				table.remove(CHAT_BUBBLE_TABLE,i);
			end
		else
			table.remove(CHAT_BUBBLE_TABLE,i);
		end
	end
end)