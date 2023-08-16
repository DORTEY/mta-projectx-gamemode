addRemoteEvents{"Job->Farmer->UI","Job->Create->Farmer->Stuff","Job->Destroy->Farmer->Stuff","Create->Farmer->Object"};--addEvent


local JOB_BLIP={};
local JOB_BLIP2=nil;
local JOB_OBJECTS={};

local JOB_OBJECTLIST={
	[1]={855},
	[2]={818},
};

local JOB_TIMER=nil;
local JOB_MARKER=nil;
local JOB_MARKER2=nil;
local JOB_MARKER_POS={};
local JOB_MARKER_POINT=0;
local MarkerPositions={
	[0]={--line 1
		{-118.6,98.9,2.1},
		{-114.4,110.9,2.1},
		{-110.4,123.1,2.1},
		{-106.7,134.2,2.1},
		{-102.9,147.7,2.1},
		
		--line 2
		{-106.5,149.0,2.2},
		{-110.5,135.6,2.1},
		{-114.1,124.5,2.1},
		{-118.3,112.3,2.1},
		{-122.4,100.3,2.1},
		
		--line 3
		{-126.5,101.6,2.1},
		{-122.2,113.8,2.1},
		{-118.0,125.9,2.1},
		{-114.3,137.0,2.1},
		{-110.2,150.4,2.3},
		
		--line 4
		{-114.3,151.9,2.3},
		{-118.5,138.5,2.1},
		{-122.3,127.5,2.1},
		{-126.5,115.5,2.1},
		{-130.6,102.9,2.1},
		
		--line 5
		{-135.0,104.5,2.1},
		{-130.5,117.0,2.1},
		{-126.5,129.0,2.1},
		{-122.7,140.0,2.1},
		{-118.2,153.3,2.5},
		
		--line 6
		{-122.3,154.8,2.7},
		{-127.0,141.5,2.1},
		{-130.8,130.6,2.1},
		{-134.8,118.6,2.1},
		{-139.3,106.1,2.1},
	},
	[1]={
		--line 1
		{10.112082481384,36.363006591797,2.1},
		{13.838623046875,47.631690979004,2.1},
		{19.539789199829,64.484741210938,2.1},
		--line 2
		{23.508062362671,64.017791748047,2.1},
		{18.576042175293,50.425765991211,2.1},
		{12.507641792297,32.813953399658,2.1},
		--line 3
		{14.798945426941,28.194482803345,2.1},
		{20.05428314209,44.052753448486,2.1},
		{26.380929946899,61.38765335083,2.1},
		--line 4
		{29.921283721924,61.261817932129,2.1},
		{24.595970153809,46.495708465576,2.1},
		{17.041198730469,24.985618591309,2.1},
		--line 5
		{18.759502410889,20.833562850952,2.1},
		{24.242530822754,36.146068572998,2.1},
		{32.884677886963,59.379283905029,2.1},
		--line 6
		{36.260604858398,57.995765686035,2.0},
		{29.549005508423,39.743236541748,2.1},
		{21.742681503296,18.670251846313,2.1},
		--line 7
		{23.733980178833,12.71763420105,2.1},
		{30.65976524353,32.361743927002,2.1},
		{39.02770614624,55.310752868652,1.7},
		--line 8
		{42.195697784424,53.32116317749,1.3},
		{36.288459777832,36.578147888184,2.1},
		{26.442567825317,9.9890985488892,2.1},
		--line 9
		{29.114757537842,6.5253677368164,2.1},
		{36.663520812988,27.937509536743,2.1},
		{45.016117095947,51.106552124023,1.1},
		--line 10
		{47.980266571045,49.385566711426,0.8},
		{42.297855377197,33.110954284668,1.5},
		{31.629856109619,4.5120806694031,2.1},
		--line 11
		{34.327945709229,0.75729048252106,2.1},
		{41.189228057861,20.79084777832,1.8},
		{50.509654998779,46.232284545898,0.5},
		--line 12
		{54.273788452148,44.49728012085,0.1},
		{48.851833343506,29.797872543335,0.8},
		{37.118392944336,-1.683923125267,2.1},
		--line 13
		{39.431091308594,-5.8922243118286,2.1},
		{47.753211975098,16.561666488647,1.1},
		{57.034313201904,42.053161621094,-0.8},
		--line 14
		{59.921798706055,40.534183502197,-0.6},
		{52.868606567383,20.52766418457,0.5},
		{42.28088760376,-7.8566493988037,1.9},
		--line 15
		{44.490417480469,-11.402270317078,1.7},
		{53.223609924316,11.568369865417,0.7},
		{62.929370880127,37.908184051514,-0.6},
		--line 16
		{65.695701599121,35.666946411133,-0.6},
		{59.356018066406,18.50731086731,0.1},
		{46.904415130615,-15.153985977173,1.4},
		--line 17
		{49.829776763916,-18.814212799072,1.1},
		{59.082633972168,6.4811110496521,0.4},
		{68.724090576172,33.050323486328,-0.6},
		--line 18
		{71.857124328613,30.775365829468,-0.6},
		{65.25545501709,12.475295066833,-0.8},
		{52.811447143555,-21.338407516479,0.9},
		--line 19
		{54.915172576904,-24.903602600098,0.6},
		{63.079555511475,-3.3035461902618,0.3},
		{74.690132141113,28.717027664185,-0.6},
		--line 20
		{77.556655883789,26.956657409668,-0.6},
		{69.919227600098,5.6167736053467,-0.6},
		{57.689632415771,-28.032899856567,0.3},
		--line 21
		{60.178249359131,-31.976133346558,0.1},
		{68.321617126465,-8.6757764816284,0.1},
		{79.881912231445,22.144403457642,-0.6},
	},
	[2]={--&3
		--line 1
		{-10.38419342041,0.025674810633063,2.1},
		{-23.132699966431,-27.162897109985,2.1},
		{-33.885929107666,-57.048522949219,2.1},
		{-48.818885803223,-106.99208831787,2.1},
		--line 2
		{-44.54536819458,-109.12969207764,2.1},
		{-36.228939056396,-79.35619354248,2.1},
		{-24.268566131592,-41.413669586182,2.1},
		{-8.4212312698364,-2.9553377628326,2.1},
		--line 3
		{-5.8633275032043,-5.086434841156,2.1},
		{-20.631959915161,-43.587387084961,2.1},
		{-30.393148422241,-73.740570068359,2.1},
		{-40.450668334961,-108.98152923584,2.1},
		--line 4
		{-37.151969909668,-110.33193206787,2.1},
		{-26.939542770386,-75.68090057373,2.1},
		{-15.664968490601,-40.166702270508,2.1},
		{-3.5563371181488,-7.7912354469299,2.1},
		--line 5
		{-1.5258967876434,-10.454891204834,2.1},
		{-14.128293037415,-47.480445861816,2.1},
		{-24.256351470947,-79.881393432617,2.1},
		{-32.894844055176,-110.08757781982,2.1},
		--line 6
		{-29.205852508545,-111.44258880615,2.1},
		{-21.267583847046,-83.224838256836,2.1},
		{-11.213075637817,-51.60680770874,2.1},
		{1.1184381246567,-14.380531311035,2.1},
		--line 7
		{4.8670825958252,-17.089635848999,2.1},
		{-3.8768892288208,-42.304187774658,2.1},
		{-12.674233436584,-70.436103820801,2.1},
		{-24.850807189941,-111.47423553467,2.1},
		--line 8
		{-20.895240783691,-113.03675842285,2.1},
		{-13.947011947632,-88.645668029785,2.1},
		{-2.633819103241,-52.217247009277,2.1},
		{7.7305068969727,-20.964422225952,2.1},
		--line 9
		{10.849149703979,-23.395050048828,2.1},
		{3.7728371620178,-44.58861541748,2.1},
		{-5.1830649375916,-72.645111083984,2.1},
		{-16.789859771729,-112.19352722168,1.9},
		--line 10
		{-13.153650283813,-114.05419921875,1.5},
		{-8.6816930770874,-97.155952453613,2.0},
		{1.2527912855148,-64.652679443359,2.1},
		{13.059273719788,-28.318601608276,2.1},
		--line 11
		{16.428565979004,-31.397722244263,2.1},
		{8.0636291503906,-56.376388549805,2.1},
		{-0.55861949920654,-82.953598022461,2.1},
		{-9.2866296768188,-113.93895721436,1.2},
		--line 12
		{-5.4270181655884,-116.10083007812,0.8},
		{1.7421005964279,-90.95987701416,1.6},
		{7.7532134056091,-70.194259643555,2.1},
		{19.404071807861,-34.686573028564,2.1},
	},
	[4]={
		--line 1
		{-123.72364044189,58.999404907227,2.1},
		{-136.9814453125,25.154850006104,2.1},
		{-152.08114624023,-13.5138463974,2.1},
		{-172.32174682617,-66.251052856445,2.1},
		--line 2
		{-182.02508544922,-83.342353820801,2.1},
		{-173.72676086426,-60.34774017334,2.1},
		{-162.66023254395,-31.314556121826,2.1},
		{-149.46067810059,2.235888004303,2.1},
		{-127.37648010254,60.726528167725,2.1},
		--line 3
		{-130.62780761719,63.528728485107,2.1},
		{-142.32168579102,31.089416503906,2.1},
		{-153.79580688477,1.3080948591232,2.1},
		{-172.53961181641,-46.965614318848,2.1},
		{-185.07008361816,-82.644256591797,2.1},
		--line 4
		{-188.87162780762,-83.15852355957,2.1},
		{-179.40017700195,-55.179229736328,2.1},
		{-165.89500427246,-20.739145278931,2.1},
		{-151.45736694336,16.257566452026,2.1},
		{-134.77658081055,63.875556945801,2.1},
		--line 5
		{-138.31605529785,66.687614440918,2.1},
		{-152.20207214355,26.989574432373,2.1},
		{-163.33937072754,-3.1298718452454,2.1},
		{-177.93096923828,-39.819427490234,2.1},
		{-192.54591369629,-83.311264038086,2.1},
		--line 6
		{-195.75598144531,-83.125549316406,2.1},
		{-186.50936889648,-53.405460357666,2.1},
		{-172.03608703613,-16.617958068848,2.1},
		{-160.0384979248,14.964904785156,2.1},
		{-142.08990478516,67.344665527344,2.1},
		--line 7
		{-145.97230529785,70.026885986328,2.1},
		{-158.0171661377,33.425487518311,2.1},
		{-174.27352905273,-12.206907272339,2.1},
		{-188.72329711914,-48.68286895752,2.1},
		{-199.14639282227,-83.250869750977,2.1},
	},
	[5]={
		{-520.4,-544.3,24.5},
		{1027.3,-351.8,72.9},
		{-70.3,-1121.4,0.1},
		{-375.7,-1428.1,24.7},
		{1219.9,189.9,18.8},
	}
};

