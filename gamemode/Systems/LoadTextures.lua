addRemoteEvents{"Textures->Load","Load->Vehicle->Paintjob->Show","Load->Vehicle->Light->Show","Load->Vehicle->NPlate->Show","Textures->Skybox->Load"};--addEvent


local Textures={};

--vehicles textures
addEventHandler("Textures->Load",root,function()
	Textures["Shader->Ped->1"]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/Main.fx");
	Textures["Shader->Ped->1:1"]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Images/Transparent.png");
	dxSetShaderValue(Textures["Shader->Ped->1"],"Tex",Textures["Shader->Ped->1:1"]);
	engineApplyShaderToWorldTexture(Textures["Shader->Ped->1"],"shad_ped");
	
	for i,v in ipairs(getElementsByType("vehicle"))do
		local id=getElementModel(v);
		
		if(getElementData(v,"Veh->Data->Paintjob->SAPD")==true)then
			if(id==596 or id==528)then
				Textures[1]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/Main.fx");
				Textures[2]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/SAPD.png");
				dxSetShaderValue(Textures[1],"Tex",Textures[2]);
				engineApplyShaderToWorldTexture(Textures[1],"vehiclepoldecals128",v);
			end
		end
		if(getElementData(v,"Veh->Data->Paintjob->FIB")==true)then
			if(id==596 or id==528)then
				Textures[1]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/Main.fx");
				Textures[2]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/FIB.png");
				dxSetShaderValue(Textures[1],"Tex",Textures[2]);
				engineApplyShaderToWorldTexture(Textures[1],"vehiclepoldecals128",v);
			end
		end
		if(getElementData(v,"Veh->Data->Paintjob->SAMD")==true)then
			if(id==596)then
				Textures[1]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/Main.fx");
				Textures[2]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/SAMD.png");
				dxSetShaderValue(Textures[1],"Tex",Textures[2]);
				engineApplyShaderToWorldTexture(Textures[1],"vehiclepoldecals128",v);
				
				Textures[3]=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/Main.fx");
				Textures[4]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/State/RescueLightbar.png");
				dxSetShaderValue(Textures[3],"Tex",Textures[4]);
				engineApplyShaderToWorldTexture(Textures[3],"copcarla92interior128",v);
			end
		end
	end
end)









local textures={};--paintjobs
local textures2={};--lights
local textures3={};--numberplates
local paintJobs={};--paintjobs
local lightJobs={};--lights
local numberplates={};--

local function togglePaintjob(veh,bool)
	if(bool)then
		if(getElementData(localPlayer,"LoadVehTextures")~=2)then
			return;
		end
		
		local vehID=tonumber(getElementData(veh,"Veh->Data->VehID"))or nil;
		local paintJob=tonumber(getElementData(veh,"Veh->Data->Paintjob"))or nil;
		if(paintJob and paintJob~=9999 and paintJob~=0 and paintJob~=1 and paintJob~=2)then
			local shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Paintjobs/Main.fx");
			engineRemoveShaderFromWorldTexture(shader,"vehiclegrunge256",veh);
			engineApplyShaderToWorldTexture(shader,"vehiclegrunge256",veh);
			engineApplyShaderToWorldTexture(shader,"?emap*",veh);
			
			engineRemoveShaderFromWorldTexture(shader,"@hite",veh);
			engineApplyShaderToWorldTexture(shader,"@hite",veh);
			
			if(not(textures[paintJob]))then
				textures[paintJob]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Paintjobs/"..tostring(paintJob)..".png");
			end
			dxSetShaderValue(shader,"CustomPaintjobs",textures[paintJob]);
			paintJobs[veh]=shader;
		else
			if(isElement(paintJobs[veh]))then
				destroyElement(paintJobs[veh]);
				paintJobs[veh]=nil;
			end
		end
	else
		if(isElement(paintJobs[veh]))then
			destroyElement(paintJobs[veh]);
			paintJobs[veh]=nil;
		end
	end
