--═CONFIGURATION══════════════════════════════════════════════════════════════════════════════--
ChatServer = "https://script.tiny-warthog-19.telebit.io/chat/"  --chat server to connect to
--════════════════════════════════════════════════════════════════════════════════════════════--

--[[

╔═TO═DO══════════════════════════════════════════════════════════╗
║o add pm/custom chat "servers" (DONE)                           ║▒
║o rename it because it sounds like 2000's (DONE)                ║▒
║o um (DONE)                                                     ║▒
║o fix the backend issues with purple (DONE)                     ║▒
║o add autoclear if chat >= 9 (DONE)                             ║▒
║o giant wall of text (DONE)                                     ║▒ 
║o what is your opinion on the name pls respond                  ║▒
║o config needs more config (DONE)                               ║▒
║o moar colored text woah \x0F\xRR\xGG\xBB                       ║▒
║o ascii (DONE)                                                  ║▒
╚════════════════════════════════════════════════════════════════╝▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

╔═MISC═══════════════════════════════╗
║  Credits are at the bottom of the  ║▒
║              script.               ║▒
╚════════════════════════════════════╝▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

--]]

--======================--

local welcomewindow = Window:new(-1, -1, 420, 60)

local welcometext = Label:new(110, currentY, (select(1, welcomewindow:size())/2)-20, 16, "Thank you for installing ETRD v2!")
local welcomecloseButton = Button:new(5, select(2, welcomewindow:size())-23, 100, 16, "Close")

welcomewindow:addComponent(welcomecloseButton)
welcomewindow:addComponent(welcometext)

if (MANAGER.getsetting("aaccbbETRDIM", "firstlaunch") ~= "no") then
MANAGER.savesetting("aaccbbETRDIM","firstlaunch","no")
MANAGER.savesetting("aaccbbETRDIM","room","chatv2")
MANAGER.savesetting("aaccbbETRDIM","winsizex","300")
MANAGER.savesetting("aaccbbETRDIM","winsizey","200")
MANAGER.savesetting("aaccbbETRDIM","btnposx","598")
MANAGER.savesetting("aaccbbETRDIM","btnposy","1")
MANAGER.savesetting("aaccbbETRDIM","btnsizex","15")
MANAGER.savesetting("aaccbbETRDIM","btnsizey","15")
MANAGER.savesetting("aaccbbETRDIM","btntext","<")
MANAGER.savesetting("aaccbbETRDIM","dopings","true")
MANAGER.savesetting("aaccbbETRDIM","autoupdate","true")
WindowSizeX = MANAGER.getsetting("aaccbbETRDIM", "winsizex")
WindowSizeY = MANAGER.getsetting("aaccbbETRDIM", "winsizey")	
local chatwindow = Window:new(-1, -1, WindowSizeX, WindowSizeY)
loadingwindow = Window:new(-1, -1, 100, 50)
cfgWindow = Window:new(-1, -1, 200, 200)
interface.showWindow(welcomewindow)
end

welcomecloseButton:action(function() interface.closeWindow(welcomewindow) end)
welcomewindow:onTryExit(function() interface.closeWindow(welcomewindow) end)

--======================--

DefaultRoom = MANAGER.getsetting("aaccbbETRDIM", "room")
WindowSizeX = MANAGER.getsetting("aaccbbETRDIM", "winsizex")
WindowSizeY = MANAGER.getsetting("aaccbbETRDIM", "winsizey")
BtnPosX = MANAGER.getsetting("aaccbbETRDIM", "btnposx")
BtnPosY = MANAGER.getsetting("aaccbbETRDIM", "btnposy")
BtnSizeX = MANAGER.getsetting("aaccbbETRDIM", "btnsizex")
BtnSizeY = MANAGER.getsetting("aaccbbETRDIM", "btnsizey")
BtnText = MANAGER.getsetting("aaccbbETRDIM", "btntext")
doPings = MANAGER.getsetting("aaccbbETRDIM", "dopings")
AutoUpdate = MANAGER.getsetting("aaccbbETRDIM", "autoupdate")

local chatwindow = Window:new(-1, -1, WindowSizeX, WindowSizeY)
local loadingwindow = Window:new(-1, -1, 100, 50)
local welcomewindow = Window:new(-1, -1, 420, 60)
local cfgWindow = Window:new(-1, -1, 200, 200)
local version = 2
local currentY = 10
local room = DefaultRoom
MANAGER.print("ETRD (PowderIM) v".. version .." loaded!")
MANAGER.print("ETRD (PowderIM) by aaccbb.")
windowopen = 0

