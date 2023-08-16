addRemoteEvents{"Sync->Animation->S"};--addEvent


local animationListTable={
	["Hands up"]={{"shop","SHP_HandsUp_Scr",-1,false,true,true,nil,nil},"normal"},
	["Hands up 2"]={{"gtav","handsup",-1,false,true,true,nil,nil},"custom"},
	["Wave"]={{"ON_LOOKERS","wave_loop",-1,true,false,true,nil,nil},"normal"},
	["Fuck you"]={{"ped","fucku",-1,true,true,true,nil,nil},"normal"},
	["Fuck you 2"]={{"gtav","fucku",-1,true,true,true,nil,nil},"custom"},
	["Laugh"]={{"rapping","Laugh_01",-1,true,false,true,nil,nil},"normal"},
	["Lying down 1"]={{"BEACH","bather",-1,true,false,true,nil,nil},"normal"},
	["Lying down 2"]={{"BEACH","lay_bac_loop",-1,true,false,true,nil,nil},"normal"},
	["Lying down 3"]={{"BEACH","sitnwait_loop_w",-1,true,false,true,nil,nil},"normal"},
	["Sit down (Male)"]={{"BEACH","parksit_m_loop",-1,true,false,true,nil,nil},"normal"},
	["Sit down (Female)"]={{"BEACH","parksit_w_loop",-1,true,false,true,nil,nil},"normal"},
	["Hide"]={{"PED","cower",-1,true,false,true,nil,nil},"normal"},
	["Show something"]={{"on_lookers","point_loop",-1,true,false,true,nil,nil},"normal"},
	["Cross arms"]={{"cop_ambient","Coplook_loop",-1,true,false,true,nil,nil},"normal"},
	["Piss"]={{"PAULNMAC","Piss_loop",-1,true,false,true,nil,nil},"normal"},
	["Deal"]={{"dealer","dealer_deal",-1,true,false,true,nil,nil},"normal"},
	["Fortnite (Come here)"]={{"fortnite1","baile 1",-1,true,false,false,nil,nil},"custom"},
	["Fortnite (Infinity)"]={{"fortnite1","baile 6",14000,true,false,false,nil,nil},"custom","Infinity"},
	--["test"]={{"gtav","fucku",-1,true,false,false,nil,nil},"custom"},
	
	--dances
	["Dancing clapping 1"]={{"DANCING","bd_clap",-1,true,false,false,nil,nil},"normal"},
	["Dancing clapping 2"]={{"DANCING","bd_clap1",-1,true,false,false,nil,nil},"normal"},
	["Dancing oriental"]={{"DANCING","dnce_M_a",-1,true,false,true,nil,nil},"normal"},
	["Dancing chill"]={{"DANCING","dnce_M_b",-1,true,false,true,nil,nil},"normal"},
	["Dancing rhythmic"]={{"DANCING","dnce_M_d",-1,true,false,false,nil,nil},"normal"},
	["Dancing wild"]={{"DANCING","dnce_M_e",-1,true,false,false,nil,nil},"normal"},
	["Dancing hiphop"]={{"DANCING","dance_loop",-1,true,false,false,nil,nil},"normal"},
	["Dancing sexy"]={{"STRIP","STR_Loop_A",-1,true,false,false,nil,nil},"normal"},
	["Dancing slutty"]={{"STRIP","STR_Loop_B",-1,true,false,false,nil,nil},"normal"},
	["Dancing strip 1"]={{"STRIP","STR_Loop_C",-1,true,false,false,nil,nil},"normal"},
	["Dancing strip 2"]={{"STRIP","strip_d",-1,true,false,false,nil,nil},"normal"},
	
	--idle
	["Idle 1"]={{"gtav","Idle_Gang1",-1,true,false,false,nil,nil},"custom"},
	["Idle 2"]={{"gtav","IDLE_HBHB",-1,true,false,false,nil,nil},"custom"},
	["Idle 3"]={{"gtav","IDLE_tired",-1,true,false,false,nil,nil},"custom"},
	["Idle (Armed)"]={{"gtav","IDLE_armed",-1,true,false,false,nil,nil},"custom"},
	
	--vulgär
	["Sex top"]={{"SEX","sex_1_cum_p",-1,true,false,true,nil,nil},"normal"},
	["Sex bottom"]={{"SEX","sex_1_cum_w",-1,true,false,true,nil,nil},"normal"},
	["Masturbate"]={{"PAULNMAC","wank_loop",-1,true,false,true,nil,nil},"normal"},
	["Slap that ass"]={{"SWEET","sweet_ass_slap",-1,true,false,false,nil,nil},"normal"},
	
	--donor
	["Fortnite (Orange Justice)"]={{"fortnite1","baile 2",-1,true,false,false,nil,nil},"custom","OrangeJustice"},
	["Fortnite (Smooth Moves)"]={{"fortnite1","baile 3",-1,true,false,false,nil,nil},"custom","SmoothMoves"},
	["Fortnite (Eagle)"]={{"fortnite1","baile 4",-1,true,false,false,nil,nil},"custom","Eagle"},
	["Fortnite (Electro Shuffle)"]={{"fortnite1","baile 5",14000,true,false,false,nil,nil},"custom","ElectroShuffle"},
	["Fortnite (Dance Moves)"]={{"fortnite2","baile 7",-1,true,false,false,nil,nil},"custom","DanceMoves"},
	["Fortnite (Bel-Air)"]={{"fortnite2","baile 8",-1,true,false,false,nil,nil},"custom"},
	["Fortnite (Hype)"]={{"fortnite3","baile 9",14000,true,false,false,nil,nil},"custom","Hype"},
	["Fortnite (Floss)"]={{"fortnite3","baile 10",14000,true,false,false,nil,nil},"custom","Floss"},
	["Fortnite (Take the L)"]={{"fortnite3","baile 11",14000,true,false,false,nil,nil},"custom","TakeTheL"},
	["Fortnite (Best Mate)"]={{"fortnite3","baile 12",14000,true,false,false,nil,nil},"custom","BestMate"},
	["Fortnite (Groove)"]={{"fortnite3","baile 13",14000,true,false,false,nil,nil},"custom","Groove"},
};