end
local function toggleLights(veh,bool)
	if(bool)then
		if(getElementData(localPlayer,"LoadVehTextures")~=2)then
			return;
		end
		
		local vehID=tonumber(getElementData(veh,"Veh->Data->VehID"))or nil;
		local lightJob=tonumber(getElementData(veh,"Veh->Data->Light"))or nil;
		if(lightJob and lightJob~=9999)then
			local shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Lights/Main.fx");
			engineRemoveShaderFromWorldTexture(shader,"vehiclelights128",veh);
			engineRemoveShaderFromWorldTexture(shader,"vehiclelightson128",veh);
			engineApplyShaderToWorldTexture(shader,"vehiclelights128",veh);
			engineApplyShaderToWorldTexture(shader,"vehiclelightson128",veh);
			
			if(not(textures2[lightJob]))then
				textures2[lightJob]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Lights/"..tostring(lightJob)..".png");
			end
			dxSetShaderValue(shader,"CustomLights",textures2[lightJob]);
			lightJobs[veh]=shader;
		else
			if(isElement(lightJobs[veh]))then
				destroyElement(lightJobs[veh]);
				lightJobs[veh]=nil;
			end
		end
	else
		if(isElement(lightJobs[veh]))then
			destroyElement(lightJobs[veh]);
			lightJobs[veh]=nil;
		end
	end
end
local function toggleNumberplate(veh,bool)
	if(bool)then
		local vehID=tonumber(getElementData(veh,"Veh->Data->VehID"))or nil;
		local numbplate=tonumber(getElementData(veh,"Veh->Data->Numberplate"))or nil;
		if(numbplate and numbplate~=9999)then
			local shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Numberplates/Main.fx");
			engineRemoveShaderFromWorldTexture(shader,"custom_car_plate",veh);
			engineRemoveShaderFromWorldTexture(shader,"plateback1",veh);
			engineRemoveShaderFromWorldTexture(shader,"plateback2",veh);
			engineRemoveShaderFromWorldTexture(shader,"plateback3",veh);
			engineApplyShaderToWorldTexture(shader,"plateback1",veh);
			engineApplyShaderToWorldTexture(shader,"plateback2",veh);
			engineApplyShaderToWorldTexture(shader,"plateback3",veh);
			
			
			if(not(textures3[numbplate]))then
				textures3[numbplate]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Numberplates/"..tostring(numbplate)..".png");
			end
			dxSetShaderValue(shader,"CustomNumbplates",textures3[numbplate]);
			numberplates[veh]=shader;
		else
			if(isElement(numberplates[veh]))then
				destroyElement(numberplates[veh]);
				numberplates[veh]=nil;
			end
		end
	else
		if(isElement(numberplates[veh]))then
			destroyElement(numberplates[veh]);
			numberplates[veh]=nil;
		end
	end
end

function togglePaintjobShow(veh,paintJob)
	if(paintJob)then
		local vehID=tonumber(getElementData(veh,"Veh->Data->VehID"))or nil;
		if(paintJob~=9999 and paintJob~=0 and paintJob~=1 and paintJob~=2)then
			if(isElement(paintJobs[veh]))then
				destroyElement(paintJobs[veh]);
				paintJobs[veh]=nil;
			end
			local shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Paintjobs/Main.fx");
			engineRemoveShaderFromWorldTexture(shader,"vehiclegrunge256",veh);
			engineApplyShaderToWorldTexture(shader,"vehiclegrunge256",veh);
			engineApplyShaderToWorldTexture(shader,"?emap*",veh);
			
			engineRemoveShaderFromWorldTexture(shader,"@hite",veh);
			engineApplyShaderToWorldTexture(shader,"@hite",veh);
			
			if(not(textures[paintJob]))then
				textures[paintJob]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Paintjobs/"..tostring(paintJob)..".png");
			end
			dxSetShaderValue(shader,"CustomPaintjobs",textures[paintJob]);
			paintJobs[veh]=shader;
		else
			if(isElement(paintJobs[veh]))then
				destroyElement(paintJobs[veh]);
				paintJobs[veh]=nil;
			end
		end
	else
		if(isElement(paintJobs[veh]))then
			destroyElement(paintJobs[veh]);
			paintJobs[veh]=nil;
		end
	end