--======================--



if (AutoUpdate == "true") then
	versionFetch = http.get("https://raw.githubusercontent.com/AACCBB80/ETRD-IM/main/VERS.ION")
	while versionFetch:status() == "running" do
	end
	versionFetchOut, tmp = versionFetch:finish()
	if (versionFetchOut ~= "2\n") then
		print("[ETRD v".. version .."] Updating to v".. versionFetchOut)
		tpt.getscript(245, "./scripts/downloaded/245 aaccbb-ETRD _Formerly PowderIM_.lua", 1, 0)
	else
		print("[ETRD v".. version .."] No updates found!")
	end
end

--[[
function getMessages()
--fetch = http.get("https://script.tiny-warthog-19.telebit.io/chat/".. room ..".txt")
	fetch = http.get(ChatServer.. room ..".txt")
	
	while fetch:status() == "running" do
	interface.showWindow(loadingwindow)
	end
	interface.closeWindow(loadingwindow)
	chat, tmp = fetch:finish()
		if (tmp ~= 200) then
		chat:text("Server error!\nNotify aaccbb.")
	else
		chat = string.gsub(chat, "\x0A", "")
		--chat = string.gsub(chat, "○", "\n")
		chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
			else
				chatu = chatu .. word1 .."\n"
			end	
		end
		interface.showWindow(chatwindow)
		chat1:text(chatu)
	end
end
 ]]--


local powderim = Button:new(BtnPosX, BtnPosY, BtnSizeX, BtnSizeY, BtnText, "ETRD")


local powderim = Button:new(BtnPosX, BtnPosY, BtnSizeX, BtnSizeY, BtnText, "ETRD")

local testLabel = Label:new(15, currentY, (select(1, chatwindow:size())/2)-20, 16, "ETRD v".. version .." (Formerly PowderIM)")

local testLabel2 = Label:new(10, 20, (select(1, chatwindow:size())/2)-20, 16, "Sending...")

loadingwindow:addComponent(testLabel2)

currentY = currentY + 17

local chat1 = Label:new(150, 80, -20, 16, "")

currentY = currentY + 123

local testTextbox = Textbox:new(10, currentY, (select(1, chatwindow:size())/2)-20, 16, "", "...")
testTextbox:onTextChanged(
	function(sender)

	end
	)
	
local testButton = Button:new(150, currentY, (select(1, chatwindow:size())/4)-20, 16, "Send")
testButton:action(
	function(sender)
	--interface.showWindow(loadingwindow)
	msg = testTextbox:text()
	--msg = string.gsub(msg, "%s+", "+")
	--print(msg)
	fetch = http.post(ChatServer .."chat.php", {
	["user"] = tpt.get_name(),
	["msg"] = msg,
	["room"] = room
	})
	--interface.closeWindow(chatwindow)
	while fetch:status() == "running" do
	end
	--interface.closeWindow(loadingwindow)
	--interface.showWindow(chatwindow)
	chat, tmp = fetch:finish()
		if (tmp ~= 200) then
		chat1:text("Server error!\nNotify aaccbb.")
	else
	fetch = http.get(ChatServer.. room ..".txt")
	--interface.showWindow(loadingwindow)
	while fetch:status() == "running" do
	end
	--interface.closeWindow(loadingwindow)
	chat, tmp = fetch:finish()
		if (tmp ~= 200) then
		chat1:text("Server error!\nNotify aaccbb.")
	else
	chat = string.gsub(chat, "\x0A", "")
	--chat = string.gsub(chat, "○", "\n")
	chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
		else
			chatu = chatu .. word1 .."\n"
		end	
	end
	chat1:text(chatu)
	end
	end
	end
	)
	
local reloadButton = Button:new(215, currentY, (select(1, chatwindow:size())/4)-20, 16, "Reload")
reloadButton:action(
function(sender)
--coroutine.create(getMessages)
--coroutine.resume(getMessages)
	--fetch = http.get("https://script.tiny-warthog-19.telebit.io/chat/".. room ..".txt")
	fetch = http.get(ChatServer.. room ..".txt")
	interface.showWindow(loadingwindow)
	while fetch:status() == "running" do
	end
	interface.closeWindow(loadingwindow)
	chat, tmp = fetch:finish()
		if (tmp ~= 200) then
		chat1:text("Server error!\nNotify aaccbb.")
	else
		chat = string.gsub(chat, "\x0A", "")
		--chat = string.gsub(chat, "○", "\n")
		chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
			else
				chatu = chatu .. word1 .."\n"
			end	
		end
		chat1:text(chatu)
	end
	end
	
)

