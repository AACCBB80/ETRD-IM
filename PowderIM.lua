--to do
--o add im/custom chat "servers"
--o rename it because it sounds like 2000's
--o um
--o fix the backend issues with purple
--o add autoclear if chat >= 9
--o giant wall of text
--o jacbob what is your opinion on the name
local chatwindow = Window:new(-1, -1, 280, 200)
local loadingwindow = Window:new(-1, -1, 100, 50)

local currentY = 10

--======================--

local testLabel = Label:new(40, currentY, (select(1, chatwindow:size())/2)-20, 16, "PowderIM v1 (Server hosted by aaccbb)")
local testLabel2 = Label:new(10, 20, (select(1, chatwindow:size())/2)-20, 16, "Sending...")

loadingwindow:addComponent(testLabel2)

currentY = currentY + 17

local chat1 = Label:new(150, 80, -20, 16, "")

currentY = currentY + 123

local textboxInfo = Label:new(10+((select(1, chatwindow:size())/2)-20), currentY, (select(1, chatwindow:size())/2)-20, 16, "0 characters")

local testTextbox = Textbox:new(10, currentY, (select(1, chatwindow:size())/2)-20, 16, "", "...")
testTextbox:onTextChanged(
	function(sender)

	end
	)
	
local testButton = Button:new(150, currentY, (select(1, chatwindow:size())/4)-20, 16, "Send")
testButton:action(
	function(sender)
	interface.showWindow(loadingwindow)
	msg = testTextbox:text()
	fetch = http.post("https://script.tiny-warthog-19.telebit.io/chat/chat.php?user=".. tpt.get_name() .."&msg=".. msg)
	--interface.closeWindow(chatwindow)
	while fetch:status() == "running" do
	end
	interface.closeWindow(loadingwindow)
	--interface.showWindow(chatwindow)
	chat, tmp = fetch:finish()
		if (tmp == 404) then
		chat:text("404, server down!\nNotify aaccbb.")
	else
	fetch = http.get("https://script.tiny-warthog-19.telebit.io/chat/chat.txt")
	interface.showWindow(loadingwindow)
	while fetch:status() == "running" do
	end
	interface.closeWindow(loadingwindow)
	chat, tmp = fetch:finish()
		if (tmp == 404) then
		chat:text("404, server down!\nNotify aaccbb.")
	else
	chat = string.gsub(chat, "\x0A", "")
	chat = string.gsub(chat, "○", "\n")
	chat1:text(chat)
	end
	end
	end
	)
	
local reloadButton = Button:new(217, currentY, (select(1, chatwindow:size())/4)-20, 16, "Reload")
reloadButton:action(
function(sender)
	fetch = http.get("https://script.tiny-warthog-19.telebit.io/chat/chat.txt")
	interface.showWindow(loadingwindow)
	while fetch:status() == "running" do
	end
	interface.closeWindow(loadingwindow)
	chat, tmp = fetch:finish()
		if (tmp == 404) then
		chat:text("404, server down!\nNotify aaccbb.")
	else
	chat = string.gsub(chat, "\x0A", "")
	chat = string.gsub(chat, "○", "\n")
	chat1:text(chat)
	end
	end
	) --end

local closeButton = Button:new(10, select(2, chatwindow:size())-26, 100, 16, "Close")

closeButton:action(function() interface.closeWindow(chatwindow) end)

chatwindow:onTryExit(function() interface.closeWindow(chatwindow) end) -- Allow the default exit events
--====================--
chatwindow:addComponent(testLabel)
chatwindow:addComponent(chat1)
chatwindow:addComponent(testButton)
chatwindow:addComponent(testTextbox)
chatwindow:addComponent(reloadButton)
chatwindow:addComponent(closeButton)

	local function keypressed(key, keynum, mod, evt)

		if evt == 2 and key == "/" then

			interface.showWindow(chatwindow)
		end

	end

	tpt.register_keypress(keypressed)