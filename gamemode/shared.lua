SERVER_NAME="Project X - Cops 'n' Robbers (Early Access)";
SERVER_NAME_SHORT="Project X";
SERVER_VERSION="2.0ea";
SERVER_COPYRIGHT="Copyright 2023-2024 @ fem_luna";
URL_DISCORD="";
CURRENCY="$";

--external resouce names
RESOURCE_NAME=getResourceName(getThisResource());--get this resourcename
RESOURCE_NAME_NEWMODELS="newmodels";

--not allowed names
NotAllowedNames={
	"none","nil","null","insert","delete","element",
	"sapd","samd","rescue","army","fib","fbi","grove","ballas","vagos","aztecas","bloods",
};
NotAllowedCharacters={
	" ツ","!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]"
};


DEVMODE=false;--development mode
BETAMODE=false;--beta mode

--shared tables
ADUTY_LastSkin={};
ADUTY_MARKER={};




SRV_COLORS={--server color for UI's etc
	RGB={0,150,220},
	HEX="FF643C",
};

ADMIN_LEVELS={--all admin levels & permissions
	[0]={
		Name="Player",RGB={255,255,255},HEX="#ffffff",
		Permissions={
			Kick=false,BanTemp=false,BanPerm=false,Unban=false,BanlistSee=false,
			Goto=false,Gethere=false,Freeze=false,ServerSee=false,SetPW=false,
			GiveItem=false,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=false,ADlistClear=false,ChatWorldwide=false,ChatEvent=false,
			EventsSee=false,EventStart=false,EventStop=false,RepairVeh=false,
			ClearChat=false,
		},
	},
	[1]={
		Name="Trial-Supporter",RGB={255,255,90},HEX="#FFFF5A",
		Permissions={
			Kick=false,BanTemp=false,BanPerm=false,Unban=false,BanlistSee=false,
			Goto=true,Gethere=false,Freeze=true,ServerSee=false,SetPW=false,
			GiveItem=false,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=false,ADlistClear=false,ChatWorldwide=false,ChatEvent=false,
			EventsSee=false,EventStart=false,EventStop=false,RepairVeh=false,
			ClearChat=true,
		},
	},
	[2]={
		Name="Supporter",RGB={160,80,255},HEX="#A050FF",
		Permissions={
			Kick=true,BanTemp=false,BanPerm=false,Unban=false,BanlistSee=false,
			Goto=true,Gethere=true,Freeze=true,ServerSee=false,SetPW=false,
			GiveItem=false,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=true,ADlistClear=false,ChatWorldwide=false,ChatEvent=false,
			EventsSee=false,EventStart=false,EventStop=false,RepairVeh=false,
			ClearChat=true,
		},
	},
	[3]={
		Name="Moderator",RGB={0,130,220},HEX="#0082DC",
		Permissions={
			Kick=true,BanTemp=true,BanPerm=true,Unban=false,BanlistSee=true,
			Goto=true,Gethere=true,Freeze=true,ServerSee=false,SetPW=false,
			GiveItem=false,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=true,ADlistClear=false,ChatWorldwide=false,ChatEvent=false,
			EventsSee=false,EventStart=false,EventStop=false,RepairVeh=true,
			ClearChat=true,
		},
	},
	[4]={
		Name="Event Manager",RGB={255,150,80},HEX="#FF9650",
		Permissions={
			Kick=false,BanTemp=false,BanPerm=false,Unban=false,BanlistSee=false,
			Goto=false,Gethere=false,Freeze=false,ServerSee=false,SetPW=false,
			GiveItem=false,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=true,ADlistClear=false,ChatWorldwide=false,ChatEvent=true,
			EventsSee=true,EventStart=true,EventStop=true,RepairVeh=false,
			ClearChat=false,
		},
	},
	[5]={
		Name="Administrator",RGB={30,180,60},HEX="#1EB43C",
		Permissions={
			Kick=true,BanTemp=true,BanPerm=true,Unban=false,BanlistSee=true,
			Goto=true,Gethere=true,Freeze=true,ServerSee=false,SetPW=false,
			GiveItem=false,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=true,ADlistClear=true,ChatWorldwide=true,ChatEvent=true,
			EventsSee=true,EventStart=true,EventStop=true,RepairVeh=true,
			ClearChat=true,
		},
	},
	[6]={
		Name="Head of Administrator",RGB={180,0,0},HEX="#B40000",
		Permissions={
			Kick=true,BanTemp=true,BanPerm=true,Unban=true,BanlistSee=true,
			Goto=true,Gethere=true,Freeze=true,ServerSee=true,SetPW=true,
			GiveItem=true,GiveItemCoins=false,Kickall=false,Generatecodes=false,
			ADlistSee=true,ADlistClear=true,ChatWorldwide=true,ChatEvent=true,
			EventsSee=true,EventStart=true,EventStop=true,RepairVeh=true,
			ClearChat=true,
		},
	},
	[7]={
		Name="Project Lead",RGB={255,90,90},HEX="#FF5A5A",
		Permissions={
			Kick=true,BanTemp=true,BanPerm=true,Unban=true,BanlistSee=true,
			Goto=true,Gethere=true,Freeze=true,ServerSee=true,SetPW=true,
			GiveItem=true,GiveItemCoins=true,Kickall=true,Generatecodes=true,
			ADlistSee=true,ADlistClear=true,ChatWorldwide=true,ChatEvent=true,
			EventsSee=true,EventStart=true,EventStop=true,RepairVeh=true,
			ClearChat=true,
		},
	},
};