--local cfgCheckbox = Checkbox:new(10, 100, 0, 16, "CHECKBOX")

cfgY = 20

local cfg1L = Label:new(48, (cfgY - 12), 0, 16, "Default Room")

local cfg1 = Textbox:new(10, cfgY, 80, 16, DefaultRoom, "Default Room")

cfgY = cfgY + 30

local cfg2L = Label:new(48, (cfgY - 12), 0, 16, "Window X Size")

local cfg2 = Textbox:new(10, cfgY, 80, 16, WindowSizeX, "Window X Size")

cfgY = cfgY + 30

local cfg3L = Label:new(50, (cfgY - 12), 0, 16, "Window Y Size")

local cfg3 = Textbox:new(10, cfgY, 80, 16, WindowSizeY, "Window Y Size")

cfgY = cfgY + 30

local cfg4L = Label:new(48, (cfgY - 12), 0, 16, "Button X Pos")

local cfg4 = Textbox:new(10, cfgY, 80, 16, BtnPosX, "Button X Pos")

cfgY = cfgY + 30

local cfg5L = Label:new(48, (cfgY - 12), 0, 16, "Button Y Pos")

local cfg5 = Textbox:new(10, cfgY, 80, 16, BtnPosY, "Button Y Pos")

cfgY2 = 20

local cfg6L = Label:new(138, (cfgY2 - 12), 0, 16, "Button X Size")

local cfg6 = Textbox:new(100, cfgY2, 80, 16, BtnSizeX, "Button X Size")

cfgY2 = cfgY2 + 30

local cfg7L = Label:new(138, (cfgY2 - 12), 0, 16, "Button Y Size")

local cfg7 = Textbox:new(100, cfgY2, 80, 16, BtnSizeY, "Button Y Size")

cfgY2 = cfgY2 + 30

local cfg8L = Label:new(138, (cfgY2 - 12), 0, 16, "Button Display")

local cfg8 = Textbox:new(100, cfgY2, 15, 16, BtnText, "Button Display")

cfgY2 = cfgY2 + 30

local cfg9 = Checkbox:new(100, cfgY2, 100, 16, "Pings")

cfgY2 = cfgY2 + 30

local cfg10 = Checkbox:new(100, cfgY2, 100, 16, "Auto Update")

local cfgClose = Button:new(10, select(2, cfgWindow:size())-26, 100, 16, "Save")

cfgClose:action(
	function(sender)
		DefaultRoom = cfg1:text()
		WindowSizeX = cfg2:text()
		WindowSizeY = cfg3:text()
		BtnPosX = cfg4:text()
		BtnPosY = cfg5:text()
		BtnSizeX = cfg6:text()
		BtnSizeY = cfg7:text()
		BtnText = cfg8:text()
		if (cfg9:checked() == true) then
			doPings = "true"
		else
			doPings = "false"
		end
		
		if (cfg10:checked() == true) then
			AutoUpdate = "true"
		else
			AutoUpdate = "false"
		end
		MANAGER.savesetting("aaccbbETRDIM","room",DefaultRoom)
		MANAGER.savesetting("aaccbbETRDIM","winsizex",WindowSizeX)
		MANAGER.savesetting("aaccbbETRDIM","winsizey",WindowSizeY)
		MANAGER.savesetting("aaccbbETRDIM","btnposx",BtnPosX)
		MANAGER.savesetting("aaccbbETRDIM","btnposy",BtnPosY)
		MANAGER.savesetting("aaccbbETRDIM","btnsizex",BtnSizeX)
		MANAGER.savesetting("aaccbbETRDIM","btnsizey",BtnSizeY)
		MANAGER.savesetting("aaccbbETRDIM","btntext",BtnText)
		MANAGER.savesetting("aaccbbETRDIM","dopings",doPings)
		MANAGER.savesetting("aaccbbETRDIM","autoupdate",AutoUpdate)
		interface.closeWindow(cfgWindow)
		windowopen = 0
	end
)

local closeButton = Button:new(10, select(2, chatwindow:size())-26, 100, 16, "Close")

local roomTextbox = Textbox:new(120, select(2, chatwindow:size())-26, 50, 16, "", "Room ID")

