function loc(var)
	local pLang=getElementData(localPlayer,"Language")or "EN";
	if(Language[pLang])then
		if(Language[pLang][var])then
			return Language[pLang][var];
		else
			return var;
		end
	end
end