EVENTS={--todo
	STARTET_EVENT=nil,
	[1]={
		Name="Hide 'n' Seek",
		Description="Your task is to find the admin on the map! But he isn't marked!",
		Status=false,
		
		Teleport={
			Status=false,
			Coords=nil,--x,y,z,int,dim
			Limit=nil,
		},
	},
	[2]={
		Name="5 Towers",
		Description="Type /eventwarp to participate",
		Status=false,
		
		Teleport={
			Status=true,
			Coords={4018.3,861.1,82.3,0,777},--x,y,z,int,dim
			Limit=20,
		},
	},
};

PLAYTIME_ACTIVITY={
	--playtime minutes, money, exp
	{180,5000,100},--3 stunden
	{600,10000,150},--10 stunden
	{900,15000,200},--15 stunden
	{1200,20000,250},--20 stunden
	{1500,25000,250},--25 stunden
	{1800,30000,300},--30 stunden
	{2400,35000,500},--40 stunden
	{3000,40000,750},--50 stunden
	{3600,45000,1000},--60 stunden
	{4200,50000,1100},--70 stunden
	{4800,55000,1200},--80 stunden
	{5400,60000,1300},--90 stunden
	{6000,65000,1400},--100 stunden
	{7200,75000,1500},--120 stunden
	{9000,90000,2000},--150 stunden
	{12000,120000,5000},--200 stunden
	{13200,150000,9000},--220 stunden
};

LEVEL={
	EXPforNextLevelUP={
		[0]=200,
		[1]=400,
		[2]=600,
		[3]=800,
		[4]=1000,
		[5]=1200,
		[6]=1400,
		[7]=1600,
		[8]=1800,
		[9]=2000,
		[10]=2200,
		[11]=2400,
		[12]=2600,
		[13]=2800,
		[14]=3000,
		[15]=3200,
		[16]=3400,
		[17]=3600,
		[18]=3800,
		[19]=4000,
		[20]=4200,
		[21]=4400,
		[22]=4600,
		[23]=4800,
		[24]=5000,
		[25]=5200,
		[26]=5400,
		[27]=5600,
		[28]=5800,
		[29]=6000,
		[30]=6200,
		[31]=6400,
		[32]=6600,
		[33]=6800,
		[34]=7000,
		[35]=7200,
		[36]=7400,
		[37]=7600,
		[38]=7800,
		[39]=8000,
		[40]=8200,
	},
}