local roomButton = Button:new(180, select(2, chatwindow:size())-26, 50, 16, "Join")

local configButton = Button:new(240, select(2, chatwindow:size())-26, 50, 16, "Config")

configButton:action(
function(sender)
interface.closeWindow(chatwindow)
if (doPings == "true") then
	cfg9:checked(true)
else
	cfg9:checked(false)
end
if (AutoUpdate == "true") then
	cfg10:checked(true)
else
	cfg10:checked(false)
end
interface.showWindow(cfgWindow)
--MANAGER.getsetting("aaccbbETRD","DefualtRoom")
end
)

roomButton:action(
function(sender)
room = roomTextbox:text()
if (room == "") then
	room = DefaultRoom
	fetch = http.get(ChatServer.. room ..".txt")
	while fetch:status() == "running" do
	end
	chat, tmp = fetch:finish()
	if (tmp ~= 200) then
		print("Server error!\nNotify aaccbb.")
	else
		chat = string.gsub(chat, "\x0A", "")
	--chat = string.gsub(chat, "○", "\n")
	chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
		else
			chatu = chatu .. word1 .."\n"
		end	
	end
	chat1:text(chatu)
	end
else
	fetch = http.post(ChatServer .."create.php", {
	["user"] = tpt.get_name(),
	["room"] = room
	})
	while fetch:status() == "running" do
	end
	--chat1:text("Joined ".. room ..".")	
	fetch = http.get(ChatServer.. room ..".txt")
	interface.showWindow(loadingwindow)
	while fetch:status() == "running" do
	end
	interface.closeWindow(loadingwindow)
	chat, tmp = fetch:finish()
		if (tmp ~= 200) then
		chat1:text("Server error!\nNotify aaccbb.")
	else
	chat = string.gsub(chat, "\x0A", "")
	--chat = string.gsub(chat, "○", "\n")
	chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
		else
			chatu = chatu .. word1 .."\n"
		end	
	end
	chat1:text(chatu)
	end
	end
	end
)



--======================--

closeButton:action(function() interface.closeWindow(chatwindow)
windowopen = 0
 end)

chatwindow:onTryExit(function() interface.closeWindow(chatwindow)
windowopen = 0
 end) -- Allow the default exit events

--cfgClose:action(function() interface.closeWindow(cfgWindow) end)

cfgWindow:onTryExit(function() interface.closeWindow(cfgWindow) end)

--====================--

chatwindow:addComponent(testLabel)
chatwindow:addComponent(configButton)
chatwindow:addComponent(chat1)
chatwindow:addComponent(testButton)
chatwindow:addComponent(testTextbox)
chatwindow:addComponent(reloadButton)
chatwindow:addComponent(closeButton)
chatwindow:addComponent(roomButton)
chatwindow:addComponent(roomTextbox)

welcomewindow:addComponent(welcomecloseButton)
welcomewindow:addComponent(welcometext)

interface.addComponent(powderim)

cfgWindow:addComponent(cfgClose)
cfgWindow:addComponent(cfg1)
cfgWindow:addComponent(cfg2)
cfgWindow:addComponent(cfg3)
cfgWindow:addComponent(cfg4)
cfgWindow:addComponent(cfg5)
cfgWindow:addComponent(cfg6)
cfgWindow:addComponent(cfg7)
cfgWindow:addComponent(cfg8)
cfgWindow:addComponent(cfg9)
cfgWindow:addComponent(cfg10)

cfgWindow:addComponent(cfg1L)
cfgWindow:addComponent(cfg2L)
cfgWindow:addComponent(cfg3L)
cfgWindow:addComponent(cfg4L)
cfgWindow:addComponent(cfg5L)
cfgWindow:addComponent(cfg6L)
cfgWindow:addComponent(cfg7L)
cfgWindow:addComponent(cfg8L)

--======================--