playerAnimStatus={};
addEvent("Play->Animation",true)
addEventHandler("Play->Animation",root,function(anim)
	if(not(isLoggedin(client)))then
		return;
	end
	if(not(isPedOnGround(client)))then
		return;
	end
	if(getElementDimension(client)>0)then
		return;
	end
	if(getElementInterior(client)>0)then
		return;
	end
	
	if(animationListTable[anim])then
		if(not(isPedInVehicle(client)))then
			local x,y,z=getElementPosition(client);
			playerAnimStatus[client]=true;
			if(animationListTable[anim][2]and animationListTable[anim][2]=="custom")then
				if(animationListTable[anim][3]and animationListTable[anim][3]~=nil and animationListTable[anim][3]~="")then
					triggerClientEvent(root,"Create->Animation->Sound",root,client,"create",x,y,z,animationListTable[anim][3],animationListTable[anim][1][3]);
				else
					triggerClientEvent(root,"Create->Animation->Sound",root,client);
				end
				triggerClientEvent(root,"Sync->Animation",root,client,animationListTable[anim][1],animationListTable[anim][1][3]);
			else
				setPedAnimation(client,animationListTable[anim][1][1],animationListTable[anim][1][2],animationListTable[anim][1][3],animationListTable[anim][1][4],animationListTable[anim][1][5],animationListTable[anim][1][6],animationListTable[anim][1][7],animationListTable[anim][1][8])
				triggerClientEvent(root,"Create->Animation->Sound",root,client);
			end
			bindKey(client,"space","down",stopPlayerAnimation)
		end
	end
end)

function stopPlayerAnimation(player)
	if(playerAnimStatus[player]==true)then
		playerAnimStatus[player]=nil;
		setPedAnimation(player);
		unbindKey(player,"space","down",stopPlayerAnimation);
		triggerClientEvent(root,"Create->Animation->Sound",root,player);
	end
end
addEvent("Stop->Animation",true)
addEventHandler("Stop->Animation",root,stopPlayerAnimation)

addEventHandler("onPlayerQuit",root,function()
	triggerClientEvent(root,"Create->Animation->Sound",root,source);
end)
addEventHandler("onPlayerWasted",root,function()
	triggerClientEvent(root,"Create->Animation->Sound",root,source);
end)



addEventHandler("Sync->Animation->S",root,function(animation)
	if(client and isElement(client)and getElementType(client)=="player")then
		if(not(isLoggedin(client)))then
			return;
		end
		
		if(animation)then
			setPedAnimation(client,unpack(animation));
		else
			setPedAnimation(client);
		end
	end
end)