TEAMS={--SpawnPOS: x,y,z,int,dim,rot
	["Civilian"]={
		Name="Civilian",
		SpawnPOS=nil,
		RGB={255,255,255},
		HEX="#ffffff",
		VehicleRGB=nil,
		Weapon=nil,
		Limit=99999999,
		Peds=nil,
		SortID=0,--for tablist
	},
	["SAPD"]={
		Name="S.A.P.D",
		SpawnPOS={1575.0,-1673.8,16.2, 0,0, 0},
		BlipPOS={1558.4,-1627.7,13.4},--phone mark pos
		RGB={0,140,200},
		HEX="#008CC8",
		VehicleRGB={0,0,0,255,255,255},
		Weapon=3,--nightstick
		Limit=15,
		Peds={
			{[1]=3,[2]=119,[3]=265,[4]=266,[5]=280,[6]=281, [7]=246,[8]=180000},
		},
		SortID=1,--for tablist
	},
	["FIB"]={
		Name="F.I.B",
		SpawnPOS={1160.8,-1180.2,44.1, 0,0, 0},
		BlipPOS={1167.4,-1208.0,19.6},--phone mark pos
		RGB={125,125,200},
		HEX="#7D7DC8",
		VehicleRGB={0,0,0,0,0,0},
		Weapon=3,--nightstick
		Limit=15,
		Peds={
			{[1]=185000,[2]=185001,[3]=165,[4]=166, [5]=180001},
		},
		SortID=2,--for tablist
	},
	["SAMD"]={
		Name="S.A.M.D",
		SpawnPOS={214.1,114.4,1003.2, 10,666, 270},
		BlipPOS={2000.6,-1446.6,13.5},--phone mark pos
		RGB={240,65,65},
		HEX="#F04141",
		VehicleRGB={200,0,0,255,255,255},
		Weapon=nil,
		Limit=40,
		Peds={
			{[1]=274,[2]=275,[3]=276,[4]=70, [5]=180002},
		},
		SortID=3,--for tablist
	},
	["Grove"]={
		Name="Grove",
		SpawnPOS={2492.9,-1705.5,18.5, 0,0, 90},
		BlipPOS={2464.2,-1659.1,13.3},--phone mark pos
		RGB={0,150,0},
		HEX="#009600",
		VehicleRGB={0,150,0,0,150,0},
		Weapon=nil,
		Limit=20,
		Peds={
			{[1]=105,[2]=106,[3]=107,[4]=269,[5]=270,[6]=271,[7]=300,[8]=301, [9]=207,[10]=180003,[11]=180004},
		},
		SortID=4,--for tablist
	},
	["Ballas"]={
		Name="Ballas",
		SpawnPOS={2224.4,-1142.1,1025.8, 15,50, 180},
		BlipPOS={2219.2,-1145.6,25.8},--phone mark pos
		RGB={140,40,230},
		HEX="#8C28E6",
		VehicleRGB={140,40,230,140,40,230},
		Weapon=nil,
		Limit=20,
		Peds={
			{[1]=102,[2]=103,[3]=104,[4]=296, [5]=13,[6]=195,[3]=304},
		},
		SortID=5,--for tablist
	},
};

ROBS={
	["Jeweler"]={
		WANTEDS=2,
		REWARD_AMOUNT={5000,11000},
		REWARD_EXP=35,
		TIMER=20,--20 seconds (for each showcase)
		TIMER_RESET=15*60*1000,--15 minutes
		COPS_NEEDED=2,
	},
	["Bank"]={
		WANTEDS=3,
		REWARD_AMOUNT={6000,12500},
		REWARD_EXP=45,
		TIMER=30,--30 seconds (for each showcase)
		TIMER_RESET=20*60*1000,--20 minutes
		COPS_NEEDED=2,
	},
	["ATM"]={
		WANTEDS=1,
		REWARD_AMOUNT={4000,8000},
		REWARD_EXP=75,
		TIMER=2,--2 seconds
		TIMER_RESET=5*60*1000,--5 minutes
	},
	["Shop"]={
		WANTEDS=2,
		REWARD_AMOUNT={400,600},
		REWARD_EXP=85,
		TIMER=2,--2 seconds
		TIMER_RESET=10*60*1000,--10 minutes
		COPS_NEEDED=1,
	},
};

JOBS={
	["Miner"]={
		BlipPOS={2298.7,-1132.7,26.9},--phone mark pos
		BlipName="Miner (LS)",
		Name="Miner",
		MaxCount=6,
		Peds={
			{16,27,65,260,289, 115000},
		},
	},
	["Farmer"]={
		BlipPOS={-60.0,75.0,3.1},--phone mark pos
		BlipName="Farmer (LS)",
		Name="Farmer",
		Peds={
			{158,159,160,161,162,200, 31,131,157,199,201},
		},
		VehicleColor={150,70,50},
		LevelsEXP={
			[0]=900,
			[1]=1800,
			[2]=2700,
			[3]=99999999,
		},
		Tiers={
			[0]={VehID=nil,Price=60,Level=0,LevelUpBonus=30000,},
			[1]={VehID=572,Price=20,Level=1,LevelUpBonus=60000,},
			[2]={VehID=531,Price=21,Level=2,LevelUpBonus=80000,},
			[3]={VehID=80000,Price=34,Level=3,LevelUpBonus=100000,},
			[4]={VehID=532,Price=50,Level=4,LevelUpBonus=150000,},
			[5]={VehID=478,Price=5000,Level=5,LevelUpBonus=300000,},
		},
	},
	["Garbage"]={
		BlipPOS={2104.2,-2037.2,12.5},--phone mark pos
		BlipName="Garbage (LS)",
		Name="Garbage",
		Peds={
			{16,65,289},
		},
		VehicleColor={90,90,90},
		LevelsEXP={
			[0]=900,
			[1]=1800,
			[2]=2700,
			[3]=99999999,
		},
		Tiers={
			[0]={VehID=574,Price=150,Limit=65,Level=0,LevelUpBonus=30000,},
			[1]={VehID=80001,Price=205,Limit=120,Level=1,LevelUpBonus=60000,},
			[2]={VehID=408,Price=220,Limit=200,Level=2,LevelUpBonus=80000,},
		},
	},
};