end
addEventHandler("Load->Vehicle->Paintjob->Show",root,togglePaintjobShow)
function toggleLightsShow(veh,lightJob)
	if(lightJob)then
		if(lightJob~=9999)then
			if(isElement(lightJobs[veh]))then
				destroyElement(lightJobs[veh]);
				lightJobs[veh]=nil;
			end
			local shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Lights/Main.fx");
			engineRemoveShaderFromWorldTexture(shader,"vehiclelights128",veh);
			engineRemoveShaderFromWorldTexture(shader,"vehiclelightson128",veh);
			engineApplyShaderToWorldTexture(shader,"vehiclelights128",veh);
			engineApplyShaderToWorldTexture(shader,"vehiclelightson128",veh);
			
			if(not(textures2[lightJob]))then
				textures2[lightJob]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Lights/"..tostring(lightJob)..".png");
			end
			dxSetShaderValue(shader,"CustomLights",textures2[lightJob]);
			lightJobs[veh]=shader;
		else
			if(isElement(lightJobs[veh]))then
				destroyElement(lightJobs[veh]);
				lightJobs[veh]=nil;
			end
		end
	else
		if(isElement(lightJobs[veh]))then
			destroyElement(lightJobs[veh]);
			lightJobs[veh]=nil;
		end
	end
end
addEventHandler("Load->Vehicle->Light->Show",root,toggleLightsShow)
function toggleNumberplateShow(veh,numbplate)
	if(numbplate)then
		if(numbplate~=9999)then
			if(isElement(numberplates[veh]))then
				destroyElement(numberplates[veh]);
				numberplates[veh]=nil;
			end
			local shader=dxCreateShader(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Numberplates/Main.fx");
			engineRemoveShaderFromWorldTexture(shader,"custom_car_plate",veh);
			engineRemoveShaderFromWorldTexture(shader,"plateback1",veh);
			engineRemoveShaderFromWorldTexture(shader,"plateback2",veh);
			engineRemoveShaderFromWorldTexture(shader,"plateback3",veh);
			engineApplyShaderToWorldTexture(shader,"plateback1",veh);
			engineApplyShaderToWorldTexture(shader,"plateback2",veh);
			engineApplyShaderToWorldTexture(shader,"plateback3",veh);
			
			if(not(textures3[numbplate]))then
				textures3[numbplate]=dxCreateTexture(":"..RESOURCE_NAME.."/Files/Textures_Shaders/Vehicle/Numberplates/"..tostring(numbplate)..".png");
			end
			dxSetShaderValue(shader,"CustomNumbplates",textures3[numbplate]);
			numberplates[veh]=shader;
		else
			if(isElement(numberplates[veh]))then
				destroyElement(numberplates[veh]);
				numberplates[veh]=nil;
			end
		end
	else
		if(isElement(numberplates[veh]))then
			destroyElement(numberplates[veh]);
			numberplates[veh]=nil;
		end
	end
end
addEventHandler("Load->Vehicle->NPlate->Show",root,toggleNumberplateShow)


addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle")then
		togglePaintjob(source,true);
		toggleLights(source,true);
		toggleNumberplate(source,true);
	end
end)
addEventHandler("onClientElementStreamOut",root,function()
	if(getElementType(source)=="vehicle")then
		togglePaintjob(source,false);
		toggleLights(source,false);
		toggleNumberplate(source,false);
	end
end)
addEventHandler("onClientElementDestroy",root,function()
	if(getElementType(source)=="vehicle")then
		togglePaintjob(source,false);
		toggleLights(source,false);
		toggleNumberplate(source,false);
	end
end)













--skybox (not from us)
local dynamicSkySettings = {
	modelID = 15057,  -- model id to replace
	sunPreRotation = {25, 0, 0}, -- roll -- pitch ( time) -- yaw
	moonPreRotation = {0, 0, 0}, -- roll -- pitch ( time) -- yaw
	moonShine = 1, -- moon 'shine through clouds' multiplier
	modelScale = {0.125, 0.125, 0.125}, -- skydome scale
	bottomCloudSpread = 700, -- range in which the bottom clouds will appear (after camera.z reaches farClipDistance)
	enableIngameClouds = false, -- enable GTA clouds
	enableCloudTextures = false, -- enable smog/clouds textures
	enableHorizonBlending = true, -- should the sky gradually blend with horizon color
	stratosFade = {14000, 10000}, -- fake stratospheare effect
}

-- Do not touch
local shaderTable = {}
local textureTable = {}
local modelTable = {}
local tempParam = {}
local moonPhase = 0