function createFarmerMarker(typ)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isElement(JOB_BLIP[JOB_MARKER]))then
		destroyElement(JOB_BLIP[JOB_MARKER]);
		JOB_BLIP[JOB_MARKER]=nil;
	end
	if(isElement(JOB_MARKER))then
		destroyElement(JOB_MARKER);
		JOB_MARKER=nil;
	end
	
	if(typ=="Step->1")then--start marker
		JOB_MARKER_POINT=0;
		
		JOB_MARKER=createMarker(-29.1,62.3,2.1,"cylinder",1.5,220,220,0,100);
		
		JOB_BLIP[JOB_MARKER]=createBlip(-29.1,62.3,2.1,0,20,220,220,0,255,0);
		setElementData(JOB_BLIP[JOB_MARKER],"tooltipText","Job Mark");
		
		addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
			if(elem==localPlayer and dim)then
				if(not(isPedInVehicle(localPlayer)))then
					triggerServerEvent("Job->Start->Farmer",localPlayer);
					destroyElement(source);
				end
			end
		end)
		
	elseif(typ==0)then--lvl 0
		if(JOB_MARKER_POINT<#MarkerPositions[tonumber(typ)])then
			JOB_MARKER_POINT=JOB_MARKER_POINT+1;
			
			JOB_MARKER_POS=MarkerPositions[tonumber(typ)][JOB_MARKER_POINT];
			
			JOB_MARKER=createMarker(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],"cylinder",1.5,220,220,0,120);
			setElementDimension(JOB_MARKER,0);
			setElementInterior(JOB_MARKER,0);
			
			JOB_BLIP[JOB_MARKER]=createBlip(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],0,20,220,220,0,255,0);
			setElementData(JOB_BLIP[JOB_MARKER],"tooltipText","Job Mark");
			
			addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
				if(elem==localPlayer and dim)then
					if(not(isPedInVehicle(localPlayer)))then
						setElementFrozen(localPlayer,true);
						
						triggerServerEvent("Sync->Animation->S",localPlayer,{"BOMBER","BOM_Plant_Crouch_In",1500,false,false,false,nil,nil});
						triggerServerEvent("Sync->Animation->S",localPlayer,{"BOMBER","BOM_Plant_Loop",-1,true,false,false,true,nil});
						
						triggerEvent("Create->Farmer->Object",localPlayer,"ped",JOB_OBJECTLIST[math.random(1,#JOB_OBJECTLIST)][1],JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3]);
						
						JOB_TIMER=setTimer(function()
							if(isElement(localPlayer))then
								triggerServerEvent("Sync->Animation->S",localPlayer,{"BOMBER","BOM_Plant_Crouch_Out",1500,false,false,false,true,nil});
								setTimer(function()
									triggerServerEvent("Sync->Animation->S",localPlayer);
									setElementFrozen(localPlayer,false);
								end,1400,1)
								createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
								triggerServerEvent("Job->GiveReward",localPlayer);
							end
						end,3500,1)
					else
						triggerEvent("Infobox->UI",localPlayer,"error",loc(client,"Vehicle->LeaveBefore"));
					end
				end
			end)
		else
			JOB_MARKER_POINT=0;
			for i,v in ipairs(JOB_OBJECTS)do
				table.removevalue(JOB_OBJECTS,i);
				if(isElement(v))then
					destroyElement(v);
				end
			end
			createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
			triggerServerEvent("Job->GiveReward",localPlayer);
		end
	elseif(typ==1)then--lvl 1
		if(JOB_MARKER_POINT<#MarkerPositions[tonumber(typ)])then
			JOB_MARKER_POINT=JOB_MARKER_POINT+1;
			
			JOB_MARKER_POS=MarkerPositions[tonumber(typ)][JOB_MARKER_POINT];
			
			JOB_MARKER=createMarker(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],"cylinder",1.5,220,220,0,120);
			setElementDimension(JOB_MARKER,0);
			setElementInterior(JOB_MARKER,0);
			
			JOB_BLIP[JOB_MARKER]=createBlip(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],0,20,220,220,0,255,0);
			setElementData(JOB_BLIP[JOB_MARKER],"tooltipText","Job Mark");
			
			addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
				if(elem==localPlayer and dim)then
					if(isPedInVehicle(localPlayer))then
						local veh=getPedOccupiedVehicle(localPlayer);
						if(veh and isElement(veh))then
							if(getElementData(veh,"Veh->Data->VehID")==JOBS["Farmer"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
								createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
								triggerServerEvent("Job->GiveReward",localPlayer);
							end
						end
					end
				end
			end)
		else
			JOB_MARKER_POINT=0;
			for i,v in ipairs(JOB_OBJECTS)do
				table.removevalue(JOB_OBJECTS,i);
				if(isElement(v))then
					destroyElement(v);
				end
			end
			createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
			triggerServerEvent("Job->GiveReward",localPlayer);
		end
	elseif(typ==2 or typ==3)then--lvl 2 & 3
		if(JOB_MARKER_POINT<#MarkerPositions[2])then
			JOB_MARKER_POINT=JOB_MARKER_POINT+1;
			
			JOB_MARKER_POS=MarkerPositions[2][JOB_MARKER_POINT];
			
			JOB_MARKER=createMarker(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],"cylinder",1.5,220,220,0,120);
			setElementDimension(JOB_MARKER,0);
			setElementInterior(JOB_MARKER,0);
			
			JOB_BLIP[JOB_MARKER]=createBlip(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],0,20,220,220,0,255,0);
			setElementData(JOB_BLIP[JOB_MARKER],"tooltipText","Job Mark");
			
			addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
				if(elem==localPlayer and dim)then
					if(isPedInVehicle(localPlayer))then
						local veh=getPedOccupiedVehicle(localPlayer);
						if(veh and isElement(veh))then
							if(getElementData(veh,"Veh->Data->VehID")==JOBS["Farmer"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
								triggerEvent("Create->Farmer->Object",localPlayer,"veh",2901,JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3]+0.4);
								createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
								triggerServerEvent("Job->GiveReward",localPlayer);
							end
						end
					end
				end
			end)
		else
			JOB_MARKER_POINT=0;
			for i,v in ipairs(JOB_OBJECTS)do
				table.removevalue(JOB_OBJECTS,i);
				if(isElement(v))then
					destroyElement(v);
				end
			end
			createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
			triggerServerEvent("Job->GiveReward",localPlayer);
		end
	elseif(typ==4)then--lvl 4
		if(JOB_MARKER_POINT<#MarkerPositions[2])then
			JOB_MARKER_POINT=JOB_MARKER_POINT+1;
			
			JOB_MARKER_POS=MarkerPositions[2][JOB_MARKER_POINT];
			
			JOB_MARKER=createMarker(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],"cylinder",2.5,220,220,0,120);
			setElementDimension(JOB_MARKER,0);
			setElementInterior(JOB_MARKER,0);
			
			JOB_BLIP[JOB_MARKER]=createBlip(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],0,20,220,220,0,255,0);
			setElementData(JOB_BLIP[JOB_MARKER],"tooltipText","Job Mark");
			
			addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
				if(elem==localPlayer and dim)then
					if(isPedInVehicle(localPlayer))then
						local veh=getPedOccupiedVehicle(localPlayer);
						if(veh and isElement(veh))then
							if(getElementData(veh,"Veh->Data->VehID")==JOBS["Farmer"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
								triggerEvent("Create->Farmer->Object",localPlayer,"veh",2901,JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3]+0.4);
								createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
								triggerServerEvent("Job->GiveReward",localPlayer);
							end
						end
					end
				end
			end)
		else
			JOB_MARKER_POINT=0;
			for i,v in ipairs(JOB_OBJECTS)do
				table.removevalue(JOB_OBJECTS,i);
				if(isElement(v))then
					destroyElement(v);
				end
			end
			createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
			triggerServerEvent("Job->GiveReward",localPlayer);
		end
	elseif(typ==5)then--lvl 5
		if(not(isElement(JOB_MARKER2)))then
			JOB_MARKER2=createMarker(-32.7,63.6,2.1,"cylinder",3,0,220,0,120);
			JOB_BLIP2=createBlip(-32.7,63.6,2.1,0,5,0,220,0,255,0);
			setElementData(JOB_BLIP2,"tooltipText","Load point");
			
			addEventHandler("onClientMarkerHit",JOB_MARKER2,function(elem,dim)
				if(elem==localPlayer and dim)then
					if(isPedInVehicle(localPlayer))then
						local veh=getPedOccupiedVehicle(localPlayer);
						if(veh and isElement(veh))then
							if(getElementData(veh,"Veh->Data->VehID")==JOBS["Farmer"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
								if(getElementData(veh,"Vehicle->Data->Job->TempStuff")>0)then
									return triggerEvent("Infobox->UI",localPlayer,"error","Vehicle has been already loaded!");
								end
								setElementFrozen(veh,true);
								toggleAllControls(false);
								
								JOB_TIMER=setTimer(function()
									if(isPedInVehicle(localPlayer))then
										setElementFrozen(veh,false);
										toggleAllControls(true);
										triggerServerEvent("Job->Farmer->LoadVehicle",localPlayer);
										
										--create new marker after vehicle load
										local rdmPos=math.random(1,#MarkerPositions[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))]);
										JOB_MARKER_POS=MarkerPositions[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))][rdmPos];
										
										JOB_MARKER=createMarker(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],"cylinder",2.5,220,220,0,120);
										setElementDimension(JOB_MARKER,0);
										setElementInterior(JOB_MARKER,0);
										
										JOB_BLIP[JOB_MARKER]=createBlip(JOB_MARKER_POS[1],JOB_MARKER_POS[2],JOB_MARKER_POS[3],0,20,220,220,0,255,0);
										setElementData(JOB_BLIP[JOB_MARKER],"tooltipText","Deliver point");
										
										addEventHandler("onClientMarkerHit",JOB_MARKER,function(elem,dim)
											if(elem==localPlayer and dim)then
												if(isPedInVehicle(localPlayer))then
													local veh=getPedOccupiedVehicle(localPlayer);
													if(veh and isElement(veh))then
														if(getElementData(veh,"Veh->Data->VehID")==JOBS["Farmer"].Tiers[tonumber(getElementData(localPlayer,"Player->Data->JobRoute"))].VehID)then
															if(getElementSpeed(veh,"km/h")<=50)then
																createFarmerMarker(tonumber(getElementData(localPlayer,"Player->Data->JobRoute")));
																triggerServerEvent("Job->GiveReward",localPlayer);
															else
																triggerEvent("Open->Infobox",localPlayer,"warning","Du bist zu schnell!\nFahre langsam in den Marker! (50km/h)");
															end
														end
													end
												end
											end
										end)
									end
								end,5*1000,1)
							end
						end
					end
				end
			end)
		end
	end