SHOPS={
	--client side
	["Weapons"]={
		Name="Ammunation",
		ItemsWeapons={--item,price,level
			{"Armor",1500,0},
			{"Colt-45",5000,0},
			{"Silenced",5000,5},
			{"Deagle",10000,10},
			{"Shotgun",7000,0},
			{"Combat Shotgun",10000,7},
			{"MP5",8000,12},
			{"UZI",9000,20},
			{"Tec-9",9000,25},
			{"AK-47",9000,15},
			{"M4A1",10000,35},
		},
		ItemsAmmo={
			{"Colt-45",18},
			{"Silenced",18},
			{"Deagle",25},
			{"Shotgun",7},
			{"Combat Shotgun",12},
			{"MP5",20},
			{"UZI",22},
			{"Tec-9",22},
			{"AK-47",20},
			{"M4A1",27},
		},
	},
	--server side weapon id and price check
	WeaponPrices={--id,price,level
		["Colt-45"]={22,5000,0},
		["Silenced"]={23,5000,5},
		["Deagle"]={24,10000,10},
		["Shotgun"]={25,7000,0},
		["Combat Shotgun"]={27,10000,7},
		["MP5"]={29,8000,12},
		["UZI"]={28,9000,20},
		["Tec-9"]={32,9000,25},
		["AK-47"]={30,9000,15},
		["M4A1"]={31,10000,35},
	},
	WeaponAmmoPrices={--price
		["Colt-45"]=18,
		["Silenced"]=18,
		["Deagle"]=25,
		["Shotgun"]=7,
		["Combat Shotgun"]=12,
		["MP5"]=20,
		["UZI"]=22,
		["Tec-9"]=22,
		["AK-47"]=20,
		["M4A1"]=27,
	},
	WeaponID={
		["Colt-45"]=22,
		["Silenced"]=23,
		["Deagle"]=24,
		["Shotgun"]=25,
		["Combat Shotgun"]=27,
		["MP5"]=29,
		["UZI"]=28,
		["Tec-9"]=32,
		["AK-47"]=30,
		["M4A1"]=31,
	},
	WeaponLevel={
		["Colt-45"]=0,
		["Silenced"]=5,
		["Deagle"]=10,
		["Shotgun"]=0,
		["Combat Shotgun"]=7,
		["MP5"]=12,
		["UZI"]=20,
		["Tec-9"]=25,
		["AK-47"]=15,
		["M4A1"]=35,
	},
	--client side
	["247"]={
		Name="24/7 Store",
		ItemsFD={
			{"Bread",14},
			{"Donut",19},
			{"Milk",16},
			{"Water",11},
		},
		ItemsHeal={
			{"Bandage",75},
			{"Medikit",300},
		},
	},
	--server side prices and price check
	ItemPrices={
		["Bread"]=14,
		["Donut"]=19,
		["Milk"]=16,
		["Water"]=11,
		
		["Armor"]=1500,
		["Bandage"]=75,
		["Medikit"]=300,
	},
	--client side (Skin store normal)
	["Skin->Normal"]={
		Name="Normal Skin Store",
		Peds={
			Category={
				["Normal"]={
					["Male"]={
						{1,5000},
						{2,5000},
						{7,5000},
						{14,5000},
						{15,5000},
						{18,5000},
						{20,5000},
						{21,5000},
						{22,5000},
						{23,5000},
						{24,5000},
						{25,5000},
						{26,5000},
						{28,5000},
						{29,5000},
						{30,5000},
						{32,5000},
						{33,5000},
						{34,5000},
						{35,5000},
						{36,5000},
						{37,5000},
						{44,5000},
						{45,5000},
						{46,5000},
						{51,5000},
						{52,5000},
						{58,5000},
						{59,5000},
						{60,5000},
						{61,5000},
						{62,5000},
						{66,5000},
						{78,5000},
						{79,5000},
						{80,5000},
						{81,5000},
						{82,5000},
						{83,5000},
						{84,5000},
						{94,5000},
						{95,5000},
						{96,5000},
						{97,5000},
						{99,5000},
						{101,5000},
						{128,5000},
						{132,5000},
						{133,5000},
						{134,5000},
						{135,5000},
						{136,5000},
						{137,5000},
						{161,5000},
						{162,5000},
						--addon
						{105000,15000},
						{105001,15000},
						{105002,15000},
						{105003,15000},
						{105004,15000},
						{105005,15000},
						{105006,15000},
						{105007,15000},
						{105008,15000},
						{105009,15000},
						{105010,15000},
						{105011,15000},
						{105012,15000},
						{105013,15000},
						{105014,15000},
						{105015,15000},
						{105016,15000},
						{105017,15000},
						{105018,15000},
						{105019,15000},
						{105020,15000},
						{105021,15000},
						{105022,15000},
						{105023,15000},
						{105024,15000},
						{105025,15000},
					},
					["Female"]={
						{11,5000},
						{12,5000},
						{31,5000},
						{38,5000},
						{39,5000},
						{40,5000},
						{41,5000},
						{53,5000},
						{55,5000},
						{56,5000},
						{63,5000},
						{64,5000},
						{69,5000},
						{75,5000},
						{76,5000},
						{77,5000},
						{85,5000},
						{89,5000},
						{90,5000},
						{91,5000},
						{92,5000},
						{129,5000},
						{130,5000},
						{131,5000},
						{138,5000},
						{139,5000},
						{140,5000},
						{148,5000},
						{151,5000},
						{152,5000},
						{157,5000},
						{172,5000},
						{190,5000},
						{194,5000},
						{196,5000},
						{197,5000},
						{198,5000},
						{199,5000},
						{201,5000},
						{205,5000},
						{214,5000},
						{215,5000},
						{216,5000},
						{226,5000},
						{231,5000},
						{232,5000},
						{233,5000},
						{251,5000},
						--addon
						{100000,15000},
						{100001,15000},
						{100002,15000},
						{100003,15000},
						{100004,15000},
						{100005,15000},
						{100006,15000},
						{100007,15000},
						{100008,15000},
						{100009,15000},
						{100010,15000},
						{100011,15000},
						{100012,15000},
						{100013,15000},
						{100014,15000},
						{100015,15000},
						{100016,15000},
						{100017,15000},
						{100018,15000},
						{100019,15000},
						{100020,15000},
						{100021,15000},
						{100022,15000},
						{100023,15000},
						{100024,15000},
						{100025,15000},
						{100026,15000},
						{100027,15000},
					}
				},
			},
		}
	},
	--client side (Skin store exclusive)
	["Skin->Exclusive"]={
		Name="Exclusive Skin Store",
		Peds={
			Category={
				["Normal"]={--addon
					["Male"]={
						{106000,30000},
						{106001,30000},
						{106002,30000},
						{106003,30000},
						{106004,30000},
						{106005,30000},
						{106006,30000},
						{106007,30000},
					},
					["Female"]={
						{110000,30000},
						{110001,30000},
						{110002,30000},
						{110003,30000},
						{110004,30000},
						{110005,30000},
						{110006,30000},
						{110007,30000},
						{110008,30000},
						{110009,30000},
						{110010,30000},
					},
				},
			},
		}
	},
	--server side (Skin stores) prices and price check
	PedPrices={
		["Male"]={
			--normal skin store
			[1]=5000,
			[2]=5000,
			[7]=5000,
			[14]=5000,
			[15]=5000,
			[18]=5000,
			[20]=5000,
			[21]=5000,
			[22]=5000,
			[23]=5000,
			[24]=5000,
			[25]=5000,
			[26]=5000,
			[28]=5000,
			[29]=5000,
			[30]=5000,
			[32]=5000,
			[33]=5000,
			[34]=5000,
			[35]=5000,
			[36]=5000,
			[37]=5000,
			[44]=5000,
			[45]=5000,
			[46]=5000,
			[51]=5000,
			[52]=5000,
			[58]=5000,
			[59]=5000,
			[60]=5000,
			[61]=5000,
			[62]=5000,
			[66]=5000,
			[78]=5000,
			[79]=5000,
			[80]=5000,
			[81]=5000,
			[82]=5000,
			[83]=5000,
			[84]=5000,
			[94]=5000,
			[95]=5000,
			[96]=5000,
			[97]=5000,
			[99]=5000,
			[101]=5000,
			[128]=5000,
			[132]=5000,
			[133]=5000,
			[134]=5000,
			[135]=5000,
			[136]=5000,
			[137]=5000,
			[161]=5000,
			[162]=5000,
			--addon
			[105000]=15000,
			[105001]=15000,
			[105002]=15000,
			[105003]=15000,
			[105004]=15000,
			[105005]=15000,
			[105006]=15000,
			[105007]=15000,
			[105008]=15000,
			[105009]=15000,
			[105010]=15000,
			[105011]=15000,
			[105012]=15000,
			[105013]=15000,
			[105014]=15000,
			[105015]=15000,
			[105016]=15000,
			[105017]=15000,
			[105018]=15000,
			[105019]=15000,
			[105020]=15000,
			[105021]=15000,
			[105022]=15000,
			[105023]=15000,
			[105024]=15000,
			[105025]=15000,
			--exclusive
			[106000]=30000,
			[106001]=30000,
			[106002]=30000,
			[106003]=30000,
			[106004]=30000,
			[106005]=30000,
			[106006]=30000,
			[106007]=30000,
		},
		["Female"]={
			--normal skin store
			[11]=5000,
			[12]=5000,
			[31]=5000,
			[38]=5000,
			[39]=5000,
			[40]=5000,
			[41]=5000,
			[53]=5000,
			[55]=5000,
			[56]=5000,
			[63]=5000,
			[64]=5000,
			[69]=5000,
			[75]=5000,
			[76]=5000,
			[77]=5000,
			[85]=5000,
			[89]=5000,
			[90]=5000,
			[91]=5000,
			[92]=5000,
			[129]=5000,
			[130]=5000,
			[131]=5000,
			[138]=5000,
			[139]=5000,
			[140]=5000,
			[148]=5000,
			[151]=5000,
			[152]=5000,
			[157]=5000,
			[172]=5000,
			[190]=5000,
			[194]=5000,
			[196]=5000,
			[197]=5000,
			[198]=5000,
			[199]=5000,
			[201]=5000,
			[205]=5000,
			[214]=5000,
			[215]=5000,
			[216]=5000,
			[226]=5000,
			[231]=5000,
			[232]=5000,
			[233]=5000,
			[251]=5000,
			--addon
			[100000]=15000,
			[100001]=15000,
			[100002]=15000,
			[100003]=15000,
			[100004]=15000,
			[100005]=15000,
			[100006]=15000,
			[100007]=15000,
			[100008]=15000,
			[100009]=15000,
			[100010]=15000,
			[100011]=15000,
			[100012]=15000,
			[100013]=15000,
			[100014]=15000,
			[100015]=15000,
			[100016]=15000,
			[100017]=15000,
			[100018]=15000,
			[100019]=15000,
			[100020]=15000,
			[100021]=15000,
			[100022]=15000,
			[100023]=15000,
			[100024]=15000,
			[100025]=15000,
			[100026]=15000,
			[100027]=15000,
			--exclusive
			[110000]=30000,
			[110001]=30000,
			[110002]=30000,
			[110003]=30000,
			[110004]=30000,
			[110005]=30000,
			[110006]=30000,
			[110007]=30000,
			[110008]=30000,
			[110009]=30000,
			[110010]=30000,
		},
	}
};