----------------------------------------------------------------
-- resource start/stop
----------------------------------------------------------------
function startDynamicSky()
	if dsEffectEnabled then return end
	
	shaderTable.skyboxTropos = dxCreateShader ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/shader_dynamicSky2tropos.fx", 2, 0, false, "object" )
	shaderTable.skyboxStratos = dxCreateShader ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/shader_dynamicSky2stratos.fx", 2, 0, false, "object" )
	shaderTable.skyboxBottom = dxCreateShader ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/shader_dynamicSky2bottom.fx", 3, 0, false, "object" )
	shaderTable.clear = dxCreateShader ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/shader_clear.fx", 3, 0, false, "world" )
	textureTable.cloud = dxCreateTexture ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/clouds.dds", "dxt5" )
	textureTable.normal = dxCreateTexture ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/clouds_normal.jpg", "dxt5" ) 
	textureTable.skybox = dxCreateTexture ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/skybox.dds", "dxt5" )
	moonPhase = getCurrentMoonPhase()
	textureTable.moon = dxCreateTexture ( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/moon/"..toint( 20 - toint( moonPhase * 20 ) )..".png" )
	
	-- Get list of all elements used
	effectParts = {
						textureTable.cloud,
						textureTable.normal,
						textureTable.skybox,
						textureTable.moon,
						shaderTable.skyboxTropos,
						shaderTable.skyboxStratos,
						shaderTable.skyboxBottom,
						shaderTable.clear
					}

	-- Check list of all elements used
	bAllValid = true
	for _,part in ipairs(effectParts) do
		bAllValid = part and bAllValid
	end
	if not bAllValid then 
		outputChatBox('Dynamic Sky v2: failed to start shaders!',255,0,0)
		return
	end

	dxSetShaderValue ( shaderTable.skyboxTropos, "gAlphaMult", 1 )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gHorizonBlending", dynamicSkySettings.enableHorizonBlending )
	dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloud )
	dxSetShaderValue ( shaderTable.skyboxTropos, "sNormal", textureTable.normal ) 
	dxSetShaderValue ( shaderTable.skyboxTropos, "sCubeTex", textureTable.skybox )
	dxSetShaderValue ( shaderTable.skyboxTropos, "sMoon", textureTable.moon )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gStratosFade", dynamicSkySettings.stratosFade )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gScale", dynamicSkySettings.modelScale )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gBottCloudSpread", dynamicSkySettings.bottomCloudSpread )
	
	dxSetShaderValue ( shaderTable.skyboxStratos, "gAlphaMult", 1 )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gHorizonBlending", dynamicSkySettings.enableHorizonBlending )
	dxSetShaderValue ( shaderTable.skyboxStratos, "sCubeTex", textureTable.skybox )
	dxSetShaderValue ( shaderTable.skyboxStratos, "sMoon", textureTable.moon )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gStratosFade", dynamicSkySettings.stratosFade )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gScale", dynamicSkySettings.modelScale )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gBottCloudSpread", dynamicSkySettings.bottomCloudSpread )
	
	dxSetShaderValue ( shaderTable.skyboxBottom, "gAlphaMult", 1 )
	dxSetShaderValue ( shaderTable.skyboxBottom, "gHorizonBlending", dynamicSkySettings.enableHorizonBlending )	
	dxSetShaderValue ( shaderTable.skyboxBottom, "sClouds", textureTable.cloud )
	dxSetShaderValue ( shaderTable.skyboxBottom, "gStratosFade", dynamicSkySettings.stratosFade[1],dynamicSkySettings.stratosFade[2])
	dxSetShaderValue ( shaderTable.skyboxBottom, "gScale", dynamicSkySettings.modelScale )	
	dxSetShaderValue ( shaderTable.skyboxBottom, "gBottCloudSpread", dynamicSkySettings.bottomCloudSpread )
	
	engineApplyShaderToWorldTexture ( shaderTable.skyboxStratos	, "skybox_tex" )
	engineApplyShaderToWorldTexture ( shaderTable.skyboxBottom, "skybox_tex_bottom" ) 
	engineApplyShaderToWorldTexture ( shaderTable.clear, "coronamoon" )

		
	if not dynamicSkySettings.enableCloudTextures then
		engineApplyShaderToWorldTexture ( shaderTable.clear, "cloudmasked" )	
	end

	tempParam[1] = getSunSize()
	tempParam[2] = getMoonSize()
	tempParam[3] = getCloudsEnabled()
	setSunSize( 0 )
	setMoonSize( 0 )
    setCloudsEnabled( dynamicSkySettings.enableIngameClouds )
	
	modelTable.txd = engineLoadTXD( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/Model.txd" )
	engineImportTXD( modelTable.txd, dynamicSkySettings.modelID)
	modelTable.dff = engineLoadDFF( ":"..RESOURCE_NAME.."/Files/Textures_Shaders/Skybox/Model.dff", dynamicSkySettings.modelID )
	engineReplaceModel( modelTable.dff, dynamicSkySettings.modelID, true )  

	local camX, camY, camZ = getElementPosition( getLocalPlayer() )
	modelTable.object = createObject ( dynamicSkySettings.modelID, camX, camY, camZ, 0, 0, 0, true )
	setObjectScale( modelTable.object, 8, 8, 8)
	setElementAlpha( modelTable.object, 1 )

	addEventHandler ( "onClientPreRender", getRootElement (), renderSphere ) -- sphere
	addEventHandler ( "onClientPreRender", getRootElement (), renderTime ) -- time
	shaderTable.isSwitched = false
	addEventHandler ( "onClientPreRender", getRootElement (), switchShaders ) -- change shaders
	dsEffectEnabled = true
end
addEventHandler("Textures->Skybox->Load",root,startDynamicSky)

function switchShaders()
	if dsEffectEnabled then 
		local camX, camY, camZ = getCameraMatrix()
		if camZ > dynamicSkySettings.stratosFade[2] then
			if shaderTable.isSwitched then
				engineRemoveShaderFromWorldTexture( shaderTable.skyboxTropos, "skybox_tex" )
				engineApplyShaderToWorldTexture ( shaderTable.skyboxStratos	, "skybox_tex" )
				shaderTable.isSwitched = false
			end
		else
			if not shaderTable.isSwitched then
				engineRemoveShaderFromWorldTexture( shaderTable.skyboxStratos, "skybox_tex" )
				engineApplyShaderToWorldTexture ( shaderTable.skyboxTropos, "skybox_tex" )
				shaderTable.isSwitched = true
			end
		end
	end
end


function renderSphere()
	if dsEffectEnabled then
		-- Set the skybox model position accordingly to the camera position
		local camX, camY, camZ = getCameraMatrix()
		setElementPosition ( modelTable.object, camX, camY, camZ ,false )
	end
end


function toint(n)
    local s = tostring(n)
    local i = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

function rang(x)
    local b = x / 360
    local a = 360 * ( b - toint( b ))
    if ( a < 0 ) then 
		a = a + 360 
	end
    return a
end

function faza(Rok, Miesiac, Dzien, godzina, minuta, sekunda)
local A, b, phi1, phi2, jdp, tzd, elm, ams, aml, asd
    if (Miesiac > 2) then
        Miesiac = Miesiac
        Rok = Rok
	end
	if Miesiac <= 2 then
		Miesiac = Miesiac + 12
		Rok = Rok - 1
	end

	local A = toint(Rok / 100)
	local b = 2 - A + toint(A / 4)

	jdp = toint(365.25 * (Rok + 4716)) + toint(30.6001 * (Miesiac + 1)) + Dzien + b + ((godzina + minuta / 60 + sekunda / 3600) / 24) - 1524.5
	jdp = jdp
	tzd = (jdp - 2451545) / 36525
	elm = rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + tzd * tzd * tzd / 545868 - (tzd * tzd * tzd * tzd) / 113065000);
	ams = rang(357.5291092 + 35999.0502909 * tzd - 0.0001536 * tzd * tzd + tzd * tzd * tzd / 24490000)
	aml = rang(134.9634114 + 477198.8676313 * tzd - 0.008997 * tzd * tzd + tzd * tzd * tzd / 69699 - (tzd * tzd * tzd * tzd) / 14712000);
	asd = 180 - elm -   (6.289 * math.sin((3.1415926535 / 180) * aml)) +
                    (2.1 * math.sin((3.1415926535 / 180) * ((ams)))) -
                    (1.274 * math.sin((3.1415926535 / 180) * ((2 * elm) - aml))) -
                    (0.658 * math.sin((3.1415926535 / 180) * (2 * elm))) -
                    (0.214 * math.sin((3.1415926535 / 180) * (2 * aml))) -
                    (0.11 * math.sin((3.1415926535 / 180) * elm))
	phi1 = ((1 + math.cos((3.1415926535 / 180) * (asd))) / 2)


	tzd = (jdp + (0.5 / 24) - 2451545) / 36525
	elm = rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + (tzd * tzd * tzd) / 545868 - (tzd * tzd * tzd * tzd) / 113065000)
	ams = rang(357.5291092 + 35999.0502909 * tzd - (0.0001536 * tzd * tzd) + (tzd * tzd * tzd) / 24490000)
	aml = rang(134.9634114 + 477198.8676313 * tzd - (0.008997 * tzd * tzd) + (tzd * tzd * tzd) / 69699 - (tzd * tzd * tzd * tzd) / 14712000)
	asd= 180 - elm -   (6.289 * math.sin((3.1415926535 / 180) * ((aml)))) +
                    (2.1 * math.sin((3.1415926535 / 180) * ams)) -
                    (1.274 * math.sin((3.1415926535 / 180) * ((2 * elm) - aml))) -
                    (0.658 * math.sin((3.1415926535 / 180) * (2 * elm))) -
                    (0.214 * math.sin((3.1415926535 / 180) * (2 * aml))) -
                    (0.11 * math.sin((3.1415926535 / 180) * elm))
	phi2 = ((1 + math.cos((3.1415926535 / 180) * (asd))) / 2)

	if ( phi2 - phi1 ) < 0 then 
		phi1 = -phi1 
	end
	return phi1