end
addEventHandler("Job->Create->Farmer->Stuff",root,createFarmerMarker)


addEventHandler("Job->Destroy->Farmer->Stuff",root,function()
	if(not(isLoggedin()))then
		return;
	end
	--blips
	if(isElement(JOB_BLIP[JOB_MARKER]))then
		destroyElement(JOB_BLIP[JOB_MARKER]);
		JOB_BLIP[JOB_MARKER]=nil;
	end
	if(isElement(JOB_BLIP2))then
		destroyElement(JOB_BLIP2);
		JOB_BLIP2=nil;
	end
	
	--marker
	if(isElement(JOB_MARKER))then
		destroyElement(JOB_MARKER);
		JOB_MARKER=nil;
	end
	if(isElement(JOB_MARKER2))then
		destroyElement(JOB_MARKER2);
		JOB_MARKER2=nil;
	end
	
	--timer
	if(isTimer(JOB_TIMER))then
		killTimer(JOB_TIMER);
		JOB_TIMER=nil;
	end
	
	--objects
	for i,v in ipairs(JOB_OBJECTS)do
		table.removevalue(JOB_OBJECTS,i);
		if(isElement(v))then
			destroyElement(v);
		end
	end
end)


addEventHandler("onClientVehicleStartEnter",root,function(player)
	if(player==localPlayer)then
		if(getElementData(source,"Veh->Data->Job"))then
			if(getElementData(source,"Veh->Data->Job->Farmer")==true)then
				if(tostring(getElementData(source,"Veh->Data->Owner"))~=getPlayerName(localPlayer))then
					triggerEvent("Infobox->UI",localPlayer,"error","You cant enter others Job vehicle!");
					cancelEvent();
				end
			end
		end
	end
end)


