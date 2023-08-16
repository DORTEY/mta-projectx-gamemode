--credits: n0pe
local starttick=getTickCount();
local MarkerCacheTable={};
local MarkerStatus=true;


addEventHandler("onClientPreRender",root,function()
	if(not(isLoggedin()))then
		return;
	end
	
	local tick=getTickCount();
	local progress=(tick-starttick)/1000;
	if(progress>1)then
		progress=progress-1;
		starttick=starttick+1000;
		MarkerStatus=not MarkerStatus;
	end
	local plusZ=interpolateBetween(0,0,0,0.5,0,0,MarkerStatus and progress or 1-progress,"InQuad")--OutQuad
	local index=0;
	local cMarker=getElementByID("cMarker",index);
	
	while cMarker~=false and cMarker~=nil do
		if(not(MarkerCacheTable[cMarker]))then
			MarkerCacheTable[cMarker]={};
		end
		
		if(not(MarkerCacheTable[cMarker]._imgobj))then
			MarkerCacheTable[cMarker]._imgobj=dxCreateTexture(getElementData(cMarker,"cMarker.image"));
		end
		if(not(MarkerCacheTable[cMarker]._imgunderground))then
			MarkerCacheTable[cMarker]._imgunderground=dxCreateTexture(getElementData(cMarker,"cMarker.uimage"));
		end
		
		local px,py,pz=unpack(getElementData(cMarker,"cMarker.positions"));
		local z=getGroundPosition(px-0.5,py,pz-0.5)+0.05;
		dxDrawMaterialLine3D(px-0.5,py,z,px-0.5+1,py,z,MarkerCacheTable[cMarker]._imgunderground,1,tocolor(255,255,255,155),px-0.5+1,py,z+1);
		dxDrawMaterialLine3D(px,py,(pz+0.4+plusZ),px,py,(pz-0.4+plusZ),MarkerCacheTable[cMarker]._imgobj,1,tocolor(255,255,255,255));
		index=index+1;
		cMarker=getElementByID("cMarker",index);
	end
end)