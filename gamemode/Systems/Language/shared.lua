Language={
	["DE"]={
		--//register/login
		["UI->Register->Name"]="Benutzername",
		["UI->Register->Pass"]="Passwort",
		["UI->Register->Button"]="Account erstellen",
		
		["UI->Register->Gender"]="Wähle dein Geschlecht",
		["UI->Register->GenderM"]="Männlich",
		["UI->Register->GenderF"]="Weiblich",
		
		["UI->Register->MSG->UsernameNotLongEnough"]="Der Benutzername muss zwichen 3-15\nZeichen lang sein!",
		["UI->Register->MSG->PasswordNotLongEnough"]="Das Password muss mindestens 4 Zeichen\nlang sein!",
		
		["Register->MSG->NameAlreadyTaken"]="Dieser Name ist bereits vergeben!",
		["Register->MSG->RegisterSuccess"]="Du hast dich erfolgreich registriert!",
		["Register->MSG->NotAllowedName"]="Dieser Name ist nicht erlaubt!",
		["Register->MSG->NotAllowedChars"]="Es sind keine Sonderzeichen erlaubt!",
		["Register->MSG->AlreadyAccount"]="Multiaccounts sind nicht erlaubt!",
		--
		["UI->Login->Name"]="Benutzername",
		["UI->Login->Pass"]="Passwort",
		["UI->Login->Button"]="Einloggen",
		["UI->Login->SaveName"]="Benutzername speichern?",
		["UI->Login->SavePW"]="Password speichern?",
		
		["Login->MSG->LoginSuccess"]="Du hast dich erfolgreich angemeldet!",
		["Login->MSG->WrongPassword"]="Falsches Passwort!",
		--\\register/login
		
		--//team selection
		["UI->TeamSelect->Header"]="Team Auswahl",
		["UI->TeamSelect->Info->BTN"]="Informationen",
		["UI->TeamSelect->Info->Text"]="Als 'Civilian' kannst du jobben, kleine Raübe sowie andere\nDinge tun, um Geld zu verdienen.\n\nAls 'S.A.P.D' & oder 'F.I.B' musst du Verbrecher schnappen\nund die Stadt vor Verbrechen beschützen.\n\nAls S.A.M.D musst du Leute wiederbeleben, damit die Menschen\nüberleben.\n\nAls Gangster wie 'Grove' etc kannst du Leute überfallen\nsowie Räube usw starten.",
		["TeamSelect->Full"]="Dieses Team ist bereits voll!",
		--\\team selection
		
		--//death systems
		["Dead->MSG->ToSAMD->OnMap"]="Toter (%s, %s)",
		["Dead->MSG->ToSAMD"]="[INFO]: Toter in %s,%s gemeldet.",
		["Revive->MSG->GotRevived"]="Du wurdest von Sanitäter %s wieder ins Leben gerufen!",
		["Revive->MSG->YouRevived"]="Du hast %s wiederbelebt und erhälst %s",
		["UI->DeathScreen"]="Du bist bewusstlos!\n\nDas S.A.M.D wurden benachrichtig.\nSollten keine Sanitäter verfügbar sein, wirst du\nnach ablauf der Zeit im Krankenhaus gespawnt. \n\nDu wirst in %s sekunden respawnt.",
		--\\death systems
		
		--//money
		["UI->ATM->Tab->Deposit"]="Einzahlung",
		["UI->ATM->BTN->Deposit"]="Einzahlen",
		["UI->ATM->Tab->Withdraw"]="Auszahlung",
		["UI->ATM->BTN->Withdraw"]="Auszahlen",
		["UI->ATM->Balance"]="Kontostand",
		--\\money
		
		--//items
		["Item->Name->Bread"]="Brot",
		["Item->Name->Donut"]="Donut",
		["Item->Name->Milk"]="Milch",
		["Item->Name->Water"]="Wasser",
		
		["Item->Name->Bandage"]="Verband",
		["Item->Name->Medikit"]="Verbandskasten",
		
		["Item->Name->Stone"]="Stein",
		["Item->Name->OreBronze"]="Bronze",
		["Item->Name->OreIron"]="Eisen",
		["Item->Name->OreGold"]="Gold",
		["Item->Name->Jewel"]="Juwel",
		["Item->Name->Armor"]="Schutzweste",
		--\\items
		
		--//job related
		["JobJoined"]="Du hast den Job %s betreten!",
		["JobLeaved"]="Du hast den Job %s verlassen!",
		["JobAlready"]="Du bist in keinem Job tätig!",
		["AlreadyInJob"]="Du bist bereits im %s Job!",
		["LeaveJobBefore"]="Verlassen deinen Job vorher!",
		["Job->GotItem"]="Du hast x%s %s erhalten!",
		["Job->SelledItem"]="Du hast x%s %s verkauft!\nDu erhälst %s",
		
		["Job->UI->Tab->SellItems"]="Gegenstände verkaufen",
		["Job->UI->Sell->BTN"]="Verkaufen",
		["Job->Garbage->Collected"]="Müll eingesammelt! (%s L./%s L.)",
		["Job->Garbage->VehFull"]="Das Fahrzeug ist voll!\nFahre zurück & entleere es.",
		["Job->Garbage->VehNeed50"]="Das Fahrzeug muss mindestens\n50% gefüllt sein!",
		["Job->Garbage->VehEmptied"]="Müll erfolgreich ausgeladen!\nDu erhälst %s%s.",
		["Job->Garbage->PickupInfo"]="Drücke 'X' um den Müllsack aufzuheben.",
		["Job->Garbage->DeliverInfo"]="Müll aufgehoben.\nGehe zum Müllwagen & drücke 'X'",
		--\\job related
		
		--//shop related
		["UI->Shop->Skin->Title"]="Drücke die 'Leertaste' um das drehen anzuhalten/zu starten",
		["UI->Shop->Price"]="Preis",
		["UI->Shop->Level"]="Level",
		["UI->Shop->Skin->BTN"]="Skin kaufen",
		["UI->Shop->Item->BTN"]="Gegenstand kaufen",
		["Shop->MSG->Bought->Item"]="Gegenstand erfolgreich gekauft!\nx%s %s",
		["Shop->MSG->Bought->Skin"]="Skin erfolgreich gekauft!\n%s",
		["Shop->MSG->NotEnoughLevel"]="Du hast nicht das erforderliche\nLevel für diese Waffe! %s",
		--\\shop related
		
		--//phonecell related
		["Phonecell->Info"]="Drücke 'X' um den hörer abzunehmen.",
		["Phonecell->Reward"]="Du hast ein Glückliches Telefon gefunden! Du erhälst %s%s.",
		--\\phonecell related
		
		--//tuning related
		["UI->Shop->Tuning->Title"]="Drücke 'M' um die Kamera zu drehen!",
		["UI->Tuning->Buy->BTN"]="Ausge. Tuning kaufen",
		["UI->Tuning->Rem->BTN"]="Ausge. Tuning entfernen",
		["ShopT->MSG->Bought->Item"]="Tuning erfolgreich gekauft!",
		--\\tuning related
		
		--//rob related
		["Rob->NeedAmountOfStateMembers"]="Es müssen mindestens %s\nCops online sein.",
		--\\rob related
		
		
		
		
		--//vehicle stuff
		["Vehicle->NoPerms"]="Du kannst dieses Fahrzeug nicht benutzen!\nDu bist nicht im %s Team!",
		["Vehicle->NoVehicles"]="Du hast keine Fahrzeuge!\nDu kannst die eins im Autohaus kaufen!",
		["Vehicle->IsntSpawned"]="Dieses Fahrzeug ist nicht gespawnt!",
		["Vehicle->AlreadySpawned"]="Dieses Fahrzeug ist bereits gespawnt!",
		["Vehicle->Repair->PNS"]="Du hast %s%s für die Reperatur\nbezahlt.",
		["Vehicle->LeaveBefore"]="Verlasse dein Fahrzeug vorher.",
		--\\vehicle stuff
		
		--other stuff
		["OnlyNumber"]="Es sind nur Zahlen erlaubt!",
		["Close->UI"]="Menü Schließen",
		["NotInCivilianTeam"]="Du musst dem Civilian Team beitreten!",
		["NotInGangTeam"]="Du bist in keiner Gang!",
		["NotInRightTeam"]="Du bist nicht im %s Team!",
		["NotInRightJob"]="Du bist nicht im %s Job!",
		["NotEnoughMoney"]="Du hast nicht Genug Geld!\nDu benötigst %s%s",
		["NotEnoughItemAmount"]="Du hast nicht Genug %s!",
		["NotEnoughLevel"]="Du hast nicht das erforderliche\nLevel! %s",
		["PremiumExpired"]="Dein Premium-status ist abgelaufen.",
		["PremiumStatus"]="Dein Premium-Status ist noch aktiv für '%s' Stunde(n)",
		["AlreadyEnoughAmmo"]="Du hast bereits Maximale Munition!",
		["CantDoThatCuzWanteds"]="Dies kannst du derzeitig nicht tun\nda du Wanteds hast.",
		["GotActivityBonus"]="Du hast %s und %s EXP erhalten, da du %s spielstunden erreicht hast.",
		["NoDMText"]="Jegliche Art von Deathmatch ist verboten!",
		["TeamChangeDelay"]="Du kannst dein Team nicht ändern!\nBitte warte %s Minuten!",
		["CaseAlreadyOpened"]="Du hast die Kiste bereits geöffnet!\nDiese kannst du nach jedem restart öffnen!",
	},
	["EN"]={
		--//register/login
		["UI->Register->Name"]="Username",
		["UI->Register->Pass"]="Password",
		["UI->Register->Button"]="Create account",
		
		["UI->Register->Gender"]="Select your Gender",
		["UI->Register->GenderM"]="Male",
		["UI->Register->GenderF"]="Female",
		
		["UI->Register->MSG->UsernameNotLongEnough"]="The username must be between 3-15\ncharacters long!",
		["UI->Register->MSG->PasswordNotLongEnough"]="The password must be at least 4 characters\nlong!",
		
		["Register->MSG->NameAlreadyTaken"]="This Name is already taken!",
		["Register->MSG->RegisterSuccess"]="Registration successfully",
		["Register->MSG->NotAllowedName"]="This name is not allowed!",
		["Register->MSG->NotAllowedChars"]="No special characters are allowed!",
		["Register->MSG->AlreadyAccount"]="Multiaccounts are not allowed!",
		--
		["UI->Login->Name"]="Username",
		["UI->Login->Pass"]="Password",
		["UI->Login->Button"]="Log in",
		["UI->Login->SaveName"]="Save Username?",
		["UI->Login->SavePW"]="Save password?",
		
		["Login->MSG->LoginSuccess"]="Log in successfully!",
		["Login->MSG->WrongPassword"]="Wrong Password!",
		--\\register/login
		
		--//team selection
		["UI->TeamSelect->Header"]="Team Selection",
		["UI->TeamSelect->Info->BTN"]="Informations",
		["UI->TeamSelect->Info->Text"]="As 'Civilian' you can do jobs, do small robbery as well as other\nthings to earn money.\n\nAs 'S.A.P.D' & or 'F.I.B' you have to catch criminals\nand protect the city from crimes.\n\nAs S.A.M.D you have to revive people so that people survive.\n\nAs gangster like 'Grove' you can rob peoples\nas well as start robberies.",
		["TeamSelect->Full"]="This Team is already full!",
		--\\team selection
		
		--//death systems
		["Dead->MSG->ToSAMD->OnMap"]="Dead Body (%s, %s)",
		["Dead->MSG->ToSAMD"]="[INFO]: Dead person at %s,%s reported.",
		["Revive->MSG->GotRevived"]="You have been brought back to life by medic %s!",
		["Revive->MSG->YouRevived"]="You have revived %s and get %s.",
		["UI->DeathScreen"]="You are unconscious!\n\nThe S.A.M.D. have been notified.\nIf no medics are available, you will be spawned\nat the hospital after the time runs out.\nYou will respawn in %s seconds.",
		--\\death systems
		
		--//money
		["UI->ATM->Tab->Deposit"]="Deposit",
		["UI->ATM->BTN->Deposit"]="Deposit",
		["UI->ATM->Tab->Withdraw"]="Withdraw",
		["UI->ATM->BTN->Withdraw"]="Withdraw",
		["UI->ATM->Balance"]="Balance",
		--\\money
		
		--//items
		["Item->Name->Bread"]="Bread",
		["Item->Name->Donut"]="Donut",
		["Item->Name->Milk"]="Milk",
		["Item->Name->Water"]="Water",
		
		["Item->Name->Bandage"]="Bandage",
		["Item->Name->Medikit"]="Medikit",
		
		["Item->Name->Stone"]="Stone",
		["Item->Name->OreBronze"]="Bronze",
		["Item->Name->OreIron"]="Iron",
		["Item->Name->OreGold"]="Gold",
		["Item->Name->Jewel"]="Jewel",
		["Item->Name->Armor"]="Armor",
		--\\items
		
		--//job related
		["JobJoined"]="You have joined the job %s!",
		["JobLeaved"]="You have leaved the job %s!",
		["JobAlready"]="You are not in any job!",
		["AlreadyInJob"]="You're already in job %s!",
		["LeaveJobBefore"]="Leave your job before!",
		["Job->GotItem"]="You got x%s %s!",
		["Job->SelledItem"]="You have selled x%s %s!\nYou got %s",
		
		["Job->UI->Tab->SellItems"]="Sell Items",
		["Job->UI->Sell->BTN"]="Sell",
		["Job->Garbage->Collected"]="Garbage collected! (%s L./%s L.)",
		["Job->Garbage->VehFull"]="The vehicle is full!\nDrive back & empty it.",
		["Job->Garbage->VehNeed50"]="The vehicle must be at least\n50% full!",
		["Job->Garbage->VehEmptied"]="Garbage successfully unloaded!\nYou get %s%s.",
		["Job->Garbage->PickupInfo"]="Press 'X' to pick up the trash bag.",
		["Job->Garbage->DeliverInfo"]="Garbage picked up.\nGo to the garbage truck & press 'X'.",
		--\\job related
		
		--//shop related
		["UI->Shop->Skin->Title"]="Press 'Sprace' to stop/start the rotation",
		["UI->Shop->Price"]="Price",
		["UI->Shop->Level"]="Level",
		["UI->Shop->Skin->BTN"]="Buy skin",
		["UI->Shop->Item->BTN"]="Buy item",
		["Shop->MSG->Bought->Item"]="Item successfully bought!\nx%s %s",
		["Shop->MSG->Bought->Skin"]="Skin successfully bought!\n%s",
		["Shop->MSG->NotEnoughLevel"]="You dont have the required\nLevel for this weapon! %s",
		--\\shop related
		
		--//phonecell related
		["Phonecell->Info"]="Press 'X' to take the phone higher.",
		["Phonecell->Reward"]="You have found a lucky phone! You got %s%s.",
		--\\phonecell related
		
		--//tuning related
		["UI->Shop->Tuning->Title"]="Press 'M' to rotate your camera!",
		["UI->Tuning->Buy->BTN"]="Buy selected tuning",
		["UI->Tuning->Rem->BTN"]="Remove selected tuning",
		["ShopT->MSG->Bought->Item"]="Tuning successfully purchased!",
		--\\tuning related
		
		--//rob related
		["Rob->NeedAmountOfStateMembers"]="There must be at least %s\ncops online.",
		--\\rob related
		
		
		
		
		--//vehicle stuff
		["Vehicle->NoPerms"]="You cannot use this Vehicle!\nYou're not in the %s Team!",
		["Vehicle->NoVehicles"]="You dont have vehicles!\nYou can buy a vehicle at a Carhouse!",
		["Vehicle->IsntSpawned"]="This vehicle isn't spawned!",
		["Vehicle->AlreadySpawned"]="This vehicle is already spawned!",
		["Vehicle->Repair->PNS"]="You have paid %s%s for the repair.",
		["Vehicle->LeaveBefore"]="Leave your vehicle before.",
		--\\vehicle stuff
		
		--other stuff
		["OnlyNumber"]="Only numbers are allowed!",
		["Close->UI"]="Close Menu",
		["NotInCivilianTeam"]="You need to join the Civilian Team!",
		["NotInGangTeam"]="You're not in a Gang!",
		["NotInRightTeam"]="You're not in the %s Team!",
		["NotInRightJob"]="You're not in the %s Job!",
		["NotEnoughMoney"]="You don't have enough Money!\nYou need %s%s",
		["NotEnoughItemAmount"]="You don't have enough %s!",
		["NotEnoughLevel"]="You dont have the required\nLevel! %s",
		["PremiumExpired"]="Your premium status has expired.",
		["PremiumStatus"]="Your Premium status is still active for '%s' hour(s)",
		["AlreadyEnoughAmmo"]="You already have maximum ammo!",
		["CantDoThatCuzWanteds"]="You cannot do this at the moment\nbecause you are wanted.",
		["GotActivityBonus"]="You have received %s and %s EXP for reaching %s playtime hours.",
		["NoDMText"]="Any kind of deathmatch is forbidden!",
		["TeamChangeDelay"]="You cannot change your team!\nPlease wait %s minutes!",
		["CaseAlreadyOpened"]="You have already opened the case!\nYou can open it after each restart!",
	},
	
	["TR"]={
		--//register/login
		["UI->Register->Name"]="Kullanıcı Adı",
		["UI->Register->Pass"]="Şifre",
		["UI->Register->Button"]="Hesap oluştur",
		
		["UI->Register->Gender"]="Cinsiyetinizi Seçin",
		["UI->Register->GenderM"]="Erkek",
		["UI->Register->GenderF"]="kadın",
		
		["UI->Register->MSG->UsernameNotLongEnough"]="Kullanıcı adı 3-15\nkarakter uzunluğunda olmalıdır!",
		["UI->Register->MSG->PasswordNotLongEnough"]="Şifre en az 4 karakter\uzun olmalıdır!",
		
		["Register->MSG->NameAlreadyTaken"]="Bu isim çoktan alınmış!",
		["Register->MSG->RegisterSuccess"]="Kayıt başarıyla gerçekleşti",
		["Register->MSG->NotAllowedName"]="Bu isme izin verilmiyor!",
		["Register->MSG->NotAllowedChars"]="No special characters are allowed!",
		["Register->MSG->AlreadyAccount"]="Multiaccounts are not allowed!",
		--
		["UI->Login->Name"]="Kullanıcı Adı",
		["UI->Login->Pass"]="Şifre",
		["UI->Login->Button"]="Giriş yap",
		["UI->Login->SaveName"]="Kullanıcı adını kaydetmek mi?",
		["UI->Login->SavePW"]="Şifreyi kaydet?",
		
		["Login->MSG->LoginSuccess"]="Başarıyla giriş yapın!",
		["Login->MSG->WrongPassword"]="Yanlış Şifre!",
		--\\register/login
		
		--//team selection
		["UI->TeamSelect->Header"]="Takım Seçimi",
		["UI->TeamSelect->Info->BTN"]="Bilgiler",
		["UI->TeamSelect->Info->Text"]="As 'Civilian' you can do jobs, do small robbery as well as other\nthings to earn money.\n\nAs 'S.A.P.D' & or 'F.I.B' you have to catch criminals\nand protect the city from crimes.\n\nAs S.A.M.D you have to revive people so that people survive.\n\nAs gangster like 'Grove' you can rob peoples\nas well as start robberies.",
		["TeamSelect->Full"]="Bu takım zaten dolu!",
		--\\team selection
		
		--//death systems
		["Dead->MSG->ToSAMD->OnMap"]="Ölü Beden (%s, %s)",
		["Dead->MSG->ToSAMD"]="[INFO]: Dead person at %s,%s reported.",
		["Revive->MSG->GotRevived"]="Doktor %s tarafından hayata döndürüldün.!",
		["Revive->MSG->YouRevived"]="%s'yu canlandırdınız ve %s kazandınız.",
		["UI->DeathScreen"]="You are unconscious!\n\nThe S.A.M.D. have been notified.\nIf no medics are available, you will be spawned\nat the hospital after the time runs out.\nYou will respawn in %s seconds.",
		--\\death systems
		
		--//money
		["UI->ATM->Tab->Deposit"]="Depozito",
		["UI->ATM->BTN->Deposit"]="Depozito",
		["UI->ATM->Tab->Withdraw"]="Geri Çekilme",
		["UI->ATM->BTN->Withdraw"]="Geri Çekilme",
		["UI->ATM->Balance"]="Para Dengesi",
		--\\money
		
		--//items
		["Item->Name->Bread"]="Ekmek",
		["Item->Name->Donut"]="çörek",
		["Item->Name->Milk"]="süt",
		["Item->Name->Water"]="Su",
		
		["Item->Name->Bandage"]="Bandaj",
		["Item->Name->Medikit"]="Medikit",
		
		["Item->Name->Stone"]="Taş",
		["Item->Name->OreBronze"]="Bronz",
		["Item->Name->OreIron"]="Demir",
		["Item->Name->OreGold"]="Altın",
		["Item->Name->Jewel"]="Mücevher",
		["Item->Name->Armor"]="Armor",
		--\\items
		
		--//job related
		["JobJoined"]="You have joined the job %s!",
		["JobLeaved"]="You have leaved the job %s!",
		["JobAlready"]="Herhangi bir işte çalışmıyorsun!",
		["AlreadyInJob"]="You're already in job %s!",
		["LeaveJobBefore"]="Leave your job before!",
		["Job->GotItem"]="You got x%s %s!",
		["Job->SelledItem"]="You have selled x%s %s!\nYou got %s",
		
		["Job->UI->Tab->SellItems"]="ürün satmak",
		["Job->UI->Sell->BTN"]="Satmak",
		["Job->Garbage->Collected"]="Garbage collected! (%s L./%s L.)",
		["Job->Garbage->VehFull"]="The vehicle is full!\nDrive back & empty it.",
		["Job->Garbage->VehNeed50"]="The vehicle must be at least\n50% full!",
		["Job->Garbage->VehEmptied"]="Garbage successfully unloaded!\nYou get %s%s.",
		["Job->Garbage->PickupInfo"]="Press 'X' to pick up the trash bag.",
		["Job->Garbage->DeliverInfo"]="Garbage picked up.\nGo to the garbage truck & press 'X'.",
		--\\job related
		
		--//shop related
		["UI->Shop->Skin->Title"]="Döndürmeyi durdurmak/başlatmak için 'Space' düğmesine\nbasın",
		["UI->Shop->Price"]="Fiyat",
		["UI->Shop->Level"]="Seviye",
		["UI->Shop->Skin->BTN"]="Cilt satın al",
		["UI->Shop->Item->BTN"]="ürün satın al",
		["Shop->MSG->Bought->Item"]="Ürün başarıyla satın alındı!\nx%s %s",
		["Shop->MSG->Bought->Skin"]="Cilt başarıyla satın alındı!\n%s",
		["Shop->MSG->NotEnoughLevel"]="You dont have the required\nLevel for this weapon! %s",
		--\\shop related
		
		--//phonecell related
		["Phonecell->Info"]="Telefonu daha yükseğe çıkarmak için 'X' tuşuna basın.",
		["Phonecell->Reward"]="Şanslı bir telefon buldunuz! %s%s'niz var.",
		--\\phonecell related
		
		--//tuning related
		["UI->Shop->Tuning->Title"]="Kameranızı döndürmek için 'M' tuşuna basın!",
		["UI->Tuning->Buy->BTN"]="Buy selected tuning",
		["UI->Tuning->Rem->BTN"]="Remove selected tuning",
		["ShopT->MSG->Bought->Item"]="Tuning successfully purchased!",
		--\\tuning related
		
		--//rob related
		["Rob->NeedAmountOfStateMembers"]="Çevrimiçi en az %s\npolis olmalıdır.",
		--\\rob related
		
		
		
		
		--//vehicle stuff
		["Vehicle->NoPerms"]="Bu Aracı kullanamazsınız!\n%s Takımında değilsiniz!",
		["Vehicle->NoVehicles"]="Araçlarınız yok!\nBir Carhouse'dan araç satın alabilirsiniz!",
		["Vehicle->IsntSpawned"]="Bu araç ortaya çıkmadı!",
		["Vehicle->AlreadySpawned"]="Bu araç çoktan üretildi!",
		["Vehicle->Repair->PNS"]="Onarım için %s%s ödeme yaptınız.",
		["Vehicle->LeaveBefore"]="Leave your vehicle before.",
		--\\vehicle stuff
		
		--other stuff
		["OnlyNumber"]="Sadece sayılara izin var!",
		["Close->UI"]="Menüyü Kapat",
		["NotInCivilianTeam"]="Sivil Ekibe katılmalısın!",
		["NotInGangTeam"]="Çetede değilsin!",
		["NotInRightTeam"]="Sen %s Takımı'nda değilsin!",
		["NotInRightJob"]="You're not in the %s Job!",
		["NotEnoughMoney"]="Yeterli paranız yok! %s%s ihtiyacınız var",
		["NotEnoughItemAmount"]="Yeterince %s niz yok!",
		["NotEnoughLevel"]="Gerekli Seviyeye sahip\ndeğilsiniz! %s",
		["PremiumExpired"]="Prim statünüzün süresi doldu.",
		["PremiumStatus"]="Premium statünüz '%s' saat(ler) için hala etkin",
		["AlreadyEnoughAmmo"]="Zaten maksimum cephaneniz var!",
		["CantDoThatCuzWanteds"]="Şu anda bunu yapamazsınız çünkü\naranıyorsunuz.",
		["GotActivityBonus"]="s oyun süresine ulaştığınız için %s ve %s EXP kazandınız.",
		["NoDMText"]="Her türlü ölüm maçı yasaktır!",
		["TeamChangeDelay"]="You cannot change your team!\nPlease wait %s minutes!",
		["CaseAlreadyOpened"]="You have already opened the case!\nYou can open it after each restart!",
	},
	["RU"]={
		--//register/login
		["UI->Register->Name"]="Имя пользователя",
		["UI->Register->Pass"]="Пароль",
		["UI->Register->Button"]="Создать учетную запись",
		
		["UI->Register->Gender"]="Выберите свой пол",
		["UI->Register->GenderM"]="Мужчина",
		["UI->Register->GenderF"]="Женский",
		
		["UI->Register->MSG->UsernameNotLongEnough"]="Tимя пользователя должно быть длиной от 3 до 15\nсимволов!",
		["UI->Register->MSG->PasswordNotLongEnough"]="Пароль должен состоять как минимум из 4\nсимволов!",
		
		["Register->MSG->NameAlreadyTaken"]="Это имя уже занято!",
		["Register->MSG->RegisterSuccess"]="Регистрация прошла успешно",
		["Register->MSG->NotAllowedName"]="Это имя запрещено!",
		["Register->MSG->NotAllowedChars"]="Никакие специальные символы\nне разрешены!",
		["Register->MSG->AlreadyAccount"]="Мультиаккаунты запрещены!",
		--
		["UI->Login->Name"]="Имя пользователя",
		["UI->Login->Pass"]="Пароль",
		["UI->Login->Button"]="Войти",
		["UI->Login->SaveName"]="Сохранить имя пользователя?",
		["UI->Login->SavePW"]="Сохранить пароль?",
		
		["Login->MSG->LoginSuccess"]="Войти успешно!",
		["Login->MSG->WrongPassword"]="Неправильный пароль!",
		--\\register/login
		
		--//team selection
		["UI->TeamSelect->Header"]="Выбор команды",
		["UI->TeamSelect->Info->BTN"]="Информация",
		["UI->TeamSelect->Info->Text"]="As 'Civilian' you can do jobs, do small robbery as well as other\nthings to earn money.\n\nAs 'S.A.P.D' & or 'F.I.B' you have to catch criminals\nand protect the city from crimes.\n\nAs S.A.M.D you have to revive people so that people survive.\n\nAs gangster like 'Grove' you can rob peoples\nas well as start robberies.",
		["TeamSelect->Full"]="Эта команда уже переполнена!",
		--\\team selection
		
		--//death systems
		["Dead->MSG->ToSAMD->OnMap"]="Мертвое тело (%s, %s)",
		["Dead->MSG->ToSAMD"]="[INFO]: Сообщается об умершем человеке в %s,%s.",
		["Revive->MSG->GotRevived"]="Вы были возвращены к жизни медиком %s!",
		["Revive->MSG->YouRevived"]="You have revived %s and get %s.",
		["UI->DeathScreen"]="You are unconscious!\n\nThe S.A.M.D. have been notified.\nIf no medics are available, you will be spawned\nat the hospital after the time runs out.\nYou will respawn in %s seconds.",
		--\\death systems
		
		--//money
		["UI->ATM->Tab->Deposit"]="Депозит",
		["UI->ATM->BTN->Deposit"]="Депозит",
		["UI->ATM->Tab->Withdraw"]="Отозвать",
		["UI->ATM->BTN->Withdraw"]="Отозвать",
		["UI->ATM->Balance"]="Баланс",
		--\\money
		
		--//items
		["Item->Name->Bread"]="Хлеб",
		["Item->Name->Donut"]="Пончик",
		["Item->Name->Milk"]="молоко",
		["Item->Name->Water"]="Вода",
		
		["Item->Name->Bandage"]="бинт",
		["Item->Name->Medikit"]="Medikit",
		
		["Item->Name->Stone"]="камень",
		["Item->Name->OreBronze"]="Бронза",
		["Item->Name->OreIron"]="железо",
		["Item->Name->OreGold"]="золото",
		["Item->Name->Jewel"]="Jewel",
		["Item->Name->Armor"]="Armor",
		--\\items
		
		--//job related
		["JobJoined"]="Вы поступили на работу %s!",
		["JobLeaved"]="вы оставили работу %s!",
		["JobAlready"]="У вас нет никакой работы!",
		["AlreadyInJob"]="Вы уже на работе %s!",
		["LeaveJobBefore"]="Leave your job before!",
		["Job->GotItem"]="Вы получили x%s %s!",
		["Job->SelledItem"]="Вы продали x%s %s!\nВы получили %s",
		
		["Job->UI->Tab->SellItems"]="продавать товары",
		["Job->UI->Sell->BTN"]="продать",
		["Job->Garbage->Collected"]="Garbage collected! (%s L./%s L.)",
		["Job->Garbage->VehFull"]="The vehicle is full!\nDrive back & empty it.",
		["Job->Garbage->VehNeed50"]="The vehicle must be at least\n50% full!",
		["Job->Garbage->VehEmptied"]="Garbage successfully unloaded!\nYou get %s%s.",
		["Job->Garbage->PickupInfo"]="Press 'X' to pick up the trash bag.",
		["Job->Garbage->DeliverInfo"]="Garbage picked up.\nGo to the garbage truck & press 'X'.",
		--\\job related
		
		--//shop related
		["UI->Shop->Skin->Title"]="Нажмите 'Sprace', чтобы остановить/запустить вращение",
		["UI->Shop->Price"]="Цена",
		["UI->Shop->Level"]="Уровень",
		["UI->Shop->Skin->BTN"]="Купить кожу",
		["UI->Shop->Item->BTN"]="купить товар",
		["Shop->MSG->Bought->Item"]="товар успешно куплен!\nx%s %s",
		["Shop->MSG->Bought->Skin"]="Кожа успешно куплена!\n%s",
		["Shop->MSG->NotEnoughLevel"]="You dont have the required\nLevel for this weapon! %s",
		--\\shop related
		
		--//phonecell related
		["Phonecell->Info"]="Нажмите 'X', чтобы поднять телефон выше.",
		["Phonecell->Reward"]="Вы нашли счастливый телефон! Вы получили %s%s.",
		--\\phonecell related
		
		--//tuning related
		["UI->Shop->Tuning->Title"]="Нажмите 'M', чтобы повернуть камеру!",
		["UI->Tuning->Buy->BTN"]="Buy selected tuning",
		["UI->Tuning->Rem->BTN"]="Remove selected tuning",
		["ShopT->MSG->Bought->Item"]="Tuning successfully purchased!",
		--\\tuning related
		
		--//rob related
		["Rob->NeedAmountOfStateMembers"]="В сети должно быть не менее %s\nполицейских.",
		--\\rob related
		
		
		
		
		--//vehicle stuff
		["Vehicle->NoPerms"]="Вы не можете использовать это\nтранспортное средство! Вы не состоите в команде %s!",
		["Vehicle->NoVehicles"]="У вас нет автомобилей!\nВы можете купить транспортное средство в Кархаусе!",
		["Vehicle->IsntSpawned"]="Этот автомобиль не порожден!",
		["Vehicle->AlreadySpawned"]="Этот автомобиль уже порожден!",
		["Vehicle->Repair->PNS"]="Вы заплатили %s%s за ремонт.",
		["Vehicle->LeaveBefore"]="Leave your vehicle before.",
		--\\vehicle stuff
		
		--other stuff
		["OnlyNumber"]="Разрешается использовать только цифры!",
		["Close->UI"]="Закрыть меню",
		["NotInCivilianTeam"]="Вам нужно присоединиться к Гражданской команде!",
		["NotInGangTeam"]="Ты не в банде!",
		["NotInRightTeam"]="Вы не в команде %s!",
		["NotInRightJob"]="Вы не в %s Job!",
		["NotEnoughMoney"]="У вас недостаточно денег!\nТебе нужно %s%s",
		["NotEnoughItemAmount"]="У вас недостаточно %s!",
		["NotEnoughLevel"]="У вас нет необходимого\nуровня! %s",
		["PremiumExpired"]="Срок действия вашего премиального статуса истек.",
		["PremiumStatus"]="Ваш статус Premium все еще активен в течение '%s' часа(ов)",
		["AlreadyEnoughAmmo"]="У вас уже есть максимум патронов!",
		["CantDoThatCuzWanteds"]="You cannot do this at the moment\nbecause you are wanted.",
		["GotActivityBonus"]="Вы получили %s и %s EXP за достижение %s часов игрового времени.",
		["NoDMText"]="Любой вид deathmatch запрещен!",
		["TeamChangeDelay"]="You cannot change your team!\nPlease wait %s minutes!",
		["CaseAlreadyOpened"]="You have already opened the case!\nYou can open it after each restart!",
	},
};