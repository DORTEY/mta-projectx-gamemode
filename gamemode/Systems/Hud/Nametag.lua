nameTagRange=15;
nameSphere=createColSphere(0,0,0,nameTagRange)

nameTagPlayers={};
nameTagVisible={};
nameTagHP={};
nameTagImages={};
nameTagAimTarget=localPlayer;


for _,i in pairs(getElementsByType("player"))do
	setPlayerNametagShowing(i,false);
end
addEventHandler("onClientPlayerJoin",root,function()
	setPlayerNametagShowing(source,false);
end)

function nameTagSpawn()
	detachElements(nameSphere);
	if(isElement(localPlayer))then
		attachElements(nameSphere,localPlayer);
	end
end
setTimer(nameTagSpawn,250,0);

function nameTagSphereHit(elem,dim)
	if(getElementType(elem)=="player" and not(elem==localPlayer))then
		nameTagPlayers[elem]=true;
		nameTagImages[elem]={};
		nameTagCheckPlayerSight(elem);
	end
end
addEventHandler("onClientColShapeHit",nameSphere,nameTagSphereHit)

function nameTagCheckPlayerSight(player)
	if(isElement(player))then
		local x1,y1,z1=getPedBonePosition(player,8);
		local x2,y2,z2=getPedBonePosition(localPlayer,8);
		local hit=processLineOfSight(x1,y1,z1,x2,y2,z2,true,false,false,true,false);
		
		nameTagVisible[player]=not hit;
		
		if(nameTagVisible[player])then
			nameTagHP[player]=getElementHealth(localPlayer);
		end
		
		local PlayerWanted=tonumber(getElementData(player,"Wanteds"))or 0;
		local PlayerTeam=tostring(getElementData(player,"Player->Data->Team"))or nil;
		local Aduty=getElementData(player,"Player->Data->AdminDuty")or false;
		
		if(not nameTagImages[player])then
			nameTagImages[player]={};
		end
		--teams
		nameTagImages[player]["Teams/Civilian.png"]=false;
		nameTagImages[player]["Teams/SAPD.png"]=false;
		nameTagImages[player]["Teams/FIB.png"]=false;
		nameTagImages[player]["Teams/SAMD.png"]=false;
		nameTagImages[player]["Teams/Grove.png"]=false;
		--wanteds
		nameTagImages[player]["Nametag/Wanted_1.png"]=false;
		nameTagImages[player]["Nametag/Wanted_2.png"]=false;
		nameTagImages[player]["Nametag/Wanted_3.png"]=false;
		nameTagImages[player]["Nametag/Wanted_4.png"]=false;
		nameTagImages[player]["Nametag/Wanted_5.png"]=false;
		nameTagImages[player]["Nametag/Wanted_6.png"]=false;
		--other
		nameTagImages[player]["Nametag/ADUTY.png"]=false;
		
		
		--//Facs
		if(PlayerTeam and PlayerTeam~=nil)then
			if(PlayerTeam=="Civilian")then
				nameTagImages[player]["Teams/Civilian.png"]=true;
			end
			if(PlayerTeam=="SAPD")then
				nameTagImages[player]["Teams/SAPD.png"]=true;
			end
			if(PlayerTeam=="FIB")then
				nameTagImages[player]["Teams/FIB.png"]=true;
			end
			if(PlayerTeam=="SAMD")then
				nameTagImages[player]["Teams/SAMD.png"]=true;
			end
			if(PlayerTeam=="Grove")then
				nameTagImages[player]["Teams/Grove.png"]=true;
			end
		end
		--//Wanteds
		if(PlayerWanted)then
			if(PlayerWanted>=1)then
				nameTagImages[player]["Nametag/Wanted_"..tostring(PlayerWanted)..".png"]=true;
			end
		end
		--//Other
		if(Aduty)then
			if(Aduty==true)then
				nameTagImages[player]["Nametag/ADUTY.png"]=true;
			end
		end
	else
		if(nameTagPlayers[player])then
			nameTagPlayers[player]=nil;
		end
		if(nameTagVisible[player])then
			nameTagVisible[player]=nil;
		end
		if(nameTagHP[player])then
			nameTagHP[player]=nil;
		end
	end
end