end

function getCurrentMoonPhase()
	local getTime = getRealTime()
	local faze = faza( getTime.year + 1900, getTime.month + 1, getTime.monthday, getTime.hour, getTime.minute, getTime.second )
	if faze >= 0 then 
		return 1 - ( faze / 2  )
	else
		if faze < 0 then 
			return 1 - (( 2 + faze ) / 2 )
		end 
	end
end


local oldWeather = -1 
local windVelocity = {{1,0.1},{3,0.2},{4,0.25},{5, 0.15},{7,0.6},{ 10,0.05},{12, 0.25}, { 14,0.06},{15, 0.34},{18, 0.1}}
local removeWeather = {8,9,16,19,30,31,32,118}
local alphaInWater = 1

local timeHMS = {0,0,0}
local minuteStartTickCount
local minuteEndTickCount

function getTimeHMS()
	return unpack(timeHMS)
end

addEventHandler( "onClientPreRender", root,function ()
	if not dsEffectEnabled then return end
	local h, m = getTime ()
	local s = 0
	if m ~= timeHMS[2] then
		minuteStartTickCount = getTickCount ()
		local gameSpeed = math.clamp( 0.01, getGameSpeed(), 10 )
		minuteEndTickCount = minuteStartTickCount + 1000 / gameSpeed
	end
	if minuteStartTickCount then
		local minFraction = math.unlerpclamped( minuteStartTickCount, getTickCount(), minuteEndTickCount )
		s = math.min ( 59, math.floor ( minFraction * 60 ) )
	end
	timeHMS = {h, m, s}
end)

