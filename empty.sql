-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 13. Aug 2023 um 18:42
-- Server-Version: 10.5.18-MariaDB-0+deb11u1
-- PHP-Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `stdb_user_dortey_323125`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ADlist`
--

CREATE TABLE `ADlist` (
  `ID` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Helpmenu`
--

CREATE TABLE `Helpmenu` (
  `SortID` int(11) NOT NULL DEFAULT 0,
  `Category` varchar(20) NOT NULL,
  `CategoryText` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `Helpmenu`
--

INSERT INTO `Helpmenu` (`SortID`, `Category`, `CategoryText`) VALUES
(1, 'Start', 'Start:                    Last Update: 06/13/2023\r\n\r\nFirst of all Hello and Welcome to this Server. Project X is an Cops \'n\' Robbers\r\nServer.\r\n\r\nCops \'n\' Robbers means, you can be a criminal or fight against criminals.\r\nYou also can be Civilian, civilian means, you can be friendly and you can\r\ndo Jobs. Jobs like Miner. If you want to know all Locations, open your Phone\r\nby pressing \'B\' and click on the Navigator.\r\n\r\nFor beginners we recommend being Civilian, to get to know the Server\r\nbetter. Otherwise you can be whatever you want and do what you want!\r\nBut follow our Rules. You can find our Rules also in the Help menu.\r\n\r\nIf you need any help or something isn\'t clear for you, feel free to join our\r\nDiscord. We\'ll help you there for sure :)\r\n\r\n\r\ndiscord.gg/FV9cKSj8M2\r\n\r\n'),
(2, 'Bindkeys/Commands', 'Bindkeys & Commands:                    Last Update: 07/26/2023\r\n\r\nBindkeys:\r\nF1 -> Help menu\r\nF2 -> Toggle Vehicle menu\r\nF9 -> Toggle toplists\r\nI -> Inventory\r\nU -> Userpanel (Settings etc)\r\nB -> Toggle phone\r\nM -> Toggle mouse cursor\r\nL -> Toggle vehicle lights\r\nX -> Toggle vehicle engine\r\nN -> Show levelbar\r\nY -> Team chat\r\n\r\nCommands:\r\n/team - change your team\r\n/global - write in Global chat'),
(3, 'Rules', 'Rules:                    Last Update: 08/12/2023\r\n\r\nGeneral:\r\n1. Respect everyone! No matter what he/she/they are!\r\n2. Political, religious, race or sex discussions are prohibited on this server.\r\n3. Don\'t insult anyone! Also the N word is prohibited!\r\n4. Don\'t disturb people if they say you should leave them.\r\n5. Don\'t ram other vehicles without a reason! especially jobs vehicles!\r\n6. Don\'t shoot at other vehicles! especially job vehicles!\r\n7. Driveby from vehicle to play isn\'t allowed! Just from vehicle to vehicle.\r\n8. Spawning vehicles inside a building is forbidden!\r\n\r\nTeam:\r\n1. Cops are only allowed to hunt with a Cop vehicle!\r\n\r\n\r\n\r\n\r\n\r\n\r\n- Trading with real money on Project X is forbidden!\r\nYou\'re not allowed to buy/sell ingame items for real money.\r\nSellers and buyers will be banned.\r\n\r\n- All accounts are virtual property of Project X.\r\nThere is no fundamental claim to the account.\r\n\r\n\r\nYou agree to our Rules by playing on our Server!'),
(5, 'State/Gangs/Civilian', 'State/Gangs/Civilian:                    Last Update: 06/26/2023\r\n\r\nOur concept of State/Gangs/Civilian is very simple.\r\n\r\nIf you join the State like S.A.P.D or F.I.B you\'ve to stop the Gangs if they\r\ndoing criminal aktions, also if they have Wanteds you can catch them.\r\nYou can catch players with a nightstick and also by killing them.\r\n\r\nIf you dont like a State team, you also can be criminal. As a Gang member\r\nyou can do criminal things.\r\n\r\nIf you dont like State or Gang teams, you also can be a civilian.\r\nAs civilian you can do Jobs and also commit some small robberies.'),
(8, 'Skins/Peds', 'Player Skins:                    Last Update: 06/18/2023\r\n\r\nOur Skin(Ped) system is simple to understand.\r\nYou can purchcase a own Skin in our skinshops. The Grey ones are for\r\ndefault GTA skins. The yellow ones are for custom(addon) skins.\r\n\r\nIf you go in a State/Gang team you wont lose your purchased skin! Just\r\ntemporary until you go in the Civilian Team.'),
(9, 'Level system', 'Level system:                    Last Update: 06/25/2023\r\n\r\nWe have an overall level system and also job level system.\r\nYou can level the overall level system by doing jobs, killing players and\r\narresting players. You can also earn EXP by doing robs and reaching specify\r\nplay time hours.\r\n\r\nYou need levels for certain weapons and vehicles.\r\n\r\nYour EXP will also reset to 0 when you reach a level up, they wont stack.'),
(10, 'Vehicle system', 'Vehicle:                    Last Update: 06/25/2023\r\n\r\nWe have 2 types of vehicles. The first one are Team vehicles for players\r\nwho dont have enough money for own ones.\r\n\r\nThe second one is private vehicles(player vehicles). Player vehicles can be\r\ntuned and also spawn/despawn anytime to your position. You can\r\nspawn/despawn your vehicles by pressing \'F2\'. You also can sell it there.\r\n\r\nYou must note that each vehicle has a required level.'),
(12, 'HUD', 'HUD:                    Last Update: 06/22/2023\r\n\r\nHUD means head-up display.\r\nThe red bar shows your Health. The grey bar shows your Armor. The green\r\none shows your hunger status. The icon at the left site shows, in which\r\nteam you are.\r\n\r\nYou also can change your HUD in the Userpanel (U).'),
(20, 'Job: Miner', 'Miner job:                    Last Update: 06/13/2023\r\n\r\nFirst of all you\'ve to go to the Miner Job. If you want to know the Location,\r\nopen your Phone by pressing \'B\' and click on the Navigator\r\n(select Jobs -> Miner). Once you\'re there, press \'M\' and click on the Ped.\r\n\r\nAfter clicking on the Ped you\'ve to enter the Mine.\r\nIf you entered the Mine, go on the Lift and go to the rocks, now you\r\nshould have a Pickaxe in your Hand. Press LMB to Mine.'),
(21, 'Job: Farmer', 'Farmer job:                    Last Update: 06/16/2023\r\n\r\nFirst of all you\'ve to go to the Farmer Job. If you want to know the\r\nLocation, open your Phone by pressing \'B\' and click on the Navigator\r\n(select Jobs -> Farmer). Once you\'re there, press \'M\' and click on the Ped.\r\n\r\nAfter clicking on the Ped you\'ve to go into the yellow marker.\r\nOnce you\'ve entered the yellow marker you\'ll see a yellow blip on the Map.\r\nGo to the yellow blip and lets go :)'),
(22, 'Job: Garbage', 'Garbage job:                    Last Update: 06/29/2023\r\n\r\nFirst of all you\'ve to go to the Garbage Job. If you want to know the\r\nLocation, open your Phone by pressing \'B\' and click on the Navigator\r\n(select Jobs -> Garbage). Once you\'re there, press \'M\' and click on the Ped.\r\n\r\nAfter clicking on the Ped you\'ve to go into the yellow marker.\r\nOnce you\'ve entered the yellow marker you\'ll see yellow blips on the Map.\r\nGo to the yellow blips and lets go :)\r\n\r\nOnce your job vehicles has more than 50% of volume drive back to the\r\nstart location and drive into the green marker.'),
(50, 'Rob: Jeweler', 'Jeweler rob:                    Last Update: 06/13/2023\r\n\r\nFirst of all you\'ve to go to the Jeweler. Once you\'re there, go inside and\r\ngo inside the marker upstairs.\r\n\r\nWhen you\'re inside the marker press \'X\' to start the robbery. After you\'ve\r\npressed \'X\' just wait (time is in the chat) and if the showcases are open\r\njust go inside the Green Markers.\r\nIf you survive the robbery you\'ll get money, otherwise you\'ll get nothing.'),
(51, 'Rob: Bank', 'Bank rob:                    Last Update: 07/02/2023\r\n\r\nFirst of all you\'ve to go to the Bank. Once you\'re there, go inside and\r\ngo inside the marker.\r\n\r\nWhen you\'re inside the marker press \'X\' to start the robbery. After you\'ve\r\npressed \'X\' just wait (time is in the chat) and if the door is open\r\njust go inside the Green Markers.\r\nIf you survive the robbery you\'ll get money, otherwise you\'ll get nothing.'),
(52, 'Rob: ATM', 'ATM rob:                    Last Update: 06/14/2023\r\n\r\nFirst of all you\'ve to go to a ATM. Once you\'re there, press \'M\' and click on\r\nthe ATM. After you\'ve clicked on the ATM the rob will start.\r\n\r\nIf you survive the robbery you\'ll get money, otherwise you\'ll get nothing.\r\nAlso dont go to far away from the ATM, when you are far away, the rob\r\nwill canceled directly!'),
(53, 'Rob: Shop', 'Shop rob:                    Last Update: 06/28/2023\r\n\r\nFirst of all you\'ve to go to a Shop(Burgershot). Once you\'re there, get your\r\nweapon out and press \'X\'. After you\'ve pressed \'X\' the rob will start.\r\n\r\nYou\'ve to wait 2 minutes to complete the shoprob. After the 2 minutes you\r\nneed to escape without dying.\r\n\r\nIf you survive the robbery you\'ll get the money, otherwise you\'ll get nothing.\r\nAlso dont go to far away from the Shop, when you are far away, the rob\r\nwill canceled directly!');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Accounts`
--

CREATE TABLE `Player_Accounts` (
  `Username` varchar(20) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Password` text NOT NULL,
  `DateRegister` text NOT NULL,
  `DateLastLogin` text NOT NULL,
  `AdminLevel` int(11) NOT NULL DEFAULT 0,
  `Gender` varchar(20) NOT NULL,
  `SpawnPos` varchar(150) NOT NULL DEFAULT '{0,0,10,0}',
  `Language` varchar(10) NOT NULL DEFAULT 'EN',
  `SkinID` int(11) NOT NULL DEFAULT 0,
  `Phone_Contacts` text NOT NULL DEFAULT '{}',
  `LoggedinDB` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Achievements`
--

CREATE TABLE `Player_Achievements` (
  `Username` varchar(20) NOT NULL,
  `Items` text NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Bans`
--

CREATE TABLE `Player_Bans` (
  `AdminName` varchar(20) NOT NULL,
  `TargetName` varchar(20) NOT NULL,
  `TargetSerial` varchar(50) NOT NULL,
  `Reason` text NOT NULL,
  `Time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Cases`
--

CREATE TABLE `Player_Cases` (
  `Username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Inventory`
--

CREATE TABLE `Player_Inventory` (
  `Username` varchar(20) NOT NULL,
  `Coins` int(11) NOT NULL DEFAULT 0,
  `Money` int(11) NOT NULL DEFAULT 20000,
  `Bankmoney` int(11) NOT NULL DEFAULT 35000,
  `Items` text NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Levels`
--

CREATE TABLE `Player_Levels` (
  `Username` varchar(20) NOT NULL,
  `OverallLVL` int(11) NOT NULL DEFAULT 0,
  `OverallEXP` int(11) NOT NULL DEFAULT 0,
  `FarmerLVL` int(11) NOT NULL DEFAULT 0,
  `FarmerEXP` int(11) NOT NULL DEFAULT 0,
  `GarbageLVL` int(11) NOT NULL DEFAULT 0,
  `GarbageEXP` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Premium`
--

CREATE TABLE `Player_Premium` (
  `Username` varchar(20) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Time` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_SavedWeapons`
--

CREATE TABLE `Player_SavedWeapons` (
  `Username` varchar(20) NOT NULL,
  `Weapons` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Settings`
--

CREATE TABLE `Player_Settings` (
  `Username` varchar(20) NOT NULL,
  `HUD` int(11) NOT NULL DEFAULT 1,
  `Radar` int(11) NOT NULL DEFAULT 1,
  `Speedo` int(11) NOT NULL DEFAULT 1,
  `BlipsATM` int(11) NOT NULL DEFAULT 1,
  `Hitsound` int(11) NOT NULL DEFAULT 1,
  `VehBlur` int(11) NOT NULL DEFAULT 2,
  `Bloodscreen` int(11) NOT NULL DEFAULT 2,
  `LoadVehTextures` int(11) NOT NULL DEFAULT 2,
  `LoadSkyboxTextures` int(11) NOT NULL DEFAULT 2,
  `PhoneBackground` int(11) NOT NULL DEFAULT 0,
  `PhoneModel` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Stats`
--

CREATE TABLE `Player_Stats` (
  `Username` varchar(20) NOT NULL,
  `PlayTime` int(11) NOT NULL DEFAULT 0,
  `Health` int(11) NOT NULL DEFAULT 100,
  `Armor` int(11) NOT NULL DEFAULT 0,
  `Hunger` int(11) NOT NULL DEFAULT 100,
  `Wanteds` int(11) NOT NULL DEFAULT 0,
  `Kills` int(11) NOT NULL DEFAULT 0,
  `Deaths` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Player_Timer`
--

CREATE TABLE `Player_Timer` (
  `Username` varchar(20) NOT NULL,
  `Jailtime` int(11) NOT NULL DEFAULT 0,
  `Hospitaltime` int(11) NOT NULL DEFAULT 0,
  `TeamChangeDelay` int(11) NOT NULL DEFAULT 0,
  `EventDelay` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Redeemcodes`
--

CREATE TABLE `Redeemcodes` (
  `ID` int(11) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `Typ` varchar(20) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Used` int(11) NOT NULL DEFAULT 0,
  `Username` varchar(20) NOT NULL DEFAULT 'NONE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Vehicles`
--

CREATE TABLE `Vehicles` (
  `ID` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `VehID` int(11) NOT NULL,
  `Health` int(11) NOT NULL,
  `Typ` varchar(15) NOT NULL DEFAULT 'User',
  `Tunings` varchar(300) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `ColorBody` varchar(100) NOT NULL DEFAULT '255|255|255',
  `ColorLight` varchar(100) NOT NULL DEFAULT '255|255|255',
  `Paintjob` int(11) NOT NULL DEFAULT 9999,
  `Lights` int(11) NOT NULL DEFAULT 9999,
  `Numberplate` int(11) NOT NULL DEFAULT 9999,
  `Horn` int(11) NOT NULL DEFAULT 0,
  `Engine` int(11) NOT NULL DEFAULT 0,
  `DriveTyp` varchar(20) NOT NULL DEFAULT 'rwd'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Vehicles_Carhouse`
--

CREATE TABLE `Vehicles_Carhouse` (
  `SortID` int(11) NOT NULL,
  `VehID` int(11) NOT NULL,
  `MaxSpeed` int(11) NOT NULL DEFAULT 0,
  `Typ` varchar(15) NOT NULL DEFAULT 'Normal'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `Vehicles_Carhouse`
--

INSERT INTO `Vehicles_Carhouse` (`SortID`, `VehID`, `MaxSpeed`, `Typ`) VALUES
(1, 549, 153, 'User'),
(6, 589, 162, 'User'),
(8, 533, 166, 'User'),
(9, 492, 140, 'User'),
(10, 565, 164, 'User'),
(16, 562, 177, 'User'),
(30, 561, 153, 'User'),
(60, 480, 184, 'User'),
(61, 85000, 192, 'User'),
(70, 560, 168, 'User'),
(71, 85001, 168, 'User'),
(72, 415, 192, 'User'),
(73, 451, 193, 'User'),
(90, 411, 221, 'User'),
(200, 581, 149, 'User'),
(201, 468, 139, 'User'),
(202, 521, 162, 'User'),
(203, 461, 165, 'User'),
(204, 522, 174, 'User'),
(500, 596, 0, 'SAPD'),
(501, 597, 0, 'SAPD'),
(502, 599, 0, 'SAPD'),
(510, 490, 0, 'FIB'),
(511, 528, 0, 'FIB'),
(520, 416, 0, 'SAMD'),
(521, 596, 0, 'SAMD');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Whitelist`
--

CREATE TABLE `Whitelist` (
  `Name` varchar(20) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Access` varchar(20) NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `ADlist`
--
ALTER TABLE `ADlist`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Helpmenu`
--
ALTER TABLE `Helpmenu`
  ADD PRIMARY KEY (`SortID`);

--
-- Indizes für die Tabelle `Player_Accounts`
--
ALTER TABLE `Player_Accounts`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Achievements`
--
ALTER TABLE `Player_Achievements`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Bans`
--
ALTER TABLE `Player_Bans`
  ADD PRIMARY KEY (`TargetSerial`);

--
-- Indizes für die Tabelle `Player_Cases`
--
ALTER TABLE `Player_Cases`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Inventory`
--
ALTER TABLE `Player_Inventory`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Levels`
--
ALTER TABLE `Player_Levels`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Premium`
--
ALTER TABLE `Player_Premium`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_SavedWeapons`
--
ALTER TABLE `Player_SavedWeapons`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Settings`
--
ALTER TABLE `Player_Settings`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Stats`
--
ALTER TABLE `Player_Stats`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Player_Timer`
--
ALTER TABLE `Player_Timer`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Redeemcodes`
--
ALTER TABLE `Redeemcodes`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Vehicles`
--
ALTER TABLE `Vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Vehicles_Carhouse`
--
ALTER TABLE `Vehicles_Carhouse`
  ADD PRIMARY KEY (`SortID`);

--
-- Indizes für die Tabelle `Whitelist`
--
ALTER TABLE `Whitelist`
  ADD PRIMARY KEY (`Name`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `ADlist`
--
ALTER TABLE `ADlist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Redeemcodes`
--
ALTER TABLE `Redeemcodes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `Vehicles`
--
ALTER TABLE `Vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
