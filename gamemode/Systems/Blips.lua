local Table={--x,y,z,iconID,iconSIze,colorR,colorG,colorB,range,tooltip
	{115.1,2959.9,72.1,4,20, 255,255,255, 9999,"North"},
	
	--robs
	{474.7,-1498.8,20.4,13,20, 255,255,255, 100,"Jeweler (Rob)"},
	{2304.4,-15.8,26.7,18,20, 0,150,30, 100,"Bank (Rob)"},
	
	{811.1,-1616.2,12.5,17,20, 170,130,95, 100,"Burgershot (Rob)"},--LS Marina
	{1198.7,-917.7,42.1,17,20, 170,130,95, 100,"Burgershot (Rob)"},--LS temple
	
	--shops
	{1352.4,-1758.8,13.5,6,20, 255,255,255, 100,"24/7 Shop"},--LSPD
	{1315.4,-898,39.6,6,20, 255,255,255, 100,"24/7 Shop"},--LS mulholland
	{1928.8,-1776.3,13,6,20, 255,255,255, 100,"24/7 Shop (Rob)"},--LS idlewood
	{1012.2,-927.0,41.3,6,20, 255,255,255, 100,"24/7 Shop (Rob)"},--LS mulholland
	{172.2,-201.0,0.6,6,20, 255,255,255, 100,"24/7 Shop"},--LS blueberry
	
	{2244.5,-1664.9,15.4,7,20, 255,255,255, 100,"Skin Shop"},
	{479.8,-1538.3,19.3,7,20, 255,255,255, 100,"Skin Shop"},
	{2112.9,-1211.8,23.9,7,20, 150,150,0, 100,"Skin Shop (VIP)"},--exclusive
	
	{2131.8,-1151,23.1,8,20, 255,255,255, 100,"Vehicle Shop"},--CAS
	{545.7,-1292.7,16.2,8,20, 255,255,255, 100,"Vehicle Shop"},--Grotti
	{-1663.4,1208.6,6.2,8,20, 255,255,255, 100,"Vehicle Shop"},--Ottos
	
	{1380.8,-1277.2,12.6,9,20, 255,255,255, 100,"Weapon Shop"},--LS Downtown
};

addEventHandler("onClientResourceStart",resourceRoot,function()
	local Element={};
	for i,v in pairs(Table)do
		Element[i]=createBlip(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],255,v[9]);
		setBlipColor(Element[i],v[6],v[7],v[8],255);
		if(v[10])then
			setElementData(Element[i],"tooltipText",v[10]);
		end
	end
end)