powderim:action(function(sender)
--getMessagesCo = coroutine.create(getMessages)
--coroutine.resume(getMessagesCo)

----[[
	windowopen = 1
	interface.showWindow(chatwindow)
	fetch = http.get(ChatServer.. room ..".txt")
			while fetch:status() == "running" do
			end
			chat, tmp = fetch:finish()
			if (tmp ~= 200) then
				print("Server error!\nNotify aaccbb.")
			else
				chat = string.gsub(chat, "\x0A", "")
				--chat = string.gsub(chat, "○", "\n")
				chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
					else
						chatu = chatu .. word1 .."\n"
					end	
				end
				--interface.showWindow(chatwindow)
				chat1:text(chatu)
			end
			--]]--
		end)


	local function keypressed(key, keynum, mod, evt)
		if evt == 2 and key == "/" then
			windowopen = 1
			interface.showWindow(chatwindow)
			fetch = http.get(ChatServer.. room ..".txt")
			while fetch:status() == "running" do
			end
			chat, tmp = fetch:finish()
			if (tmp ~= 200) then
				print("Server error!\nNotify aaccbb.")
			else
				chat = string.gsub(chat, "\x0A", "")
				--chat = string.gsub(chat, "○", "\n")
				chatu = ""
				local pingname = "@".. tpt.get_name() .." "
				local pingname2 = " @".. tpt.get_name()
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
					else
						chatu = chatu .. word1 .."\n"
					end	
				end
				--interface.showWindow(chatwindow)
				chat1:text(chatu)
			end
		end
			
	--end
		
		
		if evt == 2 and key == "\\" then --QuickView
			fetch = http.get(ChatServer.. room ..".txt")
			while fetch:status() == "running" do
			end
			chat, tmp = fetch:finish()
			if (tmp ~= 200) then
				print("Server error!\nNotify aaccbb.")
			else
				chat = string.gsub(chat, "\x0A", "")
				--chat = string.gsub(chat, "○", " | ")
				local pingname = "@".. tpt.get_name() .." "
				for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							print("\x0F\xED\xE6\x61".. word1)
						else
							print(word1)
						end
					else
						print(word1)
					end	
				end

				--for i1 in string.gmatch(chat, "%S+") do
					--print(i1)
				--end
				
				--print(chat)
			end 
		end	
		--end
		--end
		
		if evt == 2 and keynum == 13 and windowopen == 1 then
			msg = testTextbox:text()
			fetch = http.post(ChatServer .."chat.php", {
			["user"] = tpt.get_name(),
			["msg"] = msg,
			["room"] = room
			})
			while fetch:status() == "running" do
			end
			chat, tmp = fetch:finish()
			if (tmp ~= 200) then
				chat1:text("Server error!\nNotify aaccbb.")
			else
				fetch = http.get(ChatServer.. room ..".txt")
				--interface.showWindow(loadingwindow)
				while fetch:status() == "running" do
				end
				--interface.closeWindow(loadingwindow)
				chat, tmp = fetch:finish()
				if (tmp ~= 200) then
					chat1:text("Server error!\nNotify aaccbb.")
				else
					chat = string.gsub(chat, "\x0A", "")
					--chat = string.gsub(chat, "○", "\n")
					chatu = ""
					local pingname = "@".. tpt.get_name() .." "
					local pingname2 = " @".. tpt.get_name()
					for word1 in string.gmatch(chat, '([^○]+)') do
					if (doPings == "true") then
						if string.match(word1, pingname) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
						elseif string.match(word1, pingname2) then
							chatu = chatu .."\x0F\xED\xE6\x61".. word1 .."\n"
							else
							chatu = chatu .."\x0F\xFF\xFF\xFF".. word1 .."\n"
						end
		else
			chatu = chatu .. word1 .."\n"
		end	
	end
	chat1:text(chatu)
	end
	end
		end
		
	end

	tpt.register_keypress(keypressed)
	
--[[
╔═Credits══════════════════╗
║  aaccbb, the high blood  ║▒
║  pressure guy that makes ║▒
║ terrible memes and mints ║▒
║  PowderCoins (legally).  ║▒
╠══════════════════════════╣▒
║RebMiami, the one who made║▒
║ETRDv1 (PowderIM) work by ║▒
║adding 1 line and persuade║▒
║me to be less lazy enough ║▒
║  to continue writing v2. ║▒
╠══════════════════════════╣▒
║ Maticzpl, he helped with ║▒
║colored text, which I     ║▒
║couldn't find in the wiki.║▒
╠══════════════════════════╣▒
║   jacob1, he helped fix  ║▒
║QuickView and... approved ║▒
║       the script?        ║▒
╠══════════════════════════╣▒
║ Thanks to a bunch of YT  ║▒
║PHP tutorials, the backend║▒
║     works pretty well.   ║▒
╠══════════════════════════╣▒
║If you think your name is ║▒
║missing, DM me at aaccbb80║▒
║                 (Discord)║▒
╚══════════════════════════╝▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
--]]