function renderTime()
	if not dsEffectEnabled then return end
	local ho,mi,se = getTimeHMS()
	local timeAspect = ((( ho * 60 ) + mi ) + ( se / 60 )) / 1440
			
	dxSetShaderValue ( shaderTable.skyboxTropos, "gRotate", math.rad(dynamicSkySettings.sunPreRotation[1]), math.rad(( timeAspect * 360 ) + 
			dynamicSkySettings.sunPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] ))
	dxSetShaderValue ( shaderTable.skyboxStratos, "gRotate", math.rad(dynamicSkySettings.sunPreRotation[1]), math.rad(( timeAspect * 360 ) + 
			dynamicSkySettings.sunPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] ))

	dxSetShaderValue ( shaderTable.skyboxTropos, "mRotate", math.rad(dynamicSkySettings.sunPreRotation[1] + dynamicSkySettings.moonPreRotation[1]), math.rad((( moonPhase + timeAspect ) * 360) + 
			dynamicSkySettings.sunPreRotation[2] + dynamicSkySettings.moonPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] + dynamicSkySettings.moonPreRotation[3]))
	dxSetShaderValue ( shaderTable.skyboxStratos, "mRotate", math.rad(dynamicSkySettings.sunPreRotation[1] + dynamicSkySettings.moonPreRotation[1]), math.rad((( moonPhase + timeAspect ) * 360) + 
			dynamicSkySettings.sunPreRotation[2] + dynamicSkySettings.moonPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] + dynamicSkySettings.moonPreRotation[3]))

	dxSetShaderValue ( shaderTable.skyboxTropos, "mMoonLightInt", math.sin( math.pi * moonPhase ) * dynamicSkySettings.moonShine )
	dxSetShaderValue ( shaderTable.skyboxStratos, "mMoonLightInt", math.sin( math.pi * moonPhase ) * dynamicSkySettings.moonShine )
	
	local camX, camY, camZ = getCameraMatrix()
	local watLvl = getWaterLevel(camX, camY, camZ)
	if watLvl then
		if (camZ - 0.65 < watLvl ) then
			dxSetShaderValue ( shaderTable.skyboxTropos, "gIsInWater", true )
			dxSetShaderValue ( shaderTable.skyboxBottom, "gIsInWater", true ) 
			dxSetShaderValue ( shaderTable.skyboxStratos, "gIsInWater", true )
		end
	end
	if not watLvl or (camZ - 0.65 > watLvl ) then
		dxSetShaderValue ( shaderTable.skyboxTropos, "gIsInWater", false )
		dxSetShaderValue ( shaderTable.skyboxBottom, "gIsInWater", false ) 
		dxSetShaderValue ( shaderTable.skyboxStratos, "gIsInWater", false )
	end
	
	local thisWeather = getWeather()
	for index, nr in ipairs(removeWeather) do
		if thisWeather==nr then 
			dxSetShaderValue ( shaderTable.skyboxTropos, "gAlphaMult", 0 )
			dxSetShaderValue ( shaderTable.skyboxBottom, "gAlphaMult", 0 ) 
			dxSetShaderValue ( shaderTable.skyboxStratos, "gAlphaMult", 0 ) 
		end
	end
	
	if (thisWeather~=oldWeather) then
		local windVelocityValue = 0.00
		for index, value in ipairs(windVelocity) do
			if value[1]==thisWeather then windVelocityValue = value[2] end
		end
		dxSetShaderValue ( shaderTable.skyboxTropos, "gCloudSpeed", 0.15 * windVelocityValue )
		dxSetShaderValue ( shaderTable.skyboxBottom, "gCloudSpeed", 0.15 * windVelocityValue )
	end
	local r1,g1,b1,r2,g2,b2 = getSunColor()
	dxSetShaderValue ( shaderTable.skyboxTropos, "gSunColor", r1/255, g1/255, b1/255, r2/255, g2/255, b2/255 )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gSunColor", r1/255, g1/255, b1/255, r2/255, g2/255, b2/255 )
	
	if ( ho==0 and mi==0 and se==0 ) then
		dawn_aspect = 0.001
	end
	if ho <= 6 and not ( ho==0 and se==0 and mi==0 ) then
		dawn_aspect =(( ho * 60 + mi + se/60 )) / 360
	end
	
	if ho > 6 and ho < 20 then
		dawn_aspect = 1
	end
 
	if ho >=20  then
		dawn_aspect = -6 * (((( ho - 20 ) * 60 ) + mi + se/60 ) / 1440 ) + 1
	end
	
	dxSetShaderValue ( shaderTable.skyboxTropos, "gDayTime", dawn_aspect )
	dxSetShaderValue ( shaderTable.skyboxBottom, "gDayTime", dawn_aspect )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gDayTime", dawn_aspect )	
	oldWeather = thisWeather
end


----------------------------------------------------------------
-- Math helper functions
----------------------------------------------------------------
function math.lerp(from,alpha,to)
    return from + (to-from) * alpha
end

function math.unlerp(from,pos,to)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end

function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.unlerpclamped(from,pos,to)
	return math.clamp(0,math.unlerp(from,pos,to),1)
end