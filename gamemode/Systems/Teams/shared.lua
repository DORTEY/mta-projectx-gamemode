function getTeamMembersOnline(team)
	local Counter=0;
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"Player->Data->Team")==tostring(team))then
			Counter=Counter+1;
		end
	end
	return Counter;
end

function getTeamMembersLimit(team)
	return TEAMS[tostring(team)].Limit;
end