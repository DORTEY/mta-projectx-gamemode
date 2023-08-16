DB={
	HOST="",--IP
	PORT="3306",
	NAME="",--DB name
	PASS="",--DB password
	USER="",--DB user
	HANDLER=nil,
};

addEventHandler("onResourceStart",resourceRoot,function()
	DB.HANDLER=dbConnect("mysql","dbname="..DB.NAME..";host="..DB.HOST..";charset=utf8;port="..DB.PORT,DB.USER,DB.PASS,"autoreconnect=1");
	print("[MYSQL] Opening connection to MySQL database..");
	if(DB.HANDLER)then
		print("[MYSQL] Connection successfully established!");
		
		return true;
	else
		print("[MYSQL] Connection failed!");
		stopResource(resource);
		return false;
	end
end)



function getMySQLData(from,where,name,data)
	local sql=dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?",from,where,name);
	local row=dbPoll(sql,-1);
	if(#row>=1)then
		return row[1][data];
	end
end
function getMySQLData2(from,where,name,andd,name2,data)
	local sql=dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=? AND ??=?",from,where,name,andd,name2);
	local row=dbPoll(sql,-1);
	if(#row>=1)then
		return row[1][data];
	end
end