addEventHandler("onClientColShapeLeave",nameSphere,function(elem)
	nameTagPlayers[elem]=nil;
	nameTagVisible[elem]=nil;
	nameTagHP[elem]=nil;
end)

addEventHandler("onClientRender",root,function()
	setElementData(localPlayer,"isChatBoxInputActive",tostring(isChatBoxInputActive()))
	
	if(not isLoggedin())then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isClickedState(localPlayer)==true)then
		return;
	end
	local x,y,z,sx,sy;
	local name,social,nametag;
	local r,g,b,armor;
	local images,drawn;
	for i,_ in pairs(nameTagVisible)do
		if(isElement(i)and isLoggedin(i))then
			if(nameTagVisible[i])then
				x,y,z=getElementPosition(i);
				if(x and y and z)then
					sx,sy=getScreenFromWorldPosition(x,y,z+1.1,1000,true);
					if(sx and sy)then
						if(getElementAlpha(i)>=100)then
							r,g,b=calcRGBByHP(i)
							r1,g1,b1=255,255,255;
							name=getPlayerName(i);
							
							social="";
							nametag="";
							
							if(isChatBoxInputActive())then
								setElementData(localPlayer,"isChatBoxInputActive",true);
							else
								setElementData(localPlayer,"isChatBoxInputActive",false);
							end
							
							if(getElementData(i,"Player->Data->AdminDuty")==true)then
								social="Supportmodus";
								r1,g1,b1=220,0,0;
							end
							if(getElementData(i,"isChatBoxInputActive")==true)then 
								social="writing...";
							end
							
							--if(tonumber(getElementData(i,"AdminLevel"))>=1)then
							--	nametag="["..ServerStuff.NameShort.."]";
							--end
							dxDrawText(nametag..name,sx,sy,sx,sy,tocolor(r,g,b,255),1.3,"default-bold","center","center");
							dxDrawText(social,sx-2,sy-1+40,sx,sy,tocolor(r1,g1,b1,255),1.1,"default-bold","center","center");
							
							dxSetRenderTarget();
							
							images,drawn=0,0;
							for _,v in pairs(nameTagImages[i])do
								if(v)then
									images=images+1;
								end
							end
							for ii,v in pairs(nameTagImages[i])do
								if(v)then
									local imgpath="Files/Images/"..ii;
									if(images/2==math.floor(images/2))then
										dxDrawImage(sx+25*(drawn)-images*25+25,sy+30,25,25,imgpath)
										drawn=drawn+1
									else
										dxDrawImage(sx+25*(drawn)-images*25/2,sy+30,25,25,imgpath)
										drawn=drawn+1
									end
								end
							end
						end
					end
				end
			end
		else
			nameTagCheckPlayerSight(i);
		end
	end
end)

function calcRGBByHP(player)
	local hp=getElementHealth(player)
	local armor=getPedArmor(player)
	if(hp<=0)then
		return 0,0,0
	else
		if(armor>0)then
			armor=math.abs(armor-0.01)
			return 0+(2.55*armor),(255),0+(2.55*armor)
		else
			hp=math.abs(hp-0.01)
			return(100-hp)*2.55/2,(hp*2.55),0
		end
	end
end

function reCheckNameTag()
	if(isElement(getCameraTarget()))then
		detachElements(nameSphere);
		attachElements(nameSphere,getCameraTarget());
	end
	setElementInterior(nameSphere,getElementInterior(localPlayer));
	setElementDimension(nameSphere,getElementDimension(localPlayer));
	if(isPedAiming(localPlayer)and getPedWeaponSlot(localPlayer)==6)then
		local x1,y1,z1=getPedTargetStart(localPlayer);
		local x2,y2,z2=getPedTargetEnd(localPlayer);
		local boolean,x,y,z,hit=processLineOfSight(x1,y1,z1,x2,y2,z2);
		if(boolean)then
			if(isElement(hit))then
				if(getElementAlpha(hit)>=100)then
					if(getElementType(hit)=="player")then
						nameTagAimTarget=hit;
						nameTagPlayers[nameTagAimTarget]=nameTagAimTarget;
					end
				end
			end
		end
	end
	for i,_ in pairs(nameTagPlayers)do
		nameTagCheckPlayerSight(i);
	end
end
setTimer(reCheckNameTag,250,0);