ACHIEVEMENTS={
	["Panel"]={
		{"FirstVehicle","First vehicle"},
		{"HappyPhone","Find a lucky phonecell"},
		{"20Bandages","Own 20 Bandages"},
		{"25Kills","Reach 25 kills"},
		{"50Kills","Reach 50 kills"},
		{"100Kills","Reach 100 kills"},
		{"200Kills","Reach 200 kills"},
		{"50Deaths","Reach 50 deaths"},
		{"100Deaths","Reach 100 deaths"},
		{"FarmerLevel1","Reach Farmer Level 1"},
		{"FarmerLevel2","Reach Farmer Level 2"},
		{"FarmerLevel3","Reach Farmer Level 3"},
		{"FarmerLevel4","Reach Farmer Level 4"},
		{"FarmerLevel5","Reach Farmer Level 5"},
		{"GarbageLevel1","Reach Garbage Level 1"},
		{"GarbageLevel2","Reach Garbage Level 2"},
		{"GarbageLevel3","Reach Garbage Level 3"},
	},
	["Description"]={
		["FirstVehicle"]={"Buy your first vehicle of your choice",Reward={10000,80},DisplayText="Buy your first vehicle."},
		["HappyPhone"]={"Find a lucky phonecell in LS",Reward={10000,150},DisplayText="Lucky phone"},
		["20Bandages"]={"Own 20 Bandages in your Inventory",Reward={2500,50},DisplayText="Own 20 Bandages."},
		["25Kills"]={"Kill 25 players",Reward={10000,150},DisplayText="Kill 25 players."},
		["50Kills"]={"Kill 50 players",Reward={20000,300},DisplayText="Kill 50 players."},
		["100Kills"]={"Kill 100 players",Reward={30000,500},DisplayText="Kill 100 players."},
		["200Kills"]={"Kill 200 players",Reward={70000,1200},DisplayText="Kill 200 players."},
		["50Deaths"]={"Die 50 times",Reward={15000,150},DisplayText="Die 50 times."},
		["100Deaths"]={"Die 100 times",Reward={50000,400},DisplayText="Die 100 times."},
		["FarmerLevel1"]={"Reach Farmer Level 1",Reward={15000,200},DisplayText="Reach Farmer Level 1."},
		["FarmerLevel2"]={"Reach Farmer Level 2",Reward={15000,400},DisplayText="Reach Farmer Level 2."},
		["FarmerLevel3"]={"Reach Farmer Level 3",Reward={15000,700},DisplayText="Reach Farmer Level 3."},
		["FarmerLevel4"]={"Reach Farmer Level 4",Reward={15000,1200},DisplayText="Reach Farmer Level 4."},
		["FarmerLevel5"]={"Reach Farmer Level 5",Reward={15000,1800},DisplayText="Reach Farmer Level 5."},
		["GarbageLevel1"]={"Reach Garbage Level 1",Reward={15000,200},DisplayText="Reach Garbage Level 1."},
		["GarbageLevel2"]={"Reach Garbage Level 2",Reward={15000,400},DisplayText="Reach Garbage Level 2."},
		["GarbageLevel3"]={"Reach Garbage Level 3",Reward={15000,700},DisplayText="Reach Garbage Level 3."},
	}
};