addEventHandler("Job->Farmer->UI",root,function(typ)
	if(not(isLoggedin()))then
		return;
	end
	if(isPedDead(localPlayer))then
		return;
	end
	if(isPedInVehicle(localPlayer))then
		return;
	end
	
	if(typ=="Open")then
		if(isClickedState(localPlayer)==true)then
			return;
		end
		--set UI stuff
		setUIdatas("set","cursor",true);
		dgsSetInputMode("no_binds");
		dgsSetInputMode("no_binds_when_editing");
		
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,"Farmer Job",false,tocolor(255,255,255),GUI.Settings.Height,nil,GUI.Color.Bar,nil,GUI.Color.BG,nil,true);
		dgsWindowSetSizable(GUI.Window[1],false);
		dgsWindowSetMovable(GUI.Window[1],false);
		dgsSetProperty(GUI.Window[1],"textSize",{GUI.Settings.TextSize,GUI.Settings.TextSize});
		GUI.Button["Close"]=dgsCreateButton(465,-35,35,35,"×",false,GUI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
		
		--skin selection
		GUI.Grid[1]=dgsCreateGridList(410,10,80,285,false,GUI.Window[1],30,GUI.Color.Grid.BG,tocolor(255,255,255,255),GUI.Color.Grid.Bar,tocolor(65,65,65,255));
		GUI.Scroll[1]=dgsGridListGetScrollBar(GUI.Grid[1]);
		dgsSetProperty(GUI.Scroll[1],"troughColor",tocolor(0,0,0,200));
		dgsSetProperty(GUI.Scroll[1],"cursorColor",{GUI.Color.Grid.Scroll1,GUI.Color.Grid.Scroll2,GUI.Color.Grid.Scroll3});
		dgsSetProperty(GUI.Scroll[1],"scrollArrow",false);
		dgsSetProperty(GUI.Grid[1],"rowColor",{GUI.Color.Grid.Row1,GUI.Color.Grid.Row2,GUI.Color.Grid.Row3});
		dgsSetProperty(GUI.Grid[1],"rowTextColor",{tocolor(255,255,255),tocolor(255,255,255),GUI.Color.Grid.Bar});
		dgsSetProperty(GUI.Grid[1],"scrollBarThick",0);
		
		local pedID=dgsGridListAddColumn(GUI.Grid[1],"ID",1);
		
		for i,v in pairs(JOBS["Farmer"].Peds[1])do
			local row=dgsGridListAddRow(GUI.Grid[1]);
			dgsGridListSetItemText(GUI.Grid[1],row,pedID,v,false,false);
		end
		
		
		GUI.Button[1]=dgsCreateButton(10,365,480,40,"Join Job",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Green1,GUI.Color.Button.Green2,GUI.Color.Button.Green3,true);
		GUI.Button[2]=dgsCreateButton(10,415,480,40,"Leave Job",false,GUI.Window[1],tocolor(255,255,255),1.2,1.2,_,_,_,GUI.Color.Button.Red1,GUI.Color.Button.Red2,GUI.Color.Button.Red3,true);
		
		
		
		dgsSetProperty(GUI.Grid[1],"rowHeight",35);
		dgsGridListSetSortEnabled(GUI.Grid[1],false);
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					triggerServerEvent("Job->Leave",localPlayer);
					setUIdatas("rem","cursor",true);
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local itemAmount=dgsGridListGetSelectedItem(GUI.Grid[1])
					if(itemAmount>0)then
						local item=dgsGridListGetItemText(GUI.Grid[1],dgsGridListGetSelectedItem(GUI.Grid[1]),1);
						triggerServerEvent("Job->Join",localPlayer,"Farmer",tonumber(item));
						setUIdatas("rem","cursor",true);
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="down")then
					setUIdatas("rem","cursor",true);
				end
			end,
		false)
	elseif(typ=="Close")then
		if(isClickedState(localPlayer)==true)then
			setUIdatas("rem","cursor",true);
		end
	end
end)




local playerToGroundLevel=1.3085;
addEventHandler("Create->Farmer->Object",root,function(typ,modelID,x,y,z)
	if(typ=="ped")then
		local _,_,rot=getElementRotation(localPlayer);
		local z=z-playerToGroundLevel*2;
		setTimer(function(x,y,z)
			local object=createObject(modelID,x,y,z,0,0,rot);
			setElementCollisionsEnabled(object,false);
			moveObject(object,5*1000,x,y,z+playerToGroundLevel);
			
			table.insert(JOB_OBJECTS,object);
		end,1500,1,x,y,z)
	elseif(typ=="veh")then
		local veh=getPedOccupiedVehicle(localPlayer);
		if(veh and isElement(veh))then
			if(modelID==1454)then
				z=z+0.8;
			end
			local _,_,rot=getElementRotation(veh);
			local object=createObject(modelID,x,y,z,0,0,rot);
			setElementCollisionsEnabled(object,false);
			
			table.insert(JOB_OBJECTS,object);
		end
	end
end)