TELEPORTS={
	["Panel"]={
		{"Noobspawn"},
		{"Angelpine"},
		{"Hospital (LS)"},
		{"Hospital (SF)"},
		{"Fort Carson"},
		{"L.S.P.D"},
		{"S.F.P.D"},
	},
	["Server"]={
		["Noobspawn"]={1686.0,-1945.2,13.5},
		["Angelpine"]={-2107.6,-2277.7,30.6},
		["Hospital (LS)"]={1999.5,-1440.2,13.5},
		["Hospital (SF)"]={-2638.6,635.5,14.4},
		["Fort Carson"]={-205.2,1212.3,19.7},
		["L.S.P.D"]={1570.4,-1635.4,13.5},
		["S.F.P.D"]={-1574.3,668.6,7.2},
	}
};




WeaponMaxAmmo={
	[0]=0,
	[1]=1,
	[2]=1,
	[3]=1,
	[8]=1,
	[22]=17,
	[23]=17,
	[24]=7,
	[25]=1,
	[26]=2,
	[27]=7,
	[28]=50,
	[29]=30,
	[30]=30,
	[31]=50,
	[32]=50,
	[33]=1,
	[34]=1,
	[35]=1,
	[36]=1,
	[41]=500,
};

WeaponDamage={
	[0]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[2]={[3]=7,[4]=7,[5]=7,[6]=7,[7]=7,[8]=7,[9]=7},
	[3]={[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0},--cancel nightstick damage cuz arresting system
	[4]={[3]=10,[4]=20,[5]=5,[6]=5,[7]=5,[8]=5,[9]=20},
	[5]={[3]=10,[4]=10,[5]=10,[6]=10,[7]=10,[8]=10,[9]=10},
	[8]={[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=25},
	[9]={[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=25},
	[10]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[11]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[12]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[16]={[3]=100,[4]=100,[5]=100,[6]=100,[7]=100,[8]=100,[9]=130},
	[17]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[18]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[22]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=15},
	[23]={[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0},
	[24]={[3]=42,[4]=49,[5]=25,[6]=25,[7]=35,[8]=32,[9]=50},
	[25]={[3]=25,[4]=25,[5]=20,[6]=20,[7]=20,[8]=20,[9]=35},
	[26]={[3]=30,[4]=30,[5]=20,[6]=20,[7]=20,[8]=20,[9]=40},
	[27]={[3]=30,[4]=30,[5]=20,[6]=20,[7]=20,[8]=20,[9]=40},
	[28]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=10},
	[29]={[3]=9,[4]=9,[5]=8,[6]=8,[7]=8,[8]=8,[9]=12},
	[32]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=10},
	[30]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=14},
	[31]={[3]=9,[4]=9,[5]=7,[6]=7,[7]=7,[8]=7,[9]=12},
	[33]={[3]=15,[4]=15,[5]=12,[6]=12,[7]=12,[8]=2,[9]=20},
	[34]={[3]=15,[4]=15,[5]=12,[6]=12,[7]=12,[8]=2,[9]=200},
	[35]={[3]=200,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200}, 
	[36]={[3]=200,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200},
	[37]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=12},
	[38]={[3]=8,[4]=8,[5]=6,[6]=6,[7]=6,[8]=6,[9]=12},
	[39]={[3]=100,[4]=100,[5]=100,[6]=100,[7]=100,[8]=100,[9]=100},
	[41]={[3]=2,[4]=2,[5]=2,[6]=2,[7]=2,[8]=2,[9]=2},
	[49]={[3]=25,[4]=25,[5]=25,[6]=25,[7]=25,[8]=25,[9]=25},--rammed
	[50]={[3]=1000,[4]=1000,[5]=1000,[6]=1000,[7]=1000,[8]=1000,[9]=1000},--Ranover(also helicopter roters)
	[51]={[3]=1000,[4]=1000,[5]=1000,[6]=1000,[7]=1000,[8]=1000,[9]=1000},--explosion
};

WeaponNotSaveAble={
	[3]=true,
	[6]=true,
};


function getPedWeapons(ped)--get all weapon from ped(player)
	local tbl={};
	if(ped and isElement(ped)and getElementType(ped)=="ped" or getElementType(ped)=="player")then
		for i=1,12 do
			local wep=getPedWeapon(ped,i);
			if(wep and wep~=0)then
				table.insert(tbl,wep);
			end
		end
	else
		return false;
	end
	return tbl;
end












--funcs
function isClickedState(player)
	if(not player)then
		player=localPlayer;
	end
	if(isElement(player))then
		return getElementData(player,"ClickedState");
	end
end
function setClickedState(player,state)
	if(not player)then
		player=localPlayer;
	end
	if(isElement(player))then
		setElementData(player,"ClickedState",state);
	end
end
function isLoggedin(player)
	if(not player)then
		player=localPlayer;
	end
	if(isElement(player)and getElementType(player)=="player")then
		return getElementData(player,"Player->Data->Loggedin")==1;
	end
end

function convertNumber(amount)--convert number with ,
	local Amount=amount;
    while true do
        Amount,k=string.gsub(Amount,"^(-?%d+)(%d%d%d)",'%1,%2');
        if(k==0)then
			break;
		end
    end
    Amount=tostring(Amount);
    return Amount;
end


function table.find(tab,value)--credits: eXo
	for k,v in pairs(tab)do
		if(v==value)then
			return k;
		end
	end
	return nil;
end

function table.removevalue(tab,value)--credits: eXo
	local idx=table.find(tab,value);
	if(idx)then
		table.remove(tab,idx);
		return true;
	end
end

function addRemoteEvents(eventList)--credits: eXo
	for _,v in ipairs(eventList)do
		addEvent(v,true);
	end
end



function GetNearestGarbageVehicle(player)
    local x,y,z=getElementPosition(player);
    local prevDistance;
    local nearestVehicle;
    for _,v in ipairs(getElementsByType("vehicle"))do
        local distance=getDistanceBetweenPoints3D(x,y,z,getElementPosition(v));
        if(distance<=(prevDistance or distance+1))then
            prevDistance=distance;
			if(prevDistance<4.5)then
				nearestVehicle=v;
			else
				nearestVehicle=false;
			end
        end
    end
    return nearestVehicle or false;
end